using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Amazon.Runtime.Internal.Util;
using Common.Helpers;
using Hangfire.Annotations;
using Hangfire.Dashboard;
using log4net;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace BoApi.Filters
{
    public class HangfireAuthorizationFilter : IDashboardAuthorizationFilter
    {
        private const string HangFireCookieName = "HangFireCookie";
        private const int CookieExpirationMinutes = 60;
        private readonly TokenValidationParameters tokenValidationParameters;

        public HangfireAuthorizationFilter()
        {
            this.tokenValidationParameters = new TokenValidationParameters
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
        }

        public bool Authorize([NotNull] DashboardContext context)
        {
            var httpContext = context.GetHttpContext();

            var access_token = String.Empty;

            var setCookie = false;

            if (httpContext.Request.Query.ContainsKey("access_token"))
            {
                access_token = httpContext.Request.Query["access_token"].FirstOrDefault();
                setCookie = true;
            }
            else
            {
                access_token = httpContext.Request.Cookies[HangFireCookieName];
            }

            if (String.IsNullOrEmpty(access_token))
            {
                return false;
            }

            try
            {
                SecurityToken validatedToken = null;
                JwtSecurityTokenHandler hand = new JwtSecurityTokenHandler();
                var claims = hand.ValidateToken(access_token, this.tokenValidationParameters, out validatedToken);
                if (!claims.Identity.IsAuthenticated && !claims.IsInRole(Settings.DEFAULT_ECR_ADMIN_ROLE))
                {
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }

            if (setCookie)
            {
                httpContext.Response.Cookies.Append(HangFireCookieName,
                access_token,
                new CookieOptions()
                {
                    Expires = DateTime.Now.AddHours(CookieExpirationMinutes)
                });
            }

            return true;
        }
    }
}