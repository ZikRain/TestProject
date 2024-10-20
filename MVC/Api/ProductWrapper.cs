using Microsoft.AspNetCore.Hosting.Server;
using MVC.Entities;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace MVC.Api
{
    public class ProductWrapper : BaseWrapper
    {
        private static readonly string _controller = "product";

        public static async Task<IEnumerable<Product>> GetProductsByName(string? name = null)
        {
            using (HttpClient client = new HttpClient())
            {

                HttpResponseMessage response = await client.GetAsync($"{_server}{_controller}/getByName?filterName={name}");

                if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
                {
                    string resp = await response.Content.ReadAsStringAsync();
                    string[] subs = resp.Split('=', '}');
                    throw new Exception(subs[1]);
                }

                if (response.StatusCode != System.Net.HttpStatusCode.OK) throw new Exception(await response.Content.ReadAsStringAsync());

                response.EnsureSuccessStatusCode();

                return JsonConvert.DeserializeObject<IEnumerable<Product>>(await response.Content.ReadAsStringAsync());
            }
        }

        public static async Task<Product> AddProduct(Product product)
        {
            return await AddProduct(product.Name, product.Description);
        }
        public static async Task<Product> AddProduct(string name, string? description)
        {
            using (HttpClient client = new HttpClient())
            {
                var formContent = new FormUrlEncodedContent(
                [
                    new KeyValuePair<string, string>("name",name),
                    new KeyValuePair<string, string>("description",description ?? string.Empty)
                ]);

                HttpResponseMessage response = await client.PostAsync($"{_server}{_controller}/add", formContent);


                if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
                {
                    string resp = await response.Content.ReadAsStringAsync();
                    string[] subs = resp.Split('=', '}');
                    throw new Exception(subs[1]);
                }

                if (response.StatusCode != System.Net.HttpStatusCode.OK) throw new Exception(await response.Content.ReadAsStringAsync());

                response.EnsureSuccessStatusCode();

                return JsonConvert.DeserializeObject<Product>(await response.Content.ReadAsStringAsync());
            }
        }

        public static async Task<Product> UpdateProduct(Product product)
        {
            return await UpdateProduct(product.ID, product.Name, product.Description);
        }
        public static async Task<Product> UpdateProduct(Guid guid, string name, string? description)
        {
            using (HttpClient client = new HttpClient())
            {
                var formContent = new FormUrlEncodedContent(
                [
                    new KeyValuePair<string, string>("guid",guid.ToString()),
                    new KeyValuePair<string, string>("name",name),
                    new KeyValuePair<string, string>("description",description ?? string.Empty)
                ]);

                HttpResponseMessage response = await client.PostAsync($"{_server}{_controller}/update", formContent);

                if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
                {
                    string resp = await response.Content.ReadAsStringAsync();
                    string[] subs = resp.Split('=', '}');
                    throw new Exception(subs[1]);
                }

                if (response.StatusCode != System.Net.HttpStatusCode.OK) throw new Exception(await response.Content.ReadAsStringAsync());

                response.EnsureSuccessStatusCode();

                return JsonConvert.DeserializeObject<Product>(await response.Content.ReadAsStringAsync());
            }
        }

        public static async Task<bool> DeleteProduct(Product product)
        {
            return await DeleteProduct(product.ID);
        }
        public static async Task<bool> DeleteProduct(Guid guid)
        {
            using (HttpClient client = new HttpClient())
            {
                var formContent = new FormUrlEncodedContent(
                [
                    new KeyValuePair<string, string>("guid",guid.ToString())
                ]);

                HttpResponseMessage response = await client.PostAsync($"{_server}{_controller}/delete", formContent);

                if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
                {
                    string resp = await response.Content.ReadAsStringAsync();
                    string[] subs = resp.Split('=', '}');
                    throw new Exception(subs[1]);
                }

                if (response.StatusCode != System.Net.HttpStatusCode.OK) throw new Exception(await response.Content.ReadAsStringAsync());

                response.EnsureSuccessStatusCode();

                return JsonConvert.DeserializeObject<bool>(await response.Content.ReadAsStringAsync());
            }
        }

    }
}
