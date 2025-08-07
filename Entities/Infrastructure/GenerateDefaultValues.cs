using Dapper;
using Common.Constant;
using Common.Helpers;
using Microsoft.AspNetCore.Identity;
using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using System.Text.RegularExpressions;

namespace Entities.Infrastructure
{
    public static class GenerateDefaultValues
    {
        public static IConfiguration Configuration { get; set; }

        public static async Task GenerateData(IServiceProvider serviceProvider, IHostEnvironment hostingEnviroment, string apiConnectionString, string transactionConnectionString)
        {
            try
            {
                InitHOBranch(hostingEnviroment, serviceProvider);
                InitOnlineBranch(hostingEnviroment, serviceProvider);
                await CreateUserRoles(serviceProvider);
                GenerateInitData(serviceProvider, hostingEnviroment, apiConnectionString, transactionConnectionString);
                InitENLanguage(hostingEnviroment, serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void GenerateInitData(IServiceProvider serviceProvider, IHostEnvironment hostingEnviroment, string apiConnectionString, string transactionConnectionString)
        {
            InitModule(hostingEnviroment, serviceProvider);
            IniTableStatus(hostingEnviroment, serviceProvider);
            InitDeviceModule(hostingEnviroment, serviceProvider);
            InitTopCurrency(hostingEnviroment, serviceProvider);
            InitValidationRule(hostingEnviroment, serviceProvider);
            InitTenderType(hostingEnviroment, serviceProvider);
            Init_DbSyncSetting(hostingEnviroment, serviceProvider);
            Init_PRINT_TEMPLATE(hostingEnviroment, serviceProvider);
            Init_Report_Module(hostingEnviroment, serviceProvider);
            Init_TicketOnlineSettings(hostingEnviroment, serviceProvider);
            InitDeclarationType(hostingEnviroment, serviceProvider);
            Init_Setting(hostingEnviroment, serviceProvider);
            Init_StoredProcedures(hostingEnviroment, apiConnectionString, serviceProvider, INIT_SQL_PATH.INIT_SP);
            Init_StoredProcedures(hostingEnviroment, apiConnectionString, serviceProvider, INIT_SQL_PATH.INIT_REPORT_SP);
            Init_Report_Filter(hostingEnviroment, serviceProvider);
        }


        private static void IniTableStatus(IHostEnvironment hostingEnviroment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.TABLE_REPORT, hostingEnviroment), serviceProvider);
            }
            catch (Exception) { }
        }

        public static async Task TicketingGenerateData(IServiceProvider serviceProvider, IHostEnvironment hostingEnviroment, string apiConnectionString, string transactionConnectionString)
        {
            try
            {
                await CreateTicketingUserRoles(serviceProvider);
                TicketingGenerateInitData(serviceProvider, hostingEnviroment, apiConnectionString, transactionConnectionString);
            }
            catch (Exception e) { }
        }
        public static void CustomerGenerateData(IServiceProvider serviceProvider, IHostEnvironment hostingEnviroment, string customerConnectionString)
        {
            try
            {
                Init_CustomerStoredProcedures(hostingEnviroment, customerConnectionString, serviceProvider, INIT_SQL_PATH.INIT_CUSTOMER_SP);
            }
            catch (Exception e) { }
        }
        private static void TicketingGenerateInitData(IServiceProvider serviceProvider, IHostEnvironment hostingEnviroment, string apiConnectionString, string transactionConnectionString)
        {
            InitTicketingModule(hostingEnviroment, serviceProvider);
            InitTicketingTopCurrency(hostingEnviroment, serviceProvider);
            InitTicketingTenderType(hostingEnviroment, serviceProvider);
            InitTicketingDeclarationType(hostingEnviroment, serviceProvider);
            InitTicketingValidationRule(hostingEnviroment, serviceProvider);
            InitTicketingTicketProperties(hostingEnviroment, serviceProvider);
            //InitTicketingDeviceModule(hostingEnviroment, serviceProvider);
            InitTicketingPriceLevel(hostingEnviroment, serviceProvider);
            Init_TicketingSetting(hostingEnviroment, serviceProvider);
            Init_TicketingData(hostingEnviroment, serviceProvider);
            Init_TicketingReport_Module(hostingEnviroment, serviceProvider);
            Init_TicketingOrderNo(hostingEnviroment, serviceProvider);
            Init_TicketingStoredProcedures(hostingEnviroment, apiConnectionString, serviceProvider, INIT_SQL_PATH.INIT_TICKETING_SP);
            Init_TicketingStoredProcedures(hostingEnviroment, apiConnectionString, serviceProvider, INIT_SQL_PATH.INIT_TICKETING_REPORT_SP);
            Init_TicketingDbSyncSetting(hostingEnviroment, serviceProvider);
            Init_TicketingPrintTemplates(hostingEnviroment, serviceProvider);
        }

        public static async Task CreateUserRoles(IServiceProvider serviceProvider)
        {
            //var roleManager = serviceProvider.GetRequiredService<RoleManager<RoleDb>>();
            //var userManager = serviceProvider.GetRequiredService<UserManager<Account>>();
            var dbContext = serviceProvider.GetRequiredService<ApiDbContext>();

            string roleName = Settings.DEFAULT_ECR_ADMIN_ROLE;
            //var role = await roleManager.FindByNameAsync(roleName);
            var role = dbContext.Roles.FirstOrDefault(x => x.IsActive && x.Name.ToLower().Equals(roleName.ToLower()));

            if (role == null)
            {
                role = new RoleDb()
                {
                    AccountRoleMaps = new List<AccountRoleMap>(),
                    IsActive = true,
                    Name = roleName,
                    Level = 0,
                    CreatedDate = DateTime.Now,
                    UpdatedDate = DateTime.Now,
                };

                //await roleManager.CreateAsync(role);
                dbContext.Roles.Add(role);
                dbContext.SaveChanges();
            }

            string email = Settings.DEFAULT_ADMIN_EMAIL;

            //var defaultSuperAdmin = await userManager.FindByEmailAsync(email);
            var defaultSuperAdmin = dbContext.Users.FirstOrDefault(x => !x.Deleted && x.IsActive && x.Email.ToLower().Equals(email.ToLower()));

            if (defaultSuperAdmin == null)
            {
                Account account = new Account
                {
                    UserName = email,
                    Email = email,
                    EmailConfirmed = true,
                    IsActive = true,
                    HasChangeFirstPwd = true,
                };

                string password = Settings.DEFAULT_ADMIN_PASSWORD;

                //var results = await userManager.CreateAsync(account, password);
                var userId = dbContext.Users.Add(account).Entity.Id;
                dbContext.SaveChanges();

                //await userManager.AddToRoleAsync(account, roleName);
                var adminUserRole = dbContext.UserRoles.FirstOrDefault(x => x.UserId == userId);
                if (adminUserRole == null)
                {
                    dbContext.UserRoles.Add(new AccountRoleMap
                    {
                        Account = dbContext.Users.FirstOrDefault(x => !x.Deleted && x.IsActive && x.Email.ToLower().Equals(email.ToLower())),
                        Role = dbContext.Roles.FirstOrDefault(x => x.IsActive && x.Name.ToLower().Equals(roleName.ToLower()))
                    });
                }
                dbContext.SaveChanges();
            }

            var deviceRoleName = Settings.DEFAULT_ECR_DEVICE_ADMIN_ROLE;
        }

        public static async Task CreateTicketingUserRoles(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<RoleDb>>();
            var userManager = serviceProvider.GetRequiredService<UserManager<Account>>();
            var apiDbContext = serviceProvider.GetRequiredService<ApiDbContext>();

            var adminRole = apiDbContext.Roles.FirstOrDefault(x => x.IsActive && x.Name.ToLower().Equals(Settings.DEFAULT_ECR_ADMIN_ROLE.ToLower()));
            if (adminRole == null) return;

            string roleName = Settings.DEFAULT_ECR_ADMIN_ROLE;
            var role = await roleManager.FindByNameAsync(roleName);

            if (role == null)
            {
                role = new RoleDb()
                {
                    Id = adminRole.Id,
                    AccountRoleMaps = new List<AccountRoleMap>(),
                    IsActive = true,
                    Name = roleName,
                    Level = 0,
                    CreatedDate = DateTime.Now,
                    UpdatedDate = DateTime.Now,
                };

                await roleManager.CreateAsync(role);
            }

            var adminUser = apiDbContext.Users.FirstOrDefault(x => !x.Deleted && x.IsActive && x.Email.ToLower().Equals(Settings.DEFAULT_ADMIN_EMAIL.ToLower()));
            if (adminUser == null) return;

            string email = Settings.DEFAULT_ADMIN_EMAIL;

            var defaultSuperAdmin = await userManager.FindByEmailAsync(email);

            if (defaultSuperAdmin == null)
            {
                Account account = new Account
                {
                    Id = adminUser.Id,
                    UserName = email,
                    Email = email,
                    EmailConfirmed = true,
                    IsActive = true,
                    HasChangeFirstPwd = true,
                    FirstName = "Admin",
                    LastName = "Admin",
                };

                string password = Settings.DEFAULT_ADMIN_PASSWORD;

                var results = await userManager.CreateAsync(account, password);

                await userManager.AddToRoleAsync(account, roleName);
            }

            var deviceRoleName = Settings.DEFAULT_ECR_DEVICE_ADMIN_ROLE;
        }

        private static void InitHOBranch(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                string sql = @"IF NOT EXISTS (
						select *
						from 
							dbo.Branches
						where
							Code = 'HO'
					) 
					BEGIN
						insert into dbo.Branches(Active, Code, CreatedDate, Deleted, Name, UpdatedDate, Id)
						values (1, 'HO', GETDATE(), 0, '{0}', GETDATE(), NEWID())
					END";

                sql = string.Format(sql, Settings.DEFAULT_HEAD_OFFICE_NAME);

                ExecuteSQL(sql, serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitOnlineBranch(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                string sql = @"IF NOT EXISTS (
                        SELECT * 
                        FROM 
                            [dbo].[Branches]
                        WHERE
                            Code = 'OB'
                    )
                    BEGIN
                        INSERT INTO [dbo].[Branches](Id, Name, Code, 
                                                    BranchGroupId, 
                                                    Deleted, Active, CreatedDate, UpdatedDate)

                        VALUES( NEWID(), '{0}', 'OB', 
                                ( SELECT TOP 1 Id FROM BranchGroups), 
                                0, 1, GETDATE(), GETDATE())
                    END";

                sql = string.Format(sql, Settings.DEFAULT_ONLINE_BRANCH_NAME);

                ExecuteSQL(sql, serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_Report_Module(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_REPORT_MODULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_Setting(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_SETTING, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketOnlineSettings(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKET_ONLINE_SETTING, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_StoredProcedures(IHostEnvironment environment, string connectionString, IServiceProvider serviceProvider, string filePath)
        {
            var fileInfo = environment.ContentRootFileProvider.GetFileInfo(filePath);

            if (fileInfo.Exists)
            {
                using (var stream = File.OpenRead(fileInfo.PhysicalPath))
                {
                    using (System.Data.IDbConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        foreach (string part in GetScriptParts(stream))
                        {
                            using (var cmd = conn.CreateCommand())
                            {
                                try
                                {
                                    cmd.CommandText = part;
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception e) { }
                            }
                        }
                        conn.Close();
                    }
                }
            }
        }

        private static void InitModule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.MODULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitDeviceModule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.DEVICE_MODULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_DbSyncSetting(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.DB_SYNC_SETTING, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitValidationRule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.VALIDATION_RULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitTopCurrency(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TOP_CURRENCY, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitDeclarationType(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_DECLARATION_TYPE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTenderType(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TENDER_TYPE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void Init_PRINT_TEMPLATE(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                string sql = ReadFile(INIT_SQL_PATH.PRINT_TEMPLATE, environment);
                ExecuteSQL(sql, serviceProvider);
            }
            catch (Exception ex) { }
        }

        private static int ExecuteSQL(string sql, IServiceProvider serviceProvider)
        {
            int result = 0;


            using (System.Data.IDbConnection connection = new SqlConnection(Configuration.GetConnectionString("ApiConnection")))
            {
                connection.Open();
                connection.Execute(sql);
            }

            return result;
        }

        private static int TicketingExecuteSQL(string sql, IServiceProvider serviceProvider)
        {
            int result = 0;

            using (System.Data.IDbConnection connection = new SqlConnection(Configuration.GetConnectionString("TicketingConnection")))
            {
                connection.Open();
                connection.Execute(sql);
            }

            return result;
        }

        private static string ReadFile(string path, IHostEnvironment hostingEnvironment)
        {
            var fileInfo = hostingEnvironment.ContentRootFileProvider.GetFileInfo(path);

            if (fileInfo.Exists)
            {
                return File.ReadAllText(fileInfo.PhysicalPath);
            }

            return string.Empty;
        }

        private static IEnumerable<string> GetScriptParts(Stream script)
        {
            const string reBatchSeparator = @"^(/\*.\*/)?\s*GO\s*(/\*.*\*/)?\s*(--.*)?$";
            Regex batchSeparator = new Regex(reBatchSeparator);
            using (StreamReader sr = new StreamReader(script))
            {
                StringBuilder sb = new StringBuilder();
                while (!sr.EndOfStream)
                {
                    string line = sr.ReadLine();
                    if (!batchSeparator.IsMatch(line))
                    {
                        sb.AppendLine(line);
                    }
                    else
                    {
                        string srpart = sb.ToString();
                        if (!string.IsNullOrEmpty(srpart))
                        {
                            yield return srpart;
                        }
                        sb.Clear();
                    }
                }

                string part = sb.ToString();
                if (!string.IsNullOrEmpty(part))
                {
                    yield return part;
                }
            }
        }

        private static void Init_Report_Filter(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                ExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_REPORT_FILTER, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitENLanguage(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                string sql = @"IF NOT EXISTS (
						SELECT *
						FROM 
							dbo.Languages
						WHERE
							Code LIKE '%EN%'
					)
					BEGIN
						INSERT INTO dbo.Languages(Active, Code, CreatedDate, Deleted, Label, UpdatedDate, Id)
						VALUES (1, 'EN', GETDATE(), 0, 'English', GETDATE(), NEWID())
					END";

                ExecuteSQL(sql, serviceProvider);
            }
            catch (Exception) { }
        }
        // Ticketing

        private static void InitTicketingDeclarationType(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_DECLARATION_TYPE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTicketingModule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.TICKETINGMODULE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTicketingDeviceModule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.TICKETING_DEVICE_MODULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void InitTicketingTopCurrency(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_TOP_CURRENCY, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTicketingTenderType(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_TENDER_TYPE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTicketingValidationRule(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_VALIDATION_RULE, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void InitTicketingTicketProperties(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_TICKET_PROPERTIES, environment), serviceProvider);
            }
            catch (Exception e) { }
        }
        private static void InitTicketingPriceLevel(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_PRICE_LEVEL, environment), serviceProvider);
            }
            catch (Exception e) { }
        }

        private static void Init_TicketingSetting(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_SETTING, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketingData(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_DATA, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketingReport_Module(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_REPORT_MODULE, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketingOrderNo(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.INIT_TICKETING_ORDERNO, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketingStoredProcedures(IHostEnvironment environment, string connectionString, IServiceProvider serviceProvider, string filePath)
        {
            var fileInfo = environment.ContentRootFileProvider.GetFileInfo(filePath);

            if (fileInfo.Exists)
            {
                using (var stream = File.OpenRead(fileInfo.PhysicalPath))
                {
                    using (System.Data.IDbConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        foreach (string part in GetScriptParts(stream))
                        {
                            using (var cmd = conn.CreateCommand())
                            {
                                try
                                {
                                    cmd.CommandText = part;
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception e) { }
                            }
                        }
                        conn.Close();
                    }
                }
            }
        }

        private static void Init_CustomerStoredProcedures(IHostEnvironment environment, string connectionString, IServiceProvider serviceProvider, string filePath)
        {
            var fileInfo = environment.ContentRootFileProvider.GetFileInfo(filePath);

            if (fileInfo.Exists)
            {
                using (var stream = File.OpenRead(fileInfo.PhysicalPath))
                {
                    using (System.Data.IDbConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        foreach (string part in GetScriptParts(stream))
                        {
                            using (var cmd = conn.CreateCommand())
                            {
                                try
                                {
                                    cmd.CommandText = part;
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception e) { }
                            }
                        }
                        conn.Close();
                    }
                }
            }
        }

        private static void Init_TicketingDbSyncSetting(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                TicketingExecuteSQL(ReadFile(INIT_SQL_PATH.DB_TICKETING_SYNC_SETTING, environment), serviceProvider);
            }
            catch (Exception) { }
        }

        private static void Init_TicketingPrintTemplates(IHostEnvironment environment, IServiceProvider serviceProvider)
        {
            try
            {
                string sql = ReadFile(INIT_SQL_PATH.INIT_TICKETING_PRINT_TEMPLATE, environment);
                TicketingExecuteSQL(sql, serviceProvider);
            }
            catch (Exception ex)
            {
            }
        }
    }
}
