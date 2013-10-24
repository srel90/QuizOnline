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
    public partial class usertype : System.Web.UI.Page
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
            if (this.IsPostBack)
            {
                save();
            }
        }
        [WebMethod]
        public static string selectAllUserType()
        {
            comUserType comUserType = new comUserType();
            return utility.GetJSONString(comUserType.selectAllUserType().Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comUserType comUserType = new comUserType();
            return utility.GetJSONString(comUserType.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean delete(int userTypeID)
        {
            comUserType comUserType = new comUserType();
            return comUserType.delete(userTypeID);

        }
        public void save()
        {
            try
            {
                comUserType comUserType = new comUserType();
                clsUserType clsUserType = new clsUserType();
                string mode = Request.Form["mode"];
                clsUserType.userType = Request.Form["userType"];
                clsUserType.status = int.Parse(Request.Form["status"]);
                clsUserType.userTypeID = int.Parse(Request.Form["userTypeID"]);

                if (mode != null && mode.Equals("insert"))
                {
                    
                    comUserType.insert(clsUserType);
                }
                else if (mode != null && mode.Equals("update"))
                {
                    comUserType.update(clsUserType);
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