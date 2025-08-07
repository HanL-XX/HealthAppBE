using Common.Constant;
using Common.Helpers;
using Entities.Infrastructure;
using Entities.SPModels;
using Infrastructure;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Entities
{

    public class ApiDbContext : IdentityDbContext<Account, RoleDb, string, IdentityUserClaim<string>,
                    AccountRoleMap, IdentityUserLogin<string>,
                    IdentityRoleClaim<string>, IdentityUserToken<string>>
    {
        private readonly UserResolverService _userResolverService;
        private readonly string _logConnectionString;
        private readonly List<string> _includedAuditLogTables;


        public ApiDbContext(DbContextOptions<ApiDbContext> options, UserResolverService userResolverService, IConfiguration configuration) : base(options)
        {
            _userResolverService = userResolverService;
        }

        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options) { }

        public static ApiDbContext Create(DbContextOptions<ApiDbContext> options, UserResolverService userResolverService, IConfiguration configuration)
        {
            return new ApiDbContext(options, userResolverService, configuration);
        }

        public static ApiDbContext Create(DbContextOptions<ApiDbContext> options)
        {
            return new ApiDbContext(options);
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            // Customize the ASP.NET Identity model and override the defaults if needed.
            // For example, you can rename the ASP.NET Identity table names and more.
            // Add your customizations after calling base.OnModelCreating(builder);
            base.OnModelCreating(builder);

            ConfigurationRelationship.ConfigDefaultDB(builder);
        }

        public DbSet<RefreshToken> RefreshTokens { get; set; }

        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default(CancellationToken))
        {
            var entries = ChangeTracker.Entries();
            List<EntityEntry> modifiedEntries = new List<EntityEntry>();

            /// When entity is Auditable enrich with user and updated / created date.
            EnrichAuditableEntities(entries, modifiedEntries);

            /// Audit log changes.
            /// do not let this excception prevent the actual change
            /// 
            try
            {
                await AuditLogAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                ///TODO Log this somewhere.
            }
            return await base.SaveChangesAsync(cancellationToken);
        }

        public override int SaveChanges()
        {
            var entries = ChangeTracker.Entries();
            List<EntityEntry> modifiedEntries = new List<EntityEntry>();

            /// When entity is Auditable enrich with user and updated / created date.
            EnrichAuditableEntities(entries, modifiedEntries);

            /// Audit log changes.
            /// do not let this excception prevent the actual change
            /// 
            try
            {
                AuditLog();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                ///TODO Log this somewhere.
            }
            return base.SaveChanges();
        }

        private void EnrichAuditableEntities(IEnumerable<EntityEntry> entries, List<EntityEntry> modifiedEntries)
        {
            //Get entries add or update to database
            foreach (var entry in entries)
            {
                if (entry.Entity is IAuditableEntity && entry.State == EntityState.Added || entry.State == EntityState.Modified)

                {
                    modifiedEntries.Add(entry);
                }
            }

            //Set CreatedBy, CreatedDate, UpdatedBy, UpdatedDate for IAuditableEntity
            foreach (var entry in modifiedEntries)
            {
                DateTime now = DateTime.Now;

                if (entry.Entity is IAuditableEntity entity)
                {
                    string identityName = _userResolverService.GetUserId();

                    if (entry.State == EntityState.Added)
                    {
                        if (identityName != null)
                        {
                            entity.CreatedBy = string.IsNullOrEmpty(entity.CreatedBy) ? identityName : entity.CreatedBy;
                        }
                        entity.CreatedDate = now;
                    }
                    else
                    {
                        //if (!(entity is StockCountDetail))
                        //{
                        //    base.Entry(entity).Property(x => x.CreatedBy).IsModified = false;
                        //    base.Entry(entity).Property(x => x.CreatedDate).IsModified = false;
                        //}
                    }

                    if (identityName != null)
                    {
                        entity.UpdatedBy = identityName;
                    }

                    entity.UpdatedDate = now;
                }

                if (entry.Entity is BaseEntity baseEntity && entry.State == EntityState.Added && !ExcludeEntity(entry))
                {
                    baseEntity.Deleted = false;
                }
            }
        }

        /// <summary>
        /// Convert entityframework entries
        /// into audit logs and save to AuditLogs table.   
        /// Population will include only auditable entities and tables that
        /// we specify in appsettings file under AuditLog:includedTables
        /// </summary>
        private void AuditLog()
        {
            if (!string.IsNullOrEmpty(_logConnectionString))
            {
                //List<AuditEntryModel> auditEntries = GetAuditChangePopulation();
            }
        }

        private async Task AuditLogAsync()
        {
            if (!string.IsNullOrEmpty(_logConnectionString))
            {
            }
        }

        /// <summary>
        /// todo: comment
        /// </summary>
        /// <returns></returns>
        private List<AuditEntryModel> GetAuditChangePopulation()
        {
            ChangeTracker.DetectChanges();
            var auditEntries = new List<AuditEntryModel>();
            foreach (var entry in ChangeTracker.Entries())
            {
                //if (entry.Entity is Audit || entry.State == EntityState.Detached || entry.State == EntityState.Unchanged)
                //    continue;
                if (!(entry.Entity is IAuditableEntity))
                {
                    continue;
                }

                var auditEntry = new AuditEntryModel(entry);
                auditEntry.TableName = entry.Entity.GetType().Name;
                auditEntry.TableName = auditEntry.TableName.Replace("Proxy", "");

                if (auditEntry.TableName.Contains("Proxy"))
                {
                    auditEntry.TableName = entry.Entity.GetType().BaseType.Name;
                }
                /// Only audit log requested tables.
                /// Note: mybe it would be better to add more functionalities
                /// like log all , log only update,insert,log except                
                if (!_includedAuditLogTables.Contains(auditEntry.TableName))
                {
                    continue;
                }

                auditEntry.UserId = (entry.Entity as IAuditableEntity).UpdatedBy;
                auditEntries.Add(auditEntry);
                /// audit log will contains old data and new data, 
                /// and also add an array with the properties that was changed
                foreach (var property in entry.Properties)
                {
                    string propertyName = property.Metadata.Name;
                    if (property.Metadata.IsPrimaryKey())
                    {
                        auditEntry.KeyValues[propertyName] = property.CurrentValue;
                        continue;
                    }
                    switch (entry.State)
                    {
                        case EntityState.Added:
                            auditEntry.AuditType = AuditType.Create;
                            auditEntry.NewValues[propertyName] = property.CurrentValue;
                            break;
                        case EntityState.Deleted:
                            auditEntry.AuditType = AuditType.Delete;
                            auditEntry.OldValues[propertyName] = property.OriginalValue;
                            break;
                        case EntityState.Modified:
                            if (property.IsModified)
                            {
                                auditEntry.ChangedColumns.Add(propertyName);
                                auditEntry.AuditType = AuditType.Update;
                                auditEntry.OldValues[propertyName] = property.OriginalValue;
                                auditEntry.NewValues[propertyName] = property.CurrentValue;
                            }
                            break;
                    }
                }
            }

            return auditEntries;
        }

        private bool ExcludeEntity(EntityEntry entry)
        {
            //return (entry.Entity is ProductDimensionPrice || entry.Entity is PosUserGroupFunction || entry.Entity is ProductDimension || entry.Entity is OfferSet);
            return false;
        }

    }
}
