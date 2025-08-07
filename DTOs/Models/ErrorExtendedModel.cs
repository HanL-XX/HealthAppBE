using System;
using System.Collections.Generic;
using System.Text;

namespace DTOs.Models
{
    public class ErrorExtendedModel : ErrorModel
    {
        public bool HaveInsert { get; set; }
        public bool HaveException { get; set; }
        public Guid TransactionId { get; set; }
        public List<string> Warnings { get; set; }
    }
}
