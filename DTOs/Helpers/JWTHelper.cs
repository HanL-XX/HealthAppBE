using Common.Helpers;
using DTOs.Models;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace DTOs.Helpers
{
    public static class JWTHelper
    {
        public static IConfiguration Configuration { get; set; }

        public static TokenModel GenerateJwtToken(string userName, string accountId, string role)
        {
            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, userName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.Name, accountId),
                new Claim(ClaimTypes.Role, role)
            };
            Configuration.GetValue<string>("JWTToken:JwtKey");

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTToken:JwtKey")));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            var expires = DateTime.Now.AddDays(Convert.ToDouble(Configuration.GetValue<string>("JWTToken:JwtExpireDays")));

            var tokenProperties = new JwtSecurityToken(
                Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                claims,
                expires: expires,
                signingCredentials: creds
            );

            return new TokenModel(new JwtSecurityTokenHandler().WriteToken(tokenProperties), tokenProperties);
        }

        public static TokenModel GenerateJwtTokenWithTime(string userName, string accountId, string role, DateTime expires)
        {
            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, userName),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.Name, accountId),
                new Claim(ClaimTypes.Role, role),
                new Claim(ClaimTypes.GroupSid, "Custom")
            };
            Configuration.GetValue<string>("JWTToken:JwtKey");

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTToken:JwtKey")));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var tokenProperties = new JwtSecurityToken(
                Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                Configuration.GetValue<string>("JWTToken:JwtIssuer"),
                claims,
                expires: expires,
                signingCredentials: creds
            );

            return new TokenModel(new JwtSecurityTokenHandler().WriteToken(tokenProperties), tokenProperties);
        }

        public static string GeneratePassword(string password)
        {
            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
              password: password,
              salt: Encoding.ASCII.GetBytes(Settings.SALT),
              prf: KeyDerivationPrf.HMACSHA1,
              iterationCount: 10000,
              numBytesRequested: 256 / 8));

            return hashed;
        }

        public static string GenerateRandomPassword(bool useLowercase, bool useUppercase, bool useNumbers, bool useSpecial, int passwordSize)
        {
            const string LOWER_CASE = "abcdefghijklmnopqursuvwxyz";
            const string UPPER_CASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string NUMBERS = "0123456789";
            const string SPECIALS = @"!@£$%^&*()#€";

            char[] _passwords = new char[8];
            string charSet = "";
            System.Random _random = new Random();
            int counter = 0;

            if (useLowercase)
            {
                _passwords[counter] = LOWER_CASE[_random.Next(LOWER_CASE.Length - 1)];
                charSet += LOWER_CASE;
                counter++;
            }
            if (useUppercase)
            {
                _passwords[counter] = UPPER_CASE[_random.Next(UPPER_CASE.Length - 1)];
                charSet += UPPER_CASE;
                counter++;
            }
            if (useNumbers)
            {
                _passwords[counter] = NUMBERS[_random.Next(NUMBERS.Length - 1)];
                charSet += NUMBERS;
                counter++;
            }
            if (useSpecial)
            {
                _passwords[counter] = SPECIALS[_random.Next(SPECIALS.Length - 1)];
                charSet += SPECIALS;
                counter++;
            }

            while (counter < passwordSize)
            {
                _passwords[counter] = charSet[_random.Next(charSet.Length - 1)];
                counter++;
            }

            Random rng = new Random();
            int n = _passwords.Length;
            while (n > 1)
            {
                n--;
                int k = rng.Next(n + 1);
                var value = _passwords[k];
                _passwords[k] = _passwords[n];
                _passwords[n] = value;
            }

            return String.Join(null, _passwords);
        }

        public static string GenerateJwtTokenCustomer(Guid accountId)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTToken:JwtKey")));
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", accountId.ToString()) }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        public static Guid? ValidateJwtToken(string token)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTToken:JwtKey")));
            try
            {
                tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = key,
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    // set clockskew to zero so tokens expire exactly at token expiration time (instead of 5 minutes later)
                    ClockSkew = TimeSpan.Zero
                }, out SecurityToken validatedToken);

                var jwtToken = (JwtSecurityToken)validatedToken;
                var accountId = Guid.Parse(jwtToken.Claims.First(x => x.Type == "id").Value);

                // return account id from JWT token if validation successful
                return accountId;
            }
            catch
            {
                // return null if validation fails
                return null;
            }
        }
    }
}
