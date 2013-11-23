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
    public class comTraining : System.Web.UI.Page
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comTraining()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet selectAllTraining()
        {
            strsql = "SELECT * FROM trainingRegister";
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
        public DataSet selectScheduleTraining(int userID)
        {
            strsql = "SELECT t.*,c.courseName FROM trainingRegister t LEFT OUTER JOIN course c ON t.courseID=c.courseID WHERE t.userID=@userID AND DATEDIFF(d,CURRENT_TIMESTAMP,t.valueDate)>=0";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32,userID);
                ds = db.ExecuteDataSet(Dbcmd);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public DataSet selectTrainingList()
        {
            strsql = "SELECT trainingRegister.*,users.name,users.lastname,users.position From trainingRegister trainingRegister LEFT OUTER JOIN users users ON trainingRegister.userID=users.userID";
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
        public DataSet selectTrainingListByUserID(int userID)
        {
            strsql = "SELECT course.courseName,trainingRegister.*,users.name,users.lastname,users.position,users.valueDate as startdate,users.email,users.mobile,users.photo,users.department,DATEDIFF(year, users.valuedate, getdate()) - (CASE WHEN (DATEADD(year, DATEDIFF(year, users.valuedate, getdate()), users.valuedate)) > getdate() THEN 1 ELSE 0 END) as Years, MONTH(getdate() - (DATEADD(year, DATEDIFF(year, users.valuedate, getdate()), users.valuedate))) - 1 as 'Month', DAY(getdate() - (DATEADD(year, DATEDIFF(year, users.valuedate, getdate()), users.valuedate))) - 1 as Days From trainingRegister trainingRegister LEFT OUTER JOIN users users ON trainingRegister.userID=users.userID LEFT OUTER JOIN course course ON  trainingRegister.courseID=course.courseID WHERE trainingRegister.userID=@userID";
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
        public DataSet getLastID()
        {
            strsql = "IF (SELECT TOP(1) trainingRegisterID+1  as lastID FROM trainingRegister ORDER BY trainingRegisterID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) trainingRegisterID+1  as lastID FROM trainingRegister ORDER BY trainingRegisterID DESC";

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
        public Boolean insert(clsTraining clsTraining)
        {
            strsql = "INSERT INTO trainingRegister (";
            strsql += "userID,";
            strsql += "valueDate,";
            strsql += "trainingType,";
            strsql += "courseID,";
            strsql += "generation,";
            strsql += "location,";
            strsql += "cost";
            strsql += ")VALUES(";
            strsql += "@userID,";
            strsql += "@valueDate,";
            strsql += "@trainingType,";
            strsql += "@courseID,";
            strsql += "@generation,";
            strsql += "@location,";
            strsql += "@cost";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsTraining.userID);
                db.AddInParameter(Dbcmd, "@valueDate", DbType.DateTime, clsTraining.valueDate);
                db.AddInParameter(Dbcmd, "@trainingType", DbType.String, clsTraining.trainingType);
                db.AddInParameter(Dbcmd, "@courseID", DbType.String, clsTraining.courseID);
                db.AddInParameter(Dbcmd, "@generation", DbType.Int32, clsTraining.generation);
                db.AddInParameter(Dbcmd, "@location", DbType.String, clsTraining.location);
                db.AddInParameter(Dbcmd, "@cost", DbType.Double, clsTraining.cost);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean update(clsTraining clsTraining)
        {
            strsql = "UPDATE course SET ";
            strsql += "userID=@userID, ";
            strsql += "valueDate=@valueDate, ";
            strsql += "trainingType=@trainingType, ";
            strsql += "courseID=@courseID, ";
            strsql += "generation=@generation, ";
            strsql += "location=@location, ";
            strsql += "cost=@cost ";
            strsql += "WHERE ";
            strsql += "trainingRegisterID=@trainingRegisterID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsTraining.userID);
                db.AddInParameter(Dbcmd, "@valueDate", DbType.DateTime, clsTraining.valueDate);
                db.AddInParameter(Dbcmd, "@trainingType", DbType.String, clsTraining.trainingType);
                db.AddInParameter(Dbcmd, "@courseID", DbType.String, clsTraining.courseID);
                db.AddInParameter(Dbcmd, "@generation", DbType.Int32, clsTraining.generation);
                db.AddInParameter(Dbcmd, "@location", DbType.String, clsTraining.location);
                db.AddInParameter(Dbcmd, "@cost", DbType.Double, clsTraining.cost);
                db.AddInParameter(Dbcmd, "@trainingRegisterID", DbType.Int32, clsTraining.trainingRegisterID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean delete(int trainingRegisterID)
        {
            strsql = "DELETE FROM trainingRegister ";
            strsql += "WHERE ";
            strsql += "trainingRegisterID=@trainingRegisterID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@trainingRegisterID", DbType.Int32, trainingRegisterID);
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