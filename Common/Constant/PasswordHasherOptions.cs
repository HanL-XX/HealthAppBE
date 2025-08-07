using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace Common.Constant
{
    public class PasswordHasherOptions
    {
        private static readonly RandomNumberGenerator _defaultRng = RandomNumberGenerator.Create(); // secure PRNG

        public PasswordHasherCompatibilityMode CompatibilityMode { get; set; } = PasswordHasherCompatibilityMode.IdentityV3;

        public int IterationCount { get; set; } = 10000;

        public RandomNumberGenerator Rng { get; set; } = _defaultRng;
    }
}
