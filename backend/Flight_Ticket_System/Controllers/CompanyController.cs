using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Flight_Ticket_System.Controllers
{

    ///
    [Route("api/[controller]")]
    [ApiController]
    public class CompanyController : ControllerBase
    {
        ICompany _db;

        public CompanyController(ICompany db)
        {
            _db = db;
        }

        private bool IsAccountTypeCompany()
        {

            if (User.Identity.AuthenticationType != null && User.Identity.AuthenticationType.Equals("Company"))
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Login for Company.
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>

        [HttpPost("login")]
        public async Task<IActionResult> Login(string email, string password)
        {

            Company company = _db.FindCompanyForLogin(email, password);
            if (company == null)
            {

                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found Or Pending approval." }};
                return Ok(error);
            }/*else if (company)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found Or Pending pproval." }};
                return Ok(error);
            }*/

            var claims = new List<Claim>
            {
                new Claim("AccountType", "Company"),
                new Claim(ClaimTypes.Email, company.Email),
                new Claim(ClaimTypes.Name, company.Name)
            };

            var userIdentiy = new ClaimsIdentity(claims, "Company");
            ClaimsPrincipal principal = new ClaimsPrincipal(userIdentiy);

            await HttpContext.SignInAsync(principal);
            return Ok(company);
        }
        /// <summary>
        /// Logout.
        /// </summary>
        /// <returns></returns>
        [HttpGet("logout")]
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return Ok("Logout");
        }
        /// <summary>
        /// Register.
        /// </summary>
        /// <param name="CompanyName"></param>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost("register")]
        public IActionResult Register(string CompanyName, string email, string password)
        {

            if (_db.ChackMailExistInRequests(email) || _db.ChackMailExistInCompanies(email))
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Email Already Taken." }};
                return Ok(error);
            }
            /*
            Company company = new Company();
            company.Name = CompanyName;
            company.Email = email;
            company.Password = password;
            company.Created = DateTime.Now;
               _db.CreateCompany(company);
            */
            CompanyRequest companyRequest = new CompanyRequest
            {
                Name = CompanyName,
                Email = email,
                Password = password,
                Created = DateTime.Now,
            };
            _db.CreateNewCompanyRequest(companyRequest);

            return Ok(companyRequest);
        }

        /*
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        [HttpGet("CompanyRequestList")]
        public IActionResult GetCompanyRequestList()
        {
            List<CompanyRequest> companyRequests = _db.GetCompanyRequests();
            return Ok(companyRequests);
        }

        */

        [HttpGet("Test")]
        public string Test()
        {
            if (IsAccountTypeCompany())
            {
                return ("Loged in");
            }
            return "Not logged in";
        }

        /// <summary>
        /// Gets Company mail than return ID if company exists.
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        [HttpPost("CheckCompanyMailExist")]
        public IActionResult CheckCompanyMailExist(string email)
        {
            Company company = _db.GetCompanyByEmail(email);
            if (company == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found." }};
                return Ok(error);
            }
            var id = new Dictionary<string, int>(){
                    {  "id", company.Id }};
            return Ok(id);
        }

        /// <summary>
        /// Changes Company password via ID and new Password.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost("ChangePassword")]
        public IActionResult ChangeCompanyPassword(int id, string password)
        {

            _db.ChangeCompanyPassword(id, password);
            var ok = new Dictionary<string, string>(){
                    {  "message", "Password Changed Successfully." }};
            return Ok(ok);
          
        }

        /// <summary>
        /// Updates Company.
        /// </summary>
        /// <param name="companyId"></param>
        /// <returns></returns>
        [HttpPost("Update")]
        public IActionResult UpdateCompany(int companyId, string name, string email, string password)
        {
            _db.UpdateCompany(companyId, name, email, password);
            var ok = new Dictionary<string, string>(){
                    {  "message", "User informations Changed Successfully." }};

            return Ok(ok);
        }


        /*
        /// <summary>
        /// asdads
        /// </summary>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        [HttpPost("ApproveCompany")]
        public IActionResult ApproveRequest(int CompanyId)
        {
            _db.AcceptCompanyRequest(CompanyId);
            return Ok();
        }
        */
        /*

        /// <summary>
        /// Deletes a company via ID 
        /// </summary>
        /// <param name="id"></param>
        [HttpDelete("DeleteCompany")]
        public void Delete(int id)
        {
            _db.DeleteCompany(id);
        }

        */





        /*
        /// <summary>
        /// Returns All Companies
        /// </summary>
        /// <returns></returns>
        [HttpGet("AllCompanies")]
        public IActionResult GetCompanies()
        {
            IQueryable<Company> authorities = _db.GetAllAuthorities;
            return Ok(authorities);
        }
        */
    }
}
