using Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Entities
{
    public class RefreshToken : Entity<int>
    {
        public string Username { get; set; }
        public string Refreshtoken { get; set; }
        public bool Revoked { get; set; }
        public string UserId { get; set; }
        public string Role { get; set; }
    }
}
