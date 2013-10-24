using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsTraining
    {
        public int trainingRegisterID { get; set; }
        public int userID { get; set; }
        public DateTime valueDate { get; set; }
        public string trainingType { get; set; }
        public string courseID { get; set; }
        public int generation { get; set; }
        public string location { get; set; }
        public Double cost { get; set; }
    }
}