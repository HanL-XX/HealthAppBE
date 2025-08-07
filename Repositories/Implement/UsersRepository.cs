using Entities;
using Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using Infrastructure;

namespace Repositories.Implement
{
    public class UsersRepository : IUsersRepository
    {
        private readonly ApiDbContext _context;
        public UsersRepository(ApiDbContext context)
        {
            _context = context;
        }
        public async Task<List<Account>> GetUsersByIds(List<string> ids)
        {
            return await _context.Users.AsQueryable().Where(x => ids.Contains(x.Id)).ToListAsync();
        }

        public async Task<Account> GetUsersById(string id)
        {
            return await _context.Users.FindAsync(id);
        }
        public async Task<List<Account>> GetAuditEntityUsers(IAuditableEntity entity)
        {
            var createdBy = await _context.Users.FindAsync(entity.CreatedBy);
            Account updatedBy;
            if (entity.CreatedBy != entity.UpdatedBy)
            {
                updatedBy = await _context.Users.FindAsync(entity.UpdatedBy);
            }
            else
            {
                updatedBy = createdBy;
            }
            return new List<Account> { createdBy, updatedBy };
        }
    }
}
