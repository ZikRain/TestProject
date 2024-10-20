using API.DB.Configurations;
using API.Entities;
using Microsoft.EntityFrameworkCore;

namespace API.DB.Contexts
{
    public class TestDbContext : DbContext
    {

        public DbSet<Product> Products { get; set; } = null!;
        public TestDbContext(DbContextOptions<TestDbContext> options)
             : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new TestDbEntitiesConfiguration());
        }
    }
}
