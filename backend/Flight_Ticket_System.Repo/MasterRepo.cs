using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;

namespace Flight_Ticket_System.Repo
{
    public class MasterRepo : IMaster
    {
        DataContext _db;

        public MasterRepo(DataContext db)
        {
            _db = db;
        }

        public Master FindMasterForLogin(string email, string password)
        {

            return _db.Masters.FirstOrDefault(x => x.Email == email && x.Password == password);
        }

        public List<CompanyRequest> GetCompanyRequests()
        {
            List<CompanyRequest> companyRequestList = _db.CompanyRequests.ToList();
            return companyRequestList;
        }

        public void AcceptCompanyRequest(int companyId)
        {
            CompanyRequest newCompany = _db.CompanyRequests.FirstOrDefault(x => x.Id == companyId);
            Company company = new Company
            {
                Name = newCompany.Name,
                Email = newCompany.Email,
                Password = newCompany.Password,
                Created = DateTime.Now,
            };
            _db.CompanyRequests.Remove(newCompany);
            _db.Companies.Add(company);
            _db.SaveChanges();
        }
        public IQueryable<Company> GetAllAuthorities => _db.Companies;

        public void DeleteCompany(int id)
        {

            Company? company = _db.Companies.FirstOrDefault(x => x.Id == id);
            if (company != null)
            {
                _db.Companies.Remove(company);
                _db.SaveChanges();
            }
        }
    }
}
