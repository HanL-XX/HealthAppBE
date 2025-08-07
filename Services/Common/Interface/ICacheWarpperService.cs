using Microsoft.Extensions.Caching.Distributed;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Services.Common.Interface
{
    public interface ICustomDestributedService : IDistributedCache
    {

    }

    public interface ICacheWarpperService
    {
        Task<string> GetString(string key);

        Task<T> GetValue<T>(string key) where T : class;
        T GetValueSync<T>(string key) where T : class;

        Task<T> GetOrSetValue<T>(string key, Func<Task<T>> getFunc, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class;

        Task<T> GetOrSetValue<T>(string key, Func<Task<T>> getFunc, int? absoluteExpirationRelativeToNowInHours = null) where T : class;
        T GetOrSetValueSync<T>(string key, Func<T> getFunc, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class;

        /// <summary>
        /// Set an object to session store
        /// IMPORTANT: Supplied object must be serializable as it is stored into a destributed cache server.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        Task SetValue<T>(string key, T value, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class;
        void SetValueSync<T>(string key, T value, TimeSpan? absoluteExpirationRelativeToNow = null) where T : class;
        /// <summary>
        /// Set a simple string into store.
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        Task SetString(string key, string value, TimeSpan? absoluteExpirationRelativeToNow = null);

        /// <summary>
        /// Remove data by key.
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        Task RemoveKey(string key);
    }
}
