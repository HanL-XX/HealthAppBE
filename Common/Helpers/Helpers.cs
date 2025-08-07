using Common.Constant;
using System;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Common.Helpers
{
    public static class GlobalHelpers
    {
        public static void CopyModel(object from, object to)
        {
            if (from == null || to == null)
                return;
            var properties1 = TypeDescriptor.GetProperties(from);
            var properties2 = TypeDescriptor.GetProperties(to);
            foreach (PropertyDescriptor propertyDescriptor1 in properties1)
            {
                var propertyDescriptor2 = properties2.Find(propertyDescriptor1.Name, true);
                if (propertyDescriptor2 != null && !propertyDescriptor2.IsReadOnly)
                {
                    bool flag1 = propertyDescriptor2.PropertyType.IsAssignableFrom(propertyDescriptor1.PropertyType);
                    bool flag2 = !flag1 && Nullable.GetUnderlyingType(propertyDescriptor1.PropertyType) == propertyDescriptor2.PropertyType;
                    if (flag1 || flag2)
                    {
                        var obj = propertyDescriptor1.GetValue(from);
                        if (flag1 || obj != null && flag2)
                            propertyDescriptor2.SetValue(to, obj);
                    }
                }
            }

            foreach (PropertyDescriptor property in properties2)
            {
                if (property.PropertyType == typeof(string))
                    if (property.GetValue(to) == null)
                        property.SetValue(to, string.Empty);
                if (property.PropertyType == typeof(DateTime))
                    if (Convert.ToDateTime(property.GetValue(to)) == new DateTime(1, 1, 1))
                        property.SetValue(to, DateTime.Now);

            }
        }

        public static string ToCamelCase(this string str)
        {
            var words = str.Split(new[] { "_", " " }, StringSplitOptions.RemoveEmptyEntries);
            var leadWord = Regex.Replace(words[0], @"([A-Z])([A-Z]+|[a-z0-9]+)($|[A-Z]\w*)",
                m =>
                {
                    return m.Groups[1].Value.ToLower() + m.Groups[2].Value.ToLower() + m.Groups[3].Value;
                });
            var tailWords = words.Skip(1)
                .Select(word => char.ToUpper(word[0]) + word.Substring(1))
                .ToArray();
            return $"{leadWord}{string.Join(string.Empty, tailWords)}";
        }

        public static string ConvertExceptionToString(Exception ex)
        {
            StringBuilder stb = new StringBuilder();
            bool isInner = false;
            while (ex != null && !string.IsNullOrEmpty(ex.Message))
            {
                stb.AppendFormat("\n\n{0}: {1},\n\rStack: {2}\n", isInner ? "Exception" : "--Inner Exception", ex.Message, ex.StackTrace);
                ex = ex.InnerException;
                isInner = true;
            }

            return stb.ToString();
        }

        public static string ConvertBranchInformationToPrintTemplate(string printTemplate, dynamic branch)
        {
            if (printTemplate.Contains("<Branch.Code>"))
            {
                printTemplate = printTemplate.Replace("<Branch.Code>", !string.IsNullOrEmpty(branch.Code) ? branch.Code : "");
            }
            if (printTemplate.Contains("<Branch.Name>"))
            {
                printTemplate = printTemplate.Replace("<Branch.Name>", !string.IsNullOrEmpty(branch.Name) ? branch.Name : "");
            }
            if (printTemplate.Contains("<Branch.AddressLine1>"))
            {
                printTemplate = printTemplate.Replace("<Branch.AddressLine1>", !string.IsNullOrEmpty(branch.AddressLine1) ? branch.AddressLine1 : "");
            }
            if (printTemplate.Contains("<Branch.AddressLine2>"))
            {
                printTemplate = printTemplate.Replace("<Branch.AddressLine2>", !string.IsNullOrEmpty(branch.AddressLine2) ? branch.AddressLine2 : "");
            }
            if (printTemplate.Contains("<Branch.AddressLine3>"))
            {
                printTemplate = printTemplate.Replace("<Branch.AddressLine3>", !string.IsNullOrEmpty(branch.AddressLine3) ? branch.AddressLine3 : "");
            }
            if (printTemplate.Contains("<Branch.PostCode>"))
            {
                printTemplate = printTemplate.Replace("<Branch.PostCode>", !string.IsNullOrEmpty(branch.PostCode) ? branch.PostCode : "");
            }
            if (printTemplate.Contains("<Branch.PhoneNumber>"))
            {
                printTemplate = printTemplate.Replace("<Branch.PhoneNumber>", !string.IsNullOrEmpty(branch.PhoneNumber) ? branch.PhoneNumber : "");
            }
            if (printTemplate.Contains("<Branch.Email>"))
            {
                printTemplate = printTemplate.Replace("<Branch.Email>", !string.IsNullOrEmpty(branch.Email) ? branch.Email : "");
            }

            return printTemplate;
        }
        public static string IntToStringFast(int value, char[] baseChars)
        {
            // 32 is the worst cast buffer size for base 2 and int.MaxValue
            int i = 32;
            char[] buffer = new char[i];
            int targetBase = baseChars.Length;

            do
            {
                buffer[--i] = baseChars[value % targetBase];
                value = value / targetBase;
            }
            while (value > 0);

            char[] result = new char[32 - i];
            Array.Copy(buffer, i, result, 0, 32 - i);

            return new string(result);
        }

        public static bool IsTimeSpanBetweenInside(TimeSpan timeSpan,
            TimeSpan timeSpan1, TimeSpan timeSpan2)
        {
            return timeSpan > timeSpan1 && timeSpan < timeSpan2;
        }

        public static int ConvertDoubleToIntForGlobalPay(double number)
        {
            String numberAsString = String.Format("{0:00.0000000000}", number);
            String truncatedStringFor4Digit = numberAsString.Replace(".", "").Substring(0, 4);
            return Int32.Parse(truncatedStringFor4Digit);
        }
        public static string UrlEncode(string url)
        {
            return System.Web.HttpUtility.UrlEncode(url);
        }

        /// return 0 if dayOfWeek = DayOfWeek.Monday, 
        ///		   1 if dayOfWeek = DayOfWeek.Tuesday
        ///		   ...
        ///		   6 if dayOfWeek = DayOfWeek.Sunday
        public static int DataOfWeekToInt(DayOfWeek dayOfWeek)
        {
            var dayOfWeekInt = (int)dayOfWeek;
            if (dayOfWeekInt == 0)
            {
                dayOfWeekInt = 6;
            }
            else
            {
                dayOfWeekInt = dayOfWeekInt - 1;
            }
            return dayOfWeekInt;
        }

        public static string GetDatabaseName(GetDatabase database)
            => database switch
            {
                GetDatabase.ApiDatabase => new SqlConnection(Settings.APICONNECTION).Database,
                GetDatabase.TicketingDatabase => new SqlConnection(Settings.TICKETINGCONNECTION).Database,
                GetDatabase.CustomerDatabase => new SqlConnection(Settings.CUSTOMERCONNECTION).Database,
                _ => string.Empty
            };
    }
}
