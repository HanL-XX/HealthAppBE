using Microsoft.AspNetCore.Http;
using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;

namespace Common.Helpers
{
    public class HttpHelper
    {
        public static void Response(HttpResponse response, HttpResponseMessage membershipResponse)
        {
            response.ContentType = membershipResponse.Content.Headers.ContentType?.ToString();
            response.ContentLength = membershipResponse.Content.Headers.ContentLength;
            response.StatusCode = (int)membershipResponse.StatusCode;
        }

        public static void GetPath(HttpRequest request, HttpClient httpClient)
        {
            string requestPath = request.Path.Value;
            string requestQuery = request.QueryString.Value;
            httpClient.BaseAddress = new Uri(Settings.MEMBERSHIP_API + requestPath + requestQuery);
        }

        public static void GetPath(HttpRequest request, HttpClient httpClient, string remoteURL)
        {
            string requestPath = request.Path.Value;
            string requestQuery = request.QueryString.Value;
            httpClient.BaseAddress = new Uri(remoteURL + requestPath + requestQuery);
        }
        public static void GetAuthorize(HttpRequest request, HttpClient httpClient)
        {
            string token = string.Empty;

            try
            {
                token = request.Headers.GetCommaSeparatedValues("Authorization").GetValue(0).ToString();
            }
            catch { }
            finally
            {
                if (token.Length != 0)
                {
                    httpClient.DefaultRequestHeaders.Add("Authorization", token);
                }
            }
        }

        public static async Task<byte[]> RequestBody(HttpRequest request)
        {
            var ms = new MemoryStream((int)request.ContentLength);
            await request.Body.CopyToAsync(ms);
            return ms.ToArray();
        }

        public static async Task<byte[]> RequestForm(HttpRequest request)
        {
            var ms = new MemoryStream();
            await request.Form.Files.GetFile("file").CopyToAsync(ms);
            return ms.ToArray();
        }
    }
}