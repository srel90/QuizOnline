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
    public partial class allquizlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            comQuiz comQuiz = new comQuiz();
            comUsers comUsers = new comUsers();

            if (Session["USER"] == null)
            {
                Response.Redirect("default.aspx");
            }

            DataTable dt;
            int userID, userTypeID;
            dt = (DataTable)Session["USER"];
            userID = Convert.ToInt32(dt.Rows[0]["userID"]);
            userTypeID = Convert.ToInt32(dt.Rows[0]["userTypeID"]);
            if (!comUsers.checkRole(userTypeID, Request.ServerVariables["SCRIPT_NAME"]))
            {
                Response.Redirect("nopermission.aspx");
            }
            lbname.Text = dt.Rows[0]["title"].ToString() + " " + dt.Rows[0]["name"].ToString() + " " + dt.Rows[0]["lastname"];
            dt = new DataTable();
            dt = comQuiz.selectTop10QuizListAndStatus().Tables[0];
            quizlist.DataSource = dt;
            quizlist.DataBind();
        }
    }
}