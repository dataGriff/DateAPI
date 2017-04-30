using System.Linq;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Dapper;
using DateAPI.DAL;
using DateAPI.Models;

namespace DateAPI
{
    public class DateRepository :IDateRepository
    {

        private readonly IDbConnection _db = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);

        public Date GetSingleDate(string date)
        {
            return _db.Query<Date>("EXEC acc.pr_Date @date = @date", new { Date = date }).SingleOrDefault();
        }

    }
}