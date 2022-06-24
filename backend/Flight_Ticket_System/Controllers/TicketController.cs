using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Flight_Ticket_System.Controllers
{
    /// <summary>
    /// 
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]

    public class TicketController : ControllerBase
    {
        ITicket _db;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="db"></param>
        public TicketController(ITicket db)
        {
            _db = db;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ticketContentId"></param>
        /// <param name="userId"></param>
        /// <param name="cabinType"></param>
        /// <param name="quantity"></param>
        /// <returns></returns>
        [HttpGet("BuyTicket")]
        // public IActionResult BuyTicket(int ticketContentId, int userId, string cabinType, int quantity, List<string> passangerList)
        public IActionResult BuyTicket(int ticketContentId, int userId, string cabinType, int quantity)
        {
            _db.BuyTicket(ticketContentId, userId, cabinType, quantity);
            Dictionary<string, string> result = new Dictionary<string, string>();
            result.Add("Message", "Purchase Completed");
            return Ok(result);
        }

        [HttpGet("getpassenger")]
        public IActionResult GetPassengersInfo(int ticketContentId, string name, string Surname, DateTime birthDate)
        {
            _db.GetPassengersInfo(ticketContentId, name, Surname, birthDate);

             return Ok();
        }



        [HttpGet("ViewTicket")]
        public IActionResult ViewTicket(int userId)
        {
            List<TicketView> ticket = _db.ViewTicket(userId);
            if (ticket.Count == 0)
            {
                Dictionary<string, string> error = new Dictionary<string, string>();
                error.Add("Message", "You do not have any ticket!");
                return Ok("{}");
            }
         
            else if (ticket[0].Ticket.OwnerId != userId)
            {
                Dictionary<string, string> error = new Dictionary<string, string>();
                error.Add("Message", "User does not exist!");
                return Ok(error);
            }


            return Ok(ticket);
        }

    }
}
