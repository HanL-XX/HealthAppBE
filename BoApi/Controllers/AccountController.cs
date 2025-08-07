using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Common.Constant;
using Common.Helpers;
using DTOs.Models;
using Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Services.Interface;

namespace BoApi.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    //[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class AccountController : BaseController
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        /// <summary>
        /// Create Account
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        //[Filters.CustomAuthorize(PermissionId: PermissionEnum.Users)]
        public async Task<IActionResult> Create([FromBody] CreateAccountModel model)
        {
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                return BadRequest(errors);
            }

            Dictionary<ErrorModel, AccountModel> account = await _accountService.CreateAccount(model);
            if (!account.First().Key.IsEmpty)
            {
                return BadRequest(account.First().Key);
            }

            return Ok(account.First().Value);
        }

        /// <summary>
        /// Update Account
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut("{userId}")]
        //[Filters.CustomAuthorize(PermissionId: PermissionEnum.Users)]
        public async Task<IActionResult> Update(string userId, [FromBody] UpdateAccountModel model)
        {
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                return BadRequest(errors);
            }

            var connectionString = Startup.Configuration.GetConnectionString("ApiConnection");
            Dictionary<ErrorModel, AccountModel> account = await _accountService.Update(userId, model, connectionString);
            if (!account.First().Key.IsEmpty)
            {
                return BadRequest(account.First().Key);
            }

            return Ok(account.First().Value);
        }

        /// <summary>
        /// Get account's profile by account Id
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        [Route("GetById/{Id}")]
        [HttpGet]
        public async Task<IActionResult> GetById(string Id)
        {
            Dictionary<ErrorModel, AccountModel> account = await _accountService.GetById(Id);
            if (!account.First().Key.IsEmpty)
            {
                return NotFound(account.First().Key);
            }

            return Ok(account.First().Value);
        }

        /// <summary>
        /// Delete User
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        [HttpDelete]
        [Route("{userId}")]
        //[Filters.CustomAuthorize(PermissionId: PermissionEnum.Users)]
        public async Task<IActionResult> Delete(string userId)
        {
            Dictionary<ErrorModel, AccountModel> errors = await _accountService.Delete(userId);
            if (!errors.First().Key.IsEmpty)
            {
                return BadRequest(errors.First().Key);
            }

            return Ok();
        }

        /// <summary>
        /// Update Profile
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPut]
        public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfile model)
        {
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                return BadRequest(errors);
            }

            string connectionString = Startup.Configuration.GetConnectionString("ApiConnection");
            Dictionary<ErrorModel, SearchAcccountModel> account = await _accountService.UpdateByToken(model, connectionString);
            if (!account.First().Key.IsEmpty)
            {
                return BadRequest(account.First().Key);
            }

            return Ok(account.First().Value);
        }

        /// <summary>
        /// Get Account By Token
        /// </summary>
        /// <returns></returns>
        [Route("GetByToken")]
        [HttpGet]
        public async Task<IActionResult> GetByToken()
        {
            Dictionary<ErrorModel, AccountModel> account = await _accountService.GetByToken();

            if (account.Count == 0)
            {
                return Unauthorized();
            }

            if (!account.First().Key.IsEmpty)
            {
                return Unauthorized();
            }

            return Ok(account.First().Value);
        }

        /// <summary>
        /// Get Users with Pagination
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        [HttpGet]
        public PaginationModel<AccountShortModel> Get([FromQuery] PaginationAccountRequest req)
        {
            req.Format();
            return _accountService.GetUsers(req);
        }

        /// <summary>
        /// Change state User
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="state"></param>
        /// <returns></returns>
        [HttpPut("ChangeState/{Id}/{state}")]
        //[Filters.CustomAuthorize(PermissionId: PermissionEnum.Users)]
        public async Task<IActionResult> ChangeState(string Id, bool state)
        {
            ErrorModel error = await _accountService.ChangeState(Id, state);

            if (error.IsEmpty)
            {
                return Ok();
            }

            return BadRequest(error);
        }

        [HttpPut("ResetUserPassword")]
        //[Filters.CustomAuthorize(PermissionId: PermissionEnum.Users)]
        public async Task<IActionResult> ResetPassword(string Id)
        {
            ErrorModel errors = new ErrorModel();

            if (!ModelState.IsValid)
            {
                AddErrorsFromModelState(ref errors);
                return BadRequest(errors);
            }

            await _accountService.ResetPassword(Id);
            if (errors.IsEmpty)
            {
                return Ok();
            }

            errors.Add(Common.ErrorLocalization.ErrorResource.ResetPasswordFailed);
            return BadRequest(errors);
        }

    }
}