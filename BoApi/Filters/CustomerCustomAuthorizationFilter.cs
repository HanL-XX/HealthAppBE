using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Common.Constant;
using Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace BoApi.Filters
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
    public sealed class CustomerCustomAuthorizeAttribute : AuthorizeAttribute, IAuthorizationFilter
    {
        public PermissionEnum _permissionId { get; set; }

        public CustomerCustomAuthorizeAttribute() { }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
        }
    }
}