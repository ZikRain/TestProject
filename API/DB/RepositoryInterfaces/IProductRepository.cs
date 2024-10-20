using API.Entities;

namespace API.DB.RepositoryInterfaces
{
    public interface IProductRepository
    {
        Task<IEnumerable<Product>> GetByName(string? productName);
        Task<Product> Add(string name, string? description);
        Task<Product> Add(Product product);

        Task<bool> ChekAvailabilityName(Product product);
        Task<bool> ChekAvailabilityName(Guid? ID, string name);

        Task<Product> Update(Guid ID, string name, string? description);
        Task<Product> Update(Product product);

        Task<bool> Delete(Guid ID);
        Task<bool> Delete(Product product);
    }
}
