using API.Controllers;
using API.DB.RepositoryInterfaces;
using API.Entities;
using API.Services.ServiceInterfaces;
using API.Validators;

namespace API.Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;

        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository ?? throw new ArgumentNullException(nameof(productRepository));
        }

        public async Task<IEnumerable<Product>> GetProductByNameAsync(string? name)
        {
            return await _productRepository.GetByName(name);
        }

        public async Task<Product> AddAsync(string name, string? description)
        {
            if (!ProductValidator.IsValid(name, description)) throw new ArgumentException("Arguments is not valid");
            if(!await _productRepository.ChekAvailabilityName(null, name)) throw new ArgumentException("Arguments is not availability");

            return await _productRepository.Add(name, description);
        }

        public async Task<Product> UpdateAsync(Guid guid, string name, string? description)
        {
            if (!ProductValidator.IsValid(name, description)) throw new ArgumentException("Arguments is not valid");
            if (!await _productRepository.ChekAvailabilityName(guid, name)) throw new ArgumentException("Arguments is not availability");

            return await _productRepository.Update(guid, name, description);
        }

        public async Task<bool> DeleteAsyc(Guid guid)
        {
            if (await _productRepository.Delete(guid))
            {
                return true;
            }
            else
            {
                throw new ArgumentException("Arguments is not availability");
            }
        }
    }
}
