using Common.Constant;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
using System.Text;

namespace Common.Helpers
{
    public static class ReasonTypeEnum
    {
        public static string[] ToList()
        {
            var enumObjects = (ReasonTypes[])Enum.GetValues(typeof(ReasonTypes));
            var enumNames = Enum.GetNames(typeof(ReasonTypes));

            var description = new List<string>();

            for (int i = 0; i < enumObjects.Length; i++)
            {
                description.Add(((DescriptionAttribute)enumObjects[i].GetType().GetField(enumNames[i]).GetCustomAttribute(typeof(DescriptionAttribute), false)).Description);

            }


            return description.ToArray();
        }
    }

    public static class TicketingReasonTypeEnum
    {
        public static string[] ToList()
        {
            var enumObjects = (ReasonTypes[])Enum.GetValues(typeof(ReasonTypes));
            var enumNames = Enum.GetNames(typeof(ReasonTypes));

            var description = new List<string>();

            for (int i = 0; i < enumObjects.Length; i++)
            {
                description.Add(((DescriptionAttribute)enumObjects[i].GetType().GetField(enumNames[i]).GetCustomAttribute(typeof(DescriptionAttribute), false)).Description);

            }
            return description.ToArray();
        }
    }
}
