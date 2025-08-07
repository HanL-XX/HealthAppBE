using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using Services.Common.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Services.Common.Implement
{

    public class CustomMemoryDistributedCache : MemoryDistributedCache, ICustomDestributedService
    {
        public CustomMemoryDistributedCache(IOptions<MemoryDistributedCacheOptions> optionsAccessor) : base(optionsAccessor)
        {

        }
    }

    public class CacheWarpperService : ICacheWarpperService
    {
        private readonly ICustomDestributedService _cache;
        private readonly string _applicationName;

        public CacheWarpperService(IConfiguration configuration, ICustomDestributedService cache)
        {
            _cache = cache;
            _applicationName = configuration.GetValue<string>("ApplicationInfo:applicationName");
        }

        /// <summary>
        /// All keys should be adjusted
        /// and added with the current session id
        /// NOTE: This is only a temp solution
        /// prefered one is using session agains a destributed server.
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string AdjustSessionKey(string key)
        {
            if (!key.ToLower().StartsWith(_applicationName.ToLower()))
            {
                return $"{_applicationName}{key}";
            }
            return key;
        }

        public async Task<T> GetValue<T>(string key) where T : class
        {
            string result = await _cache.GetStringAsync(AdjustSessionKey(key));
            if (!string.IsNullOrEmpty(result))
            {
                return JsonSerializer.Deserialize<T>(result);
            }
            else
            {
                return null;
            }
        }

        public async Task<string> GetString(string key)
        {
            string result = await _cache.GetStringAsync(AdjustSessionKey(key));
            return result;
        }

        public async Task SetValue<T>(string key, T value) where T : class
        {
            await this.SetString(key, JsonSerializer.Serialize(value));
        }

        public async Task SetValue<T>(string key, T value, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class
        {
            await this.SetString(key, JsonSerializer.Serialize(value), absoluteExpirationRelativeToNow);
        }

        public async Task SetString(string key, string value, TimeSpan? absoluteExpirationRelativeToNow = null)
        {
            if (absoluteExpirationRelativeToNow == null)
            {
                await _cache.SetStringAsync(AdjustSessionKey(key), value);
            }
            else
            {
                await _cache.SetStringAsync(AdjustSessionKey(key), value, new DistributedCacheEntryOptions()
                {
                    AbsoluteExpirationRelativeToNow = absoluteExpirationRelativeToNow
                });
            }
        }

        public async Task RemoveKey(string key)
        {
            await _cache.RemoveAsync(AdjustSessionKey(key));
        }

        public async Task<T> GetOrSetValue<T>(string key, Func<Task<T>> getFunc, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class
        {
            string finalKey = AdjustSessionKey(key);
            T value = await GetValue<T>(finalKey);
            if (value == null)
            {
                value = await getFunc();
                if (value != null)
                {
                    await this.SetValue<T>(finalKey, value);
                }
            }
            return value;
        }

        public Task<T> GetOrSetValue<T>(string key, Func<Task<T>> getFunc, int? absoluteExpirationRelativeToNowInHours = null) where T : class
        {
            if (absoluteExpirationRelativeToNowInHours.HasValue)
            {
                return GetOrSetValue<T>(key, getFunc, new TimeSpan(absoluteExpirationRelativeToNowInHours.Value, 0, 0));
            }
            else
            {
                return GetOrSetValue<T>(key, getFunc, new TimeSpan());
            }
        }

        public T GetValueSync<T>(string key) where T : class
        {
            string result = _cache.GetString(AdjustSessionKey(key));
            if (!string.IsNullOrEmpty(result))
            {
                return JsonSerializer.Deserialize<T>(result);
            }
            else
            {
                return null;
            }
        }

        public T GetOrSetValueSync<T>(string key, Func<T> getFunc, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class
        {
            string finalKey = AdjustSessionKey(key);
            T value = GetValueSync<T>(finalKey);
            if (value == null)
            {
                value = getFunc();
                if (value != null)
                {
                    this.SetValueSync<T>(finalKey, value, absoluteExpirationRelativeToNow);
                }
            }
            return value;
        }

        public void SetValueSync<T>(string key, T value, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class
        {
            this.SetStringSync(key, JsonSerializer.Serialize(value), absoluteExpirationRelativeToNow);
        }

        public void SetStringSync(string key, string value, TimeSpan? absoluteExpirationRelativeToNow = null)
        {
            if (absoluteExpirationRelativeToNow == null)
            {
                _cache.SetString(AdjustSessionKey(key), value);
            }
            else
            {
                _cache.SetString(AdjustSessionKey(key), value, new DistributedCacheEntryOptions()
                {
                    AbsoluteExpirationRelativeToNow = absoluteExpirationRelativeToNow
                });
            }
        }
    }
}
