using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsQuiz
    {
        public int quizID { get; set; }
        public int quizListID { get; set; }
        public string question { get; set; }
        public string choice1 { get; set; }
        public string choice2 { get; set; }
        public string choice3 { get; set; }
        public string choice4 { get; set; }
        public int answer { get; set; }
        public int status { get; set; }
    }
}