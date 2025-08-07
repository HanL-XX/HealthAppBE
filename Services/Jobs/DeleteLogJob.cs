using Entities;
using Hangfire;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Services.Jobs
{
    public class DeleteLogJob
    {
        private ApiDbContext _dbContext;
        public DeleteLogJob(ApiDbContext apiDbContext)
        {
            this._dbContext = apiDbContext;
        }

        //[AutomaticRetry(Attempts = 0)]
        //public void DeleteLog()
        //{
        //    _dbContext.RemoveRange(_dbContext.Logs.Where(x => (x.ResponseStatusCode >= 200 && x.ResponseStatusCode < 300 && x.CreatedDate.Date < DateTime.Now.AddDays(-3)) || x.CreatedDate.Date < DateTime.Now.AddDays(-60)));
        //    _dbContext.SaveChanges();
        //}

        //[AutomaticRetry(Attempts = 0)]
        //public void DeleteLoginLog()
        //{
        //    _dbContext.RemoveRange(_dbContext.LoginLogs.Where(x =>  x.CreatedDate.Date < DateTime.Now.AddDays(-90)));
        //    _dbContext.SaveChanges();
        //}
    }
}
