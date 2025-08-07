using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Reflection;
using System.Text;

namespace Common.Constant
{
    public static class EnumHelper
    {
        public static TEnum GetEnumFromDescription<TEnum>(string description) where TEnum : Enum
        {
            FieldInfo[] fields = typeof(TEnum).GetFields();

            foreach (FieldInfo field in fields)
            {
                if (Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute)) is DescriptionAttribute attribute)
                {
                    if (attribute.Description.Equals(description, StringComparison.OrdinalIgnoreCase))
                    {
                        return (TEnum)field.GetValue(null);
                    }
                }
            }

            throw new ArgumentException("No enum with the provided description found.", nameof(description));
        }
    }
    public enum UserType
    {
        Back_Office = 0,
        Both = 2,
        Customer = 3
    }

    public enum CashierSessionStatus
    {
        /// <summary>
        /// Session is open
        /// </summary>
        [Description("Open")]
        Open = 0,
        /// <summary>
        /// Session is end of shift
        /// </summary>
        [Description("Close")]
        Close = 1,
        /// <summary>
        /// Session accepted
        /// </summary>
        [Description("Accepted")]
        Accepted = 2,
        /// <summary>
        /// Session need investigation
        /// </summary>
        [Description("Futher Investigation")]
        FutherInvestigation = 3,
        /// <summary>
        /// Session is banked
        /// </summary>
        [Description("Banked")]
        Banked = 4
    }

    public enum ProductScrollbarItem
    {
        ChangeLocation = 0,
        Revenue = 1,
        Annulment = 2,
        EndOfShift = 3,
        ManualSync = 4,
        Commission = 5,
        SessionStaff = 6,
        SaveSales = 7,
        StockLevels = 8
    }
    public enum FunctionMenuScrollbarItem
    {
        ChangeLocation = 0,
        Revenue = 1,
        Annulment = 2,
        EndOfShift = 3,
        ManualSync = 4,
        Commission = 5,
        SaveSales = 7,
        ChangeCabinType = 8,
        CrewChange = 9,
        EndOfSession = 10,
        PrintOffer = 11
    }
    public enum TwoFactorAuthenticationType
    {
        Sms = 0,
        App = 1
    }
    public enum PaginationType
    {
        /// <summary>
        /// Get All list data
        /// </summary>
        Not_Pagination = -1,
        /// <summary>
        /// Allow pagination
        /// </summary>
        Pagination = 0
    }
    public enum PasswordHasherCompatibilityMode
    {
        /// <summary>
        /// Indicates hashing passwords in a way that is compatible with ASP.NET Identity versions 1 and 2.
        /// </summary>
        IdentityV2,

        /// <summary>
        /// Indicates hashing passwords in a way that is compatible with ASP.NET Identity version 3.
        /// </summary>
        IdentityV3
    }
    public enum Image_Upload_Type
    {
        [Description("Branch")]
        Branch = 0,
        [Description("Avatar")]
        Avatar_User = 1,
        [Description("SaleLocation")]
        Sale_location = 2,
        [Description("Product")]
        Product = 3,
        [Description("Folder")]
        Folder = 4,
        [Description("Stock")]
        Stock = 5,
        [Description("DeviceVersion")]
        DeviceVersion = 6,
        [Description("ProductGroup")]
        ProductGroup = 7,
        [Description("TicketingVenue")]
        TicketingVenue = 8
    }
    public enum GetDatabase
    {
        ApiDatabase = 0,
        TicketingDatabase = 1,
        CustomerDatabase = 2,
    }
    public enum ReasonTypes
    {
        [Description("Free Issue")]
        FreeIssue = 0,
        [Description("Item Voided")]
        ItemVoided = 1,
        [Description("Discount")]
        Discount = 2,
        [Description("Refund")]
        Refund = 3,
        [Description("Boarding")]
        Boarding = 4,
        [Description("Complimentary")]
        Complimentary = 5,
        [Description("Left on Board Stock")]
        LeftonBoardStock = 6,
        [Description("Stock Count Difference")]
        StockCountDifference = 7,
        [Description("Stock Adjustment")]
        StockAdjustment = 9,
        [Description("Stock Transfer")]
        StockTransfer = 10,
        [Description("No Sale")]
        NoSale = 11,
        [Description("Sale Voided")]
        SaleVoided = 12,
        [Description("Clear Basket")]
        ClearBasket = 13
    }
    public enum TicketingAccessLevel
    {
        /// <summary>
        /// Read (GET)
        /// </summary>
        RO = 0,
        /// <summary>
        /// Read write (CRUD)
        /// </summary>
        RW = 1
    }
    public enum PasswordVerificationResult
    {
        /// <summary>
        /// Indicates password verification failed.
        /// </summary>
        Failed = 0,

        /// <summary>
        /// Indicates password verification was successful.
        /// </summary>
        Success = 1,

        /// <summary>
        /// Indicates password verification was successful however the password was encoded using a deprecated algorithm
        /// and should be rehashed and updated.
        /// </summary>
        SuccessRehashNeeded = 2
    }
    public enum AccessLevel
    {
        /// <summary>
        /// Read (GET)
        /// </summary>
        RO = 0,
        /// <summary>
        /// Read write (CRUD)
        /// </summary>
        RW = 1
    }
}
