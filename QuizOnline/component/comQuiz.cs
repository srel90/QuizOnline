using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using QuizOnline.entity;
using System;
using System.Web;
using System.Web.Services;

namespace QuizOnline.component
{
    public class comQuiz
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comQuiz()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet getLastID()
        {
            strsql = "IF (SELECT TOP(1) quizListID+1  as lastID FROM quizList ORDER BY quizListID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) quizListID+1  as lastID FROM quizList ORDER BY quizListID DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public int getCorrectChoiceByQuizID(int quizID)
        {
            strsql = "SELECT answer FROM quiz WHERE quizID=@quizID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizID", DbType.Int32, quizID);
                ds = db.ExecuteDataSet(Dbcmd);
                return Convert.ToInt32(ds.Tables[0].Rows[0]["answer"]);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean checkPassQuiz(int quizListID, int userID)
        {
            strsql = "SELECT * FROM answerSheet WHERE quizListID=@quizListID AND userID=@userID AND status=1";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
                ds = db.ExecuteDataSet(Dbcmd);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean checkNextQuiz(int quizListID, int userID)
        {

            try
            {
                strsql = "SELECT * FROM quizList WHERE quizListID=@quizListID";
                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                int quizNumber = Convert.ToInt32(ds.Tables[0].Rows[0]["quizNumber"]);
                quizNumber = quizNumber - 1;
                if (quizNumber <= 0)
                {
                    quizNumber = 1;
                }

                strsql = "SELECT * FROM answerSheet WHERE quizListID=@quizListID AND userID=@userID AND status=1";
                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
                ds = db.ExecuteDataSet(Dbcmd);
                if (ds.Tables[0].Rows.Count != 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizList()
        {
            strsql = "SELECT ql.*,CONCAT(u.title,' ',u.name,' ',u.lastname) as 'user' FROM quizList ql LEFT OUTER JOIN users u ON ql.userID=u.userID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectTop10QuizListAndStatus()
        {
            strsql = "SELECT TOP(10)* FROM quizList WHERE status=1 ORDER BY quizListID,quizNumber DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizListAndStatus()
        {
            strsql = "SELECT * FROM quizList WHERE status=1 ORDER BY quizListID,quizNumber DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectQuizListByID(int quizListID)
        {
            strsql = "SELECT * FROM quizList WHERE quizListID=@quizListID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectQuizListByIDAndStatus(int quizListID)
        {
            strsql = "SELECT * FROM quizList WHERE quizListID=@quizListID AND status=1";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizByQuizListID(int quizListID)
        {
            strsql = "SELECT * FROM quiz WHERE quizListID=@quizListID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizByQuizListIDAndStatusRandom(int quizListID)
        {
            
            try
            {
                strsql = "SELECT * FROM quizList WHERE quizListID=@quizListID AND status=1";
                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                dt = ds.Tables[0];
                int numberQuiz = Convert.ToInt32(dt.Rows[0]["numberQuiz"]);
                strsql = "SELECT TOP(" + numberQuiz + ")* FROM quiz WHERE quizListID=@quizListID AND status=1 ORDER BY newid()";
                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizByQuizListIDAndStatus(int quizListID)
        {
            strsql = "SELECT * FROM quiz WHERE quizListID=@quizListID AND status=1";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAllQuizByQuizListIDForReport(int quizListID)
        {
            strsql = "SELECT ql.quizListID,ql.userID,ql.title,ql.description,q.question,q.choice1,q.choice2,q.choice3,q.choice4,q.answer FROM quizList ql  LEFT OUTER JOIN quiz q ON ql.quizListID=q.quizListID WHERE ql.quizListID=@quizListID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean insertQuizList(clsQuizList clsQuizList)
        {
            strsql = "INSERT INTO quizList (";
            strsql += "userID,";
            strsql += "title,";
            strsql += "description,";
            strsql += "valueDate,";
            strsql += "dateTimeFrom,";
            strsql += "dateTimeTo,";
            strsql += "quizNumber,";
            strsql += "numberQuiz,";
            strsql += "status,";
            strsql += "courseID,";
            strsql += "location ";
            strsql += ")VALUES(";
            strsql += "@userID,";
            strsql += "@title,";
            strsql += "@description,";
            strsql += "CURRENT_TIMESTAMP,";
            strsql += "@dateTimeFrom,";
            strsql += "@dateTimeTo,";
            strsql += "@quizNumber,";
            strsql += "@numberQuiz,";
            strsql += "@status,";
            strsql += "@courseID,";
            strsql += "@location";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsQuizList.userID);
                db.AddInParameter(Dbcmd, "@title", DbType.String, clsQuizList.title);
                db.AddInParameter(Dbcmd, "@description", DbType.String, clsQuizList.description);
                db.AddInParameter(Dbcmd, "@dateTimeFrom", DbType.DateTime, clsQuizList.dateTimeFrom);
                db.AddInParameter(Dbcmd, "@dateTimeTo", DbType.DateTime, clsQuizList.dateTimeTo);
                db.AddInParameter(Dbcmd, "@quizNumber", DbType.String, clsQuizList.quizNumber);
                db.AddInParameter(Dbcmd, "@numberQuiz", DbType.Int32, clsQuizList.numberQuiz);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsQuizList.status);
                db.AddInParameter(Dbcmd, "@courseID", DbType.Int32, clsQuizList.courseID);
                db.AddInParameter(Dbcmd, "@location", DbType.String, clsQuizList.location);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean insertQuiz(clsQuiz clsQuiz)
        {
            strsql = "INSERT INTO quiz (";
            strsql += "quizListID,";
            strsql += "question,";
            strsql += "choice1,";
            strsql += "choice2,";
            strsql += "choice3,";
            strsql += "choice4,";
            strsql += "answer,";
            strsql += "status";
            strsql += ")VALUES(";
            strsql += "@quizListID,";
            strsql += "@question,";
            strsql += "@choice1,";
            strsql += "@choice2,";
            strsql += "@choice3,";
            strsql += "@choice4,";
            strsql += "@answer,";
            strsql += "@status";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, clsQuiz.quizListID);
                db.AddInParameter(Dbcmd, "@question", DbType.String, clsQuiz.question);
                db.AddInParameter(Dbcmd, "@choice1", DbType.String, clsQuiz.choice1);
                db.AddInParameter(Dbcmd, "@choice2", DbType.String, clsQuiz.choice2);
                db.AddInParameter(Dbcmd, "@choice3", DbType.String, clsQuiz.choice3);
                db.AddInParameter(Dbcmd, "@choice4", DbType.String, clsQuiz.choice4);
                db.AddInParameter(Dbcmd, "@answer", DbType.Int32, clsQuiz.answer);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsQuiz.status);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean updateQuizList(clsQuizList clsQuizList)
        {
            strsql = "UPDATE quizList SET ";
            strsql += "userID=@userID, ";
            strsql += "title=@title, ";
            strsql += "description=@description, ";
            strsql += "valueDate=CURRENT_TIMESTAMP, ";
            strsql += "dateTimeFrom=@dateTimeFrom, ";
            strsql += "dateTimeTo=@dateTimeTo, ";
            strsql += "quizNumber=@quizNumber, ";
            strsql += "numberQuiz=@numberQuiz, ";
            strsql += "status=@status, ";
            strsql += "courseID=@courseID, ";
            strsql += "location=@location ";
            strsql += "WHERE ";
            strsql += "quizListID=@quizListID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsQuizList.userID);
                db.AddInParameter(Dbcmd, "@title", DbType.String, clsQuizList.title);
                db.AddInParameter(Dbcmd, "@description", DbType.String, clsQuizList.description);
                db.AddInParameter(Dbcmd, "@dateTimeFrom", DbType.DateTime, clsQuizList.dateTimeFrom);
                db.AddInParameter(Dbcmd, "@dateTimeTo", DbType.DateTime, clsQuizList.dateTimeTo);
                db.AddInParameter(Dbcmd, "@quizNumber", DbType.String, clsQuizList.quizNumber);
                db.AddInParameter(Dbcmd, "@numberQuiz", DbType.Int32, clsQuizList.numberQuiz);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsQuizList.status);
                db.AddInParameter(Dbcmd, "@courseID", DbType.Int32, clsQuizList.courseID);
                db.AddInParameter(Dbcmd, "@location", DbType.String, clsQuizList.location);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, clsQuizList.quizListID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean deleteQuizList(int quizListID)
        {
            strsql = "DELETE FROM quizList WHERE quizListID=@quizListID;DELETE FROM quiz WHERE quizListID=@quizListID;";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean deleteQuiz(int quizListID)
        {
            strsql = "DELETE FROM quiz WHERE quizListID=@quizListID ";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}