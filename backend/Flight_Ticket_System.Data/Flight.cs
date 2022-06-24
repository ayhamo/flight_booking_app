using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Data
{
    public class Flight
    {

        public int Id { get; set; }
        public int CompanyId { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public DateTime DepartureDate { get; set; }
        public DateTime LandingDate { get; set; }

        public double TicketContentEconomyPrice { get; set; }
    }
}
