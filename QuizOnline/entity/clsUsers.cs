using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsUsers
    {
        public int userID { get; set; }
        public int userTypeID { get; set; }
        public string IDCard { get; set; }
        public string name { get; set; }
        public string lastname { get; set; }
        public string title { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public DateTime dateOfBirth { get; set; }
        public DateTime valueDate { get; set; }
        public int status { get; set; }
        public string department { get; set; }
        public string position { get; set; }
        public string address { get; set; }
        public string district { get; set; }
        public string subDistrict { get; set; }
        public string province { get; set; }
        public string zip { get; set; }
        public string mobile { get; set; }
        public string email { get; set; }
        public string photo { get; set; }

    }
}