using API.Entities;

namespace API.Validators
{
    public static class ProductValidator
    {
        public static bool IsValid(string name, string? description)
        {
            return !string.IsNullOrWhiteSpace(name);
        }

        public static bool IsValid(Product product)
        {
            return IsValid(product.Name,product.Description);
        }
    }
}
