using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Data
{
    public class FlightPassenger
    {
        public int Id { get; set; }
        public int TicketId { get; set; }
        public string PassangerInfo { get; set; }
        public DateTime BirthDate { get; set; }
    }
}
