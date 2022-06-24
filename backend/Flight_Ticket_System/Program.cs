using Flight_Ticket_System.Repo;

using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddScoped<Flight_Ticket_System.Services.IUser, UserRepo>();
builder.Services.AddScoped<Flight_Ticket_System.Services.ICompany, CompanyRepo>();
builder.Services.AddScoped<Flight_Ticket_System.Services.IMaster, MasterRepo>();
builder.Services.AddScoped<Flight_Ticket_System.Services.IFlight, FlightRepo>();
builder.Services.AddScoped<Flight_Ticket_System.Services.ITicketContent, TicketContentRepo>();
builder.Services.AddScoped<Flight_Ticket_System.Services.ITicket, TicketRepo>();


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSwaggerDocument();


builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie();




builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("UserPolicy", policy => policy.RequireClaim("AccountType", "User"));
    options.AddPolicy("CompanyPolicy", policy => policy.RequireClaim("AccountType", "Company"));
    options.AddPolicy("MasterPolicy", policy => policy.RequireClaim("AccountType", "Master"));
});






builder.Services.AddDbContext<DataContext>(options =>
{

    // Install-Package Microsoft.EntityFrameworkCore.SqlServer

    options.UseSqlServer(builder.Configuration.GetConnectionString("MyConnection"), b => b.MigrationsAssembly("Flight_Ticket_System"));

});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseOpenApi();
    app.UseSwaggerUi3();
}

app.UseAuthorization();
app.UseAuthentication();
app.UseStaticFiles();
app.MapControllers();

app.Run();
