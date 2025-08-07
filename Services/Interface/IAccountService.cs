using DTOs.Models;
using Entities;
using Services.Common;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Services.Interface
{
    public interface IAccountService
    {
        Task<Dictionary<ErrorModel, AccountModel>> CreateAccount(CreateAccountModel model);
        Task<ErrorModel> ResetPassword(string Id);
        Task<Dictionary<ErrorModel, AccountModel>> Update(string userId, UpdateAccountModel model, string connectionString);
        Task<Dictionary<ErrorModel, AccountModel>> GetById(string Id);
        Task<Dictionary<ErrorModel, AccountModel>> Delete(string userId);
        Task<Dictionary<ErrorModel, SearchAcccountModel>> UpdateByToken(UpdateProfile model, string connectionString);
        Task<Dictionary<ErrorModel, AccountModel>> GetByToken();
        PaginationModel<AccountShortModel> GetUsers(PaginationAccountRequest req);
        Task<ErrorModel> ChangeState(string userId, bool state);
        string GetNameByToken();
    }
}
