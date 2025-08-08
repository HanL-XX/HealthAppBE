using Infrastructure;
using System;

namespace Entities
{
    public class Exercise : AuditableEntity<Guid>
    {
        public int DurationMinutes { get; set; }
        public int? CaloriesBurned { get; set; }
        public DateTime ExerciseDate { get; set; }
        public string Activity { get; set; }

        public Guid AccountId { get; set; }
        public virtual Account Account { get; set; }
    }
}
