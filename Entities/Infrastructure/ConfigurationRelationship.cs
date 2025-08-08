using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace Entities.Infrastructure
{
    public class ConfigurationRelationship
    {
        public static void ConfigDefaultDB(ModelBuilder builder)
        {
            builder.Entity<AccountRoleMap>(userRole =>
            {
                userRole.HasKey(ur => new { ur.UserId, ur.RoleId });

                userRole.HasOne(ur => ur.Role)
                    .WithMany(r => r.AccountRoleMaps)
                    .HasForeignKey(ur => ur.RoleId)
                    .IsRequired();

                userRole.HasOne(ur => ur.Account)
                    .WithMany(r => r.AccountRoleMaps)
                    .HasForeignKey(ur => ur.UserId)
                    .IsRequired();
            });

            builder.Entity<Account>()
                .Property(b => b.IsActive)
                .HasDefaultValue(true);

            builder.Entity<RoleDb>()
                .Property(b => b.IsActive)
                .HasDefaultValue(true);
        }
    }
}
