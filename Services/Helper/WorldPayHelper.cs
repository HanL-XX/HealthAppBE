using DTOs;
using Newtonsoft.Json;
using Services.Common;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using Common.Constant;

namespace Services.Helper
{
    public class WorldPayHelper
    {
        //        public async static Task<TicketingWorldPayModel> CreateTransaction(TicketingWorldPayCreateTransactionModel model, WorldPayRequest requestmodel, double price, string Currency, ErrorModel errors)
        //        {
        //            var result = new TicketingWorldPayModel();
        //            var paymentHistory = new TicketingPaymentHistoryCreateModel();
        //            try
        //            {
        //                var httpClient = new HttpClient();
        //                var authContent = UtilService.EncodeTo64($"{model.Username}:{model.XMLPassword}");
        //                httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //                var orderKey = (requestmodel.PartPaymentId != null ? "part_" + requestmodel.PartPaymentId : "booking_" + requestmodel.BookingId) + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
        //                var dataToSend = GetRequestPaymentData(model, requestmodel, orderKey, price, Currency);
        //                result.TransactionId = orderKey;
        //                var response = await httpClient.PostAsync(
        //                    new Uri(model.Url),
        //                    new StringContent(dataToSend, Encoding.UTF8, "application/xml"));

        //                var responseString = await response.Content.ReadAsStringAsync();
        //                if (response.StatusCode == System.Net.HttpStatusCode.OK)
        //                {
        //                    var resultXML = XElement.Parse(responseString);
        //                    dynamic resultDynamic = new Dictionary<string, object>();
        //                    XmlToDynamic.Parse(resultDynamic, resultXML);
        //                    // 
        //                    var reply = resultDynamic["paymentService"].reply;
        //                    if (((IDictionary<string, object>)reply).ContainsKey("error"))
        //                    {
        //                        result.Message = reply.error;
        //                        result.Success = false;
        //                    } else
        //                    {
        //                        reply.orderStatus.reference += "&successURL=" + HttpUtility.UrlEncode(model.successURL);
        //                        reply.orderStatus.reference += "&failureURL=" + HttpUtility.UrlEncode(model.failureURL);
        //                        reply.orderStatus.reference += "&cancelURL=" + HttpUtility.UrlEncode(model.cancelURL);
        //                        reply.orderStatus.reference += "&errorURL=" + HttpUtility.UrlEncode(model.errorURL);
        //                        reply.orderStatus.reference += "&pendingURL=" + HttpUtility.UrlEncode(model.errorURL);
        //                        reply.orderStatus.reference += "&expiryURL=" + HttpUtility.UrlEncode(model.errorURL);
        //                        result.Message = reply.orderStatus.reference;
        //                        result.Success = true;
        //                    }

        //                    paymentHistory.PaymentStatus = PaymentStatus.WorldPayInitPaymentSuccess;
        //                }
        //                else
        //                {
        //                    paymentHistory.PaymentStatus = PaymentStatus.WorldPayInitPaymentFail;
        //                }

        //                paymentHistory.PaymentId = orderKey;
        //                paymentHistory.ResponseCode = (int) response.StatusCode;
        //                paymentHistory.Value = Math.Round(price + 0.001, 2) * 100;
        //                var doc = new XmlDocument();
        //                doc.LoadXml(dataToSend);
        //                paymentHistory.RequestContentBody = JsonConvert.SerializeXmlNode(doc);
        //                doc = new XmlDocument();
        //                doc.LoadXml(responseString);
        //                paymentHistory.ResponseContentBody = JsonConvert.SerializeXmlNode(doc);
        //                paymentHistory.BookingId = requestmodel.BookingId;

        //                result.TicketingPaymentHistoryCreateModel = paymentHistory;
        //            }
        //            catch (Exception e)
        //            {
        //                result.Success = false;
        //                result.FailureReason = e.Message;
        //                result.Message = "We are sorry, these was an error processing your payment. Please try again with a different payment method.";
        //            }
        //            return result;
        //        }

        //        public async static Task<TicketingRefundModel> RefundTransaction(TicketingWorldPayCreateTransactionModel model, string orderCode, double price, string Currency)
        //        {
        //            var result = new TicketingRefundModel();
        //            try
        //            {
        //                //string paymentStatus = await GetTransactionStatus(model, orderCode);

        //                //if (paymentStatus == "AUTHORISED")
        //                //{
        //                //    // cancel
        //                //    return await CancelTransaction(model,orderCode, price, Currency);
        //                //}
        //                var httpClient = new HttpClient();
        //                var authContent = UtilService.EncodeTo64($"{model.Username}:{model.XMLPassword}");
        //                httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //                var dataToSend = GetCancelOrRefund(model.MerchantCode,orderCode);
        //                var response = await httpClient.PostAsync(
        //                    new Uri(model.Url),
        //                    new StringContent(dataToSend, Encoding.UTF8, "application/xml"));

        //                var responseString = await response.Content.ReadAsStringAsync();
        //                if (response.StatusCode == System.Net.HttpStatusCode.OK)
        //                {
        //                    var resultXML = XElement.Parse(responseString);
        //                    dynamic resultDynamic = new Dictionary<string, object>();
        //                    XmlToDynamic.Parse(resultDynamic, resultXML);
        //                    // 
        //                    var reply = resultDynamic["paymentService"].reply;
        //                    if (((IDictionary<string, object>)reply).ContainsKey("error"))
        //                    {
        //                        result.Message = reply.error;
        //                        result.Success = false;
        //                    }

        //                    if (((IDictionary<string, object>)reply).ContainsKey("ok"))
        //                    {
        //                        result.Success = true;
        //                    }

        //                }
        //            }
        //            catch (Exception e)
        //            {
        //                result.Success = false;
        //                result.FailureReason = e.Message;
        //                result.Message = "We are sorry, these was an error processing refund request.";
        //            }
        //            return result;
        //        }
        //        public async static Task<TicketingRefundModel> PartialRefundTransaction(TicketingWorldPayCreateTransactionModel model, string orderCode, double price, string Currency)
        //        {
        //            var result = new TicketingRefundModel();
        //            try
        //            {
        //                var httpClient = new HttpClient();
        //                var authContent = UtilService.EncodeTo64($"{model.Username}:{model.XMLPassword}");
        //                httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //                var dataToSend = GetRefundData(model.MerchantCode, orderCode, price, Currency);
        //                var response = await httpClient.PostAsync(
        //                    new Uri(model.Url),
        //                    new StringContent(dataToSend, Encoding.UTF8, "application/xml"));

        //                var responseString = await response.Content.ReadAsStringAsync();
        //                if (response.StatusCode == System.Net.HttpStatusCode.OK)
        //                {
        //                    var resultXML = XElement.Parse(responseString);
        //                    dynamic resultDynamic = new Dictionary<string, object>();
        //                    XmlToDynamic.Parse(resultDynamic, resultXML);
        //                    // 
        //                    var reply = resultDynamic["paymentService"].reply;
        //                    if (((IDictionary<string, object>)reply).ContainsKey("error"))
        //                    {
        //                        result.Message = reply.error;
        //                        result.Success = false;
        //                    }

        //                    if (((IDictionary<string, object>)reply).ContainsKey("ok"))
        //                    {
        //                        result.Success = true;
        //                    }

        //                }
        //            }
        //            catch (Exception e)
        //            {
        //                result.Success = false;
        //                result.FailureReason = e.Message;
        //                result.Message = "We are sorry, these was an error processing refund request.";
        //            }
        //            return result;
        //        }
        //        public async static Task<TicketingRefundModel>CancelTransaction(TicketingWorldPayCreateTransactionModel model, string orderCode, double price, string Currency)
        //        {
        //            var result = new TicketingRefundModel();
        //            try
        //            {

        //                var httpClient = new HttpClient();
        //                var authContent = UtilService.EncodeTo64($"{model.Username}:{model.XMLPassword}");
        //                httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //                var dataToSend = GetCancel(model.MerchantCode, orderCode);
        //                var response = await httpClient.PostAsync(
        //                    new Uri(model.Url),
        //                    new StringContent(dataToSend, Encoding.UTF8, "application/xml"));

        //                var responseString = await response.Content.ReadAsStringAsync();
        //                if (response.StatusCode == System.Net.HttpStatusCode.OK)
        //                {
        //                    var resultXML = XElement.Parse(responseString);
        //                    dynamic resultDynamic = new Dictionary<string, object>();
        //                    XmlToDynamic.Parse(resultDynamic, resultXML);
        //                    // 
        //                    var reply = resultDynamic["paymentService"].reply;
        //                    if (((IDictionary<string, object>)reply).ContainsKey("error"))
        //                    {
        //                        result.Message = reply.error;
        //                        result.Success = false;
        //                    }

        //                    if (((IDictionary<string, object>)reply).ContainsKey("ok"))
        //                    {
        //                        result.Success = true;
        //                    }

        //                }
        //            }
        //            catch (Exception e)
        //            {
        //                result.Success = false;
        //                result.FailureReason = e.Message;
        //                result.Message = "We are sorry, these was an error processing refund request.";
        //            }
        //            return result;
        //        }

        //        public async static Task<string> GetTransactionStatus(TicketingWorldPayCreateTransactionModel model, string orderCode)
        //        {
        //            try
        //            {
        //                var httpClient = new HttpClient();
        //                var authContent = UtilService.EncodeTo64($"{model.Username}:{model.XMLPassword}");
        //                httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //                var dataToSend = GetPaymentStatus(model.MerchantCode, orderCode);
        //                var response = await httpClient.PostAsync(
        //                    new Uri(model.Url),
        //                    new StringContent(dataToSend, Encoding.UTF8, "application/xml"));

        //                var responseString = await response.Content.ReadAsStringAsync();
        //                if (response.StatusCode == System.Net.HttpStatusCode.OK)
        //                {
        //                    var resultXML = XElement.Parse(responseString);
        //                    dynamic resultDynamic = new Dictionary<string, object>();
        //                    XmlToDynamic.Parse(resultDynamic, resultXML);
        //                    // 
        //                    var reply = resultDynamic["paymentService"].reply;
        //                    if (((IDictionary<string, object>)reply).ContainsKey("orderStatus"))
        //                    {
        //                        return reply.orderStatus.payment.lastEvent;
        //                    }
        //                }
        //            }
        //            catch (Exception e)
        //            {

        //            }
        //            return "error";
        //        }

        //        public static bool VerifyMAC(string input, string secret, string mac)
        //        {
        //            var hash = new HMACSHA256(Encoding.ASCII.GetBytes(secret));
        //            var verify = BitConverter.ToString(hash.ComputeHash(Encoding.ASCII.GetBytes(input)));
        //            return verify.ToLower().Equals(mac.ToLower());
        //        }

        //        private static string GetRequestPaymentData(TicketingWorldPayCreateTransactionModel model, WorldPayRequest requestmodel, string orderKey, double price, string Currency)
        //        {
        //            string priceInt = Math.Round(price * 100, 0, MidpointRounding.AwayFromZero).ToString();
        //            var xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
        //<!DOCTYPE paymentService PUBLIC ""-//Worldpay//DTD Worldpay PaymentService v1//EN"" ""http://dtd.worldpay.com/paymentService_v1.dtd"">
        //<paymentService version=""1.4"" merchantCode=""" + model.MerchantCode + @"""> <!--Enter your own merchant code-->
        //   <submit>
        //      <order orderCode=""" + orderKey + @""" captureDelay=""0"" installationId="""+model.InstallationId+@"""> 
        //         <description>Purchase for Booking reference: " + requestmodel.BookingNo + @"</description> <!--Enter a description useful to you-->
        //         <amount currencyCode=""" + Currency + @""" exponent=""2"" value=""" + priceInt + @""" />
        //         <paymentMethodMask>
        //            <include code=""ALL"" />
        //         </paymentMethodMask>

        //      </order>
        //   </submit>
        //</paymentService>";
        //            return xml;
        //        }

        //        private static string GetRefundData(string merchantCode, string orderCode, double amount, string currencyCode)
        //        {
        //            string priceInt = Math.Round(amount * 100, 0, MidpointRounding.AwayFromZero).ToString();
        //            var xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
        //                <!DOCTYPE paymentService PUBLIC ""-//WorldPay//DTD WorldPay PaymentService v1//EN""
        //                ""http://dtd.worldpay.com/paymentService_v1.dtd"">
        //                <paymentService merchantCode=""" + merchantCode + @""" version=""1.4"">
        //                  <modify>
        //                    <orderModification orderCode=""" + orderCode + @""">
        //                      <refund>
        //                        <amount value=""" + priceInt + @""" currencyCode=""" + currencyCode + @""" exponent=""2""/>
        //                      </refund>
        //                    </orderModification>
        //                  </modify>
        //                </paymentService>";
        //            return xml;
        //        }

        //        private static string GetPaymentStatus(string merchantCode, string orderCode)
        //        {
        //            var xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
        //                <!DOCTYPE paymentService PUBLIC ""-//WorldPay//DTD WorldPay PaymentService v1//EN""
        //                ""http://dtd.worldpay.com/paymentService_v1.dtd"">
        //                <paymentService merchantCode=""" + merchantCode + @""" version=""1.4"">
        //                   <inquiry>
        //                    <orderInquiry orderCode="""+orderCode+@"""/> <!--Enter the relevant order code-->
        //                  </inquiry >
        //                </paymentService>";
        //            return xml;
        //        }

        //        private static string GetCancel(string merchantCode, string orderCode)
        //        {
        //            var xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
        //                <!DOCTYPE paymentService PUBLIC ""-//WorldPay//DTD WorldPay PaymentService v1//EN""
        //                ""http://dtd.worldpay.com/paymentService_v1.dtd"">
        //                <paymentService merchantCode=""" + merchantCode + @""" version=""1.4"">
        //                   <modify>
        //                    <orderModification orderCode=""" + orderCode + @"""> <!--The unique order code for this payment-->
        //                      <cancel/>
        //                    </orderModification >
        //                  </modify >
        //                </paymentService>";
        //            return xml;
        //        }

        //        private static string GetCancelOrRefund(string merchantCode, string orderCode)
        //        {
        //            var xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
        //                <!DOCTYPE paymentService PUBLIC ""-//WorldPay//DTD WorldPay PaymentService v1//EN""
        //                ""http://dtd.worldpay.com/paymentService_v1.dtd"">
        //                <paymentService merchantCode=""" + merchantCode + @""" version=""1.4"">
        //                   <modify>
        //                    <orderModification orderCode=""" + orderCode + @"""> <!--The unique order code for this payment-->
        //                      <cancelOrRefund/>
        //                    </orderModification >
        //                  </modify >
        //                </paymentService>";
        //            return xml;
        //        }
    }
}
