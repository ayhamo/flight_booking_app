using Flight_Ticket_System.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Services
{
    public interface ITicketContent
    {
        void Create(int flightId, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double bussinesClassPrice);

        List<TicketContent> SearchOneWayFlight(string from, string to, DateTime DepartureDate, int numberOfSeat, string cabinClass);
      //  IEnumerable<TicketContent> SearchRoundTripFlight(string from, string to, DateTime depDate, DateTime retDate, int numberOfSeat, string cabinClass);

        List<Flight> CompaniesFlights(int companyId);

    }



}

