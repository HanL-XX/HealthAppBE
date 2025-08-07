using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Newtonsoft.Json;
using Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace Entities
{
    [Keyless]
    public class AuditReportModel
    {
        [JsonProperty(PropertyName = "ds+EditDate")]
        public string EditDate { get; set; }
        public string EditTime { get; set; }
        public string Module { get; set; }
        public string RequestMethod { get; set; }
        public string RequestUrl { get; set; }
        public string Field { get; set; }
        public string User { get; set; }
        public bool IsShow { get; set; }
    }
}
