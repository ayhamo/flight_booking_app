using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Repo
{
    public class TicketRepo : ITicket
    {
        public DataContext _db;
        
        public TicketRepo(DataContext db)
        {
            _db = db;
        }
        

        public void BuyTicket(int ticketContentId, int userId, string cabinType, int quantity)
        {  


            TicketContent ticketContent = _db.TicketContents.FirstOrDefault(x => x.Id == ticketContentId);
            Flight flight= _db.Flights.FirstOrDefault(x => x.Id == ticketContentId);
            
            Ticket ticket = new Ticket
            {
                OwnerId = userId,
                TicketContentId = ticketContentId,
                CabinType = cabinType,
                Quantity = quantity,
                CompanyName = ticketContent.CompanyName,
                From = flight.From,
                To = flight.To,
                DepartureDate = flight.DepartureDate,
                LandingDate = flight.LandingDate,
            };
            
            if (cabinType.Equals("Bussines")) 
            {
                ticketContent.BussinesCapacity -= quantity;
                ticket.Price = quantity * ticketContent.BussinesPrice;
            }
            else if (cabinType.Equals("Economy"))
            {
                 ticketContent.EconomyCapacity -= quantity;
                ticket.Price = quantity * ticketContent.EconomyPrice;
            }
            else
            {
                ticketContent.FirstClassCapacity -= quantity;
                ticket.Price = quantity * ticketContent.FirstClassPrice;
            }

            _db.Ticket.Add(ticket);
            _db.Update(ticketContent);
            _db.SaveChanges();


        }
        public List<FlightPassenger> GetPassengers(int ticketId)
        {
            List<FlightPassenger> passengers = new List<FlightPassenger>();
            passengers = _db.Passangers.Where( x => x.TicketId == ticketId).ToList();
            return passengers;
        }

        public void GetPassengersInfo(int ticketContentId, string name, string Surname, DateTime birthDate)
        {
            FlightPassenger passenger = new FlightPassenger()
            {
                TicketId = ticketContentId,
                BirthDate = birthDate,
                PassangerInfo = name + " " + Surname,
            };

            _db.Passangers.Add(passenger);
            _db.SaveChanges();

        }

 

        public List<TicketView> ViewTicket(int userId)
        {
            List<TicketView> views = new List<TicketView>();

            List<Ticket> ticket = _db.Ticket.ToList();
            List<Ticket> filteredTicketList = new List<Ticket>();


            for (int i = 0; i < ticket.Count; i++)
            {
                if (ticket[i].OwnerId == userId)
                {
                    TicketView view = new TicketView();
                    view.Ticket = ticket[i];
                    view.passengers = GetPassengers(ticket[i].Id);
                    views.Add(view);
                    filteredTicketList.Add(ticket[i]);
                }
            }


            return views;
        }


    }
}
