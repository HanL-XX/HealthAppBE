using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.Constant;
using Common.Helpers;
using DTOs;
using DTOs.Helpers;
using Entities;
using Entities.SPModels;

namespace DTOs.Models
{
    public class EmailModel
    {
        public string EmailAddress { get; set; }
        public string PhoneNumber { get; set; }
        public string TitleFooter { get; set; }
        public string PrivacyFooter { get; set; }
        public string ByFooter { get; set; }
        public string CompanyLogo { get; set; }
        public string Color { get; set; }
        public string Logo { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }
        public string ClientName { get; set; }
        public string OwnerName { get; set; }
        public string FooterUrl { get; set; }
        public string OwnerSiteUrl { get; set; }
        public string OwnerSiteName { get; set; }
        public bool DisplayPaymentLink { get; set; } = false;
    }

}
