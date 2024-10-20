using Microsoft.AspNetCore.Mvc;
using MVC.Api;
using MVC.Models;
using System.Diagnostics;

namespace MVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public async Task<IActionResult> Index(string? searchText)
        {

            var model = new IndexModel() { SearchText = searchText};

            model.Products = await ProductWrapper.GetProductsByName(searchText);

            return View(model);
        }


        public async Task<IActionResult> SearchProducts(string? searchText)
        {
            try
            {
                var result = await ProductWrapper.GetProductsByName(searchText);
                return Json(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        public async Task<IActionResult> AddProduct(string name, string? description)
        {
            try
            {
                var result = await ProductWrapper.AddProduct(name,description);
                return Json(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        public async Task<IActionResult> UpdateProduct(Guid guid,string name, string? description)
        {
            try
            {
                var result = await ProductWrapper.UpdateProduct(guid, name, description);
                return Json(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }
    }
}
