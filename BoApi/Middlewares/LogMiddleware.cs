using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Common.Helpers;
using Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BoApi.Middlewares
{
    public class LogMiddleware
    {
        private readonly RequestDelegate _next;

        public LogMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            if (context.Request.Path.StartsWithSegments("/api"))
            {
                try
                {
                    if ((context.Request.Method.ToLower() == "get") || (context.Request.HasFormContentType && context.Request.Form.Files?.Count > 0))
                    {
                        await _next(context);
                    }
                }
                catch (Exception)
                {
                    context.Request.EnableBuffering();

                    string bodyAsText = await new StreamReader(context.Request.Body).ReadToEndAsync();

                    var injectedRequestStream = new MemoryStream();
                    var bytesToWrite = Encoding.UTF8.GetBytes(bodyAsText);
                    injectedRequestStream.Write(bytesToWrite, 0, bytesToWrite.Length);
                    injectedRequestStream.Seek(0, SeekOrigin.Begin);
                    context.Request.Body = injectedRequestStream;

                    var builderOption = new DbContextOptionsBuilder<ApiDbContext>();
                    builderOption.UseSqlServer(Startup.Configuration.GetConnectionString("LogConnection"));

                    //Log log = ParseToLogEntity(bodyAsText, context);

                    //Copy a pointer to the original response body stream
                    var originalBodyStream = context.Response.Body;

                    //Create a new memory stream...
                    using (var db = new ApiDbContext(builderOption.Options))
                    {
                        using (var memStream = new MemoryStream())
                        {
                            //...and use that for the temporary response body
                            context.Response.Body = memStream;

                            //Continue down the Middleware pipeline, eventually returning to this class
                            await _next(context);

                            memStream.Position = 0;
                            string responseBody = new StreamReader(memStream).ReadToEnd();

                            memStream.Position = 0;
                            await memStream.CopyToAsync(originalBodyStream);

                            //log.ResponseStatusCode = context.Response.StatusCode;
                            //log.ResponseContentBody = responseBody.Length <= maxChars ? responseBody : responseBody.Substring(0, maxChars);

                            var _userResolverService = context.RequestServices.GetRequiredService<UserResolverService>();
                            //log.CreatedBy = _userResolverService.GetUserId();
                            //log.CreatedDate = DateTime.Now;
                            //log.ShortSummary = string.IsNullOrEmpty(log.ShortSummary) ? log.RequestURL : log.ShortSummary;

                            //if (GlobalConstant.ExcuteLogApi.All(x => !log.RequestURL.ToLower().Contains(x.ToLower())))
                            //{
                            //	db.Entry(log).State = Microsoft.EntityFrameworkCore.EntityState.Added;
                            //	if (context.Request.Path.HasValue && (context.Request.Path.Value.StartsWith("/api") || context.Request.Path.Value.StartsWith("/GlobalPayment")))
                            //	{
                            //		db.SaveChanges();
                            //	}
                            //}
                        }
                    }
                }
            }
            else
            {
                await _next(context);
                return;
            }
        }

        //private Log ParseToLogEntity(string reqBodyText, HttpContext context)
        //{
        //	Log log = new Log
        //	{
        //		RequestMethod = context.Request.Method,
        //		RequestURL = context.Request.Path.Value,
        //		RequestContentBody = reqBodyText,
        //		Cookies = context.Request.Cookies.ToString()
        //	};

        //	if (context.Request.Query.ContainsKey(GlobalConstant.NAVIGATION_BRANCH_REQUEST_CODE))
        //	{
        //		log.BranchId = context.Request.Query[GlobalConstant.NAVIGATION_BRANCH_REQUEST_CODE].ToString();
        //	}

        //	if (!string.IsNullOrEmpty(reqBodyText))
        //	{
        //		try
        //		{
        //			var sumary = JsonConvert.DeserializeObject<LogSummary>(reqBodyText);

        //			if (sumary != null)
        //			{
        //				log.ShortSummary = sumary.shortSummary;
        //				if(sumary.longSummary != null)
        //                      {
        //					log.LongSummary = string.Join(";", sumary.longSummary);
        //					log.RequestContentBody = reqBodyText.Replace(JsonConvert.SerializeObject(sumary).Replace("{", ",").Replace("}", ""), string.Empty);
        //                      }
        //			}
        //		}
        //		catch (Exception) { };
        //	}
        //	else if (log.RequestMethod == "GET" && context.Request.Query.ContainsKey(GlobalConstant.SHORT_SUMMARY_REQUEST_CODE))
        //	{
        //		log.ShortSummary = context.Request.Query[GlobalConstant.SHORT_SUMMARY_REQUEST_CODE];
        //	}

        //	if (log.RequestURL.ToLower().Contains("/api/auth"))
        //	{
        //		string functionLink = log.RequestURL.Replace("/api/Auth", string.Empty);

        //		switch(functionLink.ToLower())
        //		{
        //			case "/resetpassword":
        //				log.RequestContentBody = "{}";
        //				break;
        //			default:
        //				if (log.RequestMethod == "POST")
        //				{
        //					log.ShortSummary = "Backoffice user logins";
        //					try
        //					{
        //						var login = JsonConvert.DeserializeObject<LoginModel>(reqBodyText);

        //						if (login != null)
        //						{
        //							login.Password = "***********";

        //							log.RequestContentBody = JsonConvert.SerializeObject(login);
        //						}
        //					}
        //					catch (Exception) { };
        //				}
        //				else
        //				{
        //					log.ShortSummary = "Backoffice user logouts";
        //				}

        //				break;
        //		}
        //	}

        //	if (GlobalConstant.UrlShortSummary.ContainsKey(log.RequestURL.ToLower()))
        //	{
        //		log.ShortSummary = GlobalConstant.UrlShortSummary[log.RequestURL.ToLower()];
        //	}

        //	return log;
        //}
    }
}