using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DTOs.Models
{
    public class ErrorModel
    {
        public List<string> Errors { set; get; } = new List<string>();
        public bool IsEmpty
        {
            get
            {
                return !Errors.Any();
            }
        }

        public void Add(string error)
        {
            Errors.Add(error);
        }

        public void Replace(string replacedError, string replacingError)
        {
            var index = Errors.FindIndex(error => error == replacedError);
            if (index != -1)
            {
                Errors[index] = replacingError;
            }
        }

        public void DistinctErrorMsgs()
        {
            Errors = Errors.Distinct().ToList();
        }
    }




}
