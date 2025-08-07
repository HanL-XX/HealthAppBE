using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Common.Constant
{
    public static class SettingApp
    {
        public static readonly int ChangePassword = 3;

        public static readonly int ExpireInSec = 60;

        public static readonly int OTPLength = 6;
    }

    public static class BackofficeSettingName
    {
        public static readonly string PasswordExpiry = "Password Expiry";
        public static readonly string DefaultLanguage = "Default Language";
        public static readonly string BookingFee = "Booking Fee";
    }
}
