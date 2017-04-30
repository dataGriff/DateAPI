using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DateAPI.DAL;
using DateAPI.Models;

namespace DateAPI.Controllers
{
    public class DateController : ApiController
    {
        private DateRepository _ourDateRespository = new DateRepository();


        // GET: api/Date
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Date/5
        [Route("Date/{date}")]
        [HttpGet]
        public Date Get(string date)
        {
            return _ourDateRespository.GetSingleDate(date);
        }

        // POST: api/Date
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Date/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Date/5
        public void Delete(int id)
        {
        }
    }
}
