using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Serilog;

namespace BoApi.Middlewares
{

    [Flags]
    public enum HttpSessionInfoToLog
    {
        All = -1,
        None = 0,
        QueryString = 1,
        Request = RequestHeaders | RequestBody | QueryString,
        RequestHeaders = 64,
        RequestBody = 128,
        Response = ResponseHeaders | ResponseBody,
        ResponseHeaders = 2048,
        ResponseBody = 4096,
    }

    public static class SerilogHttpSessionsLoggingMiddleware
    {
        ///// <summary>
        ///// Allows to log information about the http sessions processed.
        ///// </summary>
        ///// <param name="app">Application builder istance.</param>
        ///// <param name="settings">Enum flags that defines what extra information should be logged.</param>
        ///// <example>
        ///// public class Startup
        ///// {
        /////   public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        /////   {
        /////     app.UseHttpsRedirection();
        /////     app.UseStaticFiles();
        /////     app.UseSerilogHttpSessionsLogging(HttpSessionInfoToLog.All);
        /////     ...
        /////   }
        ///// }
        ///// </example>
        //public static void UseSerilogHttpSessionsLogging(this IApplicationBuilder app, HttpSessionInfoToLog settings = HttpSessionInfoToLog.None)
        //{
        //    if (settings.HasFlag(HttpSessionInfoToLog.RequestBody) || settings.HasFlag(HttpSessionInfoToLog.ResponseBody))
        //        app.Use(async (context, next) =>
        //        {
        //            if (settings.HasFlag(HttpSessionInfoToLog.RequestBody))
        //                context.Request.EnableBuffering();

        //            if (settings.HasFlag(HttpSessionInfoToLog.ResponseBody))
        //            {
        //                var originalRespBody = context.Response.Body;
        //                using var newResponseBody = new MemoryStream();
        //                context.Response.Body = newResponseBody;    //to capture it's value in-flight.
        //                await next.Invoke();
        //                newResponseBody.Position = 0;
        //                await newResponseBody.CopyToAsync(originalRespBody);
        //                context.Response.Body = originalRespBody;
        //            }
        //        });

        //    app.UseSerilogRequestLogging(x => x.EnrichDiagnosticContext = async (ctxDiag, ctxHttp)
        //        => await LogEnrichment(ctxDiag, ctxHttp, settings));
        //}

        static async Task LogEnrichment(IDiagnosticContext ctxDiag, HttpContext ctxHttp, HttpSessionInfoToLog settings)
        {
            try
            {
                const string headersSeparator = ", ";
                if (settings.HasFlag(HttpSessionInfoToLog.QueryString))
                    ctxDiag.Set("QueryString", ctxHttp.Request.QueryString);

                if (settings.HasFlag(HttpSessionInfoToLog.RequestHeaders))
                    ctxDiag.Set("RequestHeaders", string.Join(headersSeparator, ctxHttp.Request.Headers));

                if (settings.HasFlag(HttpSessionInfoToLog.ResponseHeaders))
                    ctxDiag.Set("ResponseHeaders", string.Join(headersSeparator, ctxHttp.Response.Headers));

                if (settings.HasFlag(HttpSessionInfoToLog.RequestBody))
                {
                    ctxHttp.Request.EnableBuffering();
                    ctxDiag.Set("RequestBody", await ReadStream(ctxHttp.Request.Body), false);
                }

                if (settings.HasFlag(HttpSessionInfoToLog.ResponseBody))
                    ctxDiag.Set("ResponseBody", await ReadStream(ctxHttp.Response.Body), false);
            }
            catch (Exception ex)
            {
                ctxDiag.SetException(ex);
            }
        }

        static async Task<string> ReadStream(Stream stream)
        {
            stream.Position = 0;
            using var reader = new StreamReader(stream, leaveOpen: true);
            var requestBodyText = await reader.ReadToEndAsync();
            stream.Position = 0;
            return requestBodyText;
        }
    }

}