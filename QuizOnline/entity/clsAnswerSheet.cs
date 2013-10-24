using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsAnswerSheet
    {
        public int answerSheetID { get; set; }
        public int quizListID { get; set; }
        public int userID { get; set; }
        public DateTime valueDate { get; set; }
        public int correctAnswerNumber { get; set; }
        public int status { get; set; }
    }
}