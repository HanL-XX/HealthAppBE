using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Infrastructure
{
    public abstract class AuditableEntity<T> : BaseEntity, IEntity<T>, IAuditableEntity
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public virtual T Id { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        [NotMapped]
        public string CreatedName { get; set; }
        [NotMapped]
        public string UpdatedName { get; set; }
        [NotMapped]
        public string CreatedEmail { get; set; }
    }
}
