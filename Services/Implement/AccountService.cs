using Common.Constant;
using Common.ErrorLocalization;
using Common.Helpers;
using DTOs.Helpers;
using DTOs.Models;
using Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Services.Implement
{
    public class AccountService : IAccountService
    {
        private readonly UserManager<Account> _userManager;
        private readonly RoleManager<RoleDb> _roleManager;
        private readonly UserResolverService _userResolverService;
        private readonly ApiDbContext _dbContext;

        public AccountService
        (
            UserManager<Account> userManager,
            RoleManager<RoleDb> roleManager,
            UserResolverService userResolverService,
            ApiDbContext dbContext
        )
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _userResolverService = userResolverService;
            _dbContext = dbContext;
        }

        public async Task<ErrorModel> ResetPassword(string Id)
        {
            var errors = new ErrorModel();
            var account = await _userManager.FindByIdAsync(Id);

            var token = await _userManager.GeneratePasswordResetTokenAsync(account);
            var passwords = JWTHelper.GenerateRandomPassword(true, true, true, true, 8);

            if (account == null)
            {
                errors.Add(ErrorResource.UserNotFound);
            }
            else
            {
                var resetResults = await _userManager.ResetPasswordAsync(account, token, passwords);
                account.UpdatePasswordDate = DateTime.Now;
                await _userManager.UpdateAsync(account);
            }
            return null;
        }

        public async Task<Dictionary<ErrorModel, AccountModel>> CreateAccount(CreateAccountModel model)
        {
            var accountResult = new Dictionary<ErrorModel, AccountModel>();
            var errors = new ErrorModel();

            var account = model.ParseToEntity();

            account.CreatedBy = _userResolverService.GetUserId();
            account.UpdatedBy = _userResolverService.GetUserId();

            account.Password = JWTHelper.GeneratePassword(model.passwords);


            IdentityResult result = new IdentityResult();
            try
            {
                result = await _userManager.CreateAsync(account, model.passwords);
                if (!result.Succeeded)
                {
                    foreach (var error in result.Errors)
                    {
                        Console.WriteLine($"{error.Code}: {error.Description}");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception: {ex.Message}");
            }

            if (!result.Succeeded)
            {
                foreach (var error in result.Errors)
                {
                    errors.Add(error.Description);
                }
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }
            else
            {
                accountResult.Add(new ErrorModel(), new AccountModel());
            }

            _dbContext.SaveChanges();

            return accountResult;
        }

        public async Task<Dictionary<ErrorModel, AccountModel>> Update(string userId, UpdateAccountModel model, string connectionString)
        {
            var accountResult = new Dictionary<ErrorModel, AccountModel>();
            var errors = new ErrorModel();
            var checkAccount = await FilterAccountById(userId);

            if (!checkAccount.First().Key.IsEmpty)
            {
                checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }

            if
            (
                !string.IsNullOrEmpty(model.Code)
                && _userManager.Users.Any(x => !x.Deleted && x.Code.ToUpper() == model.Code.ToUpper() && x.Id != userId)
            )
            {
                errors.Add(ErrorResource.CodeDuplicated);
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }

            UpdateAccount(model, checkAccount.First().Value);
            return accountResult;
        }

        public async Task<Dictionary<ErrorModel, SearchAcccountModel>> UpdateByToken(UpdateProfile model, string connectionString)
        {
            var userId = _userResolverService.GetUserId();
            var accountResult = new Dictionary<ErrorModel, SearchAcccountModel>();
            var errors = new ErrorModel();
            var checkAccount = await FilterAccountById(userId, true);

            if (!checkAccount.First().Key.IsEmpty)
            {
                checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                accountResult.Add(errors, new SearchAcccountModel());
                return accountResult;
            }
            else if (!string.IsNullOrEmpty(model.NewPassword) && model.NewPassword != model.ConfirmNewPassword)
            {
                errors.Add(ErrorResource.ConfirmPasswordNotMatch);
                accountResult.Add(errors, new SearchAcccountModel());
                return accountResult;
            }
            else if (!string.IsNullOrEmpty(model.NewPassword)
                && (string.IsNullOrEmpty(model.FirstName) && string.IsNullOrEmpty(model.LastName) && (model.NewPassword.ToLower().Contains(checkAccount.Values.FirstOrDefault().FirstName.ToLower()) || model.NewPassword.ToLower().Contains(checkAccount.Values.FirstOrDefault().LastName.ToLower()))
                || (!string.IsNullOrEmpty(model.FirstName) && !string.IsNullOrEmpty(model.LastName) && (model.NewPassword.ToLower().Contains(model.FirstName.ToLower()) || model.NewPassword.ToLower().Contains(model.LastName.ToLower())))))
            {
                errors.Add(ErrorResource.PasswordCanNotContainFirstNameOrLastName);
                accountResult.Add(errors, new SearchAcccountModel());
                return accountResult;
            }
            else
            {
                var builderOption = new DbContextOptionsBuilder<ApiDbContext>();
                builderOption.UseSqlServer(connectionString);

                UpdateProfile(model, checkAccount.First().Value);

                if (!string.IsNullOrEmpty(model.NewPassword))
                {

                    if (string.IsNullOrEmpty(model.CurrentPassword))
                    {
                        errors.Add(ErrorResource.CurrentPasswordRequired);
                        accountResult.Add(errors, new SearchAcccountModel());
                        return accountResult;
                    }

                    if (!string.IsNullOrEmpty(model.CurrentPassword))
                    {
                        var checkPassword = _userManager.CheckPasswordAsync(checkAccount.First().Value, model.CurrentPassword);
                        if (checkPassword.Result == false)
                        {
                            errors.Add(ErrorResource.PasswordNotCorrect);
                            accountResult.Add(errors, new SearchAcccountModel());
                            return accountResult;
                        }
                    }

                    string currentPasswordHash = JWTHelper.GeneratePassword(model.NewPassword);

                    var token = await _userManager.GeneratePasswordResetTokenAsync(checkAccount.First().Value);

                    var result = await _userManager.ResetPasswordAsync(checkAccount.First().Value, token, model.NewPassword);

                    if (result.Succeeded)
                    {
                        checkAccount.First().Value.HasChangeFirstPwd = true;
                        checkAccount.First().Value.UpdatedDate = DateTime.Now;
                        checkAccount.First().Value.UpdatedBy = _userResolverService.GetUserId();
                        checkAccount.First().Value.UpdatePasswordDate = DateTime.Now;

                        await _userManager.UpdateAsync(checkAccount.First().Value);
                        SearchAcccountModel accountProfile = new SearchAcccountModel(checkAccount.First().Value);
                        accountResult.Add(errors, accountProfile);
                        return accountResult;
                    }
                    else
                    {
                        foreach (var error in result.Errors)
                        {
                            errors.Add(error.Description);
                        }
                        accountResult.Add(errors, new SearchAcccountModel());
                        return accountResult;
                    }
                }
                await _userManager.UpdateAsync(checkAccount.First().Value);
                SearchAcccountModel account = new SearchAcccountModel(checkAccount.First().Value);
                accountResult.Add(errors, account);
            }
            return accountResult;
        }

        private void UpdateAccount(UpdateAccountModel model, Account account)
        {
            account.Code = string.IsNullOrEmpty(model.Code) ? account.Code : model.Code;
            account.FirstName = string.IsNullOrEmpty(model.FirstName) ? account.FirstName : model.FirstName;
            account.LastName = string.IsNullOrEmpty(model.LastName) ? account.LastName : model.LastName;
            account.UserType = Enum.IsDefined(typeof(UserType), model.UserType) ? model.UserType : account.UserType;
            account.Avatar = string.IsNullOrEmpty(model.Avatar) ? account.Avatar : model.Avatar;
            account.IsActive = model.IsActive.HasValue ? model.IsActive.Value : account.IsActive;
            account.Login = string.IsNullOrEmpty(model.Login) ? account.Login : model.Login;
            account.PIN = string.IsNullOrEmpty(model.PIN) ? account.PIN : model.PIN;

            account.UpdatedBy = _userResolverService.GetUserId();
            account.UpdatedDate = DateTime.Now;

            if (!string.IsNullOrEmpty(model.Email))
            {
                account.UserName = model.Email;
                account.Email = model.Email;
            }
            account.Allow2FA = model.Allow2FA == null ? false : (bool)model.Allow2FA;
            account.TwoFactorAuthenticationType = model.TwoFactorAuthenticationType == null ?
                TwoFactorAuthenticationType.Sms :
                model.TwoFactorAuthenticationType.Value;
        }

        private void UpdateProfile(UpdateProfile model, Account account)
        {
            account.FirstName = string.IsNullOrEmpty(model.FirstName) ? account.FirstName : model.FirstName;
            account.LastName = string.IsNullOrEmpty(model.LastName) ? account.LastName : model.LastName;
            account.Avatar = string.IsNullOrEmpty(model.Avatar) ? account.Avatar : model.Avatar;
            account.UpdatedBy = _userResolverService.GetUserId();
            account.UpdatedDate = DateTime.Now;

            if (!string.IsNullOrEmpty(model.Email))
            {
                account.UserName = model.Email;
                account.Email = model.Email;
            }
        }

        public async Task<Dictionary<ErrorModel, AccountModel>> GetById(string Id)
        {
            var accountResult = new Dictionary<ErrorModel, AccountModel>();
            ErrorModel errors = new ErrorModel();

            if (!string.IsNullOrEmpty(Id))
            {
                var checkAccount = await FilterAccountById(Id);
                if (!checkAccount.First().Key.IsEmpty)
                {
                    checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                    accountResult.Add(errors, new AccountModel());
                    return accountResult;
                }
                AccountModel model = new AccountModel(checkAccount.First().Value);
                accountResult.Add(errors, model);
            }
            return accountResult;
        }

        public async Task<Dictionary<ErrorModel, AccountModel>> GetByToken()
        {
            var userId = _userResolverService.GetUserId();
            var accountResult = new Dictionary<ErrorModel, AccountModel>();
            var errors = new ErrorModel();
            if (!string.IsNullOrEmpty(userId))
            {
                var checkAccount = await FilterAccountById(userId);
                if (!checkAccount.First().Key.IsEmpty)
                {
                    checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                    accountResult.Add(errors, new AccountModel());
                }
                else
                {
                    AccountModel model = new AccountModel(checkAccount.First().Value, true);
                    accountResult.Add(errors, model);
                }
            }
            return accountResult;
        }

        public async Task<Dictionary<ErrorModel, AccountModel>> Delete(string userId)
        {
            var accountResult = new Dictionary<ErrorModel, AccountModel>();
            var errors = new ErrorModel();
            var checkAccount = await FilterAccountById(userId);

            if (!checkAccount.First().Key.IsEmpty)
            {
                checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }

            if (checkAccount.First().Value.Email == Settings.DEFAULT_ADMIN_EMAIL)
            {
                errors.Add(ErrorResource.Permission_Denied);
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }

            checkAccount.First().Value.UserName = Settings.REMOVE + "_" + DateTimeOffset.Now.ToUnixTimeMilliseconds() + "_" + checkAccount.First().Value.UserName;
            checkAccount.First().Value.LastName = checkAccount.First().Value.LastName + " (Deleted)";
            checkAccount.First().Value.Deleted = true;
            var result = await _userManager.UpdateAsync(checkAccount.First().Value);
            if (!result.Succeeded)
            {
                foreach (var error in result.Errors)
                {
                    errors.Add(error.Description);
                }
                accountResult.Add(errors, new AccountModel());
                return accountResult;
            }
            else
            {
                AccountModel accountProfile = new AccountModel(checkAccount.First().Value);
                accountResult.Add(errors, accountProfile);
            }
            return accountResult;
        }

        private async Task<Dictionary<ErrorModel, RoleDb>> FilterRoleById(string role)
        {
            var result = new Dictionary<ErrorModel, RoleDb>();
            var errors = new ErrorModel();
            var roleDb = await _roleManager.FindByIdAsync(role);

            if (roleDb == null)
            {
                errors.Add(ErrorResource.RoleNotFound);
                result.Add(errors, new RoleDb());
            }
            else
            {
                result.Add(errors, roleDb);
            }
            return result;
        }
        private async Task<Dictionary<ErrorModel, Account>> FilterAccountById(string userId, bool isUpdateProfile = false)
        {
            var result = new Dictionary<ErrorModel, Account>();
            var errors = new ErrorModel();
            var account = await _userManager.FindByIdAsync(userId);

            if (account == null || account.Deleted == true)
            {
                errors.Add(ErrorResource.AccountNotFound);
                result.Add(errors, new Account());
            }
            else if (isUpdateProfile == true)
            {
                if (account.IsActive == false)
                {
                    errors.Add(ErrorResource.AccountIsDeactive);
                    result.Add(errors, new Account());
                    return result;
                }
                result.Add(errors, account);
            }
            else
            {
                result.Add(errors, account);
            }
            return result;
        }

        public string GetNameByToken()
        {
            var user = _dbContext.Users.Where(x => !x.Deleted && x.IsActive && x.Id == _userResolverService.GetUserId()).Select(x => new
            {
                FirstName = x.FirstName,
                LastName = x.LastName
            }).FirstOrDefault();
            var name = "";
            if (user != null)
            {
                name = user.FirstName + ' ' + user.LastName;
            }
            return name;
        }

        public PaginationModel<AccountShortModel> GetUsers(PaginationAccountRequest req)
        {
            string userId = _userResolverService.GetUserId();
            Guid branchNavigationId = Guid.Empty;
            Guid.TryParse(_userResolverService.GetBranch(), out branchNavigationId);

            IQueryable<Account> accounts = _userManager.Users.Include(x => x.AccountRoleMaps)
                .ThenInclude(y => y.Role).Where(account => !account.Deleted);

            if (!string.IsNullOrEmpty(req.Code))
            {
                accounts = accounts.Where(account => account.Code.ToUpper().Contains(req.Code.ToUpper()));
            }

            if (!string.IsNullOrEmpty(req.FullName))
            {
                accounts = accounts.Where(account => (account.FirstName + " " + account.LastName).ToUpper().Contains(req.FullName.ToUpper()));
            }

            if (!string.IsNullOrEmpty(req.Email))
            {
                accounts = accounts.Where(account => (account.Email.ToUpper().Contains(req.Email.ToUpper())));
            }

            if (req.LastUpdate.HasValue)
            {
                accounts = accounts.Where(account => account.UpdatedDate.Date == req.LastUpdate.Value.Date);
            }

            if (req.NotMe != null && req.NotMe.Value)
            {
                accounts = accounts.Where(account => account.Id.ToUpper() != userId.ToUpper());
            }
            if (req.Active.HasValue)
            {
                if (req.Active.Value)
                {
                    accounts = accounts.Where(account => account.IsActive);
                }
                if (!req.Active.Value)
                {
                    accounts = accounts.Where(account => !account.IsActive);
                }
            }

            if (req.IsLock.HasValue && req.IsLock.Value == true)
            {
                accounts = accounts.Where(account => account.LoginAttempt >= Settings.LOGIN_ATTEMPT_NUMBER);
            }
            else
            {
                accounts = accounts.Where(account => account.LoginAttempt < Settings.LOGIN_ATTEMPT_NUMBER);
            }

            accounts = req.Sort.ToLower() switch
            {
                Sort.AccountSort.CODE => accounts.OrderBy(x => x.Code),
                Sort.AccountSort.CODE_DESC => accounts.OrderByDescending(x => x.Code),
                Sort.AccountSort.FULLNAME => accounts.OrderBy(x => x.FirstName + " " + x.LastName),
                Sort.AccountSort.FULLNAME_DESC => accounts.OrderByDescending(x => x.FirstName + " " + x.LastName),
                Sort.AccountSort.EMAIL => accounts.OrderBy(x => x.Email),
                Sort.AccountSort.EMAIL_DESC => accounts.OrderByDescending(x => x.Email),
                Sort.AccountSort.LASTUPDATE => accounts.OrderBy(x => x.UpdatedDate),
                Sort.AccountSort.LASTUPDATE_DESC => accounts.OrderByDescending(x => x.UpdatedDate),
                _ => accounts.OrderByDescending(x => x.UpdatedDate),
            };

            PaginationModel<AccountShortModel> pagination = new PaginationModel<AccountShortModel>(req);
            pagination.TotalCount = accounts.Count();
            pagination.TotalPage = (int)Math.Ceiling((decimal)pagination.TotalCount / req.Amount);

            if (req.PaginationType == PaginationType.Pagination)
            {
                pagination.Data = accounts.Skip(req.Amount * req.Page).Take(req.Amount).AsEnumerable().Select(x => new AccountShortModel(x)).ToList();
            }
            else
            {
                pagination.Data = accounts.AsEnumerable().Select(x => new AccountShortModel(x)).ToList();
            }

            return pagination;
        }

        public async Task<ErrorModel> ChangeState(string userId, bool state)
        {
            var errors = new ErrorModel();
            var checkAccount = await FilterAccountById(userId);
            var passwords = JWTHelper.GenerateRandomPassword(true, true, true, true, 8);

            if (!checkAccount.First().Key.IsEmpty)
            {
                checkAccount.First().Key.Errors.ForEach(error => errors.Add(error));
                return errors;
            }
            else
            {
                checkAccount.First().Value.IsActive = state;
                checkAccount.First().Value.UpdatedDate = DateTime.Now;
                checkAccount.First().Value.UpdatedBy = _userResolverService.GetUserId();

                if (state)
                {
                    checkAccount.First().Value.HasChangeFirstPwd = false;
                    var token = await _userManager.GeneratePasswordResetTokenAsync(checkAccount.First().Value);
                    await _userManager.ResetPasswordAsync(checkAccount.First().Value, token, passwords);
                }

                var result = await _userManager.UpdateAsync(checkAccount.First().Value);

                if (!result.Succeeded)
                {
                    foreach (var error in result.Errors)
                    {
                        errors.Add(error.Description);
                    }
                }

                return errors;
            }
        }
    }
}
