using Common.ErrorLocalization;
using Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;

namespace DTOs.Models
{
    public class LoginModel
    {
        [Required(ErrorMessageResourceName = "UsernameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string UserName { get; set; }
        [Required(ErrorMessageResourceName = "PasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Password { get; set; }
    }

    public class LoginDeviceModel
    {
        [Required(ErrorMessageResourceName = "LoginRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Login { get; set; }
        [Required(ErrorMessageResourceName = "PinRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Pin { get; set; }
    }

    public class SendPasswordResetLink
    {
        [Required(ErrorMessageResourceName = "UsernameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string UserName { get; set; }
        public bool isBo { get; set; }
    }

    public class ResetPassword
    {
        /// <summary>
        /// UserName of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "UsernameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string UserName { get; set; }
        /// <summary>
        /// NewPassword of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "NewPasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string NewPassword { get; set; }
        /// <summary>
        /// ConfirmPassword of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "ConfirmPasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        [Compare("NewPassword", ErrorMessageResourceName = "ConfirmPasswordNotMatch", ErrorMessageResourceType = typeof(ErrorResource))]
        public string ConfirmPassword { get; set; }
        /// <summary>
        /// Token of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "TokenResetPassword", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Token { get; set; }
    }

    public class ChangePassword
    {
        /// <summary>
        /// UserName of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "UsernameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string UserName { get; set; }

        /// <summary>
        /// CurrentPassword of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "CurrentPasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string CurrentPassword { get; set; }

        /// <summary>
        /// NewPassword of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "NewPasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string NewPassword { get; set; }

        /// <summary>
        /// ConfirmPassword of Account
        /// </summary>
        [Required(ErrorMessageResourceName = "ConfirmPasswordRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        [Compare("NewPassword", ErrorMessageResourceName = "ConfirmPasswordNotMatch", ErrorMessageResourceType = typeof(ErrorResource))]
        public string ConfirmPassword { get; set; }
    }

    public class TokenModel
    {
        public string access_token { get; set; }
        public string token_type { get; set; }
        public double expires_in { get; set; }
        public bool confirmed { get; set; } = false;
        public TokenModel() { }
        public TokenModel(string token, JwtSecurityToken properties)
        {
            access_token = token;
            token_type = "bearer";
            expires_in = Math.Floor(properties.ValidTo.Subtract(properties.ValidFrom).TotalMinutes);
        }

    }

    public class SendCodeModel
    {
        public string AuthyId { get; set; }
        public string Code { get; set; }
    }
}
