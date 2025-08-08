using Microsoft.AspNetCore.Identity;

namespace Entities
{
    public class AccountRoleMap : IdentityUserRole<string>
    {
        public virtual Account Account { get; set; }
        public virtual RoleDb Role { get; set; }
    }
}
