using Infrastructure;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Common.Implement
{
    public class GenericRepositoryWithDbContext<TEntity> : IGenericRepository<TEntity> where TEntity : BaseEntity
    {
        protected DbContext _entities;
        protected readonly DbSet<TEntity> _dbset;

        protected GenericRepositoryWithDbContext(DbContext context)
        {
            _entities = context;
            _dbset = context.Set<TEntity>();
        }
        public DbContext GetDataBase()
        {
            return _entities;

        }
        public virtual IEnumerable<TEntity> GetAll()
        {
            return _dbset.AsEnumerable<TEntity>().Where(x => !x.Deleted);
        }

        public virtual void AddRange(IEnumerable<TEntity> entities)
        {
            _dbset.AddRange(entities);
        }

        public IEnumerable<TEntity> FindBy(Expression<Func<TEntity, bool>> predicate)
        {

            return _dbset.Where(predicate).AsEnumerable();
        }

        public virtual TEntity Add(TEntity entity)
        {
            return _dbset.Add(entity).Entity;
        }

        public virtual void AddRange(List<TEntity> entities)
        {
            _dbset.AddRange(entities);
        }

        public virtual TEntity Delete(TEntity entity)
        {
            return _dbset.Remove(entity).Entity;
        }

        public virtual void RemoveRange(List<TEntity> entities)
        {
            _dbset.RemoveRange(entities);
        }

        public virtual void Edit(TEntity entity)
        {
            _entities.Entry(entity).State = EntityState.Modified;
        }

        public virtual int Save()
        {
            return _entities.SaveChanges();
        }

        public virtual Task<int> SaveAsync()
        {
            return _entities.SaveChangesAsync();
        }

        public TEntity FirstOrDefault(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.FirstOrDefault(predicate);
        }

        public bool Any(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.Any(predicate);
        }

        public bool All(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.All(predicate);
        }

        public IQueryable<TEntity> FindByWithQueryable(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.Where(predicate);
        }

        public TEntity First(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.First(predicate);
        }

        public int Count(Expression<Func<TEntity, bool>> predicate)
        {
            return _dbset.Count(predicate);
        }

        public int Count()
        {
            return _dbset.Count();
        }
    }
}
