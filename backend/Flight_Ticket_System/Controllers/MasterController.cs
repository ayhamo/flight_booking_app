using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;


namespace Flight_Ticket_System.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MasterController : ControllerBase
    {
        IMaster _db;

        public MasterController(IMaster db)
        {

            _db = db;
        }


        [Route("login")]
        public async Task<IActionResult> Login(string email, string password)
        {

            Master master = _db.FindMasterForLogin(email, password);
            if (master == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found." }};
                return Ok(error);
            }

            var claims = new List<Claim>
            {
                new Claim("AccountType", "Master"),
                new Claim(ClaimTypes.Email, master.Email),
                new Claim(ClaimTypes.Name, master.Name)
            };

            var userIdentiy = new ClaimsIdentity(claims, "Master");
            ClaimsPrincipal principal = new ClaimsPrincipal(userIdentiy);

            await HttpContext.SignInAsync(principal);
            return Ok(master);
        }
        [Route("logout")]
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return Ok("Logout");
        }


        /// <summary>
        /// Get All Company Requests
        /// </summary>
        /// <returns></returns>
        [HttpGet("CompanyRequestList")]
        public IActionResult GetCompanyRequestList()
        {
            List<CompanyRequest> companyRequests = _db.GetCompanyRequests();
            return Ok(companyRequests);
        }


        /// <summary>
        /// Approve a Company
        /// </summary>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        [HttpPost("ApproveCompany")]
        public IActionResult ApproveRequest(int CompanyId)
        {
            _db.AcceptCompanyRequest(CompanyId);

            var error = new Dictionary<string, string>(){
                    {  "message", "Company Successfully Approved." }};
            return Ok(error);
            
        }

        /// <summary>
        /// Get All Approved Comapanies
        /// </summary>
        /// <returns></returns>
        [HttpGet("AllCompanies")]
        public IActionResult GetCompanies()
        {
            IQueryable<Company> authorities = _db.GetAllAuthorities;
            return Ok(authorities);
        }

        /// <summary>
        /// Deletes a company via ID 
        /// </summary>
        /// <param name="id"></param>
        [HttpDelete("DeleteCompany")]
        public IActionResult Delete(int id)
        {
            _db.DeleteCompany(id);
            var error = new Dictionary<string, string>(){
                    {  "message", "Company Successfully Deleted." }};
            return Ok(error);
        }


    }
}
