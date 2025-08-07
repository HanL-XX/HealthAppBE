using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Entities
{
    public class AccountRoleMap : IdentityUserRole<string>
    {
        public virtual Account Account { get; set; }
        public virtual RoleDb Role { get; set; }
    }
}
