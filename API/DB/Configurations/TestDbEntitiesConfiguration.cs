using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.DB.Configurations
{
    public class TestDbEntitiesConfiguration : IEntityTypeConfiguration<Product>
    {
        public void Configure(EntityTypeBuilder<Product> builder)
        {
            builder.ToTable("Product", "dbo");
            builder.HasKey(x => x.ID);
            builder.ToTable(tb => tb.HasTrigger("i_tr_Product "));
            builder.ToTable(tb => tb.HasTrigger("d_tr_Product  "));
            builder.ToTable(tb => tb.HasTrigger("u_tr_Product  "));
        }
    }
}
