using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuizOnline.entity;
using QuizOnline.component;
using System.Data;

namespace QuizOnline
{
    public partial class users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER"] == null)
            {
                Response.Redirect("default.aspx");
            }
            comUsers comUsers = new comUsers();
            DataTable dt;
            int userTypeID;
            dt = (DataTable)Session["USER"];
            userTypeID = Convert.ToInt32(dt.Rows[0]["userTypeID"]);
            if (!comUsers.checkRole(userTypeID, Request.ServerVariables["SCRIPT_NAME"]))
            {
                Response.Redirect("nopermission.aspx");
            }
            lbname.Text = dt.Rows[0]["title"].ToString()+" "+dt.Rows[0]["name"].ToString()+" "+dt.Rows[0]["lastname"];
            initial();
            if (this.IsPostBack)
            {
                save();
            }
        }
        [WebMethod]
        public static string selectAllUsers()
        {
            comUsers comUsers = new comUsers();
            return utility.GetJSONString(comUsers.selectAllUser().Tables[0]);

        }
        [WebMethod]
        public static string selectUsersByUserID(int userID)
        {
            comUsers comUsers = new comUsers();
            return utility.GetJSONString(comUsers.selectUsersByUserID(userID).Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comUsers comUsers = new comUsers();
            return utility.GetJSONString(comUsers.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean delete(int userID)
        {
            comUsers comUsers = new comUsers();
            return comUsers.delete(userID);

        }
        public void initial()
        {
            comUserType comUserType = new comUserType();
            DataSet ds = new DataSet();
            ds = comUserType.selectAllUserType();
            userTypeID.DataSource = ds.Tables[0];
            userTypeID.DataTextField = "userType";
            userTypeID.DataValueField = "userTypeID";
            userTypeID.DataBind();

        }
        public void save()
        {
            try
            {
                comUsers comUsers = new comUsers();
                clsUsers clsUsers = new clsUsers();
                string mode = Request.Form["mode"];
                clsUsers.userTypeID = int.Parse(Request.Form["userTypeID"]);
                clsUsers.IDCard = Request.Form["IDCard"];
                clsUsers.name = Request.Form["name"];
                clsUsers.lastname = Request.Form["lastname"];
                clsUsers.title = Request.Form["title"];
                clsUsers.username = Request.Form["username"];
                clsUsers.password = utility.MD5(Request.Form["password"]);
                clsUsers.dateOfBirth = DateTime.Parse(Request.Form["dateOfBirth"]);
                clsUsers.valueDate = DateTime.Parse(Request.Form["valueDate"]);
                clsUsers.status = int.Parse(Request.Form["status"]);
                clsUsers.department = Request.Form["department"];
                clsUsers.position = Request.Form["position"];
                clsUsers.address = Request.Form["address"];
                clsUsers.district = Request.Form["district"];
                clsUsers.subDistrict = Request.Form["subDistrict"];
                clsUsers.province = Request.Form["province"];
                clsUsers.zip = Request.Form["zip"];
                clsUsers.mobile = Request.Form["mobile"];
                clsUsers.email = Request.Form["email"];
                clsUsers.photo = Request.Form["photo"];
                clsUsers.userID = int.Parse(Request.Form["userID"]);

                if (mode != null && mode.Equals("insert"))
                {

                    comUsers.insert(clsUsers);
                }
                else if (mode != null && mode.Equals("update"))
                {
                    comUsers.update(clsUsers);
                }
                Response.Write("true");
            }
            catch
            {
                Response.Write("false");

            }
            finally
            {
                Response.End();
            }
        }
    }
}