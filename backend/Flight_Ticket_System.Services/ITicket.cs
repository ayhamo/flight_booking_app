using Flight_Ticket_System.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Services
{
    public interface ITicket
    {
        public void BuyTicket(int ticketContentId, int userId, string cabinType, int quantity);
        public void GetPassengersInfo(int ticketContentId, string name, string Surname, DateTime birthDate);


        public List<TicketView> ViewTicket(int userId);



    }
}
