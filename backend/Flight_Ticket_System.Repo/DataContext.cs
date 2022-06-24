using Flight_Ticket_System.Data;
using Microsoft.EntityFrameworkCore;

namespace Flight_Ticket_System.Repo
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }


        public DbSet<User> Users { get; set; }
        public DbSet<Company> Companies { get; set; }
        public DbSet<Master> Masters { get; set; }
        public DbSet<CompanyRequest> CompanyRequests { get; set; }
        public DbSet<Flight> Flights { get; set; }
        public DbSet<TicketContent> TicketContents { get; set; }
        public DbSet<Ticket> Ticket { get; set; }
        public DbSet<FlightPassenger> Passangers { get; set; }
    }
}
