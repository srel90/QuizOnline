using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuizOnline.component;

namespace QuizOnline
{
    public partial class printtraining : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            comUsers comUsers = new comUsers();

            if (Session["USER"] == null)
            {
                Response.Redirect("default.aspx");
            }

            DataTable dt;
            int userID, userTypeID;
            string name, lastname;
            dt = (DataTable)Session["USER"];
            userID = Convert.ToInt32(dt.Rows[0]["userID"]);
            userTypeID = Convert.ToInt32(dt.Rows[0]["userTypeID"]);
            name = dt.Rows[0]["name"].ToString();
            lastname = dt.Rows[0]["lastname"].ToString();
            if (!comUsers.checkRole(userTypeID, Request.ServerVariables["SCRIPT_NAME"]))
            {
                Response.Redirect("nopermission.aspx");
            }
        }
    }
}