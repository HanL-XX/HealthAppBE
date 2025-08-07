using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DTOs.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace BoApi.Controllers
{
    public class BaseController : ControllerBase
    {
        public DateTime now = DateTime.Now;

        [ApiExplorerSettings(IgnoreApi = true)]
        public void AddErrorsFromResult(IdentityResult result, ref ErrorModel error)
        {
            foreach (var element in result.Errors)
            {
                error.Add(element.Description);
            }
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public void AddErrorsFromModelState(ref ErrorModel error)
        {
            foreach (var modelState in ModelState.Values)
            {
                var errorState = modelState.Errors.FirstOrDefault();

                if (errorState != null)
                {
                    string errorMessage = errorState.ErrorMessage;

                    if (!string.IsNullOrEmpty(errorMessage))
                    {
                        error.Add(errorMessage);
                    }
                    else
                    {
                        error.Add(modelState.Errors.FirstOrDefault()?.Exception.Message);
                    }
                }
            }
        }
    }
}