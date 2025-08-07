using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Common.Helpers;
using Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.AspNetCore.Mvc.Razor;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Repositories;
using Repositories.Implement;
using Repositories.Interface;
using Services.Common;
using Services.Common.Implement;
using Services.Common.Interface;
using Services.Implement;
using Services.Interface;

namespace BoApi.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddCustomDataProtection(this IServiceCollection services)
        {
            return services;
        }

        public static IServiceCollection AddCustomDbContext(this IServiceCollection services)
        {
            services.AddDbContext<ApiDbContext>(options =>
                    options.UseLazyLoadingProxies()
                    .UseSqlServer(
                        Startup.Configuration.GetConnectionString("ApiConnection"),
                        opt => { opt.EnableRetryOnFailure(); opt.CommandTimeout(300); }
                    ));
            return services;
        }

        public static IServiceCollection AddCustomSpaStaticFile(this IServiceCollection services, IHostEnvironment hostingEnvironment)
        {
            if (!Startup.Configuration.GetValue<bool>("NotAllowSpaService"))
            {
                if (hostingEnvironment.IsDevelopment())
                {
                    services.AddSpaStaticFiles(c =>
                    {
                        c.RootPath = "ClientApp/dist";
                    });
                }
                else
                {
                    services.AddSpaStaticFiles(c =>
                    {
                        c.RootPath = "ClientApp";
                    });
                }
            }

            return services;
        }

        public static IServiceCollection AddSwagger(this IServiceCollection services)
        {
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "Hospital Project HCM", Version = "v1.0.0" });
                var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);

                //... and tell Swagger to use those XML comments.
                c.IncludeXmlComments(xmlPath);
                c.AddSecurityDefinition("Bearer",
                    new Microsoft.OpenApi.Models.OpenApiSecurityScheme
                    {
                        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
                        Description = "Please enter into field the word 'Bearer' following by space and JWT",
                        Name = "Authorization",
                        Type = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey
                    });
                c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
                {
                    {
                        new Microsoft.OpenApi.Models.OpenApiSecurityScheme
                        {
                            Reference = new Microsoft.OpenApi.Models.OpenApiReference
                            {
                                Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                                Id = "Bearer"
                            },
                            Scheme = "oauth2",
                            Name = "Bearer",
                            In = Microsoft.OpenApi.Models.ParameterLocation.Header
                        },
                        new List<string>()
                    }
                });
            });

            return services;
        }

        public static IServiceCollection AddCustomIdentity(this IServiceCollection services)
        {
            services.AddIdentity<Account, RoleDb>(options =>
            {
                // Password settings
                options.Password.RequireDigit = true;
                options.Password.RequiredLength = 8;
                options.Password.RequireLowercase = true;
                options.Password.RequireUppercase = true;
                options.Password.RequireNonAlphanumeric = false;

                // Signin settings
                options.SignIn.RequireConfirmedEmail = false;
                options.SignIn.RequireConfirmedPhoneNumber = false;

                // User settings
                options.User.RequireUniqueEmail = false;

                // Username settings
                options.User.AllowedUserNameCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@#$%^&*()+/=<> ";
            })
            .AddEntityFrameworkStores<ApiDbContext>()
            .AddDefaultTokenProviders();

            return services;
        }

        public static IServiceCollection AddJWT(this IServiceCollection services)
        {
            // ===== Add Jwt Authentication ========
            JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear(); // => remove default claims
            services
                .AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(cfg =>
                {
                    cfg.RequireHttpsMetadata = false;
                    cfg.SaveToken = true;
                    cfg.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidAudiences = new List<string>()
                        {
                            Startup.Configuration.GetValue<string>("JWTToken:JwtAudienceId")
                        },
                        ValidIssuer = Startup.Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                        ValidAudience = Startup.Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Startup.Configuration.GetValue<string>("JWTToken:JwtKey"))),
                        ClockSkew = TimeSpan.Zero // remove delay of token when expire,
                    };
                    cfg.Events = new JwtBearerEvents
                    {
                        OnAuthenticationFailed = context =>
                        {
                            if (context.Exception.GetType() == typeof(SecurityTokenExpiredException))
                            {
                                context.Response.Headers.Append("Token-Expired", "true");
                            }
                            return Task.CompletedTask;
                        }
                    };
                });
            return services;
        }

        public static IServiceCollection AddCustomizedMvc(this IServiceCollection services)
        {
            services.AddMvc()
                    .AddNewtonsoftJson(options =>
                    {
                        options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
                    })
                    .AddViewLocalization(LanguageViewLocationExpanderFormat.Suffix)
                    .AddDataAnnotationsLocalization();

            services.AddDistributedSqlServerCache(options =>
            {
                options.ConnectionString = Startup.Configuration.GetConnectionString("ApiConnection");
                options.SchemaName = "dbo";
                options.TableName = "SQLSessions";
            });

            // Add server cache for Ticketing module
            services.AddDistributedSqlServerCache(options =>
            {
                options.ConnectionString = Startup.Configuration.GetConnectionString("TicketingConnection");
                options.SchemaName = "tickets";
                options.TableName = "SQLSessions";
            });

            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(60);
            });

            services.AddControllersWithViews();

            return services;
        }

        public static IServiceCollection AddCustomErrorLocalization(this IServiceCollection services)
        {
            services.AddLocalization(options => options.ResourcesPath = "ErrorLocalization");
            services.AddLocalization(options => options.ResourcesPath = "Resources");

            //services.Configure<RequestLocalizationOptions>(options =>
            //         {
            //	var supportedCultures = new[]
            //	{
            //		new CultureInfo("en-US")
            //	};
            //	options.DefaultRequestCulture = new RequestCulture("en-US", "en-US");

            //	// You must explicitly state which cultures your application supports.
            //	// These are the cultures the app supports for formatting 
            //	// numbers, dates, etc.

            //	options.SupportedCultures = supportedCultures;

            //	// These are the cultures the app supports for UI strings, 
            //	// i.e. we have localized resources for.

            //	options.SupportedUICultures = supportedCultures;
            //});            

            return services;
        }

        public static IServiceCollection RegisterApiRepositories(this IServiceCollection services)
        {
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped<IUsersRepository, UsersRepository>();
            return services;
        }

        public static IServiceCollection RegisterApiServices(this IServiceCollection services)
        {

            services.AddSingleton<ICustomDestributedService, CustomMemoryDistributedCache>();
            services.AddScoped<ICacheWarpperService, CacheWarpperService>();
            //services.AddScoped<SqsBackgroundService>();

            services.AddScoped<IViewRenderService, ViewRenderService>();
            services.AddScoped<IAccountService, AccountService>();

            return services;
        }

        public static IServiceCollection RegisterCustomServices(this IServiceCollection services)
        {
            services.AddHttpContextAccessor();
            services.TryAddSingleton<IActionContextAccessor, ActionContextAccessor>();

            services.AddScoped<UserResolverService>();
            services.AddScoped<EncryptionService>();

            services.AddScoped<ConvertCurrency>();
            return services;
        }
    }
}