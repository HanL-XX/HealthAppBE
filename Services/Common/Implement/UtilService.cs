using Common.Constant;
using Common.ErrorLocalization;
using DTOs.Models;
using Entities;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using OfficeOpenXml;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Numerics;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Services.Common
{
    public static class UtilService
    {
        /// <summary>
        /// Key is latitude, Value is Longitude
        /// </summary>
        /// <param name="radiusInMeters"></param>
        /// <param name="lng"></param>
        /// <param name="lat"></param>
        /// <returns></returns>
        public static KeyValuePair<double, double> RandomLocationInLatLngRad(double radiusInMeters, double lng, double lat)
        {
            Random random = new Random();

            // Convert radius from meters to degrees.
            double radiusInDegrees = radiusInMeters / 111320f;

            // Get a random distance and a random angle.
            double u = random.NextDouble();
            double v = random.NextDouble();
            double w = radiusInDegrees * Math.Sqrt(u);
            double t = 2 * Math.PI * v;
            // Get the x and y delta values.
            double x = w * Math.Cos(t);
            double y = w * Math.Sin(t);

            // Compensate the x value.
            double new_x = x / Math.Cos((Math.PI / 180) * lat);

            double newLatitude = lat + y;
            double newLongitude = lng + x;

            KeyValuePair<double, double> result = new KeyValuePair<double, double>(newLatitude, newLongitude);

            return result;
        }

        public static double DistanceTo(double lat1, double lon1, double lat2, double lon2, char unit = 'M')
        {
            double rlat1 = Math.PI * lat1 / 180;
            double rlat2 = Math.PI * lat2 / 180;
            double theta = lon1 - lon2;
            double rtheta = Math.PI * theta / 180;
            double dist =
                Math.Sin(rlat1) * Math.Sin(rlat2) + Math.Cos(rlat1) *
                Math.Cos(rlat2) * Math.Cos(rtheta);
            dist = Math.Acos(dist);
            dist = dist * 180 / Math.PI;
            dist = dist * 60 * 1.1515;

            switch (unit)
            {
                case 'K': //Kilometers -> default
                    return dist * 1.609344;
                case 'N': //Nautical Miles 
                    return dist * 0.8684;
                case 'M': //Miles
                    return dist;
            }

            return dist;
        }


        public static string EncodeTo64(byte[] inArray)
        {
            return Convert.ToBase64String(inArray);
        }

        public static string EncodeTo64(string data)
        {
            return Convert.ToBase64String(System.Text.Encoding.ASCII.GetBytes(data));
        }

        public static string DecodeFrom64(string encodedData)
        {
            try
            {
                if (encodedData.Last().ToString() == "/")
                {
                    encodedData = encodedData.Remove(encodedData.Length - 1);
                }

                byte[] encodedDataAsBytes = System.Convert.FromBase64String(encodedData);

                string returnValue = System.Text.ASCIIEncoding.ASCII.GetString(encodedDataAsBytes);

                return returnValue;
            }
            catch (Exception) { }

            return string.Empty;
        }

        //public static Image<Rgba32> ResizeImage(string inputPath, string outputPath)
        //{
        //	int width = Default_HandHeld_Image_Size.Product_Size, 
        //		height = Default_HandHeld_Image_Size.Product_Size;

        //	if (inputPath.Contains(FILE_PATH.SALES_LOCATION_IMAGE_PATH))
        //	{
        //		width = Default_HandHeld_Image_Size.Sale_Location_Width;
        //		height = Default_HandHeld_Image_Size.Sale_Location_Height;
        //	}

        //	try
        //	{
        //		using (Image<Rgba32> image = Image.Load(inputPath))
        //		{
        //			image.Mutate(x => x
        //				 .Resize(new ResizeOptions()
        //				 {
        //					 Size = new Size(width, height),
        //					 Mode = ResizeMode.Max
        //				 })
        //				);

        //			image.Save(outputPath); // Automatic encoder selected based on extension.

        //			return image;
        //		}
        //	}
        //	catch (Exception)
        //	{

        //	}

        //	return null;
        //}

        public static byte[] ReadFully(Stream input)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                input.CopyTo(ms);
                return ms.ToArray();
            }
        }

        public static Guid ConvertToGuid(long number)
        {
            byte[] data = new byte[16];

            BitConverter.GetBytes(number).CopyTo(data, 0);

            return new Guid(data);
        }

        public static long GuidToLong(Guid text)
        {
            return BitConverter.ToInt64(text.ToByteArray(), 0);
        }

        private static string CreateApiKey()
        {
            var bytes = new byte[256 / 8];
            using (var random = RandomNumberGenerator.Create())
                random.GetBytes(bytes);
            return ToBase62String(bytes);
        }

        private static string ToBase62String(byte[] toConvert)
        {
            const string alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            BigInteger dividend = new BigInteger(toConvert);
            var builder = new StringBuilder();
            while (dividend != 0)
            {
                dividend = BigInteger.DivRem(dividend, alphabet.Length, out BigInteger remainder);
                builder.Insert(0, alphabet[Math.Abs(((int)remainder))]);
            }
            return builder.ToString();
        }

        //private static string ImageToBase64(Image<Rgba32> image, string imageName)
        //{
        //	imageName = imageName.ToLower();

        //	if (imageName.Contains(".png"))
        //	{
        //		return image.ToBase64String(ImageFormats.Png);
        //	}
        //	else if (imageName.Contains(".jpg"))
        //	{
        //		return image.ToBase64String(ImageFormats.Jpeg);
        //	}
        //	else if (imageName.Contains(".gif"))
        //	{
        //		return image.ToBase64String(ImageFormats.Gif);
        //	}

        //	return image.ToBase64String(ImageFormats.Bmp);
        //}

        public static void CheckImportExcelFilleType(IFormFile file, ref ErrorModel error)
        {
            if (file == null || file.Length <= 0)
            {
                error.Add(ErrorResource.FileIsEmpty);
            }
            else if (!Path.GetExtension(file.FileName).Equals(".xlsx", StringComparison.OrdinalIgnoreCase))
            {
                error.Errors.Add(ErrorResource.FileNotExcelFile);
            }
        }
        private static DateTime? SwapDateMonth(DateTime? date)
        {
            if (date.HasValue)
            {
                string fromFormat = "MM/dd/yyyy";
                string toFormat = "dd/MM/yyyy";

                if (DateTime.TryParseExact(date.Value.ToString(fromFormat), toFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime exactDate))
                {
                    return exactDate;
                }

                return date;
            }

            return null;
        }
        public static DateTime? ReadDateValueFromExcelCellValue(object value)
        {
            if (value != null && value.GetType() == typeof(DateTime))
            {
                return (DateTime)value;
            }
            else
            {
                DateTime dateTimeValue;
                if (value != null && long.TryParse(value.ToString(), out long longValue))
                    return SwapDateMonth(DateTime.FromOADate(longValue));
                else if (value != null && DateTime.TryParse(value.ToString().Split(" ").First(), new CultureInfo("fr-FR"), DateTimeStyles.None, out dateTimeValue))
                    return dateTimeValue;
                else
                    return null;
            }
        }

        public static string BuildErrorMessageFromIndexes(string title, int addtract, params int[] indexes)
        {
            string result = title;
            result += " " + string.Join(", ", indexes.Select(x => (x + addtract).ToString())) + ": ";
            return result;
        }

        internal static bool ExcellRangeValueIsEmpty(ExcelRange cells, int y1, int x1, int y2, int x2)
        {
            for (int i = y1; i <= y2; i++)
            {
                for (int j = x1; j <= x2; j++)
                {
                    if (cells[i, j].Value != null && !string.IsNullOrEmpty(cells[i, j].Value.ToString()))
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// Length of a DataValidation list cannot exceed 255 characters
        /// Use AddSheetListValidationToExcelRange instead
        /// </summary>
        /// <param name="cell"></param>
        /// <param name="y1"></param>
        /// <param name="x1"></param>
        /// <param name="y2"></param>
        /// <param name="x2"></param>
        /// <param name="itemList"></param>
        /// <param name="errorTitle"></param>
        //internal static void AddListValidationToExcelRange(ExcelRange cell, int y1, int x1, int y2, int x2, List<string> itemList, string errorTitle)
        //{
        //	if (itemList == null || !itemList.Any())
        //	{
        //		return;
        //	}

        //	cell[y1, x1, y2, x2].Style.Numberformat.Format = "@";
        //	var listValidation = cell[y1, x1, y2, x2].DataValidation.AddListDataValidation();
        //	listValidation.ErrorStyle = OfficeOpenXml.DataValidation.ExcelDataValidationWarningStyle.information;
        //	listValidation.ShowErrorMessage = true;
        //	listValidation.ErrorTitle = errorTitle;
        //	listValidation.Error = "Please select an item from list!";
        //	itemList.ForEach(x => listValidation.Formula.Values.Add(x));
        //}

        internal static void AddTrueFalseValidationToExcelRange(ExcelWorksheet worksheet, int v1, int v2, int v3, int v4, string errorTitle)
        {
            var boolRange = ExcelRange.GetAddress(v1, v2, v3, v4);
            var boolVar = worksheet.DataValidations.AddListValidation(boolRange);
            boolVar.Formula.Values.Add("True");
            boolVar.Formula.Values.Add("False");
            boolVar.ErrorStyle = OfficeOpenXml.DataValidation.ExcelDataValidationWarningStyle.information;
            boolVar.ShowErrorMessage = true;
            boolVar.ErrorTitle = errorTitle;
            boolVar.Error = "Please select an item from list!";
        }

        internal static void AddSheetListValidationToExcelRange(ExcelWorksheet worksheet, ExcelWorksheet validationWorksheet, int v1, int v2, int v3, int v4, List<string> itemList, string errorTitle)
        {
            WriteListValidationToExcelColumn(itemList, validationWorksheet, out int column);
            string columnName = GetExcelColumnName(column);

            var range = ExcelRange.GetAddress(v1, v2, v3, v4);
            var validation = worksheet.DataValidations.AddListValidation(range);
            validation.Formula.ExcelFormula = string.Concat(validationWorksheet.Name + "!" + "$", columnName, "$1:$", columnName, "$", itemList.Count);
            validation.ErrorStyle = OfficeOpenXml.DataValidation.ExcelDataValidationWarningStyle.information;
            validation.ShowErrorMessage = true;
            validation.ErrorTitle = errorTitle;
            validation.Error = "Please select an item from list!";
        }

        private static string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = String.Empty;
            int modulo;

            while (dividend > 0)
            {
                modulo = (dividend - 1) % 26;
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
                dividend = (int)((dividend - modulo) / 26);
            }

            return columnName;
        }

        private static void WriteListValidationToExcelColumn(List<string> itemList, ExcelWorksheet validationWorksheet, out int column)
        {
            column = 1;
            while (!string.IsNullOrEmpty(validationWorksheet.Cells[1, column].Value?.ToString().Trim()))
            {
                column++;
            }
            int row = 1;
            foreach (var item in itemList)
            {
                validationWorksheet.Cells[row, column].Value = item;
                row++;
            }
        }

        internal static ExcelWorksheet CreateValidationWorksheet(ExcelWorkbook workbook)
        {
            if (workbook.Worksheets["ValidationWorksheet"] == null)
            {
                ExcelWorksheet validationWorksheet = workbook.Worksheets.Add("ValidationWorksheet");
                validationWorksheet.Hidden = eWorkSheetHidden.Hidden;
            }
            return workbook.Worksheets["ValidationWorksheet"];
        }

        internal static byte[] ListToExcel(IEnumerable<object> data, List<string> excludeNames, List<string> columnNames = null)
        {
            List<string> propNames = new List<string>();
            if (data.Count() == 0)
            {
                ExcelPackage emptyPackage = new ExcelPackage();
                emptyPackage.Workbook.Worksheets.Add("ImportProductList");
                return emptyPackage.GetAsByteArray();
            }
            object obj = data.First();
            Type type = obj.GetType();
            PropertyInfo[] propertyInfos = type.GetProperties();
            foreach (var prop in propertyInfos)
            {
                if (!excludeNames.Contains(prop.Name))
                {
                    propNames.Add(prop.Name);
                }
            }

            ExcelPackage package = new ExcelPackage();
            // add a new worksheet to the empty workbook
            ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("ImportProductList");
            var cell = worksheet.Cells;
            cell.AutoFitColumns();

            int x = 1;
            if (columnNames == null)
            {
                foreach (var item in propNames)
                {
                    cell[1, x++].Value = item;
                }
            }
            else
            {
                foreach (var item in columnNames)
                {
                    cell[1, x++].Value = item;
                }
            }

            int y = 2;
            foreach (object item in data)
            {
                Type t = item.GetType();
                PropertyInfo[] props = t.GetProperties();
                x = 1;
                foreach (var prop in props)
                {
                    if (propNames.Contains(prop.Name))
                    {
                        cell[y, x++].Value = prop.GetValue(item);
                    }
                }
                y++;
            }

            return package.GetAsByteArray();
        }

    }
}
