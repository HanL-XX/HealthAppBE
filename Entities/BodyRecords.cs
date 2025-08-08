using Infrastructure;
using System;

namespace Entities
{
    public class BodyRecord : AuditableEntity<Guid>
    {
        public float Weight { get; set; }
        public float BodyFatPercentage { get; set; }
        public DateTime RecordDate { get; set; }

        public Guid AccountId { get; set; }
        public virtual Account Account { get; set; }
    }
}
