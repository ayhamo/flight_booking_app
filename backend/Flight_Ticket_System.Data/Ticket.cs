using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Data
{
    public class Ticket
    {
        public int Id { get; set; }
        public int TicketContentId { get; set; }
        public int OwnerId { get; set; }

        public double Price { get; set; }
        public int Quantity { get; set; }
        public string CabinType { get; set; }

        public String CompanyName { get; set; }
        public String From { get; set; }
        
        public String To { get; set; }

        public DateTime DepartureDate { get; set; }

        public DateTime LandingDate { get; set; }
      

    }
}
