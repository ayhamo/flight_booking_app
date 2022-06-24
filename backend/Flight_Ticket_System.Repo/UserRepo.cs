using Flight_Ticket_System.Data;
using Flight_Ticket_System.Services;
using System.Linq;

namespace Flight_Ticket_System.Repo
{
    public class UserRepo : IUser
    {
        DataContext _db;

        public UserRepo(DataContext db)
        {
            _db = db;
        }

        public IQueryable<User> GetAllUser => _db.Users;

        public bool ChackMailExist(string email)
        {
            return _db.Users.Any(x => x.Email == email);
        }

        public void ChangeUserPasswordWithId(int userId, string password)
        {
            User user = GetUserWithId(userId);
            user.Password = password;
            _db.Update(user);
            _db.SaveChanges();
        }

        public void CreateUser(User user)
        {
            _db.Users.Add(user);
            _db.SaveChanges();
        }

        public void DeleteUser(int? id)
        {
            User user = _db.Users.Find(id);
            _db.Users.Remove(user);
            _db.SaveChanges();
        }


        public void DeleteUserWithId(int id)
        {
            User user = GetUserWithId(id);
            _db.Users.Remove(user);
            _db.SaveChanges(true);
        }

        public User FindUserForLogin(string email, string password)
        {
            return _db.Users.FirstOrDefault(x => x.Email == email && x.Password == password);
        }

        public int FindUserIdWithEmail(string email)
        {

            return _db.Users.FirstOrDefault(x => x.Email.Equals(email)).Id;
        }

        public User FindUserWithEmail(string email)
        {
            return _db.Users.FirstOrDefault(x => x.Email.Equals(email));
        }



        public User GetUserWithId(int? id)
        {
            return _db.Users.FirstOrDefault(x => x.Id == id);
        }

        public void UpdateUser(int userId, string name, string lastName, string password, string email)
        {
            User oldUser = GetUserWithId(userId);
            oldUser.Name = name;
            oldUser.LastName = lastName;

            oldUser.Email = email;
            oldUser.Password = password;

            _db.Update(oldUser);
            _db.SaveChanges();

        }

        
       
       
      
    }
}
