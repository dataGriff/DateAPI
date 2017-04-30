using DateAPI.Models;

namespace DateAPI.DAL
{
    interface IDateRepository
    {
       Date GetSingleDate(string date);
    }
}
