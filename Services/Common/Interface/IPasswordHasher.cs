using Common.Constant;
using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Common.Interface
{
    public interface IPasswordHasher<TUser> where TUser : class
    {
        string HashPassword(TUser user, string password);
        PasswordVerificationResult VerifyHashedPassword(TUser user, string hashedPassword, string providedPassword);
    }
}
