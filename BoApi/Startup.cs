using System;
using System.IO;
using BoApi.Extensions;
using BoApi.Middlewares;
using Common.Constant;
using Common.Helpers;
using DTOs.Helpers;
using Entities;
using Entities.Infrastructure;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Hangfire;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Identity.Web;
using Services.Jobs;
using Stripe;

namespace BoApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IHostEnvironment env)
        {
            Configuration = configuration;
            Settings.Configuration = configuration;
            JWTHelper.Configuration = configuration;
            GenerateDefaultValues.Configuration = configuration;

            _hostingEnvironment = env;
        }

        public static IConfiguration Configuration { get; set; }

        public IHostEnvironment _hostingEnvironment { get; set; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(c =>
                c.AddPolicy("CorsPolicy",
                    builder => builder.AllowAnyHeader()
                                      .AllowAnyMethod()
                                      .SetIsOriginAllowed(origin => true)
                                      .AllowCredentials()
                                      .WithExposedHeaders("Token-Expired"))
            );

            services.AddCustomDbContext();

            services.AddCustomIdentity();

            services.AddCustomizedMvc();

            services.AddJWT();

            services.AddAuthentication("bearer2")
                    .AddMicrosoftIdentityWebApi(Configuration, "AzureAd", "bearer2");

            services.AddCustomDataProtection();

            services.AddSwagger();

            services.AddCustomErrorLocalization();

            services.Configure<ApiBehaviorOptions>(options =>
            {
                options.SuppressConsumesConstraintForFormFileParameters = true;
                options.SuppressModelStateInvalidFilter = true;
            });


            /*
             * dependency Injection repositories
             */
            services.RegisterApiRepositories();

            /*
             * dependency Injection services
             */
            services.RegisterApiServices();

            /*
			 * Add custom spa static file
			 */
            services.AddCustomSpaStaticFile(this._hostingEnvironment);

            services.RegisterCustomServices();

            /*
             *  IIS
             */
            services.Configure<IISOptions>(opt =>
            {
                opt.ForwardClientCertificate = false;
                opt.AutomaticAuthentication = false;
            });

            /*
            *Hangire setup
            */
            services.AddHangfire(x => x.UseSqlServerStorage(Configuration.GetConnectionString("ApiConnection")));

            //services.AddHangfire(x => x.UseSqlServerStorage(Configuration.GetConnectionString("TicketingConnection")));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, ApiDbContext context, IServiceProvider services, ILoggerFactory loggerFactory)
        {
            if (this._hostingEnvironment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }
            //app.UseSerilogHttpSessionsLogging(HttpSessionInfoToLog.All);
            app.UseCors("CorsPolicy");

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseForwardedHeaders(new ForwardedHeadersOptions
            {
                ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
            });

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "DefaultApi",
                    pattern: "api/{controller}/{action}/{id?}"
                );
                endpoints.MapHangfireDashboard();
            });

            // ===== Setup Swagger ======
            app.AddCustomSwagger();

            // ==== Setup Spa Service =====
            //app.AddCustomSpaService(this._hostingEnvironment);

            // ===== Setup log4net =======
            loggerFactory.AddLog4Net();

            app.ConfigureExceptionHandler();

            if (!_hostingEnvironment.IsDevelopment())
            {

                try
                {
                    // ===== Create tables ======
                    context.Database.Migrate();
                }
                catch (SqlException)
                {
                    // retry
                }

                // ===== Setup Hangfire ======
                app.AddCustomHangfire();

                // ===== Daily Job =====
                InitDailyJob.InitUpdateJob(Configuration.GetConnectionString("ApiConnection"));

                // ===== Daily Job for Ticketing DB =====
                //InitDailyJob.InitUpdateJob(Configuration.GetConnectionString("TicketingConnection")); 

                // ===== Setup Stripe =====
                StripeConfiguration.ApiKey = Settings.STRIPE_SECRET_KEY;

                // ===== Create FirebaseApp Instance =====
                FirebaseApp.Create(new AppOptions()
                {
                    Credential = GoogleCredential.FromFile(Path.Combine(_hostingEnvironment.ContentRootPath, FILE_PATH.FIREBASE_ADMINSDK_PRIVATEKEY)),
                });
            }
        }
    }
}