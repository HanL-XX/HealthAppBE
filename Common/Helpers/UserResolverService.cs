using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Common.Helpers
{
    public class UserResolverService
    {
        private readonly IHttpContextAccessor _context;
        public UserResolverService(IHttpContextAccessor context)
        {
            _context = context;
        }

        public string GetEmailUser()
        {
            try
            {
                var email = _context.HttpContext?.User?.Claims.FirstOrDefault()?.Value ?? "";
                return email;
            }
            catch (Exception)
            {
                // ignored
            }

            return string.Empty;
        }

        public string GetUserId()
        {
            try
            {
                var claims = _context.HttpContext?.User?.Claims;

                if (claims.Count() > 0)
                {
                    var nameId = claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier);

                    if (nameId != null)
                    {
                        return nameId.Value;
                    }
                }

                return _context.HttpContext?.User?.Identity?.Name;
            }
            catch (Exception) { }

            return string.Empty;
        }

        public string GetBranch()
        {
            string branchNavigation = _context.HttpContext?.Request.Query[Constant.GlobalConstant.NAVIGATION_BRANCH_REQUEST_CODE].ToString();

            if (!string.IsNullOrEmpty(branchNavigation))
            {
                return branchNavigation.ToLower();
            }

            return string.Empty;
        }

        public string GetTokenFirebase()
        {
            var result = string.Empty;
            try
            {
                if (_context.HttpContext.Request.Headers.TryGetValue(Constant.GlobalConstant.FIREBASE_MESSAGING, out var authorizationToken))
                {
                    result = authorizationToken;
                }
            }
            catch
            {
                // do nothing, no token found
            }

            return result;
        }
    }
}
