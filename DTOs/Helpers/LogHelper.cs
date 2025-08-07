using Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace DTOs.Helpers
{
    public static class LogHelper
    {
        public static void WriteLog(
            string requestMethod,
            string response,
            string request,
            string createdBy,
            int statusCode,
            string shortDescription,
            string longDescription,
            string branchId,
            ApiDbContext dbContext
            )
        {
            //Log log = new Log
            //{
            //    RequestContentBody = response,
            //    RequestURL = request,
            //    RequestMethod = requestMethod,
            //    Cookies = null,
            //    Active = true,
            //    Deleted = false,
            //    ResponseStatusCode = statusCode,
            //    ResponseContentBody = response,
            //    ShortSummary = shortDescription,
            //    LongSummary = longDescription,
            //    BranchId = branchId,
            //    CreatedBy = createdBy,
            //    CreatedDate = DateTime.Now
            //};

            //dbContext.Logs.Add(log);
            //dbContext.SaveChanges();
        }
    }
}
