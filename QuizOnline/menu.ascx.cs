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
    public partial class menu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            comUsers comUsers = new comUsers();
            DataTable dt;
            int userTypeID;
            dt = (DataTable)Session["USER"];
            userTypeID = Convert.ToInt32(dt.Rows[0]["userTypeID"]);

            if (!comUsers.checkRole(userTypeID, "usertype.aspx"))
            {
                usertype.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "userrole.aspx"))
            {
                userrole.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "users.aspx"))
            {
                users.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "quizlist.aspx"))
            {
                quizlist.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "allquizlist.aspx"))
            {
                allquizlist.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "course.aspx"))
            {
                course.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "traning.aspx"))
            {
                traning.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "certificate.aspx"))
            {
                certificate.Visible = false;
            }
            if (!comUsers.checkRole(userTypeID, "announcement.aspx"))
            {
                announcement.Visible = false;
            }
        }
    }
}