using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Infrastructure
{
    public interface IAuditableEntity
    {
        DateTime CreatedDate { get; set; }
        string CreatedBy { get; set; }
        DateTime UpdatedDate { get; set; }
        string UpdatedBy { get; set; }
        // not data base filed
        // todo: refactor comment
        public string CreatedName { get; set; }
        public string CreatedEmail { get; set; }
        // not data base filed
        public string UpdatedName { get; set; }
    }

    //public interface ISysIdEntity
    //{
    //	string SysID { get; set; }
    //}
}
