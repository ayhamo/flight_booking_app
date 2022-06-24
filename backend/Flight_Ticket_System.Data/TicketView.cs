using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Data
{
    public class TicketView
    {
        public Ticket Ticket { get; set; }
        public List<FlightPassenger> passengers { get; set; }

    }
}
