using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Amazon.Auth.AccessControlPolicy;
using Common.Constant;


namespace Common.Helpers
{
    public class ConvertCurrency
    {
        public ConvertCurrency() { }

        public async Task<double> ExecuteConvertCurrency(string source, string distance)
        {
            using (var httpClient = new HttpClient())
            {
                string uri = string.Format(Constant.GlobalConstant.CURRENCY_API_LINK_GETALL, Settings.CURRENCY_API_ACCESS_KEY);

                var response = await httpClient.GetAsync(uri);
                response.EnsureSuccessStatusCode();

                var stringResult = await response.Content.ReadAsStringAsync();

                try
                {
                    var model = JsonConvert.DeserializeObject<ApiLayerModel>(stringResult);

                    if (source == "USD")
                    {
                        if (model.Quotes.ContainsKey(source + distance))
                        {
                            return CustomCurrencyRound(model.Quotes[source + distance], GlobalConstant.DEFAULT_CURRENCY_POSITION);
                        }
                    }
                    else
                    {
                        if (distance == "USD")
                        {
                            if (model.Quotes.ContainsKey(distance + source))
                            {
                                return CustomCurrencyRound(1 / model.Quotes[distance + source], GlobalConstant.DEFAULT_CURRENCY_POSITION);
                            }
                        }
                        else
                        {
                            var keyTo = ("USD" + distance).ToUpper();
                            var keyFrom = ("USD" + source).ToUpper();

                            var data = model.Quotes[keyTo] / model.Quotes[keyFrom];
                            return CustomCurrencyRound(data, GlobalConstant.DEFAULT_CURRENCY_POSITION);
                        }
                    }
                }
                catch (NullReferenceException e)
                {
                    throw;
                }
            }

            return 0;
        }

        private double CustomCurrencyRound(double value, int position)
        {
            var init = true;
            var hasValue = false;
            var count = 0;
            var resultStr = "";
            resultStr = ((int)value).ToString();
            value = value - (int)value;

            if (position > 0)
            {
                resultStr += ".";
            }
            else
            {
                return value;
            }

            while (count < position && value - (int)value != 0)
            {
                var num = (int)value;

                if (init)
                {
                    init = false;
                    continue;
                }

                value = value * 10;
                if (hasValue || (int)value % 10 > 0)
                {
                    hasValue = true;
                    count += 1;
                }


                resultStr += ((int)value % 10).ToString();
            }

            return double.Parse(resultStr);
        }
    }

    public class ApiLayerModel
    {
        public bool Success { get; set; }
        public string Terms { get; set; }
        public string Privacy { get; set; }
        public int Timestamp { get; set; }
        public string Source { get; set; }
        public Dictionary<string, double> Quotes { get; set; }
    }

    public class ResponsLayerModel
    {
        public bool Success { get; set; }
        public string Terms { get; set; }
        public string Privacy { get; set; }
        public Dictionary<string, string> currencies { get; set; }
    }
}
