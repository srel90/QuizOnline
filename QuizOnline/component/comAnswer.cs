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
    public class comAnswer
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comAnswer()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet getLastID()
        {
            strsql = "IF (SELECT TOP(1) answerSheetID+1  as lastID FROM answerSheet ORDER BY answerSheetID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) answerSheetID+1  as lastID FROM answerSheet ORDER BY answerSheetID DESC";
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
        public Boolean insertAnswerSheet(clsAnswerSheet clsAnswerSheet)
        {
            strsql = "INSERT INTO answerSheet (";
            strsql += "quizListID,";
            strsql += "userID,";
            strsql += "valueDate,";
            strsql += "correctAnswerNumber,";
            strsql += "status";
            strsql += ")VALUES(";
            strsql += "@quizListID,";
            strsql += "@userID,";
            strsql += "CURRENT_TIMESTAMP,";
            strsql += "@correctAnswerNumber,";
            strsql += "@status";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, clsAnswerSheet.quizListID);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsAnswerSheet.userID);
                db.AddInParameter(Dbcmd, "@correctAnswerNumber", DbType.Int32, clsAnswerSheet.correctAnswerNumber);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsAnswerSheet.status);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean insertAnswerSheetDetail(clsAnswerSheetDetail clsAnswerSheetDetail)
        {
            strsql = "INSERT INTO answerSheetDetail (";
            strsql += "answerSheetID,";
            strsql += "quizID,";
            strsql += "userAnswer,";
            strsql += "answerStatus";
            strsql += ")VALUES(";
            strsql += "@answerSheetID,";
            strsql += "@quizID,";
            strsql += "@userAnswer,";
            strsql += "@answerStatus";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@answerSheetID", DbType.Int32, clsAnswerSheetDetail.answerSheetID);
                db.AddInParameter(Dbcmd, "@quizID", DbType.Int32, clsAnswerSheetDetail.quizID);
                db.AddInParameter(Dbcmd, "@userAnswer", DbType.Int32, clsAnswerSheetDetail.userAnswer);
                db.AddInParameter(Dbcmd, "@answerStatus", DbType.Int32, clsAnswerSheetDetail.answerStatus);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAnswerSheetByQuizListIDAndUserID(int quizListID,int userID)
        {
            strsql = "SELECT TOP(1) valueDate FROM answerSheet WHERE quizListID=@quizListID AND userID=@userID ORDER BY answerSheetID DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@quizListID", DbType.Int32, quizListID);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAnswerSheetHistory(int userID)
        {
            strsql = "SELECT ah.*,ql.title,ql.description,ql.valueDate as exValueDate,CASE  ah.status WHEN 1 THEN 'Pass' ELSE 'Fail' END as exStatus FROM answerSheet ah LEFT OUTER JOIN quizList ql ON ah.quizListID=ql.quizListID WHERE ah.userID=@userID ORDER BY answerSheetID DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectAnswerSheetHistoryWithPassStatus(int userID)
        {
            strsql = "SELECT ah.*,ql.title,ql.description,ql.valueDate as exValueDate,CASE  ah.status WHEN 1 THEN 'Pass' ELSE 'Fail' END as exStatus FROM answerSheet ah LEFT OUTER JOIN quizList ql ON ah.quizListID=ql.quizListID WHERE ah.userID=@userID AND ah.status=1 ORDER BY answerSheetID DESC";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean checkPass(int quizListID, int userID)
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
    }
}