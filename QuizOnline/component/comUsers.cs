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
    public class comUsers : System.Web.UI.Page
    {
        private Database db;
        private DbCommand Dbcmd;
        private DataTable dt;
        private DataSet ds = new DataSet();
        private string strsql;
        public comUsers()
        {
            DatabaseFactory.ClearDatabaseProviderFactory();
            DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());
            db = new DatabaseProviderFactory().Create("connString");
            
        }
        public string checkUser(clsUsers clsUsers)
        {
            strsql = "SELECT * FROM users WHERE username=@username AND password=@password AND status=@status";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@username", DbType.String, clsUsers.username);
                db.AddInParameter(Dbcmd, "@password", DbType.String, clsUsers.password);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, 1);
                dt = db.ExecuteDataSet(Dbcmd).Tables[0];
                if (dt.Rows.Count != 0)
                {
                    Session["USER"] = dt;

                    return "true";
                }
                else
                {
                    return "false";
                }

            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
        public Boolean checkRole(int userTypeID,string fileName)
        {
            strsql = "SELECT * FROM userRole WHERE userTypeID=@userTypeID AND (fileName= @fileName OR fileName='*') AND status=1";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, userTypeID);
                db.AddInParameter(Dbcmd, "@fileName", DbType.String, fileName.TrimStart('/'));

                dt = db.ExecuteDataSet(Dbcmd).Tables[0];
                if (dt.Rows.Count != 0)
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
        public DataSet selectAllUser()
        {
            strsql = "SELECT us.*,ut.userType FROM users us LEFT OUTER JOIN userType ut ON us.userTypeID=ut.userTypeID";
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
        public DataSet selectUsersByUserID(int userID)
        {
            strsql = "SELECT us.*,ut.userType FROM users us LEFT OUTER JOIN userType ut ON us.userTypeID=ut.userTypeID WHERE us.userID=@userID";
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
            strsql = "IF (SELECT TOP(1) userID+1  as lastID FROM users ORDER BY userID DESC) IS NULL SELECT 1 as lastID ELSE SELECT TOP(1) userID+1  as lastID FROM users ORDER BY userID DESC";

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
        public Boolean insert(clsUsers clsUsers)
        {
            strsql = "INSERT INTO users (";
            strsql += "userTypeID,";
            strsql += "IDCard,";
            strsql += "name,";
            strsql += "lastname,";
            strsql += "title,";
            strsql += "username,";
            strsql += "password,";
            strsql += "dateOfBirth,";
            strsql += "valueDate,";
            strsql += "status,";
            strsql += "department,";
            strsql += "position,";
            strsql += "address,";
            strsql += "district,";
            strsql += "subDistrict,";
            strsql += "province,";
            strsql += "zip,";
            strsql += "mobile,";
            strsql += "email,";
            strsql += "photo ";
            strsql += ")VALUES(";
            strsql += "@userTypeID,";
            strsql += "@IDCard,";
            strsql += "@name,";
            strsql += "@lastname,";
            strsql += "@title,";
            strsql += "@username,";
            strsql += "@password,";
            strsql += "@dateOfBirth,";
            strsql += "@valueDate,";
            strsql += "@status,";
            strsql += "@department,";
            strsql += "@position,";
            strsql += "@address,";
            strsql += "@district,";
            strsql += "@subDistrict,";
            strsql += "@province,";
            strsql += "@zip,";
            strsql += "@mobile,";
            strsql += "@email,";
            strsql += "@photo";
            strsql += ")";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, clsUsers.userTypeID);
                db.AddInParameter(Dbcmd, "@IDCard", DbType.String, clsUsers.IDCard);
                db.AddInParameter(Dbcmd, "@name", DbType.String, clsUsers.name);
                db.AddInParameter(Dbcmd, "@lastname", DbType.String, clsUsers.lastname);
                db.AddInParameter(Dbcmd, "@title", DbType.String, clsUsers.title);
                db.AddInParameter(Dbcmd, "@username", DbType.String, clsUsers.username);
                db.AddInParameter(Dbcmd, "@password", DbType.String, clsUsers.password);
                db.AddInParameter(Dbcmd, "@dateOfBirth", DbType.DateTime, clsUsers.dateOfBirth);
                db.AddInParameter(Dbcmd, "@valueDate", DbType.DateTime, clsUsers.valueDate);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUsers.status);
                db.AddInParameter(Dbcmd, "@department", DbType.String, clsUsers.department);
                db.AddInParameter(Dbcmd, "@position", DbType.String, clsUsers.position);
                db.AddInParameter(Dbcmd, "@address", DbType.String, clsUsers.address);
                db.AddInParameter(Dbcmd, "@district", DbType.String, clsUsers.district);
                db.AddInParameter(Dbcmd, "@subDistrict", DbType.String, clsUsers.subDistrict);
                db.AddInParameter(Dbcmd, "@province", DbType.String, clsUsers.province);
                db.AddInParameter(Dbcmd, "@zip", DbType.String, clsUsers.zip);
                db.AddInParameter(Dbcmd, "@mobile", DbType.String, clsUsers.mobile);
                db.AddInParameter(Dbcmd, "@email", DbType.String, clsUsers.email);
                db.AddInParameter(Dbcmd, "@photo", DbType.String, clsUsers.photo);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean update(clsUsers clsUsers)
        {
            strsql = "UPDATE users SET ";
            strsql += "userTypeID=@userTypeID, ";
            strsql += "IDCard=@IDCard, ";
            strsql += "name=@name, ";
            strsql += "lastname=@lastname, ";
            strsql += "title=@title, ";
            strsql += "username=@username, ";
            strsql += "password=@password, ";
            strsql += "dateOfBirth=@dateOfBirth, ";
            strsql += "valueDate=@valueDate, ";
            strsql += "status=@status, ";
            strsql += "department=@department, ";
            strsql += "position=@position, ";
            strsql += "address=@address, ";
            strsql += "district=@district, ";
            strsql += "subDistrict=@subDistrict, ";
            strsql += "province=@province, ";
            strsql += "zip=@zip, ";
            strsql += "mobile=@mobile, ";
            strsql += "email=@email, ";
            strsql += "photo=@photo ";
            strsql += "WHERE ";
            strsql += "userID=@userID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userTypeID", DbType.Int32, clsUsers.userTypeID);
                db.AddInParameter(Dbcmd, "@IDCard", DbType.String, clsUsers.IDCard);
                db.AddInParameter(Dbcmd, "@name", DbType.String, clsUsers.name);
                db.AddInParameter(Dbcmd, "@lastname", DbType.String, clsUsers.lastname);
                db.AddInParameter(Dbcmd, "@title", DbType.String, clsUsers.title);
                db.AddInParameter(Dbcmd, "@username", DbType.String, clsUsers.username);
                db.AddInParameter(Dbcmd, "@password", DbType.String, clsUsers.password);
                db.AddInParameter(Dbcmd, "@dateOfBirth", DbType.DateTime, clsUsers.dateOfBirth);
                db.AddInParameter(Dbcmd, "@valueDate", DbType.DateTime, clsUsers.valueDate);
                db.AddInParameter(Dbcmd, "@status", DbType.Int32, clsUsers.status);
                db.AddInParameter(Dbcmd, "@department", DbType.String, clsUsers.department);
                db.AddInParameter(Dbcmd, "@position", DbType.String, clsUsers.position);
                db.AddInParameter(Dbcmd, "@address", DbType.String, clsUsers.address);
                db.AddInParameter(Dbcmd, "@district", DbType.String, clsUsers.district);
                db.AddInParameter(Dbcmd, "@subDistrict", DbType.String, clsUsers.subDistrict);
                db.AddInParameter(Dbcmd, "@province", DbType.String, clsUsers.province);
                db.AddInParameter(Dbcmd, "@zip", DbType.String, clsUsers.zip);
                db.AddInParameter(Dbcmd, "@mobile", DbType.String, clsUsers.mobile);
                db.AddInParameter(Dbcmd, "@email", DbType.String, clsUsers.email);
                db.AddInParameter(Dbcmd, "@photo", DbType.String, clsUsers.photo);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, clsUsers.userID);
                db.ExecuteNonQuery(Dbcmd);
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Boolean delete(int userID)
        {
            strsql = "DELETE FROM users ";
            strsql += "WHERE ";
            strsql += "userID=@userID";
            try
            {

                Dbcmd = db.GetSqlStringCommand(strsql);
                db.AddInParameter(Dbcmd, "@userID", DbType.Int32, userID);
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