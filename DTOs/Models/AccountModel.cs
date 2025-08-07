using Common.Constant;
using Common.ErrorLocalization;
using Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace DTOs.Models
{
    public class AccountModel
    {
        public string Id { get; set; }
        public string Code { get; set; }
        public UserType UserType { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Avatar { get; set; }
        public string Email { get; set; }
        public RoleModelLookup BackOfficeRole { get; set; }
        public string Login { get; set; }
        public string PIN { get; set; }
        public DateTime LastUpdate { get; set; }
        public bool IsActive { get; set; }
        public bool HasChangeFirstPassword { get; set; }
        public string PhoneNumber { get; set; }
        public bool Allow2FA { get; set; }
        public TwoFactorAuthenticationType TwoFactorAuthenticationType { get; set; }
        public string CountryCode { get; set; }
        public AccountModel()
        {

        }
        public AccountModel(Account account, bool isDisplayBranch = false)
        {
            Id = account.Id;
            Code = account.Code;
            UserType = account.UserType;
            FirstName = account.FirstName;
            LastName = account.LastName;
            Avatar = account.Avatar;
            Email = account.Email;
            BackOfficeRole = new RoleModelLookup(account.AccountRoleMaps.FirstOrDefault()?.Role);
            Login = account.Login;
            PIN = account.PIN;
            LastUpdate = account.UpdatedDate;
            IsActive = account.IsActive;
            HasChangeFirstPassword = account.HasChangeFirstPwd;
            PhoneNumber = account.PhoneNumber;
            Allow2FA = account.Allow2FA;
            TwoFactorAuthenticationType = account.TwoFactorAuthenticationType;
        }
    }

    public class CreateAccountModel
    {
        /// <summary>
        /// Code of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "CodeRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Code { get; set; }

        /// <summary>
        /// UserType of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "UserTypeRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        [Range(0, 2, ErrorMessageResourceName = "UserTypeInvalid", ErrorMessageResourceType = typeof(ErrorResource))]
        public UserType UserType { get; set; }

        /// <summary>
        /// FirstName of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "FirstNameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string FirstName { get; set; }

        /// <summary>
        /// LastName of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "LastNameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string LastName { get; set; }

        /// <summary>
        /// Homepage of Account
        /// </summary>
        public string Avatar { get; set; }

        /// <summary>
        /// Email of Account
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// Role of Account
        /// </summary>
        public string BackOfficeRole { get; set; }

        /// <summary>
        /// Login of Account
        /// </summary>
        public string Login { get; set; }

        /// <summary>
        /// Check send invitation email or not ?
        /// </summary>
        public bool SendInvitationEmail { get; set; }
        public string PhoneNumber { get; set; }
        public bool? Allow2FA { get; set; }
        public TwoFactorAuthenticationType? TwoFactorAuthenticationType { get; set; }

        public Account ParseToEntity()
        {
            Account account = new Account();
            account.Code = Code;
            account.UserType = mappingUserType();
            account.FirstName = FirstName;
            account.LastName = LastName;
            account.Avatar = Avatar;
            account.UpdatePasswordDate = DateTime.Now;

            return account;
        }

        private UserType mappingUserType()
        {
            return UserType switch
            {
                UserType.Back_Office => UserType.Back_Office,
                UserType.Both => UserType.Both,
                _ => throw new NotImplementedException()
            };
        }
    }

    public class UpdateAccountModel
    {
        /// <summary>
        /// Code of Account
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// UserType of Account
        /// </summary>
        [Range(0, 2, ErrorMessageResourceName = "UserTypeInvalid", ErrorMessageResourceType = typeof(ErrorResource))]
        public UserType UserType { get; set; }

        /// <summary>
        /// FirstName of Account
        /// </summary>
        public string FirstName { get; set; }

        /// <summary>
        /// LastName of Account
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// Homepage of Account
        /// </summary>
        public string Avatar { get; set; }

        /// <summary>
        /// Email of Account
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// Role of Account
        /// </summary>
        public string BackOfficeRole { get; set; }

        /// <summary>
        /// Login of Account
        /// </summary>
        public string Login { get; set; }

        /// <summary>
        /// PIN of Account
        /// </summary>
        public string PIN { get; set; }

        /// <summary>
        /// Device User group
        /// </summary>
        public Guid? DeviceUserRoleId { get; set; }

        /// <summary>
        /// User Location
        /// </summary>
        public Guid? LocationId { get; set; }

        /// <summary>
        /// Active or Deactive Account
        /// </summary>
        public bool? IsActive { get; set; }
        public bool IsAllBranch { get; set; }
        [Required]
        public ICollection<Guid> ListBranchId { get; set; }
        public Guid? DefaultBranchId { get; set; }
        public bool Training { get; set; }
        public string PhoneNumber { get; set; }
        public bool? Allow2FA { get; set; }
        public TwoFactorAuthenticationType? TwoFactorAuthenticationType { get; set; }
        public string CountryCode { get; set; }
        public Guid? LanguageId { get; set; }
    }

    public class UpdateProfile
    {
        /// <summary>
        /// FirstName of Account
        /// </summary>
        public string FirstName { get; set; }

        /// <summary>
        /// LastName of Account
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// Email of Account
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// Current Password of Account
        /// </summary>
        public string CurrentPassword { get; set; }

        /// <summary>
        /// New Password of Account
        /// </summary>
		public string NewPassword { get; set; }

        /// <summary>
        /// ConfirmNewPassword of Account
        /// </summary>
		public string ConfirmNewPassword { get; set; }

        /// <summary>
        /// Homepage
        /// </summary>
        public string Avatar { get; set; }

        /// <summary>
        /// Language of Account
        /// </summary>
        public Guid? LanguageId { get; set; }
    }

    public class SearchAcccountModel
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Avatar { get; set; }

        public SearchAcccountModel() { }
        public SearchAcccountModel(Account account)
        {
            Id = account.Id;
            FirstName = account.FirstName;
            LastName = account.LastName;
            Email = account.Email;
            Avatar = account.Avatar;
        }
    }

    public class AccountShortModel
    {
        public string Id { get; set; }
        public string Code { get; set; }
        public UserType UserType { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Avatar { get; set; }
        public string Email { get; set; }
        public string Login { get; set; }
        public string PIN { get; set; }
        public DateTime LastUpdate { get; set; }
        public bool IsActive { get; set; }
        public bool HasChangeFirstPassword { get; set; }
        public bool Cashier { get; set; }
        public int RoleLevel { get; set; }

        public AccountShortModel(Account account)
        {
            Id = account.Id;
            Code = account.Code;
            UserType = account.UserType;
            FirstName = account.FirstName;
            LastName = account.LastName;
            Avatar = account.Avatar;
            Email = Email;
            Login = account.Login;
            PIN = account.PIN;
            LastUpdate = account.UpdatedDate;
            IsActive = account.IsActive;
            HasChangeFirstPassword = account.HasChangeFirstPwd;
            RoleLevel = account.AccountRoleMaps.Count > 0 ? account.AccountRoleMaps.FirstOrDefault().Role.Level : 100;
        }
    }
}
