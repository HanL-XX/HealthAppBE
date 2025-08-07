using Infrastructure;
using Microsoft.AspNetCore.Http;
using Repositories;
using Repositories.Common;
using Services.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Services.Common
{
    public abstract class EntityService<T> : IEntityService<T> where T : BaseEntity
    {
        public IUnitOfWork _unitOfWork;
        public IGenericRepository<T> _repository;
        public IHttpContextAccessor _httpContextAccessor;
        protected EntityService(IUnitOfWork unitOfWork, IGenericRepository<T> repository)
        {
            _unitOfWork = unitOfWork;
            _repository = repository;
        }
        protected EntityService(IUnitOfWork unitOfWork, IGenericRepository<T> repository, IHttpContextAccessor httpContextAccessor)
        {
            _unitOfWork = unitOfWork;
            _repository = repository;
            _httpContextAccessor = httpContextAccessor;
        }
        public T Create(T entity)
        {
            var x = _repository.Add(entity);
            _unitOfWork.Commit();
            return x;
        }

        public IEnumerable<T> GetAll()
        {
            return _repository.GetAll();
        }

        public IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate)
        {
            return _repository.FindBy(predicate);
        }

        public void Update(T entity)
        {
            _repository.Edit(entity);
            _unitOfWork.Commit();
        }

        public T FirstOrDefault(Expression<Func<T, bool>> predicate)
        {
            return _repository.FirstOrDefault(predicate);
        }

        public bool Any(Expression<Func<T, bool>> predicate)
        {
            return _repository.Any(predicate);
        }

        public IQueryable<T> FindByWithQueryable(Expression<Func<T, bool>> predicate)
        {
            return _repository.FindByWithQueryable(predicate);
        }
        public async Task SaveAsync()
        {
            await _repository.SaveAsync();
        }

    }
}
