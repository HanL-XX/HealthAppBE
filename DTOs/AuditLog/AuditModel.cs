//using Entities;
//using System;
//using System.Collections.Generic;
//using System.Text;

//namespace DTOs.AuditLog
//{
//    public  class AuditModel
//    {
//        public int Id { get; set; }
//        public string UserId { get; set; }
//        public string Type { get; set; }
//        public string TableName { get; set; }
//        public DateTime DateTime { get; set; }
//        public string OldValues { get; set; }
//        public string NewValues { get; set; }
//        public string AffectedColumns { get; set; }
//        public string PrimaryKey { get; set; }
//        public string UserName { get; set; }
//        public string FullName { get; set; }

//        public AuditModel(Audit audit)
//        {
//            Id = audit.Id;
//            UserId = audit.UserId;
//            Type = audit.Type;
//            TableName = audit.TableName;
//            DateTime = audit.DateTime;
//            OldValues = audit.OldValues;
//            NewValues = audit.NewValues;
//            AffectedColumns = audit.AffectedColumns;
//            PrimaryKey = audit.PrimaryKey;
//        }
//    }
//}
