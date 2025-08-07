using Amazon;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Common.Helpers
{
    public static class Settings
    {
        public static IConfiguration Configuration { get; set; }

        public static string DEFAULT_HEAD_OFFICE_NAME
        {
            get
            {
                return GetAppConfig("DefaultHeadOffice:Name");
            }
        }

        public static string DEFAULT_ONLINE_BRANCH_NAME
        {
            get
            {
                return GetAppConfig("DefaultOnlineBranch:Name");
            }
        }

        public static string DEFAULT_ADMIN_EMAIL
        {
            get
            {
                return GetAppConfig("DefaultAdmin:Email");
            }
        }

        public static string DEFAULT_ECR_ADMIN_ROLE
        {
            get
            {
                return GetAppConfig("DefaultRoleName");
            }
        }

        public static string CURRENCY_API_ACCESS_KEY
        {
            get
            {
                return GetAppConfig("CurrencyRateApi_accessKey");
            }
        }

        public static string DEFAULT_ADMIN_PASSWORD
        {
            get
            {
                return GetAppConfig("DefaultAdmin:Password");
            }
        }

        public static string REMOVE
        {
            get
            {
                return GetAppConfig("Remove");
            }
        }

        public static string SALT
        {
            get
            {
                return GetAppConfig("Salt");
            }
        }


        public static string AMAZONE_S3_ACCESS_KEY
        {
            get
            {
                return GetAppConfig("Amazone_S3:AccessKey");
            }
        }

        public static string AMAZONE_S3_SECRET_KEY
        {
            get
            {
                return GetAppConfig("Amazone_S3:SecretKey");
            }
        }

        public static string AMAZONE_S3_BUCKET_DEFAULT
        {
            get
            {
                return GetAppConfig("Amazone_S3:Default");
            }
        }
        public static string AMAZONE_S3_BUCKET_BRANCHES
        {
            get
            {
                return GetAppConfig("Amazone_S3:Branches");
            }
        }
        public static string AMAZONE_S3_BUCKET_SALE_LOCATIONS
        {
            get
            {
                return GetAppConfig("Amazone_S3:SaleLocations");
            }
        }
        public static string AMAZONE_S3_BUCKET_USER_AVATARS
        {
            get
            {
                return GetAppConfig("Amazone_S3:UserAvatars");
            }
        }
        public static string AMAZONE_S3_BUCKET_PRODUCTS
        {
            get
            {
                return GetAppConfig("Amazone_S3:Products");
            }
        }
        public static string AMAZONE_S3_BUCKET_FILES
        {
            get
            {
                return GetAppConfig("Amazone_S3:Files");
            }
        }
        public static string AMAZONE_S3_BUCKET_STOCKS
        {
            get
            {
                return GetAppConfig("Amazone_S3:Stocks");
            }
        }
        public static string AMAZONE_S3_BUCKET_DEVICE_VERSIONS
        {
            get
            {
                return GetAppConfig("Amazone_S3:DeviceVersion");
            }
        }

        public static String AMAZONE_S3_FOLDER_LISTING_URL
        {
            get
            {
                return GetAppConfig("Amazone_S3:FolderListingUrl");
            }
        }

        public static string FTP_SERVER_ADDRESS
        {
            get
            {
                return GetAppConfig("FTPServer:Address");
            }
        }

        public static string FTP_SERVER_USER
        {
            get
            {
                return GetAppConfig("FTPServer:User");
            }
        }

        public static string FTP_SERVER_PASSWORD
        {
            get
            {
                return GetAppConfig("FTPServer:Password");
            }
        }
        public static string AMAZONE_S3_BUCKET_NAME
        {
            get
            {
                return GetAppConfig("Amazone_S3:BucketName");
            }
        }

        public static string AMAZONE_S3_LOGS_BUCKET_NAME
        {
            get
            {
                return GetAppConfig("Amazone_S3:LogsBucketName");
            }
        }

        public static string AMAZONE_S3_LOGS_FOLDER
        {
            get
            {
                return GetAppConfig("Amazone_S3:LogsFolder");
            }
        }

        public static string GetAppConfig(string val)
        {
            return Configuration.GetValue<string>(val) ?? string.Empty;
        }

        public static string ENVIRONMENT_NAME
        {
            get
            {
                return GetAppConfig("EnvironmentName");
            }
        }

        public static string TICKET_ONLINE_HOST
        {
            get
            {
                return GetAppConfig("TICKET_ONLINE_HOST");
            }
        }
        public static string STRIPE_SECRET_KEY
        {
            get
            {
                return GetAppConfig("Stripe:SecretKey");
            }
        }

        public static string API_URL
        {
            get
            {
                return GetAppConfig("ApiUrl");
            }
        }

        public static string STRIPE_WEBHOOK_KEY
        {
            get
            {
                return GetAppConfig("Stripe:WebhookKey");
            }
        }


        public static string GWR_ORDER_STATUS_NEW_UID
        {
            get
            {
                return GetAppConfig("GwrConstants:OrderStatusNewUid");
            }
        }

        public static string DEFAULT_IMAGE_PRODUCT
        {
            get
            {
                return GetAppConfig("DefaultImage:Product");
            }
        }
        public static string GWR_LINK
        {
            get
            {
                return GetAppConfig("GwrConstants:URL");
            }
        }

        public static string DEFAULT_TICKET_ONLINE_HOST
        {
            get
            {
                return GetAppConfig("Payments:Pay360:DefaultTicketOnlineHost");
            }
        }
        public static string DEFAULT_URL_PAYMENT
        {
            get
            {
                return GetAppConfig("Payments:Pay360:DefaultUrlPayment");
            }
        }
        public static string DEFAULT_BACK_URL
        {
            get
            {
                return GetAppConfig("Payments:Pay360:DefaultBackUrl");
            }
        }

        public static string PAYPAL_CLIENT_ID
        {
            get
            {
                return GetAppConfig("Paypal:clientId");
            }
        }

        public static string PAYPAL_CLIENT_SECRET
        {
            get
            {
                return GetAppConfig("Paypal:secret");
            }
        }

        public static string PAYPAL_ENV
        {
            get
            {
                return GetAppConfig("Paypal:env");
            }
        }
        public static string AMAZON_S3_ENVIRONMENT
        {
            get
            {
                return GetAppConfig("EnvironmentName");
            }
        }
        public static string AMAZONE_S3_BUCKET_CKFINDER
        {
            get
            {
                return GetAppConfig("Amazone_S3:CKFinder");
            }
        }

        public static string UAT_LOGIN_URL
        {
            get
            {
                return GetAppConfig("LoginURLFirstTime");
            }
        }

        public static string FE_BW_LOGIN_URL
        {
            get
            {
                return GetAppConfig("FeBwLoginUrl");
            }
        }

        public static string SHOPIFYSHARP_MY_SHOPIFY_URL
        {
            get
            {
                return GetAppConfig("Shopify:SHOPIFYSHARP_MY_SHOPIFY_URL");
            }
        }

        public static string SHOPIFY_PRIVATE_APP_PASSWORD
        {
            get
            {
                return GetAppConfig("Shopify:PRIVATE_APP_PASSWORD");
            }
        }

        public static string SHOPIFYSHARP_SECRET_KEY
        {
            get
            {
                return GetAppConfig("Shopify:SHOPIFYSHARP_SECRET_KEY");
            }
        }

        public static string SHOPIFYSHARP_API_KEY
        {
            get
            {
                return GetAppConfig("Shopify:SHOPIFYSHARP_API_KEY");
            }
        }

        public static string AZUREAD_TENANTID
        {
            get
            {
                return GetAppConfig("AzureAd:TenantId");
            }
        }

        public static string AZUREAD_CLIENTID
        {
            get
            {
                return GetAppConfig("AzureAd:ClientId");
            }
        }

        public static string AZUREAD_CLIENTSECRET
        {
            get
            {
                return GetAppConfig("AzureAd:ClientSecret");
            }
        }

        public static string SHOPIFY_VENDOR_NAME_SETTING
        {
            get
            {
                return "Shopify Vendor Name";

            }
        }

        public static string SHOPIFY_SETTING_NAME
        {
            get
            {
                return "Shopify Functions";

            }
        }

        public static string E_RECEIPT_LOGO
        {
            get
            {
                return "E-receipt logo";
            }
        }

        public static string E_OWNER_LOGO
        {
            get
            {
                return "E-owner logo";
            }
        }

        public static string E_RECEIPT_FOOTER
        {
            get
            {
                return "E-receipt footer";

            }
        }

        public static string E_FOOTER_IMAGE_URL
        {
            get
            {
                return "E-Footer image url";

            }
        }

        public static string E_CLIENT_NAME_TITLE
        {
            get
            {
                return "Client name title";

            }
        }

        public static string E_CLIENT_NAME_FOOTER
        {
            get
            {
                return "Client name footer";

            }
        }

        public static string DEFAULT_ECR_DEVICE_ADMIN_ROLE
        {
            get
            {
                return GetAppConfig("DefaultDeviceRoleName");
            }
        }

        public static string MICROSOFT_GRAPH_CLIENT_ID
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:ClientId");
            }
        }

        public static string MICROSOFT_GRAPH_CLIENT_DIRECTORY_ID
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:DirectoryId");
            }
        }

        public static string MICROSOFT_GRAPH_CLIENT_SECRECT
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:ClientSecret");
            }
        }

        public static string MICROSOFT_GRAPH_FROM_MAIL
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:FromMail");

            }
        }

        public static string MICROSOFT_GRAPH_SCOPE_URL
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:ScopeUrl");
            }
        }

        public static string MICROSOFT_GRAPH_AUTHORITY_URL
        {
            get
            {
                return GetAppConfig("MicrosoftGraphConfiguration:AuthorityUrl");
            }
        }

        public static string DEFAULT_AZURE_AD_ROLE
        {
            get
            {
                return GetAppConfig("DefaultAzureADRoleName");
            }
        }

        public static string APNS_CONFIGURATION_ENVIRONMENT
        {
            get
            {
                return GetAppConfig("ApnsConfig:Environment");
            }
        }

        public static string APNS_CONFIGURATION_PASSWORD
        {
            get
            {
                return GetAppConfig("ApnsConfig:Password");
            }
        }

        public static string APNS_CONFIGURATION_URL
        {
            get
            {
                return GetAppConfig("ApnsConfig:Url");
            }
        }

        public static string APICONNECTION
        {
            get
            {
                return GetAppConfig("ConnectionStrings:ApiConnection");
            }
        }

        public static string TRANSACTIONCONNECTION
        {
            get
            {
                return GetAppConfig("ConnectionStrings:TransactionConnection");
            }
        }
        public static string CUSTOMERCONNECTION
        {
            get
            {
                return GetAppConfig("ConnectionStrings:TicketingCustomerConnection");
            }
        }

        public static string TICKETINGCONNECTION
        {
            get
            {
                return GetAppConfig("ConnectionStrings:TicketingConnection");
            }
        }

        public static string DECRYPTIONKEY
        {
            get
            {
                return GetAppConfig("Decryption:Key");
            }
        }

        public static string TWO_FA_CONFIGURATION_ALLOW
        {
            get
            {
                return GetAppConfig("2FAConfiguration:IsAllow");
            }
        }

        public static string TWO_FA_CONFIGURATION_API_KEY
        {
            get
            {
                return GetAppConfig("2FAConfiguration:AuthyApiKey");
            }
        }

        public static string TWO_FA_CONFIGURATION_URL
        {
            get
            {
                return GetAppConfig("2FAConfiguration:AuthyUrl");
            }
        }

        public static int LOGIN_ATTEMPT_NUMBER
        {
            get
            {
                int value = 1;
                Int32.TryParse(GetAppConfig("LoginAttempt"), out value);
                return value;
            }
        }

        public static string AMAZONE_S3_BUCKET_PRODUCTGROUP
        {
            get
            {
                return GetAppConfig("Amazone_S3:ProductGroups");
            }
        }

        public static string SECURITY_EMAIL_ADDRESS
        {
            get
            {
                return GetAppConfig("SecurityEmail:Email");
            }
        }

        public static string SECURITY_EMAIL_NAME
        {
            get
            {
                return GetAppConfig("SecurityEmail:Name");
            }
        }

        public static string SECURITY_EMAIL_ACCOUNT
        {
            get
            {
                return GetAppConfig("SecurityEmail:Account");
            }
        }

        public static string SECURITY_EMAIL_PASSWORD
        {
            get
            {
                return GetAppConfig("SecurityEmail:Password");
            }
        }
        public static string OPAYO_PAYMENT_KEY
        {
            get
            {
                return GetAppConfig("Payments:Opayo:IntegrationKey");
            }
        }
        public static string OPAYO_PAYMENT_PASSWORD
        {
            get
            {
                return GetAppConfig("Payments:Opayo:IntegrationPassword");
            }
        }
        public static string OPAYO_PAYMENT_VENDOR
        {
            get
            {
                return GetAppConfig("Payments:Opayo:VendorName");
            }
        }
        public static string OPAYO_PAYMENT_URL
        {
            get
            {
                return GetAppConfig("Payments:Opayo:Url");
            }
        }
        public static string WORLDPAY_MERCHANT_CODE
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:MerchantCode");
            }
        }
        public static string WORLDPAY_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:Url");
            }
        }
        public static string WORLDPAY_USERNAME
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:Username");
            }
        }
        public static string WORLDPAY_XMLPASSWORD
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:XMLPassword");
            }
        }
        public static string WORLDPAY_SUCCESS_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:successURL");
            }
        }
        public static string WORLDPAY_FAILURE_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:failureURL");
            }
        }
        public static string WORLDPAY_CANCEL_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:cancelURL");
            }
        }
        public static string WORLDPAY_ERROR_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:errorURL");
            }
        }

        public static string WORLDPAY_MAC_SECRET
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:macSecret");
            }
        }

        public static string WORLDPAY_MODE
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:mode");
            }
        }

        public static string WORLDPAY_INSTALLATION_ID
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:InstallationId");
            }
        }

        public static string WORLDPAY_BOOKING_SITE_URL
        {
            get
            {
                return GetAppConfig("Payments:WorldPay:BookingSiteUrl");
            }
        }



        public static string AMAZONE_S3_BUCKET_TICKETINGVENUE
        {
            get
            {
                return GetAppConfig("Amazone_S3:TicketingVenues");
            }
        }
        public static string EMAIL_METHOD
        {
            get
            {
                return GetAppConfig("EmailMethod");
            }
        }
        public static string FULL_PAYMENT_URL
        {
            get
            {
                return GetAppConfig("SendMailConfiguration:FullPayment");
            }
        }

        public static string QR_CODE_GENERATOR_URL
        {
            get
            {
                return GetAppConfig("QRCodeGeneratorURL");
            }
        }

        public static string DEPOSIT_PAYMENT_URL
        {
            get
            {
                return GetAppConfig("SendMailConfiguration:DepositPayment");
            }
        }
        public static string SECURITY_GRAPH_EMAIL_ADDRESS
        {
            get
            {
                return GetAppConfig("SecurityEmail:GraphEmail");
            }
        }
        public static string ALARM_EMAIL
        {
            get
            {
                return GetAppConfig("Alarm:Email");
            }
        }

        public static string ALARM_ABANDONED_BOOKING_THRESHOLD
        {
            get
            {
                return GetAppConfig("Alarm:NumberOfAbandonedBookingThreshold");
            }
        }
        public static string MEMBERSHIP_API
        {
            get
            {
                return GetAppConfig("MembershipProxy:Url");
            }
        }

        public static RegionEndpoint AMAZONE_REGION
        {
            get
            {
                var region = GetAppConfig("AmazoneSettings:Region");
                return RegionEndpoint.GetBySystemName(region);
            }
        }

        public static string AMAZON_SQS_TRANSACTIONS_ACCESS_KEY_ID
        {
            get
            {
                return GetAppConfig("AmazonSQSTransactions:accessKeyId");
            }
        }

        public static string AMAZON_SQS_TRANSACTIONS_SECRET_ACCESS_KEY
        {
            get
            {
                return GetAppConfig("AmazonSQSTransactions:secretAccessKey");
            }
        }

        public static string CUSTOMER_VERIFY_EMAIL_URL
        {
            get
            {
                return GetAppConfig("CustomerVerifyEmailUrl");
            }
        }


        public static string CLIENT_FOR_SEND_EMAIL
        {
            get
            {
                return GetAppConfig("ClientName");
            }
        }
        public static string PAY360_URL
        {
            get
            {
                return GetAppConfig("Payments:Pay360:url");
            }
        }

        public static string PAY360_INSTID
        {
            get
            {
                return GetAppConfig("Payments:Pay360:instid");
            }
        }

        public static string PAY360_USERNAME
        {
            get
            {
                return GetAppConfig("Payments:Pay360:username");
            }
        }

        public static string PAY360_PASSWORD
        {
            get
            {
                return GetAppConfig("Payments:Pay360:password");
            }
        }

        public static string PAY360_SCPIDENTIFIER
        {
            get
            {
                return GetAppConfig("Payments:Pay360:scpIdentifier");
            }
        }

        public static string PAY360_SITEID
        {
            get
            {
                return GetAppConfig("Payments:Pay360:siteId");
            }
        }

        public static string PAY360_HMACKEYID
        {
            get
            {
                return GetAppConfig("Payments:Pay360:hmacKeyID");
            }
        }

        public static string PAY360_HMACKEY
        {
            get
            {
                return GetAppConfig("Payments:Pay360:hmacKey");
            }
        }
        public static string PAY360_FUNDCODE
        {
            get
            {
                return GetAppConfig("Payments:Pay360:FundCode");
            }
        }

        public static string LOGO_EMAIL
        {
            get
            {
                return GetAppConfig("Logo:EmailLogo");
            }
        }

        public static string LOGO_EMAIL_CONFIRM
        {
            get
            {
                return GetAppConfig("Logo:ConfirmLogo");
            }
        }
        public static string PARTNER_API
        {
            get
            {
                return GetAppConfig("internalApis:PartnerApi");
            }
        }

        public static string OWNER_NAME
        {
            get
            {
                return GetAppConfig("ApplicationInfo:OwnerName");
            }
        }
        public static string OWNER_SITE_NAME
        {
            get
            {
                return GetAppConfig("ApplicationInfo:OwnerSiteName");
            }
        }
        public static string OWNER_SITE_URL
        {
            get
            {
                return GetAppConfig("ApplicationInfo:OwnerSiteUrl");
            }
        }

        public static string GetEmailTemplate(string temaplate)
        {
            return GetAppConfig($"EmailTemplate:{temaplate}");
        }
    }
}
