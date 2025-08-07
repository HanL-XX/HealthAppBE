using System;
using Common.Constant;
using Entities;
using System.Collections.Generic;
using static Common.Constant.Sort;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace DTOs.Models
{
    public class PaginationRequest
    {
        /// <summary>
        /// Current Page
        /// </summary>
        public int Page { get; set; }
        /// <summary>
        /// Current Amount
        /// </summary>
        public int Amount { get; set; }
        /// <summary>
        /// Sort value
        /// </summary>
        public string Sort { get; set; }
        /// <summary>
        /// Search Values
        /// </summary>
        public string SearchText { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public bool? Active { get; set; }
        public DateTime? LastUpdate { get; set; }
        public DateTime? FromUpdateDate { get; set; }
        public DateTime? ToUpdateDate { get; set; }
        public PaginationType PaginationType { get; set; }

        public PaginationRequest() { }

        virtual public void Format()
        {
            if (string.IsNullOrEmpty(Sort))
            {
                Sort = "";
            }

            if (string.IsNullOrEmpty(SearchText))
            {
                SearchText = "";
            }

            if (Amount <= 0)
            {
                Amount = 10;
            }

            if (Page <= 0)
            {
                Page = 0;
            }
        }
    }

    public class PaginationPatientRequest : PaginationRequest
    {
        public string FullName { get; set; }

        public int? YearOfBirth { get; set; }

        public bool? IsMale { get; set; }

    }
    public class PaginationAccountRequest : PaginationRequest
    {
        public string FullName { get; set; }
        public string Email { get; set; }
        public DateTime? LastUpdate { get; set; }
        public UserType? UserType { get; set; }
        public bool? NotMe { get; set; }
        public string Branch { get; set; }
        public bool? IsLock { get; set; }
        public new void Format()
        {
            base.Format();

            if (string.IsNullOrEmpty(Branch))
            {
                Branch = string.Empty;
            }
        }
    }
}
