using Common.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Common.Constant
{
    public static class Cashier_Status_Array
    {
        public static List<CashierSessionStatus> CashierStatuses = new List<CashierSessionStatus>()
        {
            CashierSessionStatus.Open,
            CashierSessionStatus.Close
        };

        public static List<CashierSessionStatus> CashierHistoryStatuses = new List<CashierSessionStatus>()
        {
            CashierSessionStatus.Accepted,
            CashierSessionStatus.Banked,
            CashierSessionStatus.FutherInvestigation,
        };
    }

    public static class Leg_Status_Array
    {
        public static List<CashierSessionStatus> Statuses = new List<CashierSessionStatus>()
        {
            CashierSessionStatus.Open,
            CashierSessionStatus.Close
        };

        public static List<CashierSessionStatus> HistoryStatuses = new List<CashierSessionStatus>()
        {
            CashierSessionStatus.Accepted,
            CashierSessionStatus.Banked,
            CashierSessionStatus.FutherInvestigation,
        };
    }

    public static class Default_HandHeld_Image_Size
    {
        public static readonly int Product_Size = 128;

        public static readonly int Sale_Location_Height = 240;
        public static readonly int Sale_Location_Width = 640;

        public static readonly int Print_Width = 192;
        public static readonly int Print_Full_Width = 384;

        public static readonly int MAX_SIZE_THUMBNAIL = (int)(0.5 * (1 << 20));
    }

    public static class Splash_Screen_Logo_Size
    {
        public static readonly int Width = 360;
        public static readonly int Height = 140;
    }

    public static class INIT_SQL_PATH
    {
        public static readonly string ADMIN_SETTINGS = "/Resources/sql_init_adminSettings.sql";
        public static readonly string DB_SYNC_SETTING = "/Resources/sql_init_DBSyncSettings.sql";
        public static readonly string INIT_DECLARATION_TYPE = "/Resources/sql_init_DeclarationType.sql";
        public static readonly string MODULE = "/Resources/sql_init_Modules.sql";
        public static readonly string TABLE_REPORT = "/Resources/sql_init_TableStatus.sql";
        public static readonly string DEVICE_MODULE = "/Resources/sql_init_DeviceModules.sql";
        public static readonly string POS_SETTING = "/Resources/sql_init_POSSETTING.sql";
        public static readonly string PRINT_TEMPLATE = "/Resources/sql_init_printTempate.sql";
        public static readonly string PRODUCT_NO_TYPE = "/Resources/sql_init_ProductTypeNoType";
        public static readonly string INIT_TOP_CURRENCY = "/Resources/sql_init_TopCurrency.sql";
        public static readonly string INIT_REPORT_MODULE = "/Resources/sql_init_ReportModule.sql";
        public static readonly string INIT_SETTING = "/Resources/sql_init_Setting.sql";
        public static readonly string INIT_REPORT_SP = "/Resources/sql_init_ReportSP.sql";
        public static readonly string INIT_TICKETING_REPORT_SP = "/Resources/sql_init_TicketingReportSP.sql";
        public static readonly string INIT_TICKET_ONLINE_SETTING = "/Resources/sql_init_TicketOnlineSetting.sql";
        public static readonly string INIT_TENDER_TYPE = "/Resources/sql_init_TenderType.sql";
        public static readonly string INIT_SP = "/Resources/sql_init_SP.sql";
        public static readonly string INIT_TICKETING_SP = "/Resources/sql_init_TicketingSP.sql";
        public static readonly string INIT_CUSTOMER_SP = "/Resources/sql_init_CustomerSP.sql";

        public static readonly string INIT_GWR_LOCATIONS = "/Resources/sql_init_GWRLocations.sql";
        public static readonly string INIT_MAPGWRDATA_SP = "/Resources/sql_init_MapGWRData_SP.sql";
        public static readonly string INIT_LOCALIZE_NOTIFICATIONS = "/Resources/sql_init_LocalizeNotifications.sql";

        public static readonly string VALIDATION_RULE = "Resources/sql_init_ValidationRule.sql";
        public static readonly string INIT_REPORT_FILTER = "/Resources/sql_init_ReportFilter.sql";

        public static readonly string INIT_TICKETING_DECLARATION_TYPE = "/Resources/sql_init_TicketingDeclarationType.sql";
        public static readonly string TICKETINGMODULE = "/Resources/sql_init_TicketingModules.sql";
        public static readonly string TICKETING_DEVICE_MODULE = "/Resources/sql_init_TicketingDeviceModules.sql";
        public static readonly string INIT_TICKETING_TOP_CURRENCY = "/Resources/sql_init_TicketingTopCurrency.sql";
        public static readonly string INIT_TICKETING_TENDER_TYPE = "/Resources/sql_init_TicketingTenderType.sql";
        public static readonly string INIT_TICKETING_VALIDATION_RULE = "/Resources/sql_init_TicketingValidationRule.sql";
        public static readonly string INIT_TICKETING_TICKET_PROPERTIES = "/Resources/sql_init_TicketProperty.sql";
        public static readonly string INIT_TICKETING_PRICE_LEVEL = "/Resources/sql_init_TicketingPriceLevel.sql";
        public static readonly string INIT_TICKETING_SETTING = "/Resources/sql_init_TicketingSettings.sql";
        public static readonly string INIT_TICKETING_DATA = "/Resources/sql_init_TicketingData.sql";
        public static readonly string INIT_TICKETING_REPORT_MODULE = "/Resources/sql_init_TicketingReportModule.sql";
        public static readonly string INIT_TICKETING_ORDERNO = "/Resources/sql_init_TicketingOrderNo.sql";
        public static readonly string DB_TICKETING_SYNC_SETTING = "/Resources/sql_init_TicketingDBSyncSettings.sql";
        public static readonly string INIT_TICKETING_PRINT_TEMPLATE = "/Resources/sql_init_TicketingPrintTemplate.sql";
    }

    public static class PaymentStatus
    {
        public static readonly string WorldPayAuthorised = "authorised";
        public static readonly string WorldPayCaptured = "captured";
        public static readonly string WorldPayRefunded = "sent_for_refund";
        public static string WorldPayInitPaymentSuccess = "WorldPay init payment success";
        public static string WorldPayInitPaymentFail = "WorldPay init payment fail";
        public static string WorldPayPaymentSuccess = "WorldPay payment success";
        public static string WorldPayPaymentFail = "WorldPay payment fail";
        public static string WorldPayPaymentCancel = "WorldPay payment cancel";

        public static string OpayoPaymentSuccess = "Opayo payment success";
        public static string OpayoPaymentFail = "Opayo payment fail";

    }

    public static class GlobalConstant
    {
        public static string DEFAULT_CURRENCY_CODE = "GBP";
        public static int DEFAULT_CURRENCY_POSITION = 3;
        public static string DEFAULT_CURRENCY_SYMBOL = "£";
        public const int FILE_SIZE_4MB = 4194304;
        public const string DELIMITER_PRODUCT_BAR_CODE = ";";

        public static int DEFAULT_TIMEOUT = 60;
        public static string THUMBNAIL_PREFIX = "Thumbnail_";
        public static string TICKET_ONLINE_URL = "/api/TicketOnline";
        public static string STOP_ALL_ORDERS = "Stop All Orders";
        public static string BOOKING_CANCEL_TIME = "Booking Cancel Time";

        public static string TICKET_BARCODE_PREFIX(Guid ticketId, DateTime soldDate) => $"{ticketId.ToString()}|{soldDate.Ticks}";
        public static string DEVICE_FILE_TRANSFER_PATH(Guid deviceId) => $"DeviceFileTransfer/{deviceId}/{DateTime.Now.ToString("dd-MM-yyyy")}/";
        public static string PRODUCT_TYPES_NO_TYPE = "No Type";
        public static string TRAVEL_CLASS_FIRST_CLASS = "FIRST";
        public static string TRAVEL_CLASS_STANDARD = "STD";

        public static string RandomAllChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        public static string RandomCharacterSet = "0123456789abcdefghkmnopqrstuvwxyz";
        public static char[] Base33CharacterSet = { '0','1','2','3','4','5','6','7','8','9',
            'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w'};
        public static string THIS_WEEKS_SPECIALS = "This Week's Specials";
        public static string BEST_SELLER = "Best Seller";
        public static int THIS_WEEKS_SPECIALS_POSITION = -1;
        public static int BEST_SELLER_POSITION = -2;


        public static readonly string DB_SYNC_GROUP_NAME = "DB Sync";
        public static readonly string LOG_MESSAGE = "Get information of {0}: {1}";
        public static readonly string LOG_MESSAGE_LIST = "Get list {0} of {1}";

        public static readonly string HEAD_OFFICE_CODE = "HO";
        public static readonly string ONLINE_BRANCH_CODE = "OB";
        public static readonly string DEFAULT_LANGUAGE_CODE = "EN";
        public static readonly string NAVIGATION_BRANCH_REQUEST_CODE = "branchNavigation";
        public static readonly string SHORT_SUMMARY_REQUEST_CODE = "shortSummary";
        public static readonly string ADMIN_MODULE = "Admin Modules";
        public static readonly int ADMIN_LEVEL = 0;
        public static readonly string FORGOTTENT_PASSWORD_EMAIL_TEMPLATE_PATH = "/Resources/ForgottenPasswordCMS.html";
        public static readonly string CONFIRM_EMAIL_TEMPLATE_PATH = "/Resources/ConfirmEmail.html";
        public static readonly string FORGOT_EMAIL_TEMPLATE_PATH = "/Resources/CustomerForgottenEmail.html";
        public static readonly string MODULES_IMPORT_LIST = "/Resources/Modules.txt";
        public static readonly string IMAGE_BASE64 = "data:image/jpeg;base64,{0}";
        public static readonly string INVITATION_EMAIL = "/BoApi/Views/InvitationEmail.html";
        public static readonly string SHOPIFY_GROUPNAME = "Shopify";
        public static readonly string FIREBASE_MESSAGING = "messaging-authorization";

        public static readonly string CURRENCY_API_LINK = "http://apilayer.net/api/live?access_key={0}&currencies={1}&source={2}&format=1";
        public static readonly string CURRENCY_API_LINK_GETALL = "http://apilayer.net/api/live?access_key={0}";
        public static readonly string CURRENCY_API_LINK_GET = "http://apilayer.net/api/list?access_key={0}";

        public static readonly string LOCALIZATION_PATH = "i18n/";
        public static readonly string PROMO_DISCOUNT_REASON = "Promo";

        public static readonly int SPAM_MAIL_MINUTE_CONTEXT = 5;
        public static readonly int SPAM_MAIL_COUNT_LIMIT = 3;

        public static readonly string COLLECT_FROM_THE_BAR = "Collect From The Bar";
        public static readonly string COLLECT_FROM_THE_BAR_DE = "Sammeln Sie von der Bar";

        public static readonly string SCANQR_AND_COLLECTFROMBAR = "ScanQRAndCollectFromBar";
        public static readonly string EMAIL_CONFIRMATION = "EmailConfirmation";
        public static readonly string EMAIL_DELAY = "DelayEmail";
        public static readonly string BACK_OFFICE_CODE = "BO";
        public static readonly string VOUCHER = "Voucher";
        public static readonly string EN = "En";
        public static string STANDARD = "STANDARD";
        public static int PARENT_REPORT_MODULE = 88;
        public static int INIT_MODULE_REPORT_ID = 1000;
        public static string TICKETING_REPORT_PREFIX = "tickets.";
        public static string CUSTOMER_REPORT_PREFIX = "customer.";

        public static readonly string BARCODE_GENERATOR_LINK_GET = "https://bwipjs-api.metafloor.com/?bcid=code128&text={0}";

        public static readonly List<string> ExcuteLogApi = new List<string>()
        {
            "/api/languages/getJson/",
            "/api/Logs",
            "/api/PosSetting/GetEnableDisabledStatus",
            "/api/TicketOnline"
        };

        public static readonly Dictionary<string, string> UrlShortSummary = new Dictionary<string, string>()
        {
            { "/api/accounts/getbytoken", "User get information by cookie" },
            { "/api/accounts/accessmodules", "User get access module" },
            { "/api/auth/sendpasswordresetlink", "Request email to reset password" },
            { "/api/auth/resetpassword", "Reset password" }
        };

        public static readonly List<string> Migration_Data_Config = new List<string>()
        {
            "Countries",
            "BranchGroups",
            "Branches",
            "PriceLevels",
            "TagTypes",
            "Tags",
            "ScreenLayouts",
            "ScreenLayoutFolders",
            "SaleLocations",
            "DeviceTypes",
            "DeviceVersions",
            "Devices",
            "DBSyncSettings",
            "BranchDbSyncSettingMaps",
            "Reasons",
            "ProductGroups",
            "Products",
            "SaleItems",
            "UnitOfMeasures",
            "TaxGroups",
            "StockItems",
            "Schedules",
            "OfferDiscounts",
            "OfferDiscountMembershipAttributeMaps",
            "OfferDiscountProductTagMaps",
            "OfferDiscountBranchMaps",
            "TenderTypes",
            "TenderTypeTagMaps",
            "Tenders",
            "PriceLevelBranchMaps",
            "ProductDimensions",
            "Taxes",
            "ProductDimensionPrices",
            "ProductTagMaps",
            "Currencies",
            "CurrencySettings",
            "CurrencyRates",
            "CurrencyRateMaps",
            "DeviceModules",
            "DeviceUserRoles",
            "DeviceUserRoleModuleMaps",
            "Location",
            "Languages",
            "AspNetUsers",
            "ProductQuestions",
            "ProductAnswers",
            "ProductQuestionProductMaps",
            "StockProductTags",
            "VehicleTypes",
            "Vehicles",
            "Routes",
            "Departures",
            "DepartureLocationMaps",
            "DepartureVehicleMaps",
            "DeclarationTypes",
            "BarCodes",
            "Settings",
            "PrintTemplates",
            "PrintTemplateBranchMaps",
            "TicketPrintTemplates",
            "BranchRouteMaps",
            "AccountBranchMaps",
            "StockProductTagMaps",
            "CreditNotes",
            "DeviceMessages",
            "BranchProductMaps",
            "Localizations",
            "TenderBranchMappings",
            "TenderDeviceTypeMappings",
            "TableGroups",
            "Tables",
        };

        public static readonly List<string> Ticketing_Migration_Data_Config = new List<string>()
        {
            "Countries",
            "BranchGroups",
            "Branches",
            "PriceLevels",
            "ScreenLayouts",
            "SaleLocations",
            "DeviceTypes",
            "DeviceVersions",
            "Devices",
            "DBSyncSettings",
            "BranchDbSyncSettingMaps",
            "Reasons",
            "TaxGroups",
            "OperationalHours",
            "VenueTypes",
            "Venues",
            "TimeSlots",
            "TenderTypes",
            "PriceLevelBranchMaps",
            "Taxes",
            "Currencies",
            "CurrencySettings",
            "CurrencyRates",
            "CurrencyRateMaps",
            "DeviceModules",
            "DeviceUserRoles",
            "DeviceUserRoleModuleMaps",
            "Locations",
            "Languages",
            "AspNetUsers",
            "DeclarationTypes",
            "Settings",
            "AccountBranchMaps",
            "DeviceMessages",
            "AddOns",
            "AvailabilityGroups",
            "Blackouts",
            "SaleChannels",
            "BlackoutSaleChannelMaps",
            "PassengerTypes",
            "PostageCosts",
            "PriceBands",
            "PriceTypes",
            "RedemptionTypes",
            "RefundPolicies",
            "Policies",
            "ResourceTypes",
            "RoomTypes",
            "Rooms",
            "Schedules",
            "OfferDiscounts",
            "OfferDiscountMembershipAttributeMaps",
            "Tenders",
            "Resources",
            "Seats",
            "TicketGroups",
            "ValidationRules",
            "TicketTypes",
            "TicketProperties",
            "Tickets",
            "AddOnTicketMaps",
            "BranchTicketMaps",
            "BlackoutTicketMaps",
            "TicketPassengerTypeMaps",
            "TicketPrices",
            "TicketPriceDetails",
            "ResourceTicketMaps",
            "TicketSaleChannelMaps",
            "TicketScheduleMaps",
            "TimeSlotDetails",
            "TicketScans",
            "PrintTemplates",
            "PrintTemplateBranchMaps",
            "TicketPrintTemplates",
            "OfferDiscountBranchMaps",
            "OfferDiscountTicketTagMaps",
            "DeviceLogs",
            "TicketingPromoCodes",
            "TicketingPromoCodeTicketMaps",
            "TicketingPromoCodeGeneratedMaps",
            "TicketingCreditNotes"
        };

        public static readonly List<string> PosSettingDBSync = new List<string>()
        {
            SPECIFIC_POS_SETTING.RE_ENABLE_DBSYNC
        };

        public static readonly List<string> StripeWebhookChargeEvent = new List<string>()
        {
            "charge.captured",
            "charge.expired",
            "charge.failed",
            "charge.pending",
            "charge.refunded",
            "charge.succeeded",
            "charge.updated"
        };

        public static string FIX_PRICE = "F";
        public static string MEMBER_PRICE_LEVEL_CODE = "MEM";
        public static string STANDARD_PRICE_LEVEL_CODE = "STD";
    }

    public static class SPECIFIC_POS_SETTING
    {
        public static readonly string ENABLE_DISABLED_DBSYNC = "DB Sync Activation";
        public static readonly string RE_ENABLE_DBSYNC = "Re-enable DB sync";
        public static readonly string BACKGROUND_SYNC = "Background sync frequency";
    }

    public static class FILE_PATH
    {
        public static readonly string IMAGE_APART_PATH = "Image/";
        public static readonly string THUMBNAIL_APART_PATH = "Thumbnail/";
        public static readonly string BRANCH_IMAGE_PATH = "Image/Branches/";
        public static readonly string SALES_LOCATION_IMAGE_PATH = "Image/SaleLocations/";
        public static readonly string USER_AVATAR_PATH = "Image/User_Avatars/";
        public static readonly string PRODUCT_IMAGE_PATH = "Image/Products/";
        public static readonly string FOLDER_IMAGE_PATH = "Image/Folder/";
        public static readonly string PRINT_TEMPLATE_IMAGE = "Image/PrintTemplate";
        public static readonly string SPLASH_SCREEN_LOGO_PATH = "Image/SplashScreenLogo/";
        public static readonly string STOCK_IMAGE_PATH = "Image/Stock/";
        public static string GENERATE_UPGRADE_FILE_PATH = "Apps/";
        public static string FIREBASE_ADMINSDK_PRIVATEKEY = "Keys/firebase-adminsdk-privatekey.json";
        public static string FIREBASE_PUSHPACKAGE = "Keys/pushPackage.zip";
        public static string APPLE_CERTIFICATION = "Keys/cert.p12";

        public static string WIFI_INJECTION_AES_PRIVATEKEY = "Keys/private.sec";
        public static string WIFI_INJECTION_AES_STAGING = "staging";
        public static string WIFI_INJECTION_AES_STAGINGKEY = "Keys/staging.pub";
        public static string WIFI_INJECTION_AES_PRODUCTION = "production";
        public static string WIFI_INJECTION_AES_PRODUCTIONKEY = "Keys/production.pub";
    }

    public static class DEVICE_ACTION
    {
        public static readonly string DEVICE_ADD = "Device added";
        public static readonly string DEVICE_UPDATE = "Device detail updated";
        public static readonly string VERSION_CHANGE = "Version changed";
        public static readonly string STATUS_CHANGE = "Status changed";
        public static readonly string ACTIVE_CHANGE = "Active/ InActive changed";
    }

    public static class JSON_PATH
    {
        public static readonly string TRANSACTION_REFERENCE = "TicketOnlines/";
    }

    public static class ProductScrollbarItem_Array
    {
        public static List<ProductScrollbarItem> ListProductScrollbarItem = new List<ProductScrollbarItem>() {
            ProductScrollbarItem.ChangeLocation,
            ProductScrollbarItem.Revenue,
            ProductScrollbarItem.Annulment,
            ProductScrollbarItem.EndOfShift,
            ProductScrollbarItem.ManualSync,
            ProductScrollbarItem.Commission,
            ProductScrollbarItem.SessionStaff,
            ProductScrollbarItem.SaveSales,
            ProductScrollbarItem.StockLevels
        };
    }
    public static class FunctionMenuScrollbarItem_Array
    {
        public static List<FunctionMenuScrollbarItem> ListScrollbarItem = new List<FunctionMenuScrollbarItem>() {
            FunctionMenuScrollbarItem.ChangeLocation,
            FunctionMenuScrollbarItem.Revenue,
            FunctionMenuScrollbarItem.Annulment,
            FunctionMenuScrollbarItem.EndOfShift,
            FunctionMenuScrollbarItem.ManualSync,
            FunctionMenuScrollbarItem.Commission,
            FunctionMenuScrollbarItem.SaveSales,
            FunctionMenuScrollbarItem.ChangeCabinType,
            FunctionMenuScrollbarItem.PrintOffer,
            FunctionMenuScrollbarItem.CrewChange,
            FunctionMenuScrollbarItem.EndOfSession
        };
    }

    public static class SYSTEM_MUTEX_NAME
    {
        public static readonly string GENERATE_UNIQUECODE = "generate_uniquecode";
    }

    public static class GWR_DATA_LINK
    {
        public static readonly string GET_GWRSTATUS_LINK = Settings.GWR_LINK + "/api/get/Statuses";
        public static readonly string GET_GWRPRICELEVEL_LINK = Settings.GWR_LINK + "/api/get/PriceLevels";
        public static readonly string GET_GWRPRICE_LINK = Settings.GWR_LINK + "/api/get/Prices";
        public static readonly string GET_GWRSALEITEM_LINK = Settings.GWR_LINK + "/api/get/SaleItems";
        public static readonly string GET_GWRNORMALPRODUCT_LINK = Settings.GWR_LINK + "/api/get/NormalProducts";

        public static readonly string GET_GWRDEPARTURE_LINK = Settings.GWR_LINK + "/api/get/departures";
        public static readonly string GET_GWRVEHICLE_LINK = Settings.GWR_LINK + "/api/get/vehicles";
        public static readonly string GET_GWRVEHICLETYPE_LINK = Settings.GWR_LINK + "/api/get/VehicleTypes";
        public static readonly string GET_GWRSALEPOINTGROUP_LINK = Settings.GWR_LINK + "/api/get/SalePointGroups";
        public static readonly string GET_GWRSALEPOINT_LINK = Settings.GWR_LINK + "/api/get/SalePoints";
        public static readonly string GET_GWRDEPARTUREVEHICLEMAP_LINK = Settings.GWR_LINK + "/api/get/VehicleOpenDepartures";

        public static readonly string GET_GWROFFER_LINK = Settings.GWR_LINK + "/api/get/Offers";
        public static readonly string GET_GWROFFERSET_LINK = Settings.GWR_LINK + "/api/get/OfferSets";
        public static readonly string GET_GWROFFERSETITEM_LINK = Settings.GWR_LINK + "/api/get/OfferSetItems";
        public static readonly string GET_GWROFFERTYPE_LINK = Settings.GWR_LINK + "/api/get/OfferTypes";
        public static readonly string GET_GWRSALEORDER_LINK = Settings.GWR_LINK + "/api/get/SaleOrders";

        public static readonly string POST_GWRORDER_LINK = Settings.GWR_LINK + "/api/set/SaleOrders";

        public static readonly string GET_OPEN_DEPARTURE = Settings.GWR_LINK + "/api/get/OpenDepartures/";
    }

    public static class Gwr_Constant
    {
        public static readonly string Menu_Offer_Type_Name = "Menu Offer";

        public static readonly string Order_Status_Table_Name = "SaleOrders";
        public static readonly string Order_Status_New_SysID = "4";
        public static readonly string Order_Status_Accepted_SysID = "5";
        public static readonly string Order_Status_Completed_SysID = "6";
        public static readonly string Order_Status_Canceled_SysID = "9";
        public static readonly string Order_Status_Timeout_SysID = "9";

        public static readonly int Submit_Order_Try_Time = 10;
        public static readonly int Submit_Order_Try_Sleep = 500;

        public static readonly int Set_Order_TimeOut_Try_Time = 10;
        public static readonly int Set_Order_TimeOut_Try_Sleep = 500;
    }

    public static class TicketOnlineSettingAllowEmpy
    {
        public static List<string> TicketOnlineSettingLink = new List<string>
        {
            "Youtube",
            "Twitter",
            "Facebook",
            "Instagram",
            "AppStore",
            "GooglePlayStore"
        };
    }

    public static class PdfTemplate
    {
        public static string BULK_CANCELLATION = "BulkCancelDetailPDF";
    }
    public static class ClientCode
    {
        public const string CADW = "CADW";
        public const string BMTH = "BMTH";
    }
    public static class EmailTemplate
    {
        static string GetEmailTemplate(string emailTemplate)
        {
            string prefix;
            switch (Settings.CLIENT_FOR_SEND_EMAIL)
            {
                case ClientCode.BMTH:
                    prefix = ClientCode.BMTH;
                    break;
                case ClientCode.CADW:
                    prefix = ClientCode.CADW;
                    break;
                default:
                    prefix = null;
                    break;
            }

            return prefix == null ? emailTemplate : $"{prefix}_{emailTemplate}";
        }
        public static string ORDER_CONFIRMED_EMAIL = "OrderConfirmedEmail";
        public static string ORDER_CONFIRMED_EMAIL_DE = "OrderConfirmedEmail_DE";
        public static string ORDER_ACCEPTED_EMAIL = "OrderAcceptedEmail";
        public static string ORDER_ACCEPTED_EMAIL_DE = "OrderAcceptedEmail_DE";
        public static string ORDER_COMPLETED_EMAIL = "OrderCompletedEmail";
        public static string ORDER_COMPLETED_EMAIL_DE = "OrderCompletedEmail_DE";
        public static string ORDER_CANCELED_EMAIL = "OrderCanceledEmail";
        public static string ORDER_CANCELED_EMAIL_DE = "OrderCanceledEmail_DE";
        public static string ACCOUNT_INFORMATION_EMAIL = "AccountInformation";
        public static string RECEIPT_EMAIL = GetEmailTemplate("YourReceiptEmail");
        public static string SIGN_UP_EMAIL = GetEmailTemplate("SignUpEmail");
        public static string ORDER_TO_SUPPLIER_EMAIL = GetEmailTemplate("OrderToSupplierEmail");
        public static string ORDER_DETAIL_TO_SUPPLIER_ATTACHMENT = GetEmailTemplate("OrderToSupplierDetailAttachment");
        public static string INTERNAL_ORDER_TO_WAREHOUSE_EMAIL = "InternalOrderToWarehouseEmail";
        public static string INTERNAL_ORDER_TO_WAREHOUSE_ATTACHMENT = "InternalOrderToWarehouseAttachment";
        public static string BOOKING_AMEND_EMAIL = "BookingAmendEmail";
        public static string BOOKING_PAY_LATER_EMAIL = "BookingPayLaterEmail";
        public static string LOCKED_EMAIL = GetEmailTemplate("LockedEmail");
        public static string BOOKING_EMAIL = GetEmailTemplate("BookingConfirmEmail");
        public static string BOOKING_EMAIL_CY = GetEmailTemplate("BookingConfirmEmail_CY");
        public static string BOOKING_PAYMENT_EMAIL = GetEmailTemplate("YourBookingPaymentEmail");
        public static string BOOKING_CANCEL_EMAIL = GetEmailTemplate("BookingCancelEmail");
        public static string BOOKING_CANCEL_EMAIL_CY = "BookingCancelEmail_CY";
        public static string INVOICE_EMAIL = GetEmailTemplate("InvoiceEmail");
        public static string ALARM_ABANDONED_BOOKINGS_EMAIL = GetEmailTemplate("AlarmAbandonedBookings");
        public static string BOOKING_PARTIALREFUND_EMAIL = GetEmailTemplate("BookingPartialRefundEmail");
        public static string BOOKING_PARTIALREFUND_EMAIL_CY = GetEmailTemplate("BookingPartialRefundEmail_CY");
        public static string ARRIVAL_EMAIL = "ArrivalEmail";
        public static string TICKET_SCAN_ENGLISH_EMAIL = GetEmailTemplate("TicketScanEnglishEmail");
        public static string TICKET_SCAN_CYMRAEG_EMAIL = GetEmailTemplate("TicketScanCymraegEmail");
        public static string TRANSACTION_QUEUE_ERROR_EMAIL = "TransactionQueueErrorEmailTemplate";
        public static string TRANSACTION_QUEUE_ERROR_FILE_ATTACK = "TransactionQueueErrorPDFTemplate";
        public static string SIGN_UP_EMAIL_BOOKING = GetEmailTemplate("SignUpEmailForBookingWebsite");

        //PDF Template
        public static string BULK_CANCELLATION = GetEmailTemplate("BulkCancelDetailPDF");
        public static string BOOKING_EMAIL_IN_SETTINGS
        {
            get
            {
                return TemplateInSettings("BOOKING_EMAIL");
            }
        }

        public static string BOOKING_PAY_LATER_EMAIL_IN_SETTINGS
        {
            get
            {
                return TemplateInSettings("BOOKING_PAY_LATER_EMAIL");
            }
        }

        public static string BOOKING_AMEND_EMAIL_IN_SETTINGS
        {
            get
            {
                return TemplateInSettings("BOOKING_AMEND_EMAIL");
            }
        }

        public static string TemplateInSettings(string template)
        {
            return Settings.GetEmailTemplate(template);
        }
    }

    public static class MultipleLanguageEmailTemplate
    {
        public static ISet<string> EmailTemplateNames;

        static MultipleLanguageEmailTemplate()
        {
            EmailTemplateNames = new HashSet<string>();
            // ticketing            
            EmailTemplateNames.Add(EmailTemplate.BOOKING_EMAIL);
            EmailTemplateNames.Add(EmailTemplate.BOOKING_EMAIL_CY);

            EmailTemplateNames.Add(EmailTemplate.BOOKING_CANCEL_EMAIL);
            EmailTemplateNames.Add(EmailTemplate.BOOKING_CANCEL_EMAIL_CY);

            EmailTemplateNames.Add(EmailTemplate.BOOKING_PARTIALREFUND_EMAIL);
            EmailTemplateNames.Add(EmailTemplate.BOOKING_PARTIALREFUND_EMAIL_CY);
            // stock
            EmailTemplateNames.Add(EmailTemplate.RECEIPT_EMAIL);

        }
    }


    public static class LanguageCode
    {
        public static string GERMAN = "DE";
        public static string ENGLISH = "EN";
    }

    public static class OrderEmailSubjectDE
    {
        public static string ORDER_CONFIRMED_SUBJECT_DE = "Ihre Bestellung wurde registriert";
        public static string ORDER_ACCEPTED_SUBJECT_DE = "Ihre Bestellung ist eingegangen";
        public static string ORDER_COMPLETED_SUBJECT_DE = "Ihre Bestellung wird vorbereitet";
        public static string ORDER_CANCELLED_SUBJECT_DE = "Storno Ihrer Bestellung";
    }

    public static class PaymentGatewayConstant
    {
        public static string STRIPE = "STRIPE";
        public static string PAYPAL = "PAYPAL";
    }

    public static class TicketingSaleChannelCode
    {
        public static string WEB = "WEB";
        public static string KIOSK = "KIOSK";
        public static string MOBILE_DEVICE = "MD";
        public static string BO = "BO";
    }

    public static class TicketingValidationRuleName
    {
        public const string VALID_FOR_3_MONTHS = "Valid for 3 months";
        public const string NO_VALIDATION = "No validation";
        public const string VALID_FOR_ONE_CALENDAR_DAY = "Valid for one calendar day";

        /// <summary>
        /// A ticket with this validation rule can be used ONCE only for a specified date.
        /// </summary>
        public const string SINGLE_USE = "Single use";
        public const string SAME_DAY_RETURN = "Same day return";
        public const string DAY_TICKET = "Day ticket";
        public const string EXPLORER_PASS = "Explorer pass";
        public const string TwoDayPass = "2 day pass";
        public const string EXPLORER_PASS_7_In_14_Day = "Explorer pass 7 in 14 day";
        public const string CADW_JOINT_TICKET = "CADW Joint Ticket";

        /// <summary>
        /// A ticket with this validation rule can be used ONCE no matter what the BOOKING DATE is.
        /// </summary>
        public const string SINGLE_USE_ANY_DAY = "Single use any day";
        public const string CADW_Joint_Validation_for_Castell_Coch_and_Caerphilly = "CADW Joint Validation for Castell Coch and Caerphilly";
    }

    public static class OpayoTransactionStatusCode
    {
        public const string OK = "Ok";
        public const string NOT_AUTHED = "NotAuthed";
    }

    public static class CountryCode
    {
        public const string US = "US";
    }
    public static class LanguageName
    {
        public const string EN = "EN";
        public const string CY = "CY";

    }

    public static class DateTimePattern
    {
        public const string SALENO = "yyyyMMddHHmmssfff";
    }
}
