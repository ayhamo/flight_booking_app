using Flight_Ticket_System.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Flight_Ticket_System.Services
{
    public interface IFlight
    {
        Flight Create(int CompanyId, string from, string to, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice);
        Flight Update(int flightId, DateTime DepartureDate, DateTime LandingDate, int economyCapacity, double economyPrice, int bussinesCapacity, double bussinesPrice, int firstClassCapacity, double firstClassPrice);
        Flight FindFlightFromId(int id);

    }
}
