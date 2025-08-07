using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Infrastructure
{
    public interface IBaseEntity
    {
        bool Deleted { get; set; }
        bool Active { get; set; }
    }

    public interface IEntity<T>
    {
        T Id { get; set; }
    }
}
