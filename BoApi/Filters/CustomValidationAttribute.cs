using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BoApi.Filters
{
    public class FullFillInformationAttribute : ValidationAttribute
    {
        private readonly List<string> _fields;
        public FullFillInformationAttribute(List<string> fields)
        {
            _fields = fields;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if ((FullPropertiesFill(validationContext) || FullPropertiesEmpty(validationContext)))
            {
                return ValidationResult.Success;
            }
            return new ValidationResult(ErrorMessage);
        }

        private bool FullPropertiesEmpty(ValidationContext validationContext)
        {
            foreach (var field in _fields)
            {
                var property = validationContext.ObjectType.GetProperty(field);
                var data = property.GetValue(validationContext.ObjectInstance).ToString();
                if (!string.IsNullOrEmpty(data))
                {
                    return false;
                }
            }
            return true;
        }

        private bool FullPropertiesFill(ValidationContext validationContext)
        {
            foreach (var field in _fields)
            {
                var property = validationContext.ObjectType.GetProperty(field);
                var data = property.GetValue(validationContext.ObjectInstance).ToString();
                if (string.IsNullOrEmpty(data))
                {
                    return false;
                }
            }
            return true;
        }
    }
}