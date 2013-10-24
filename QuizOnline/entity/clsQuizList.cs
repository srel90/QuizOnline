using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsQuizList
    {
        public int quizListID { get; set; }
        public int userID { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public DateTime valueDate { get; set; }
        public DateTime dateTimeFrom { get; set; }
        public DateTime dateTimeTo { get; set; }
        public string quizNumber { get; set; }
        public int numberQuiz { get; set; }
        public int status { get; set; }
        public int courseID { get; set; }
        public string location { get; set; }
    }
}