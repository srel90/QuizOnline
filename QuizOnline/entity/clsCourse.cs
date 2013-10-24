using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsCourse
    {
        public int ID { get; set; }
        public string courseID { get; set; }
        public string courseName { get; set; }
        public string instructor { get; set; }
        public string trainingType { get; set; }
    }
}