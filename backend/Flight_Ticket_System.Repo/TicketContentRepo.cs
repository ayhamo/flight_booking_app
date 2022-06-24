using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Repo
{
    public class TicketContentRepo : ITicketContent
    {
        DataContext _db;
        public TicketContentRepo(DataContext db)
        {
            _db = db;
        }

        public void Create(int flightId, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice)
        {
            TicketContent ticketContent = new TicketContent();
            ticketContent.FlightId = flightId;
            ticketContent.CompanyName = "asd";
            ticketContent.EconomyCapacity = economyCapacity;
            ticketContent.EconomyPrice = economyPrice;
            ticketContent.BussinesCapacity = bussinesCapacity;
            ticketContent.BussinesPrice = bussinesPrice;
            ticketContent.FirstClassCapacity = firstClassCapacity;
            ticketContent.FirstClassPrice = firstClassPrice;
            DateTime dt2 = new DateTime(2015,11,31);
            DateTime dt3 = new DateTime(2015, 12,31);
            ticketContent.FlightDepartureDate = dt2;
            ticketContent.FlightLandingDate = dt3;
            _db.TicketContents.Add(ticketContent);
            _db.SaveChanges();
           


        }

       

        public Flight SearchFlightContent(string from, string to, DateTime DepartureDate, DateTime LandingDate)
        {


            return _db.Flights.FirstOrDefault(f => f.From == from && f.To == to && f.DepartureDate == DepartureDate && f.LandingDate == LandingDate);

            
        }


        public List<TicketContent> SearchOneWayFlight(string from, string to, DateTime DepartureDate, int numberOfSeat, string cabinClass)
        {
            Func<TicketContent, List<Flight>, bool> filter = (c, f) => f.Any(f => f.Id == c.Id);
            List<Flight> flights = _db.Flights.ToList();
            List<Flight> flightList = flights.FindAll(f => f.From.Equals(from) && f.To.Equals(to) && f.DepartureDate.Day == DepartureDate.Day);
            List<TicketContent> ticketContents = _db.TicketContents.ToList();
            List<TicketContent> list = ticketContents.FindAll(x => filter(x, flightList) && GetCapacity(cabinClass, x) > numberOfSeat);
            
            return list;
        }
        /*
        public string FindById(int flightId)
        {
            Flight flg = _db.Flights.FirstOrDefault(x => x.Id == flightId);
            string companyname = _db.Companies.FirstOrDefault(x => x.Id ==  flg.CompanyId).Name;
            return companyname;
        }
        */
        /*
        public IEnumerable<TicketContent> SearchRoundTripFlight(string from, string to, DateTime depDate, DateTime retDate, int numberOfSeat, string cabinClass)
        {
            Func<TicketContent, List<Flight>, bool> filter = (c, f) => f.Any(f => f.Id == c.Id);
            Func<Flight, List<Flight>, bool> retCheck = (dep, FlightList) => FlightList.Any(x => x.From.Equals(dep.To) && x.To.Equals(dep.From ) && dep.Date == retDate);
            Func<Flight, List<Flight>, bool> findRet = (dep, list) => list.Any(x => x.From.Equals(dep.To) && x.To.Equals(dep.From) && x.Date == retDate );
            List<Flight> flist = _db.Flights.ToList();
            
            List<Flight> depList = flist.FindAll(x => retCheck(x, flist));
            List<Flight> retList = depList.FindAll(x => findRet(x, flist));

            


            depList.AddRange(retList);
            List<TicketContent> list = _db.TicketContents.ToList().FindAll(x => filter(x, depList));
    
            return list;
        }
        */
        public int GetCapacity(string cabinName, TicketContent ticketContent)
        {
            if (cabinName.Equals("Bussines")) //capatilize every class!!
            {
                return ticketContent.BussinesCapacity;

            }else if (cabinName.Equals("Economy"))
            {
                return ticketContent.EconomyCapacity;

            }
            else
            {
                return ticketContent.FirstClassCapacity;
            }
        }

        public List<Flight> CompaniesFlights(int companyId)
        {
            
            TicketContent tc = new TicketContent();
            List<Flight> flights = _db.Flights.ToList();
            List<Flight> list = new List<Flight>();


            for(int i = 0; i < flights.Count; i++)
            {
                if(flights[i].CompanyId == companyId)
                {
                    Flight flight = new Flight();
                    flight.Id = flights[i].Id;
                    flight.From = flights[i].From; 
                    flight.To = flights[i].To;
                    flight.DepartureDate = flights[i].DepartureDate;
                    flight.LandingDate = flights[i].LandingDate;
                    flight.TicketContentEconomyPrice = flights[i].TicketContentEconomyPrice;
                    
                    list.Add(flight);
                }
            }
            return list;
        }

    }
}
