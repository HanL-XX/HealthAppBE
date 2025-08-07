using DTOs;
using Newtonsoft.Json;
using Services.Common;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Common.Helpers;
using Entities;
using Common.Constant;
using System.Dynamic;
using Microsoft.AspNetCore.Http;
using Microsoft.Graph;

namespace Services.Helper
{
    public static class OpayoPaymentHelper
    {
        //public async static Task<string> CreateMerchantSessionKey(TicketingCreateMarchantSessionKeyModel model, ErrorModel errors)
        //{
        //    var httpClient = new HttpClient();
        //    var authContent = UtilService.EncodeTo64($"{model.IntegrationKey}:{model.IntegrationPassword}");
        //    httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //    var dataJson = JsonConvert.SerializeObject(new { vendorName = model.VendorName });

        //    var response = await httpClient.PostAsync(
        //        new Uri(model.Url), 
        //        new StringContent(dataJson, Encoding.UTF8, "application/json"));

        //    var responseString = await response.Content.ReadAsStringAsync();
        //    dynamic responseJson = JsonConvert.DeserializeObject(responseString);

        //    // successful json format: {merchantSessionKey, expiry}
        //    if (response.IsSuccessStatusCode)
        //    {
        //        string marchantSessionKey = responseJson.merchantSessionKey;
        //        return marchantSessionKey;
        //    }
        //    // error json format: {description, code}
        //    else
        //    {
        //        string errorDescription = responseJson.description;
        //        errors.Add(errorDescription);
        //        return null;
        //    }
        //}

        //public async static Task<TicketingOpayoModel> CreateTransaction(TicketingCreateMarchantSessionKeyModel model, OpayoPaymentRequest requestmodel, TicketingUnregisteredCustomer customer, double price, string Currency, ErrorModel errors, Guid bookingId)
        //{
        //    var result = new TicketingOpayoModel();
        //    var paymentHistory = new TicketingPaymentHistoryCreateModel();
        //    try
        //    {
        //        var httpClient = new HttpClient();
        //        var authContent = UtilService.EncodeTo64($"{model.IntegrationKey}:{model.IntegrationPassword}");
        //        httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");

        //        dynamic billingAddress = new ExpandoObject();
        //        billingAddress.address1 = requestmodel.Address;
        //        billingAddress.city = requestmodel.City;
        //        billingAddress.country = requestmodel.Country;
        //        billingAddress.postalCode = requestmodel.PostalCode;
        //        if (requestmodel.Country == CountryCode.US)
        //        {
        //            billingAddress.state = requestmodel.State;
        //        }

        //        var dataJson = JsonConvert.SerializeObject(new
        //        {
        //            amount = (int)(price * 100),
        //            currency = Currency,
        //            entryMethod = "Ecommerce",
        //            transactionType = "Payment",
        //            apply3DSecure = "Disable",
        //            applyAvsCvcCheck = "Disable",
        //            description = "Create transaction",
        //            customerFirstName = customer.FirstName,
        //            customerLastName = customer.LastName,
        //            paymentMethod = new
        //            {
        //                card = new
        //                {
        //                    merchantSessionKey = requestmodel.MerchantSessionKey,
        //                    cardIdentifier = requestmodel.CardIdentifier
        //                }
        //            },
        //            billingAddress = billingAddress,
        //            vendorTxCode = "transaction-" + DateTime.Now.ToString("yyyyMMddHHmmssfff")
        //        });

        //        var response = await httpClient.PostAsync(
        //            new Uri(model.Url),
        //            new StringContent(dataJson, Encoding.UTF8, "application/json"));

        //        var responseString = await response.Content.ReadAsStringAsync();
        //        dynamic responseJson = JsonConvert.DeserializeObject(responseString);

        //        result.Amount = price;
        //        result.Status = responseJson.status;
        //        result.TransactionId = responseJson.transactionId;

        //        if (response.IsSuccessStatusCode && responseJson.status == OpayoTransactionStatusCode.OK)
        //        {
        //            result.Success = true;
        //            paymentHistory.PaymentStatus = PaymentStatus.OpayoPaymentSuccess;
        //        }
        //        else
        //        {
        //            result.Success = false;
        //            result.FailureReason = responseJson.statusDetail; 
        //            result.Message = "We are sorry, these was an error processing your payment. Please try again with a different payment method.";
        //            paymentHistory.PaymentStatus = PaymentStatus.OpayoPaymentFail;
        //        }

        //        paymentHistory.BookingId = bookingId;
        //        paymentHistory.PaymentId = responseJson.transactionId;
        //        paymentHistory.RequestContentBody = dataJson;
        //        paymentHistory.ResponseContentBody = responseString;
        //        paymentHistory.Value = Math.Round(price + 0.001, 2) * 100;
        //        paymentHistory.ResponseCode = (responseJson.status) switch
        //        {
        //            OpayoTransactionStatusCode.OK => StatusCodes.Status200OK,
        //            OpayoTransactionStatusCode.NOT_AUTHED => StatusCodes.Status401Unauthorized,
        //            _ => StatusCodes.Status200OK
        //        };

        //        result.PaymentHistoryCreateModel = paymentHistory;
        //    }
        //    catch (Exception e)
        //    {
        //        result.Success = false;
        //        result.FailureReason = e.Message;
        //        result.Message = "We are sorry, these was an error processing your payment. Please try again with a different payment method.";
        //    }
        //    return result;
        //}

        //public async static Task<TicketingRefundModel> CreateRefundTransaction(string opayoTransactionId, double price)
        //{
        //    var result = new TicketingRefundModel();
        //    try
        //    {
        //        var httpClient = new HttpClient();
        //        var authContent = UtilService.EncodeTo64($"{Settings.OPAYO_PAYMENT_KEY}:{Settings.OPAYO_PAYMENT_PASSWORD}");
        //        httpClient.DefaultRequestHeaders.Add("Authorization", $"Basic {authContent}");
        //        var dataJson = JsonConvert.SerializeObject(new
        //        {
        //            amount = (int)(price * 100),
        //            transactionType = "Refund",
        //            referenceTransactionId = opayoTransactionId,
        //            description = "Create refund transaction",
        //            vendorTxCode = "refundtransaction-" + DateTime.Now.ToString("yyyyMMddHHmmssfff")
        //        });

        //        var response = await httpClient.PostAsync(
        //            new Uri(Settings.OPAYO_PAYMENT_URL + "transactions"),
        //            new StringContent(dataJson, Encoding.UTF8, "application/json"));

        //        var responseString = await response.Content.ReadAsStringAsync();
        //        dynamic responseJson = JsonConvert.DeserializeObject(responseString);
        //        result.Status = responseJson.status;

        //        if (response.IsSuccessStatusCode && responseJson.status == OpayoTransactionStatusCode.OK)
        //        {
        //            result.Success = true;
        //        }
        //        else
        //        {
        //            result.Success = false;
        //            result.FailureReason = responseJson.statusDetail;
        //            result.Message = "We are sorry, these was an error processing your refund.";
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        result.Success = false;
        //        result.FailureReason = e.Message;
        //        result.Message = "We are sorry, these was an error processing your refund.";
        //    }
        //    return result;
        //}
    }
}
