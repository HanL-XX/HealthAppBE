using Entities;
using Infrastructure;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Interface
{
    public interface IUsersRepository
    {
        Task<List<Account>> GetUsersByIds(List<string> ids);
        Task<Account> GetUsersById(string id);
        Task<List<Account>> GetAuditEntityUsers(IAuditableEntity entity);
    }
}
