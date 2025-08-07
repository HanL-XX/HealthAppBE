using DTOs;
using Common.Constant;
using Common.Helpers;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using Entities;

namespace Services.Helper
{
    public static class StripeHelper
    {
        //public static string StripeCharge(string stripeCardToken, int price)
        //{
        //    try
        //    {
        //        var chargeOptions = new ChargeCreateOptions()
        //        {
        //            Amount = (int)(price * 100),
        //            Currency = GlobalConstant.DEFAULT_CURRENCY_CODE.ToLower(),
        //            Source = stripeCardToken
        //        };

        //        var chargeService = new ChargeService();

        //        var charge = chargeService.Create(chargeOptions);

        //        return charge.Id;
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static string StripeChargeWithCurrencyCode(string stripeCardToken, int price, string currencyCode)
        //{
        //    try
        //    {
        //        var chargeOptions = new ChargeCreateOptions()
        //        {
        //            Amount = (int)(price * 100),
        //            Currency = currencyCode.ToLower(),
        //            Source = stripeCardToken
        //        };

        //        if (string.IsNullOrEmpty(currencyCode))
        //        {
        //            chargeOptions.Currency = GlobalConstant.DEFAULT_CURRENCY_CODE.ToLower();
        //        }

        //        var chargeService = new ChargeService();

        //        var charge = chargeService.Create(chargeOptions);

        //        return charge.Id;
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static StripeIntentModel StripeCreatePaymentIntent(CreateBookingTransactionModel model, double price, string currencyCode, TicketingDbContext _dbContext, UserResolverService _userResolverService)
        //{
        //    var result = new StripeIntentModel();
        //    try
        //    {
        //        var paymentIntentService = new PaymentIntentService();
        //        var paymentMethodService = new PaymentMethodService();
        //        var paymentMethod = new Stripe.PaymentMethod();

        //        if (!string.IsNullOrEmpty(model.Token))  
        //        {

        //            var paymentMethodCreateOption = new PaymentMethodCreateOptions()
        //            {
        //                Type = "card",
        //                Card = new PaymentMethodCardOptions()
        //                {
        //                    Token = model.Token
        //                }
        //            };

        //            paymentMethod = paymentMethodService.Create(paymentMethodCreateOption);
        //        }

        //        var paymentIntentCreateOptions = new PaymentIntentCreateOptions()
        //        {
        //            Amount = GlobalHelpers.ConvertDoubleToIntForGlobalPay(price),
        //            Currency = currencyCode.ToLower(),
        //            CaptureMethod = "manual",
        //            PaymentMethod = string.IsNullOrEmpty(model.PaymentMethodId) ? paymentMethod.Id : model.PaymentMethodId,
        //            PaymentMethodTypes = new List<string>
        //            {
        //                "card",
        //            },
        //            Confirm = true
        //        };

        //        paymentIntentCreateOptions.Customer = null;

        //        if (string.IsNullOrEmpty(currencyCode))
        //        {
        //            paymentIntentCreateOptions.Currency = GlobalConstant.DEFAULT_CURRENCY_CODE.ToLower();
        //        }

        //        //GlobalHelpers.WriteLogTicketOnline("Data BEFORE pay STRIPE", "Data BEFORE pay STRIPE", "POST", String.Empty, GlobalHelpers.JsonSerialize(paymentIntentCreateOptions), String.Empty, null, 200, _dbContext);
        //        var intent = paymentIntentService.Create(paymentIntentCreateOptions);

        //        result.IntentId = intent.Id;
        //        result.PaymentMethodId = intent.PaymentMethodId;
        //        //result.Amount = (int)(price * 100);
        //        result.Amount = intent.Amount;
        //        result.Status = intent.Status;
        //        if (string.IsNullOrEmpty(model.PaymentMethodId))
        //        {
        //            result.Card = new StripeCardModel
        //            {
        //                Brand = paymentMethod.Card.Brand,
        //                Last4 = paymentMethod.Card.Last4
        //            };
        //        }
        //        else
        //        {
        //            paymentMethod = paymentMethodService.Get(model.PaymentMethodId);
        //            result.Card = new StripeCardModel
        //            {
        //                Brand = paymentMethod.Card.Brand,
        //                Last4 = paymentMethod.Card.Last4
        //            };
        //        }

        //        if (intent.Status == "succeeded" || intent.Status == "requires_capture")
        //        {
        //            // Handle post-payment fulfillment
        //            result.Success = true;
        //        }
        //        else if (intent.Status == "requires_action")
        //        {
        //            // Tell the client to handle the action
        //            result.Success = false;
        //            result.RequiresAction = true;
        //            result.ClientSecret = intent.ClientSecret;
        //        }
        //        else
        //        {
        //            // Any other status would be unexpected, so error
        //            result.Success = false;
        //            result.Message = "We are sorry, these was an error processing your payment. Please try again with a different payment method.";
        //        }
        //    }
        //    catch (StripeException e)
        //    {
        //        result.Success = false;
        //        result.Message = e.Message;
        //    }

        //    return result;
        //}

        //public static string StripeCapturePaymentIntent(string paymentIntendToken)
        //{
        //    try
        //    {
        //        var paymentIntentService = new PaymentIntentService();

        //        var intent = paymentIntentService.Capture(paymentIntendToken);

        //        return intent.Id;
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static string StripeCancelPaymentIntent(string paymentIntendToken)
        //{
        //    try
        //    {
        //        var paymentIntentService = new PaymentIntentService();

        //        var intent = paymentIntentService.Cancel(paymentIntendToken);

        //        return intent.Id;
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static Dictionary<string, string> StripeCreateCustomer(string source, StripeCustomerModel model)
        //{
        //    try
        //    {
        //        var paymentMethodService = new PaymentMethodService();
        //        var customerService = new CustomerService();

        //        var paymentMethodCreateOption = new PaymentMethodCreateOptions() {
        //            Type = "card",
        //            Card = new PaymentMethodCardOptions() {
        //                Token = source
        //            }
        //        };

        //        var paymentMethod = paymentMethodService.Create(paymentMethodCreateOption);

        //        var customerCreateOptions = new CustomerCreateOptions() {
        //            Name = model.Name,
        //            Email = model.Email,
        //            Phone = model.Phone,
        //            PaymentMethod = paymentMethod.Id
        //        };

        //        var customer = customerService.Create(customerCreateOptions);

        //        return new Dictionary<string, string>() {
        //            ["customerId"] = customer.Id,
        //            ["paymentMethodId"] = paymentMethod.Id
        //        };
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static string StripeIntentWithCustomer(string customerId, string paymentMethodId, double price, string currencyCode)
        //{
        //    try
        //    {
        //        var paymentIntentService = new PaymentIntentService();

        //        var paymentIntentCreateOptions = new PaymentIntentCreateOptions()
        //        {
        //            Amount = (int)(price * 100),
        //            Currency = currencyCode.ToLower(),
        //            CaptureMethod = "manual",
        //            Customer = customerId,
        //            PaymentMethod = paymentMethodId,
        //            Confirm = true,
        //            OffSession = true
        //        };

        //        if (string.IsNullOrEmpty(currencyCode))
        //        {
        //            paymentIntentCreateOptions.Currency = GlobalConstant.DEFAULT_CURRENCY_CODE.ToLower();
        //        }

        //        var intent = paymentIntentService.Create(paymentIntentCreateOptions);

        //        var capture = paymentIntentService.Capture(intent.Id);

        //        if (capture.Status == "succeeded") {
        //            ClearCustomer(customerId);
        //        }

        //        return intent.Id;
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static void ClearCustomer(string customerId)
        //{
        //    try
        //    {
        //        var customerService = new CustomerService();
        //        var paymentMethodSerivce = new PaymentMethodService();

        //        var customer = customerService.Delete(customerId);
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public static void CreateWebhookEndPoint()
        //{
        //    try
        //    {
        //        var ApiUrl = Settings.API_URL;
        //        var service = new WebhookEndpointService();
        //        var options = new WebhookEndpointCreateOptions
        //        {
        //            Url = String.Format("{0}/api/webhook/charge", ApiUrl),
        //            EnabledEvents = GlobalConstant.StripeWebhookChargeEvent
        //        };

        //        var endpoint = service.Create(options);
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        ////public static string CreateCustomer(Models.Transaction transaction)
        ////{
        ////    var options = new CustomerCreateOptions
        ////    {
        ////        Name = $"{transaction.FirstName} {transaction.LastName}",
        ////        Email = transaction.Email,
        ////        Phone = transaction.ContactNo
        ////    };
        ////    var service = new CustomerService();
        ////    return service.Create(options).Id;
        ////}

        ////public static string CreateCard(Models.Customer customer, string token)
        ////{
        ////    customer = DecyptCustomerInfo(customer);
        ////    var options = new CardCreateOptions
        ////    {
        ////        Source = token,
        ////    };
        ////    var service = new CardService();
        ////    return service.Create(customer.StripeCustomerId, options).Id;
        ////}

        ////private static Models.Customer DecyptCustomerInfo(Models.Customer customer)
        ////{
        ////    if (customer.Key != null && customer.IV != null)
        ////    {
        ////        var aes_dto = new AES_DTO(customer);

        ////        aes_dto.Encrypted = customer.FirstName;
        ////        customer.FirstName = EncryptionService.AES_Description(aes_dto);

        ////        aes_dto.Encrypted = customer.LastName;
        ////        customer.LastName = EncryptionService.AES_Description(aes_dto);

        ////        aes_dto.Encrypted = customer.Email;
        ////        customer.Email = EncryptionService.AES_Description(aes_dto);

        ////        if (customer.StripeCustomerId != null)
        ////        {
        ////            aes_dto.Encrypted = customer.StripeCustomerId;
        ////            customer.StripeCustomerId = EncryptionService.AES_Description(aes_dto);
        ////        }
        ////    }

        ////    return customer;
        ////}

        //public static TicketingStripeModel StripeChargeWithCurrencyCode(string stripeCardToken, double price, string currencyCode, Dictionary<string, string> metaData)
        //{
        //    var result = new TicketingStripeModel();
        //    try
        //    {
        //        var paymentIntentService = new PaymentIntentService();
        //        var paymentMethodService = new PaymentMethodService();

        //        var paymentMethodCreateOption = new PaymentMethodCreateOptions()
        //        {
        //            Type = "card",
        //            Card = new PaymentMethodCardOptions()
        //            {
        //                Token = stripeCardToken
        //            }
        //        };

        //        var paymentMethod = paymentMethodService.Create(paymentMethodCreateOption);

        //        var paymentIntentCreateOptions = new PaymentIntentCreateOptions()
        //        {
        //            Amount = (int)(price * 100),
        //            Currency = currencyCode.ToLower(),
        //            CaptureMethod = "manual",
        //            PaymentMethod = paymentMethod.Id,
        //            PaymentMethodTypes = new List<string>
        //            {
        //                "card",
        //            },
        //            Confirm = true,
        //            Metadata = metaData
        //        };

        //        if (string.IsNullOrEmpty(currencyCode))
        //        {
        //            paymentIntentCreateOptions.Currency = GlobalConstant.DEFAULT_CURRENCY_CODE.ToLower();
        //        }

        //        var intent = paymentIntentService.Create(paymentIntentCreateOptions);

        //        result.IntentId = intent.Id;
        //        result.PaymentMethodId = intent.PaymentMethodId;
        //        result.Amount = price;
        //        result.Status = intent.Status;
        //        result.Card = new StripeCardModel
        //        {
        //            Brand = paymentMethod.Card.Brand,
        //            Last4 = paymentMethod.Card.Last4
        //        };

        //        if (intent.Status == "succeeded" || intent.Status == "requires_capture")
        //        {
        //            // Handle post-payment fulfillment
        //            result.Success = true;

        //            try
        //            {
        //                var paymentService = new PaymentIntentService();

        //                var intentCapture = paymentIntentService.Capture(intent.Id);
        //                string BalanceTransactionId =  intentCapture.Charges.Data.FirstOrDefault().BalanceTransactionId;
        //                if (BalanceTransactionId != null)
        //                {
        //                    var BalanceTransactionService = new BalanceTransactionService();
        //                    BalanceTransaction balanceTransaction = BalanceTransactionService.Get(BalanceTransactionId);
        //                    result.PaymentGatewayFee = (double)balanceTransaction.Fee / 100;                           
        //                }             
        //            }
        //            catch (Exception e)
        //            {
        //                result.Success = false;
        //                result.Message = e.Message;
        //            }
        //        }
        //        else if (intent.Status == "requires_action")
        //        {
        //            // Tell the client to handle the action
        //            result.Success = false;
        //            result.RequiresAction = true;
        //            result.ClientSecret = intent.ClientSecret;
        //        }
        //        else
        //        {
        //            // Any other status would be unexpected, so error
        //            result.Success = false;
        //            result.Message = "We are sorry, these was an error processing your payment. Please try again with a different payment method.";
        //        }
        //    }
        //    catch (StripeException e)
        //    {
        //        result.Success = false;
        //        result.Message = e.Message;
        //    }

        //    return result;
        //}

        //public static TicketingRefundModel StripeRefund(string paymentIntentId, double price, Dictionary<string, string> metaData)
        //{
        //    var result = new TicketingRefundModel();
        //    try
        //    {
        //        var refundService = new RefundService();

        //        var paymentRefundCreateOptions = new RefundCreateOptions()
        //        {
        //            Amount = (int)(price * 100),
        //            PaymentIntent = paymentIntentId,
        //            Metadata = metaData
        //        };

        //        var refund = refundService.Create(paymentRefundCreateOptions);

        //        result.Status = refund.Status;

        //        if (refund.Status == "succeeded")
        //        {
        //            result.Success = true;
        //        }
        //        else
        //        {
        //            // Any other status would be unexpected, so error
        //            result.Success = false;
        //            result.Message = "We are sorry, these was an error processing your refund.";
        //            result.FailureReason = refund.FailureReason;
        //        }
        //    }
        //    catch (StripeException e)
        //    {
        //        result.Success = false;
        //        result.Message = e.Message;
        //    }

        //    return result;
        //}
    }
}
