using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using BoApi.Filters;
using BoApi.Middlewares;
using Hangfire;
using Hangfire.Dashboard;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.SpaServices.AngularCli;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Serilog;

namespace BoApi.Extensions
{
    public static class ApplicationBuilderExtensions
    {
        //public static IApplicationBuilder AddCustomSpaService(this IApplicationBuilder app, IHostEnvironment hostingEnvironment)
        //{
        //    if (!Startup.Configuration.GetValue<bool>("NotAllowSpaService"))
        //    {
        //        app.UseSpaStaticFiles();

        //        app.UseSpa(spa =>
        //        {
        //            // To learn more about options for serving an Angular SPA from ASP.NET Core,
        //            // see https://go.microsoft.com/fwlink/?linkid=864501

        //            spa.Options.SourcePath = "ClientApp";

        //            if (hostingEnvironment.IsDevelopment())
        //            {
        //                spa.UseAngularCliServer(npmScript: "start");
        //            }
        //        });
        //    }

        //    return app;
        //}

        public static IApplicationBuilder AddCustomSwagger(this IApplicationBuilder app)
        {
            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), 
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
            });

            return app;
        }

        public static IApplicationBuilder SetupCustomMiddleware(this IApplicationBuilder app)
        {
            //app.UseMiddleware<LogMiddleware>();

            //app.UseMiddleware<ResetTheBodyStreamMiddleware>();

            app.UseSerilogRequestLogging(options =>
                options.EnrichDiagnosticContext = async (diagnosticContext, context) =>
                {
                    // Reset the request body stream position to the start so we can read it
                    try
                    {
                        context.Request.Body.Position = 0;

                        // Leave the body open so the next middleware can read it.
                        using StreamReader reader = new StreamReader(
                            context.Request.Body,
                            encoding: Encoding.UTF8,
                            detectEncodingFromByteOrderMarks: false);

                        string body = await reader.ReadToEndAsync();

                        if (body.Length is 0)
                            return;

                        object obj = JsonSerializer.Deserialize<object>(body);
                        if (obj is null)
                            return;

                        diagnosticContext.Set("Body", obj);
                        options.MessageTemplate = "HTTP {RequestMethod} {RequestPath} {Body} responded {StatusCode} in {Elapsed:0.0000}";
                    }
                    catch
                    {

                    }
                }
            );


            return app;
        }

        public static IApplicationBuilder AddCustomHangfire(this IApplicationBuilder app)
        {
            app.UseHangfireServer();
            var options = new DashboardOptions
            {
                Authorization = new IDashboardAuthorizationFilter[] {
                    new HangfireAuthorizationFilter()
                }
            };
            app.UseHangfireDashboard("/hangfire", options);

            return app;
        }
    }
}