namespace MVC.Entities
{
    public class Product
    {
        public Guid ID { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public Product() { }

        public Product(Guid id, string name, string? description)
        {
            ID = id;
            Name = name;
            Description = description;
        }

        public Product(string name, string? description)
        {
            Name = name;
            Description = description;
        }
    }
}
