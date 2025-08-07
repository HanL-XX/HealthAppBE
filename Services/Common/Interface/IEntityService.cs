using Entities;
using Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Services.Common
{
    public interface IEntityService<T> where T : BaseEntity
    {
        T Create(T entity);
        IEnumerable<T> GetAll();
        IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate);
        IQueryable<T> FindByWithQueryable(Expression<Func<T, bool>> predicate);
        void Update(T entity);
        T FirstOrDefault(Expression<Func<T, bool>> predicate);
        bool Any(Expression<Func<T, bool>> predicate);
        Task SaveAsync();

    }
}