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
    public class comUserRole : System.Web.UI.Page
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds;
        private string strsql;
        public comUserRole()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
        }
        public DataSet selectAllUserRole()
        {
            strsql = "SELECT ur.*,ut.userType FROM userRole ur LEFT OUTER JOIN userType ut ON ur.userTypeID=ut.userTypeID";
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
            strsql = "IF (SELECT TOP(1) userRoleID+1  as lastID FROM userRole ORDER BY userRoleID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) userRoleID+1  as lastID FROM userRole ORDER BY userRoleID DESC";

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
        public Boolean insert(clsUserRole clsUserRole)
        {
            strsql = "INSERT INTO userRole (";
            strsql += "userTypeID,";
            strsql += "fileName,";
            strsql += "status ";
            strsql += ")VALUES(";
            strsql += "@userTypeID,";
            strsql += "@fileName,";
            strsql += "@status";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, clsUserRole.userTypeID);
                db.AddInParameter(Dbcmd, "@fileName", DbType.String, clsUserRole.fileName);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUserRole.status);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean update(clsUserRole clsUserRole)
        {
            strsql = "UPDATE userRole SET ";
            strsql += "userTypeID=@userTypeID, ";
            strsql += "fileName=@fileName, ";
            strsql += "status=@status ";
            strsql += "WHERE ";
            strsql += "userRoleID=@userRoleID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, clsUserRole.userTypeID);
                db.AddInParameter(Dbcmd, "@fileName", DbType.String, clsUserRole.fileName);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUserRole.status);
                db.AddInParameter(Dbcmd, "@userRoleID", DbType.Int32, clsUserRole.userRoleID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean delete(int userRoleID)
        {
            strsql = "DELETE FROM userRole ";
            strsql += "WHERE ";
            strsql += "userRoleID=@userRoleID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userRoleID", DbType.Int32, userRoleID);
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