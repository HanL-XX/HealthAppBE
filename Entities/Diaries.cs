using Infrastructure;
using System;

namespace Entities
{
    public class Diary : AuditableEntity<Guid>
    {
        public DateTime DiaryDate { get; set; }
        public string Content { get; set; }

        public Guid AccountId { get; set; }
        public virtual Account Account { get; set; }
    }
}
