using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;

namespace Flight_Ticket_System.Repo
{
    public class CompanyRepo : ICompany
    {
        DataContext _db;
        public CompanyRepo(DataContext db)
        {
            _db = db;
        }

        public IQueryable<Company> GetAllAuthorities => _db.Companies;

        public void CreateCompany(Company company)
        {
            _db.Companies.Add(company);
            _db.SaveChanges();
        }
        public void AcceptCompanyRequest(int companyId)
        {
            CompanyRequest NewCompany = _db.CompanyRequests.FirstOrDefault(x => x.Id == companyId);

            Company company = new Company
            {
                Name = NewCompany.Name,
                Email = NewCompany.Email,
                Password = NewCompany.Password,
                Created = DateTime.Now,

            };
            _db.CompanyRequests.Remove(NewCompany);
            _db.Companies.Add(company);
            _db.SaveChanges();
        }

        public bool ChackMailExistInCompanies(string email)
        {
            return _db.Companies.Any(x => x.Email == email);
        }

        public bool ChackMailExistInRequests(string email)
        {
            return _db.CompanyRequests.Any(x => x.Email == email);
        }

        public void CreateNewCompanyRequest(CompanyRequest request)
        {

            _db.CompanyRequests.Add(request);
            _db.SaveChanges();
        }

        
        

        public Company FindCompanyForLogin(string email, string password)
        {
            return _db.Companies.FirstOrDefault(x => x.Email.Equals(email) && x.Password == password);
        }

        public CompanyRequest FindRequestWithCompanyEmail(string email)
        {
            return _db.CompanyRequests.FirstOrDefault(x => x.Email.Equals(email));
        }

        public Company GetCompanyByEmail(string email)
        {
            return _db.Companies.FirstOrDefault(x => x.Email.Equals(email));
        }

        public Company GetCompanyById(int id)
        {

            Company company = _db.Companies.Single(x => x.Id == id);
            return company;
        }

        public int GetCompanyId(string email)
        {
            return _db.Companies.FirstOrDefault(x => x.Email.Equals(x.Email)).Id;
        }

        public List<Company> GetCompanyList(int id)
        {
            List<Company> CompanyList = _db.Companies.ToList();
            return CompanyList;
        }

        public string GetCompanyName(int id)
        {
            Company company = _db.Companies.FirstOrDefault(x => x.Id == id);
            return company.Name;
        }

        public List<CompanyRequest> GetCompanyRequests()
        {
            List<CompanyRequest> companyRequestList = _db.CompanyRequests.ToList();
            return companyRequestList;
        }

        public void RejectCompanyRequest(int companyId)
        {
            CompanyRequest CompanyRequest = _db.CompanyRequests.FirstOrDefault(x => x.Id == companyId);
            _db.CompanyRequests.Remove(CompanyRequest);
            _db.SaveChanges();
        }

        public void ChangeCompanyPassword(int companyId, string password)
        {
            Company company = GetCompanyById(companyId);
            company.Password = password;
            _db.Update(company);
            _db.SaveChanges();

        }
        public void UpdateCompany(int companyId, string name, string email, string password)
        {
            Company oldCompany = _db.Companies.Find(companyId);
            oldCompany.Name = name;
            oldCompany.Email = email;
            oldCompany.Password = password;
            _db.Update(oldCompany);
            _db.SaveChanges();

        }
        /*
        public void DeleteCompany(int id)
        {

            Company? company = _db.Companies.FirstOrDefault(x => x.Id == id);
            if (company != null)
            {
                _db.Companies.Remove(company);
                _db.SaveChanges();
            }
        }
        */
    }
}
