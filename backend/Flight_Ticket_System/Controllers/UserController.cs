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
    public class UserController : ControllerBase
    {
        private readonly IUser db;

        public UserController(IUser _db)
        {
            db = _db;
        }



        private bool IsAccountTypeUser()
        {

            if (User.Identity.AuthenticationType != null && User.Identity.AuthenticationType.Equals("User"))
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// Find and Return Single User via Id.
        /// </summary>
        /// <returns>User</returns>

        [HttpGet("{id}")]
        public ActionResult<User> GetUserById(int id)
        {
            User user = db.GetUserWithId(id);
            return Ok(user);
        }
        /// <summary>
        /// Returns All Users. 
        /// </summary>
        /// <returns></returns>

        [HttpGet("AllUsers")]
        public IActionResult GetUsers()
        {

            if (IsAccountTypeUser())
            {
                IQueryable<User> users = db.GetAllUser;
                return Ok(users);
            }
            else { return BadRequest(); }
        }


        /// <summary>
        /// Updates User.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost("Update")]
        public IActionResult UpdateUser(int userId, string name, string lastName, string password, string email)
        {
            db.UpdateUser(userId, name, lastName, password, email);
            var ok = new Dictionary<string, string>(){
                    {  "message", "User informations Changed Successfully." }};

            return Ok(ok);
        }
        /// <summary>
        /// Creates new user.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="lastname"></param>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost("Register")]
        public IActionResult Register(string name, string lastname, string email, string password)
        {
            if (db.ChackMailExist(email))
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Email Already Taken." }};
                return Ok(error);
            }

            User user = new User();
            user.Name = name;
            user.LastName = lastname;
            user.Email = email;
            user.Password = password;
            user.Created = DateTime.Now;
            db.CreateUser(user);


            return Ok(user);
        }


        /// <summary>
        /// Login.
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [Route("Login")]
        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {

            User user = db.FindUserForLogin(email, password);

            if (user == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found." }};
                return Ok(error);

            }

            var claims = new List<Claim>
            {
                new Claim("AccountType", "User"),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Name, user.Name),
                new Claim(ClaimTypes.Surname, user.LastName),
            };

            var userIdentiy = new ClaimsIdentity(claims, "User");

            ClaimsPrincipal principal = new ClaimsPrincipal(userIdentiy);
            await HttpContext.SignInAsync(principal);

            return Ok(user);

        }
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
      //  [Authorize(Policy = "UserPolicy")]
        [HttpGet("Test")]
        //   [Authorize(Policy = "UserPolicy")]
        public string Test()
        {
            string t = User.Identity.AuthenticationType;
            t += " " + User.Identity.Name;
            t += " " + User.Claims.First();
            t += " " + User.HasClaim(x => x.Value.Equals("UserPolicy"));

            return t;
        }

        /// <summary>
        /// Logout.
        /// </summary>
        /// <returns></returns>
        [HttpGet("LogOut")]
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return Ok("Logout");
        }



        /// <summary>
        /// Changes password via ID.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost("ChangePassword")]
        public IActionResult ChangeUserPassword(int id, string password)
        {
            User user = db.GetUserWithId(id);
            if (user == null)
            {

                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found." }};
                return Ok(error);
            }
            db.ChangeUserPasswordWithId(id, password);
            var ok = new Dictionary<string, string>(){
                    {  "message", "Password Changed Successfully." }};
            return Ok(ok);

        }


        /// <summary>
        /// Deletes a user via ID.
        /// </summary>
        /// <param name="id"></param>
        [HttpDelete("DeleteUser")]
        public void Delete(int id)
        {
            db.DeleteUserWithId(id);

        }
        /// <summary>
        /// Checks user mail exists in DB.
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        [HttpPost("CheckUserMailExists")]
        public IActionResult FindUserWithEmail(string email)
        {
            User user = db.FindUserWithEmail(email);
            if (user == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Account Not Found." }};
                return Ok(error);
            }


            var id = new Dictionary<string, int>(){
                    {  "id", user.Id }};
            return Ok(id);
        }
        




    }


}
