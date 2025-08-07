using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Common.Constant;
using Common.ErrorLocalization;
using Entities;
using Infrastructure;

namespace DTOs.Models
{
    public class PaginationModel<T>
    {
        /// <summary>
        /// List data 
        /// </summary>
        public List<T> Data { get; set; }
        public int Page { get; set; }
        public int Amount { get; set; }
        /// <summary>
        /// Total page
        /// </summary>
        public int TotalPage { get; set; }
        public string Sort { get; set; }
        public string SearchText { get; set; }
        /// <summary>
        /// Total amount 
        /// </summary>
        public long TotalCount { get; set; }

        public PaginationModel()
        {
            Data = new List<T>();
        }

        public PaginationModel(PaginationRequest request, IQueryable<BaseEntity> list)
        {
            Data = new List<T>();
            Amount = request.Amount == 0 ? 1 : request.Amount;
            Sort = request.Sort;
            Page = request.Page;
            SearchText = request.SearchText;
            TotalCount = list.Count();
            TotalPage = (int)Math.Ceiling((decimal)TotalCount / Amount);
        }

        public PaginationModel(PaginationRequest request)
        {
            Data = new List<T>();
            Amount = request.Amount == 0 ? 1 : request.Amount;
            Sort = request.Sort;
            Page = request.Page;
            SearchText = request.SearchText;
        }

        public PaginationModel(PaginationRequest request, int count)
        {
            Data = new List<T>();
            Amount = request.Amount == 0 ? 1 : request.Amount;
            Sort = request.Sort;
            Page = request.Page;
            TotalCount = count;
            TotalPage = (int)Math.Ceiling((decimal)TotalCount / request.Amount);
            SearchText = request.SearchText;
        }

        public PaginationModel(PaginationRequest request, IEnumerable<T> list)
        {
            Data = new List<T>();
            Amount = request.Amount == 0 ? 1 : request.Amount;
            Sort = request.Sort;
            Page = request.Page;
            SearchText = request.SearchText;
            TotalCount = list.Count();
            TotalPage = (int)Math.Ceiling((decimal)TotalCount / Amount);
        }
    }

}
