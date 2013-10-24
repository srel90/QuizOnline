using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsUserRole
    {
        public int userRoleID { get; set; }
        public int userTypeID { get; set; }
        public string fileName { get; set; }
        public int status { get; set; }
    }
}