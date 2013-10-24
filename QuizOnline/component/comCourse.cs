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
    public class comCourse : System.Web.UI.Page
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comCourse()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet selectAllCourse()
        {
            strsql = "SELECT * FROM course";
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
        public DataSet getLastID()
        {
            strsql = "IF (SELECT TOP(1) ID+1  as lastID FROM course ORDER BY ID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) ID+1  as lastID FROM course ORDER BY ID DESC";

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
        public Boolean insert(clsCourse clsCourse)
        {
            strsql = "INSERT INTO course (";
            strsql += "courseID,";
            strsql += "courseName,";
            strsql += "instructor,";
            strsql += "trainingType";
            strsql += ")VALUES(";
            strsql += "@courseID,";
            strsql += "@courseName,";
            strsql += "@instructor,";
            strsql += "@trainingType";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@courseID", DbType.String, clsCourse.courseID);
                db.AddInParameter(Dbcmd, "@courseName", DbType.String, clsCourse.courseName);
                db.AddInParameter(Dbcmd, "@instructor", DbType.String, clsCourse.instructor);
                db.AddInParameter(Dbcmd, "@trainingType", DbType.String, clsCourse.trainingType);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean update(clsCourse clsCourse)
        {
            strsql = "UPDATE course SET ";
            strsql += "courseID=@courseID, ";
            strsql += "courseName=@courseName, ";
            strsql += "instructor=@instructor, ";
            strsql += "trainingType=@trainingType ";
            strsql += "WHERE ";
            strsql += "ID=@ID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@courseID", DbType.String, clsCourse.courseID);
                db.AddInParameter(Dbcmd, "@courseName", DbType.String, clsCourse.courseName);
                db.AddInParameter(Dbcmd, "@instructor", DbType.String, clsCourse.instructor);
                db.AddInParameter(Dbcmd, "@trainingType", DbType.String, clsCourse.trainingType);
                db.AddInParameter(Dbcmd, "@ID", DbType.Int32, clsCourse.ID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean delete(int ID)
        {
            strsql = "DELETE FROM course ";
            strsql += "WHERE ";
            strsql += "ID=@ID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@ID", DbType.Int32, ID);
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