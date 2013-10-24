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
    public partial class userrole : System.Web.UI.Page
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
            lbname.Text = dt.Rows[0]["title"].ToString() + " " + dt.Rows[0]["name"].ToString() + " " + dt.Rows[0]["lastname"];
            initial();
            if (this.IsPostBack)
            {
                save();
            }
        }
        [WebMethod]
        public static string selectAllUserRole()
        {
            comUserRole comUserRole = new comUserRole();
            return utility.GetJSONString(comUserRole.selectAllUserRole().Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comUserRole comUserRole = new comUserRole();
            return utility.GetJSONString(comUserRole.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean delete(int userRoleID)
        {
            comUserRole comUserRole = new comUserRole();
            return comUserRole.delete(userRoleID);

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
                comUserRole comUserRole = new comUserRole();
                clsUserRole clsUserRole = new clsUserRole();
                string mode = Request.Form["mode"];
                clsUserRole.userTypeID = int.Parse(Request.Form["userTypeID"]);
                clsUserRole.fileName = Request.Form["fileName"];
                clsUserRole.status = int.Parse(Request.Form["status"]);
                clsUserRole.userRoleID = int.Parse(Request.Form["userRoleID"]);

                if (mode != null && mode.Equals("insert"))
                {

                    comUserRole.insert(clsUserRole);
                }
                else if (mode != null && mode.Equals("update"))
                {
                    comUserRole.update(clsUserRole);
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