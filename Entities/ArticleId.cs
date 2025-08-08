using Common.Constant;
using Infrastructure;
using System;

namespace Entities
{
    public class Article : AuditableEntity<Guid>
    {
        public string Title { get; set; }
        public ArticleCategory Category { get; set; }
        public string ThumbnailImagePath { get; set; }
        public DateTime PublishedDate { get; set; }
        public string Content { get; set; }

        public Guid AccountId { get; set; }
        public virtual Account Account { get; set; }
    }
}
