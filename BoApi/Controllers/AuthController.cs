using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Common.Constant;
using Common.ErrorLocalization;
using Common.Helpers;
using DTOs.Helpers;
using DTOs.Models;
using Entities;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using Services.Common;

namespace BoApi.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    public class AuthController : BaseController
    {
        private readonly UserManager<Account> _userManager;
        private readonly UserResolverService _userResolverService;
        private readonly SignInManager<Account> _signInManager;
        private readonly ApiDbContext _dbContext;
        private readonly IHttpContextAccessor _context;
        private readonly IHostEnvironment _hostingEnvironment;
        private readonly IConfiguration _configuration;

        public AuthController(UserManager<Account> userManager, SignInManager<Account> signInManager, UserResolverService userResolverService, ApiDbContext dbContext,
            IHostEnvironment hostingEnvironment,
            IConfiguration configuration)
        {
            _userManager = userManager;
            this._userResolverService = userResolverService;
            this._signInManager = signInManager;
            _hostingEnvironment = hostingEnvironment;
            _configuration = configuration;
            _dbContext = dbContext;
        }

        /// <summary>
        /// Login
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Login([FromBody] LoginModel model)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);

                actionResult = BadRequest(errors);
            }
            else
            {
                try
                {
                    var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, false, false);
                    var account = await _userManager.FindByNameAsync(model.UserName);

                    if (!result.Succeeded)
                    {
                        if (account != null && account.IsActive)
                        {
                            account.LoginAttempt += 1;
                            if (account.LoginAttempt >= Settings.LOGIN_ATTEMPT_NUMBER)
                            {
                                account.LoginAttempt = Settings.LOGIN_ATTEMPT_NUMBER;
                                account.IsActive = false;
                            }
                            _dbContext.SaveChanges();
                        }
                        if (account.LoginAttempt >= Settings.LOGIN_ATTEMPT_NUMBER)
                        {
                            errors.Add(Common.ErrorLocalization.ErrorResource.AccountIsDeactive);
                        }
                        else
                        {
                            errors.Add(Common.ErrorLocalization.ErrorResource.Login_Failed);
                        }

                        actionResult = BadRequest(errors);
                    }
                    else
                    {
                        if (!account.IsActive)
                        {
                            errors.Add(Common.ErrorLocalization.ErrorResource.AccountIsDeactive);
                            actionResult = BadRequest(errors);
                        }
                        else
                        {
                            if (account.UpdatePasswordDate.Date.AddMonths(6) <= DateTime.Now)
                            {
                                account.HasChangeFirstPwd = false;
                            }

                            account.LoginAttempt = 0;
                            _dbContext.SaveChanges();
                            if (account.Allow2FA && Settings.TWO_FA_CONFIGURATION_ALLOW.ToLower() == "true")
                            {
                                using (var client = new HttpClient())
                                {
                                    client.DefaultRequestHeaders.Add("X-Authy-API-Key", Settings.TWO_FA_CONFIGURATION_API_KEY);
                                    var authy_id = account.AuthyId;

                                    if (account.TwoFactorAuthenticationType == TwoFactorAuthenticationType.App)
                                    {

                                    }
                                    else
                                    {
                                        HttpResponseMessage response = client.GetAsync(Settings.TWO_FA_CONFIGURATION_URL + "sms/" + authy_id).Result;
                                        HttpContent responseContent = response.Content;
                                        dynamic resultJson = JsonConvert.DeserializeObject(responseContent.ReadAsStringAsync().Result);
                                        if (resultJson.success == "false")
                                        {
                                            errors.Add(Common.ErrorLocalization.ErrorResource.SendCodeFail);
                                            return actionResult = BadRequest(errors);
                                        }
                                        else
                                        {
                                            return actionResult = Ok(new
                                            {
                                                PhoneNumber = account.PhoneNumber,
                                                AuthyId = account.AuthyId
                                            });
                                        }
                                    }

                                }
                            }

                            var authProperties = new AuthenticationProperties
                            {
                                AllowRefresh = true,
                                IssuedUtc = DateTime.UtcNow
                            };

                            await _signInManager.SignInAsync(account, authProperties, JwtBearerDefaults.AuthenticationScheme);

                            if (account.UpdatePasswordDate.Date.AddMonths(5) <= DateTime.Now && account.UpdatePasswordDate.Date.AddMonths(6) > DateTime.Now)
                            {
                                actionResult = Ok(new
                                {
                                    Token = JWTHelper.GenerateJwtToken(account.UserName, account.Id, "Super Admin"),
                                    Message = "Your password will be expired in 1 month, you need to update your password"
                                });
                            }
                            else
                            {
                                actionResult = Ok(new
                                {
                                    Token = JWTHelper.GenerateJwtToken(account.UserName, account.Id, "Super Admin")
                                });
                            }

                        }
                    }
                }
                catch (Exception)
                {
                    errors.Add(Common.ErrorLocalization.ErrorResource.Login_Failed);

                    actionResult = BadRequest(errors);
                }

                _dbContext.SaveChanges();
            }
            return actionResult;
        }

        /// <summary>
        /// Request email to reset password
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("SendPasswordResetLink")]
        public async Task<IActionResult> SendPasswordResetLink([FromBody] SendPasswordResetLink model)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                actionResult = BadRequest(errors);
            }
            else
            {
                var user = await _userManager.FindByNameAsync(model.UserName);

                if (user == null)
                {
                    actionResult = NotFound();
                }
                else
                {
                    actionResult = NoContent();
                }
            }

            return actionResult;
        }

        [HttpPost("{refreshToken}/refresh")]
        public IActionResult RefreshToken([FromRoute] string refreshToken)
        {
            var _refreshToken = _dbContext.RefreshTokens.SingleOrDefault(m => m.Refreshtoken == refreshToken);
            if (_refreshToken == null)
            {
                return BadRequest("Refresh token not found");
            }

            _refreshToken.Refreshtoken = Guid.NewGuid().ToString();
            _dbContext.RefreshTokens.Update(_refreshToken);
            _dbContext.SaveChanges();

            return Ok(new { Token = JWTHelper.GenerateJwtToken(_refreshToken.Username, _refreshToken.UserId, _refreshToken.Role), RefreshToken = _refreshToken.Refreshtoken });
        }

        /// <summary>
        /// Reset password with token from request
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("ResetPassword")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPassword model)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                actionResult = BadRequest(errors);
            }
            else
            {

                model.Token = UtilService.DecodeFrom64(model.Token);

                var account = await _userManager.FindByNameAsync(model.UserName);

                if (account == null)
                {
                    errors.Add(Common.ErrorLocalization.ErrorResource.UserNotFound);
                    actionResult = NotFound(errors);
                }
                else
                {
                    List<string> passwords = new List<string>();
                    var builderOption = new DbContextOptionsBuilder<ApiDbContext>();
                    builderOption.UseSqlServer(Startup.Configuration.GetConnectionString("ApiConnection"));
                    string currentPasswordHash = JWTHelper.GeneratePassword(model.NewPassword);
                    if (!string.IsNullOrEmpty(model.NewPassword) && (model.NewPassword.ToLower().Contains(account.FirstName.ToLower()) || model.NewPassword.ToLower().Contains(account.LastName.ToLower())))
                    {
                        errors.Add(Common.ErrorLocalization.ErrorResource.PasswordCanNotContainFirstNameOrLastName);
                        actionResult = BadRequest(errors);
                        return actionResult;
                    }

                    var resetResults = await _userManager.ResetPasswordAsync(account, model.Token, model.NewPassword);

                    if (resetResults.Succeeded)
                    {
                        account = await _userManager.FindByNameAsync(model.UserName);
                        actionResult = Ok(new AccountModel(account));
                    }
                    else
                    {
                        errors.Add(Common.ErrorLocalization.ErrorResource.ResetPasswordFailed);
                        actionResult = BadRequest(errors);
                    }
                }
            }

            return actionResult;
        }

        /// <summary>
        /// Logout
        /// </summary>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            foreach (var cookie in Request.Cookies.Keys)
            {
                Response.Cookies.Delete(cookie);
            }

            return NoContent();
        }

        /// <summary>
        /// Login device
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("LoginDevice")]
        public async Task<IActionResult> LoginDevice([FromBody] LoginDeviceModel model)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                actionResult = BadRequest(errors);
            }
            else
            {
                try
                {
                    var account = _dbContext.Users.Where(x => x.Login == model.Login && x.PIN == model.Pin).FirstOrDefault();
                    if (account == null)
                    {
                        errors.Add(Common.ErrorLocalization.ErrorResource.Login_Device_Failed);
                        actionResult = BadRequest(errors);
                    }
                    else if (!account.IsActive)
                    {
                        errors.Add(Common.ErrorLocalization.ErrorResource.AccountIsDeactive);
                        actionResult = BadRequest(errors);
                    }
                    else
                    {
                        var authProperties = new AuthenticationProperties
                        {
                            AllowRefresh = true,
                            IssuedUtc = DateTime.UtcNow
                        };

                        await _signInManager.SignInAsync(account, authProperties, JwtBearerDefaults.AuthenticationScheme);
                        actionResult = Ok(new
                        {
                            Token = JWTHelper.GenerateJwtToken(account.UserName, account.Id, "Super Admin")
                        });
                    }
                }
                catch (Exception)
                {
                    errors.Add(Common.ErrorLocalization.ErrorResource.Login_Device_Failed);
                    actionResult = BadRequest(errors);
                }
            }
            return actionResult;
        }

        [Authorize(AuthenticationSchemes = "bearer2")]
        [HttpGet("GetToken")]
        public async Task<IActionResult> RedirectExternalToInternalAuthorization()
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();
            var claims = _context.HttpContext?.User?.Claims;

            try
            {
                if (claims.Count() > 0 && claims.FirstOrDefault(x => x.Issuer.ToLower().Contains("sts.windows.net")) != null)
                {
                    var email = claims.FirstOrDefault(x => x.Type.ToLower().Equals("email"));
                    var unique_name = claims.FirstOrDefault(x => x.Type.ToLower().Equals("unique_name"));
                    var upn = claims.FirstOrDefault(x => x.Type.ToLower().Equals("upn"));
                    var claims_raw = claims.ToList();

                    if (email != null || unique_name != null || upn != null)
                    {
                        Account account = null;
                        if (email != null)
                            account = await _userManager.FindByEmailAsync(email.Value);

                        if (account == null && unique_name != null)
                        {
                            account = await _userManager.FindByEmailAsync(unique_name.Value);
                        }

                        if (account == null && upn != null)
                        {
                            account = await _userManager.FindByEmailAsync(upn.Value);
                        }


                        if (account == null)
                        {
                            errors.Add(ErrorResource.UserNotFound);
                            actionResult = BadRequest(errors);
                        }
                        else if (!account.IsActive)
                        {
                            errors.Add(ErrorResource.AccountIsDeactive);
                            actionResult = BadRequest(errors);
                        }
                        else
                        {
                            var authProperties = new AuthenticationProperties
                            {
                                AllowRefresh = true,
                                IssuedUtc = DateTime.UtcNow
                            };

                            await _signInManager.SignInAsync(account, authProperties, JwtBearerDefaults.AuthenticationScheme);

                            actionResult = Ok(new
                            {
                                Token = JWTHelper.GenerateJwtToken(account.UserName, account.Id, "")
                            }); ;
                        }
                    }
                    else
                    {
                        errors.Add(ErrorResource.TokenNotFromAzureAD);
                        actionResult = BadRequest(errors);
                    }
                }
                else
                {
                    errors.Add(ErrorResource.TokenNotFromAzureAD);
                    actionResult = BadRequest(errors);
                }
            }
            catch (Exception)
            {
                errors.Add(ErrorResource.Login_Failed);
                actionResult = BadRequest(errors);
            }

            return actionResult;
        }

        [HttpPost]
        [Route("GetCode")]
        public async Task<IActionResult> GetCode([FromBody] SendCodeModel model)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                actionResult = BadRequest(errors);
            }
            else
            {
                var user = _dbContext.Users.Where(x => x.AuthyId == model.AuthyId).FirstOrDefault();

                if (user == null)
                {
                    actionResult = NotFound();
                }
                else
                {
                    using (var client = new HttpClient())
                    {
                        client.DefaultRequestHeaders.Add("X-Authy-API-Key", Settings.TWO_FA_CONFIGURATION_API_KEY);

                        HttpResponseMessage response = client.GetAsync(Settings.TWO_FA_CONFIGURATION_URL + "verify/" + model.Code + "/" + model.AuthyId).Result;
                        HttpContent responseContent = response.Content;
                        dynamic resultJson = JsonConvert.DeserializeObject(responseContent.ReadAsStringAsync().Result);
                        if (resultJson.success == "false")
                        {
                            errors.Add(Common.ErrorLocalization.ErrorResource.WrongPasscode);
                            actionResult = BadRequest(errors);
                        }
                        else
                        {
                            if (user.TwoFactorAuthenticationType == TwoFactorAuthenticationType.App && !user.IsScanQr)
                            {
                                user.IsScanQr = true;
                                _dbContext.SaveChanges();
                            }
                            var authProperties = new AuthenticationProperties
                            {
                                AllowRefresh = true,
                                IssuedUtc = DateTime.UtcNow
                            };

                            await _signInManager.SignInAsync(user, authProperties, JwtBearerDefaults.AuthenticationScheme);

                            if (user.UpdatePasswordDate.Date.AddMonths(5) <= DateTime.Now && user.UpdatePasswordDate.Date.AddMonths(6) > DateTime.Now)
                            {
                                actionResult = Ok(new
                                {
                                    Token = JWTHelper.GenerateJwtToken(user.UserName, user.Id, "Super Admin"),
                                    Message = "Your password will be expired in 1 month, you need to update your password"
                                });
                            }
                            else
                            {
                                actionResult = Ok(new
                                {
                                    Token = JWTHelper.GenerateJwtToken(user.UserName, user.Id, "Super Admin")
                                });
                            }

                        }
                    }
                }

            }

            return actionResult;
        }

        [HttpPost]
        [Route("ReSendCode/{authyId}")]
        public IActionResult ReSendCode([FromRoute] string authyId)
        {
            IActionResult actionResult;
            ErrorModel errors = new ErrorModel();

            var user = _dbContext.Users.Where(x => x.AuthyId == authyId).FirstOrDefault();

            if (user == null)
            {
                actionResult = NotFound();
            }
            else
            {
                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Add("X-Authy-API-Key", Settings.TWO_FA_CONFIGURATION_API_KEY);

                    HttpResponseMessage response = client.GetAsync(Settings.TWO_FA_CONFIGURATION_URL + "sms/" + authyId).Result;

                    HttpContent responseContent = response.Content;
                    dynamic resultJson = JsonConvert.DeserializeObject(responseContent.ReadAsStringAsync().Result);
                    if (resultJson.success == "false")
                    {
                        errors.Add(Common.ErrorLocalization.ErrorResource.SendCodeFail);
                        actionResult = BadRequest(errors);
                    }
                    else actionResult = Ok(new { success = true });
                }
            }

            return actionResult;
        }
    }
}