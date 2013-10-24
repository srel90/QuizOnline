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
    public class comUserType : System.Web.UI.Page
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comUserType()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet selectAllUserType()
        {
            strsql = "SELECT * FROM userType";
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
            strsql = "IF (SELECT TOP(1) userTypeID+1  as lastID FROM userType ORDER BY userTypeID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) userTypeID+1  as lastID FROM userType ORDER BY userTypeID DESC";

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
        public Boolean insert(clsUserType clsUserType)
        {
            strsql = "INSERT INTO userType (";
            strsql += "userType,";
            strsql += "status";
            strsql +=")VALUES(";
            strsql += "@userType,";
            strsql += "@status";
            strsql +=")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userType", DbType.String, clsUserType.userType);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUserType.status);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean update(clsUserType clsUserType)
        {
            strsql = "UPDATE userType SET ";
            strsql += "userType=@userType, ";
            strsql += "status=@status ";
            strsql += "WHERE ";
            strsql += "userTypeID=@userTypeID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userType", DbType.String, clsUserType.userType);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUserType.status);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, clsUserType.userTypeID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean delete(int userTypeID)
        {
            strsql = "DELETE FROM userType ";
            strsql += "WHERE ";
            strsql += "userTypeID=@userTypeID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, userTypeID);
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