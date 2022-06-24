using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Repo
{
    public class FlightRepo : IFlight
    {
        DataContext _db;

        public FlightRepo(DataContext db)
        {
            _db = db;
        }

        public Flight Create(int CompanyId, string from, string to, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice)
        {
            Flight flight = new Flight();
            flight.CompanyId = CompanyId;
            flight.From = from;
            flight.To = to;
            flight.DepartureDate = DepartureDate;
            flight.LandingDate = LandingDate;
            flight.TicketContentEconomyPrice = economyPrice; 
            _db.Flights.Add(flight);
            _db.SaveChanges();
            TicketContent ticketContent = new TicketContent();
            ticketContent.FlightId = flight.Id;
            ticketContent.CompanyName = FindById(flight.Id);
            ticketContent.EconomyCapacity = economyCapacity;
            ticketContent.EconomyPrice = economyPrice;
            ticketContent.BussinesCapacity = bussinesCapacity;
            ticketContent.BussinesPrice = bussinesPrice;
            ticketContent.FirstClassCapacity = firstClassCapacity;
            ticketContent.FirstClassPrice = firstClassPrice;
            ticketContent.FlightDepartureDate = FindDepartureDate(flight.Id);
            ticketContent.FlightLandingDate = FindLandingDate(flight.Id);
            _db.TicketContents.Add(ticketContent);
            _db.SaveChanges();

            


            return flight;
        }
        
        public DateTime FindDepartureDate(int flightId)
        {
            return _db.Flights.FirstOrDefault(x => x.Id == flightId).DepartureDate;
            //DateTime departureDate = _db.Flights.FirstOrDefault(x => x.Id == tc.Id).DepartureDate;
            //return departureDate;
        }
        
        public DateTime FindLandingDate(int flightId)
        {
            return _db.Flights.FirstOrDefault(x => x.Id == flightId).LandingDate;
           // DateTime landingDate = _db.Flights.FirstOrDefault(x => x.Id == tc.FlightId).LandingDate;
            //return landingDate;
        }
        
        
        public string FindById(int flightId)
        {
            Flight flg = _db.Flights.FirstOrDefault(x => x.Id == flightId);
            string companyname = _db.Companies.FirstOrDefault(x => x.Id == flg.CompanyId).Name;
            return companyname;
        }

        public Flight FindFlightFromId(int id)
        {
            return _db.Flights.FirstOrDefault(x=> x.Id == id);
        }

        public Flight Update(int flightId, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice)
        {
            Flight flight = FindFlightFromId(flightId);
            TicketContent ticketContent = _db.TicketContents.FirstOrDefault( x=> x.FlightId == flightId);
            flight.DepartureDate = DepartureDate;
            flight.LandingDate = LandingDate;
            flight.TicketContentEconomyPrice = economyPrice;
            ticketContent.EconomyPrice = economyPrice;
            ticketContent.EconomyCapacity = economyCapacity;
            ticketContent.FirstClassCapacity=firstClassCapacity;
            ticketContent.FirstClassPrice=firstClassPrice;
            ticketContent.BussinesPrice=bussinesPrice;
            ticketContent.BussinesCapacity=bussinesCapacity;
            ticketContent.FlightDepartureDate = DepartureDate; 
            ticketContent.FlightLandingDate= LandingDate;
            _db.Update(flight);
            _db.Update(ticketContent);
            _db.SaveChanges();
            return flight;
        }
    }
}
