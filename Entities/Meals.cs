using Common.Constant;
using Infrastructure;
using System;

namespace Entities
{
    public class Meal : AuditableEntity<Guid>
    {
        public string Title { get; set; }
        public MealType MealType { get; set; }
        public string PhotoPath { get; set; }
        public DateTime MealDate { get; set; }
        public bool IsCompleted { get; set; }

        public Guid AccountId { get; set; }
        public virtual Account Account { get; set; }
    }
}
