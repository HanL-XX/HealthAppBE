using Common.Constant;
using Common.ErrorLocalization;
using Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DTOs.Models
{
    public class RoleModel
    {
        /// <summary>
        /// Role's Id
        /// </summary>
        public string Id { get; set; }
        /// <summary>
        /// Role's Name
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// Role is active or deactive
        /// </summary>
        public bool IsActive { get; set; }
        /// <summary>
        /// Role's level
        /// </summary>
        public int Level { get; set; }
        /// <summary>
        /// List modules of roles
        /// </summary>
        public List<RoleModule> Modules { get; set; }
        public List<AccountModel> Accounts { get; set; }
        public RoleModel() { }

        public RoleModel(RoleDb role)
        {
            if (role != null)
            {
                Id = role.Id;
                Name = role.Name;
                IsActive = role.IsActive;
                Level = role.Level;
            }
        }
    }

    public class CreateRoleModel
    {
        /// <summary>
        /// Role's Name
        /// </summary>
        [Required(ErrorMessageResourceName = "RoleNameRequired", ErrorMessageResourceType = typeof(ErrorResource))]
        public string Name { get; set; }
        /// <summary>
        /// Role level
        /// </summary>
        [Range(1, int.MaxValue)]
        public int? Level { get; set; }
    }

    public class UpdateRoleModel
    {
        /// <summary>
        /// Role's Name
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// Active or deactive role
        /// </summary>
        public bool IsActive { get; set; }
        /// <summary>
        /// Role level
        /// </summary>
        [Range(1, int.MaxValue)]
        public int Level { get; set; }
        /// <summary>
        /// List modules Id of roles
        /// </summary>
        public List<string> Modules { get; set; }
    }

    public class ModulePermissionModel
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public int ModuleId { get; set; }
        public int? ParentModuleId { get; set; }
        public bool IsActive { get; set; }

        public ModulePermissionModel() { }

        public ModulePermissionModel(string name, string description, int moduleId, int? parentModuleId, bool active)
        {
            Name = name;
            Description = description;
            ModuleId = moduleId;
            ParentModuleId = parentModuleId;
            IsActive = active;
        }
    }

    public class RoleModule : ModulePermissionModel
    {
        public AccessLevel AccessLevel { get; set; }

        public RoleModule() { }

        public RoleModule(string name, string description, AccessLevel accessLevel, int moduleId, int? parentModuleId, bool active) : base(name, description, moduleId, parentModuleId, active)
        {
            AccessLevel = accessLevel;
        }
    }

    public class ListRoleModule
    {
        public List<RoleModule> Modules { get; set; }
    }

    public class AddRoleModule
    {
        public IEnumerable<RoleModule> ListModuleAdd { get; set; }
        public IEnumerable<int> ListModuleRemove { get; set; }
    }

    public class RoleModelLookup
    {
        /// <summary>
        /// Role's Id
        /// </summary>
        public string Id { get; set; }
        /// <summary>
        /// Role's Name
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// Role is active or deactive
        /// </summary>
        public bool IsActive { get; set; }
        /// <summary>
        /// Role's level
        /// </summary>
        public int Level { get; set; }

        public RoleModelLookup() { }

        public RoleModelLookup(RoleDb role)
        {
            if (role != null)
            {
                Id = role.Id;
                Name = role.Name;
                IsActive = role.IsActive;
                Level = role.Level;
            }
        }
    }
}
