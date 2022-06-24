using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Flight_Ticket_System.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FlightController : ControllerBase
    {
        IFlight _db;

        public FlightController(IFlight db)
        {
            _db = db;
        }

        /// <summary>
        /// Creates flight and flightContent
        /// </summary>
        /// <returns></returns>
        [HttpPost("Create")]
        public IActionResult Create(int CompanyId, string from, string to, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice) 
        {
          Flight flight = _db.Create(CompanyId, from, to, DepartureDate, LandingDate, economyCapacity, economyPrice, bussinesCapacity, bussinesPrice, firstClassCapacity, firstClassPrice);
            return Ok(flight);
        }


        [HttpGet("ManageFlight")]
        public IActionResult Update(int flightId, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice)
        {
            Flight flight = _db.Update(flightId, DepartureDate, LandingDate, economyCapacity, economyPrice,bussinesCapacity,bussinesPrice,firstClassCapacity,firstClassPrice);
            return Ok(flight);
        }


    }
}
