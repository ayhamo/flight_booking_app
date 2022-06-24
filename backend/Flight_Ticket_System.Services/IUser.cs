using Flight_Ticket_System.Data;

namespace Flight_Ticket_System.Services
{
    public interface IUser
    {

        User GetUserWithId(int? id);
        User FindUserForLogin(string email, string password);
        User FindUserWithEmail(string email);
        int FindUserIdWithEmail(string email);
        void ChangeUserPasswordWithId(int userId, string password);

        bool ChackMailExist(string email);
        IQueryable<User> GetAllUser { get; }
        void UpdateUser(int userId, string name, string lastName, string password, string email);
        void CreateUser(User user);
        void DeleteUserWithId(int id);

        

    }
}
