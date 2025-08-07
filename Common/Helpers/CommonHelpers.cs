using System;
using System.Collections.Generic;
using System.Text;

namespace Common.Helpers
{
    public static class CommonHelpers
    {
        public static double GetTaxAmount(double amount, double rate)
        {
            var amountBeforeTax = amount / (1 + (rate / 100));
            var tax = amount - amountBeforeTax;
            return tax;
        }
    }
}
