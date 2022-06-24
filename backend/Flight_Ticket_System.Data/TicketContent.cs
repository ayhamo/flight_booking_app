using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Data
{
    public class TicketContent
    {
        public int Id { get; set; }
        public int FlightId { get; set; }
        public string CompanyName { get; set; }
        public int EconomyCapacity { get; set; }
        public double EconomyPrice { get; set; }
        public int BussinesCapacity { get; set; }
        public double BussinesPrice { get; set; }
        public int FirstClassCapacity { get; set; }
        public double FirstClassPrice { get; set; }
        public DateTime FlightDepartureDate { get; set; }
        public DateTime FlightLandingDate { get; set; }
    }
}
