using System;
using System.Collections.Generic;
using System.Text;

namespace DTOs.AmazoneSQS
{
    public class AmazonSQSRedrivePolicy
    {
        public string deadLetterTargetArn { get; set; }
        public int maxReceiveCount { get; set; }
    }
}