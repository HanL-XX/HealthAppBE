using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Entities
{
    public class RoleDb : IdentityRole
    {
        public RoleDb() : base()
        {
        }

        public RoleDb(string RoleName) : base(RoleName)
        {

        }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
        [Range(1, int.MaxValue)]
        public int Level { get; set; }
        public virtual ICollection<AccountRoleMap> AccountRoleMaps { get; set; }
    }
}



