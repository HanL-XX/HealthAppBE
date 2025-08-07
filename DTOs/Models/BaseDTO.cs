using Entities;
using Infrastructure;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DTOs.Models
{
    public class BaseDTO
    {
        public string CreatedName { get; set; }
        public DateTime CreatedDate { get; set; }
        public string UpdatedName { get; set; }
        public DateTime UpdatedDate { get; set; }

        public BaseDTO() { }

        public BaseDTO(IAuditableEntity auditableEntity)
        {
            if (auditableEntity != null)
            {
                CreatedDate = auditableEntity.CreatedDate;
                UpdatedDate = auditableEntity.UpdatedDate;
            }
        }
    }

    public class AES_DTO
    {
        public string Encrypted { get; set; }
        public byte[] IV { get; set; }
        public byte[] Key { get; set; }

        public AES_DTO() { }
    }

    public class AssignmentRequest<T>
    {
        [Required]
        public List<T> ListAssignId { get; set; }
        [Required]
        public List<T> ListUnAssignId { get; set; }

        public AssignmentRequest()
        {
            ListAssignId = new List<T>();
            ListUnAssignId = new List<T>();
        }
    }

    public class ModifyListEntitiesRequest<TN, TU, TD>
    {
        public List<TN> NewList { get; set; }
        public List<TU> UpdateList { get; set; }
        public List<TD> DeleteList { get; set; }

        public ModifyListEntitiesRequest()
        {
            NewList = new List<TN>();
            UpdateList = new List<TU>();
            DeleteList = new List<TD>();
        }
    }
}
