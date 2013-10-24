using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizOnline.entity
{
    public class clsAnswerSheetDetail
    {
        public int answerSheetDetailID { get; set; }
        public int answerSheetID { get; set; }
        public int quizID { get; set; }
        public int userAnswer { get; set; }
        public int answerStatus { get; set; }
    }
}