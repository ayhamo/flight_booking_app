using Flight_Ticket_System.Data;

namespace Flight_Ticket_System.Services
{
    public interface IMaster
    {
        public Master FindMasterForLogin(string email, string password);
        public List<CompanyRequest> GetCompanyRequests();
        public void AcceptCompanyRequest(int companyId);
        IQueryable<Company> GetAllAuthorities { get; }

        public void DeleteCompany(int id);
    }
}
