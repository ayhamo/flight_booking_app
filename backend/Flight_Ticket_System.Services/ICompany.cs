using Flight_Ticket_System.Data;

namespace Flight_Ticket_System.Services
{
    public interface ICompany
    {
        public Company GetCompanyById(int id);
        public Company GetCompanyByEmail(string email);
        public string GetCompanyName(int id);
       // public void DeleteCompany(int id);
        public List<Company> GetCompanyList(int id);
        bool ChackMailExistInRequests(string email);
        bool ChackMailExistInCompanies(string email);
        public Company FindCompanyForLogin(string email, string password);
        public CompanyRequest FindRequestWithCompanyEmail(string email);
        public List<CompanyRequest> GetCompanyRequests();
        public void CreateNewCompanyRequest(CompanyRequest request);
        public void AcceptCompanyRequest(int companyId);
        public void RejectCompanyRequest(int companyId);

        public void CreateCompany(Company company);

        public void ChangeCompanyPassword(int companyId, string password);

         void UpdateCompany(int companyId, string name, string email, string password);
        IQueryable<Company> GetAllAuthorities { get; }
    

    }
}
