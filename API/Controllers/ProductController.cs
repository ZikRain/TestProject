using API.Entities;
using API.Services.ServiceInterfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [ApiController]
    [Route("product")]
    public class ProductController : Controller
    {
        private readonly ILogger<ProductController> _logger;
        private readonly IProductService _productService;


        public ProductController(ILogger<ProductController> logger, IProductService productService)
        {
            try
            {
                _logger = logger ?? throw new ArgumentNullException(nameof(logger));
                _productService = productService ?? throw new ArgumentNullException(nameof(productService));

                _logger.LogInformation($"Controller Initialize: ProductController");
            
            }
            catch(Exception ex)
            {
                if (_logger == null)
                    throw;
                else
                    _logger.LogInformation($"Controller ERROR: ProductController Message:{ex.Message}");
            }
        }

        [HttpGet]
        [Route("getByName")]
        public async Task<IActionResult> GetByName(string? filterName)
        {
            try
            {
                _logger.LogInformation($"Start: ProductController.GetByName Parameters:[{filterName}]");

                return Ok(await _productService.GetProductByNameAsync(filterName));
            }
            catch (Exception ex)
            {
                _logger.LogError($"ERROR: ProductController.GetByName Message:[{ex.Message}]");
             
                return BadRequest(ex.Message);
            }
            finally
            {
                _logger.LogInformation($"End: ProductController.GetByName");
            }
        }

        [HttpPost]
        [Route("add")]
        public async Task<IActionResult> Add([FromForm] string name, [FromForm] string? description)
        {
            try
            {
                _logger.LogInformation($"Start: ProductController.Add Parameters:[name:{name}; description:{description}]");

                return Ok(await _productService.AddAsync(name,description));
            }
            catch (Exception ex)
            {
                _logger.LogError($"ERROR: ProductController.Add Message:[{ex.Message}]");

                return BadRequest(ex.Message);
            }
            finally
            {
                _logger.LogInformation($"End: ProductController.Add");
            }
        }

        [HttpPost]
        [Route("update")]
        public async Task<IActionResult> Update([FromForm] Guid guid, [FromForm] string name, [FromForm] string? description)
        {
            try
            {
                _logger.LogInformation($"Start: ProductController.Update Parameters:[guid:{guid}; name:{name}; description:{description}]");

                return Ok(await _productService.UpdateAsync(guid, name, description));
            }
            catch (Exception ex)
            {
                _logger.LogError($"ERROR: ProductController.Update Message:[{ex.Message}]");

                return BadRequest(ex.Message);
            }
            finally
            {
                _logger.LogInformation($"End: ProductController.Update");
            }
        }

        [HttpPost]
        [Route("delete")]
        public async Task<IActionResult> Delete([FromForm] Guid guid)
        {
            try
            {
                _logger.LogInformation($"Start: ProductController.Delete Parameters:[guid:{guid}]");

                await _productService.DeleteAsyc(guid);
                
                return Ok();
            }
            catch (Exception ex)
            {
                _logger.LogError($"ERROR: ProductController.Delete Message:[{ex.Message}]");

                return BadRequest(ex.Message);
            }
            finally
            {
                _logger.LogInformation($"End: ProductController.Delete");
            }
        }
    }
}
