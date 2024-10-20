using MVC.Entities;

namespace MVC.Models
{
    public class IndexModel
    {
        public IEnumerable<Product> Products { get; set; }

        public string? SearchText { get; set; }
    }
}
