using API.DB.Contexts;
using API.DB.RepositoryInterfaces;
using API.Entities;
using Microsoft.EntityFrameworkCore;


namespace API.DB.Repositories
{
    public class ProductRepository : IProductRepository
    {
        private readonly TestDbContext _testDbContext;

        public ProductRepository(TestDbContext testDbContext)
        {
                _testDbContext = testDbContext ?? throw new ArgumentNullException(nameof(testDbContext));
        }

        public async Task<IEnumerable<Product>> GetByName(string? productName)
        {
                return await _testDbContext.Products
                    .Where(x => string.IsNullOrWhiteSpace(productName) || x.Name.Contains(productName))
                    .ToListAsync();
        }

        public async Task<Product> Add(string name, string? description)
        {
            var product = new Product(name, description);

            return await Add(product);
        }

        public async Task<Product> Add(Product product)
        {
            product.ID = Guid.NewGuid();

            _testDbContext.Products.Add(product);
            await _testDbContext.SaveChangesAsync();
            return product;
        }

        public async Task<bool> ChekAvailabilityName(Product product)
        {
            return await ChekAvailabilityName(product.ID, product.Name);
        }

        public async Task<bool> ChekAvailabilityName(Guid? ID, string name)
        {
            var product = ID == null ?  await _testDbContext.Products.FirstOrDefaultAsync(x => x.Name == name)
                : await _testDbContext.Products.FirstOrDefaultAsync(x => x.ID != ID && x.Name == name);
            return product == null;
        }


        public async Task<Product> Update(string name, string? description)
        {
            var product = new Product(name, description);

            return await Add(product);
        }


        public async Task<Product> Update(Guid ID,string name,string? description)
        {
            var product = new Product(ID,name,description);
            return await Update(product);
        }

        public async Task<Product> Update(Product product)
        {
            var productInDb = await _testDbContext.Products.FirstOrDefaultAsync(x=>product.ID == x.ID);

            if (productInDb == null) return product;

            productInDb.Name = product.Name;
            productInDb.Description = product.Description;

            await _testDbContext.SaveChangesAsync();

            return productInDb;
        }

        public async Task<bool> Delete(Guid ID)
        {
            var product = _testDbContext.Products.FirstOrDefault(x=>x.ID == ID);
            
            return await Delete(product);
        }

        public async Task<bool> Delete(Product product)
        {
            if(product == null) return false;

            var productInDb = await _testDbContext.Products.FirstOrDefaultAsync(x => product.ID == x.ID);

            if (productInDb == null) return false;

            _testDbContext.Products.Remove(productInDb);

            await _testDbContext.SaveChangesAsync();

            return true;
        }


    }
}
