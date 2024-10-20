using API.Entities;

namespace API.Services.ServiceInterfaces
{
    public interface IProductService
    {
        Task<IEnumerable<Product>> GetProductByNameAsync(string? name);
        Task<Product> AddAsync(string name, string? description);

        Task<Product> UpdateAsync(Guid guid, string name, string? description);
        Task<bool> DeleteAsyc(Guid guid);
    }
}
