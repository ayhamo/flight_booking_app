using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Flight_Ticket_System.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TicketContentController : ControllerBase
    {
        ITicketContent _db;

        public TicketContentController(ITicketContent db)
        {
            _db = db;
        }


        
        

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost("SearchOneFlight")]
        public IActionResult SearchOneWayFlight(string from, string to, DateTime DepartureDate, int numberOfSeat, string cabinClass)
            {
            List<TicketContent> flg = _db.SearchOneWayFlight(from, to, DepartureDate, numberOfSeat, cabinClass);
            
            
                if (flg == null)
                {
                    var error = new Dictionary<string, string>(){
                    {  "message", "Flight Not Found." }};
                    return Ok(error);
                }
            

            return Ok(flg);

            }
        /*
        [HttpPost("SearchRoundTripFlight")]
        public IActionResult SearchRoundTripFlight(string from, string to, DateTime depDate, DateTime repTime, int numberOfSeat, string cabinClass)
        {
            List<TicketContent> flg = _db.SearchRoundTripFlight(from, to, depDate, repTime, numberOfSeat, cabinClass).ToList();
            if (flg == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Flight Not Found." }};
                return Ok(error);
            }

            return Ok(flg);
        }
    */

        [HttpPost("CompaniesFlights")]
        public IActionResult CompaniesFlights(int companyId)
        {
            List<Flight>  flights = _db.CompaniesFlights(companyId);
           
            if (flights == null)
            {
                var error = new Dictionary<string, string>(){
                    {  "message", "Flight Not Found." }};
                return Ok(error);
            }
            return Ok(flights);
        }

    }
}
