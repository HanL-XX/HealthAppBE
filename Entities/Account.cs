using Common.Constant;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace Entities
{
    public class Account : IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Login { get; set; }
        public string PIN { get; set; }
        public string Code { get; set; }
        public UserType UserType { get; set; }
        public override string Email { get; set; }

        [DefaultValue(true)]
        public bool IsActive { get; set; }
        public bool HasChangeFirstPwd { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        [DefaultValue(false)]
        public bool Deleted { get; set; }
        public string Avatar { get; set; }
        public string PhoneNumber { get; set; }
        public bool Allow2FA { get; set; }
        public TwoFactorAuthenticationType TwoFactorAuthenticationType { get; set; }
        public string AuthyId { get; set; }
        public int LoginAttempt { get; set; }
        public DateTime UpdatePasswordDate { get; set; }
        public bool IsScanQr { get; set; }
        public string Password { get; set; }
        public virtual ICollection<AccountRoleMap> AccountRoleMaps { get; set; } = new List<AccountRoleMap>();
        public virtual ICollection<Meal> Meals { get; set; } = new List<Meal>();
        public virtual ICollection<BodyRecord> BodyRecords { get; set; } = new List<BodyRecord>();
        public virtual ICollection<Exercise> Exercises { get; set; } = new List<Exercise>();
        public virtual ICollection<Diary> Diarys { get; set; } = new List<Diary>();
        public virtual ICollection<Article> Articles { get; set; } = new List<Article>();
    }
}
