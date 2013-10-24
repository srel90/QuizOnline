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
    public partial class course : System.Web.UI.Page
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
        public static string selectAllCourse()
        {
            comCourse comCourse = new comCourse();
            return utility.GetJSONString(comCourse.selectAllCourse().Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comCourse comCourse = new comCourse();
            return utility.GetJSONString(comCourse.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean delete(int ID)
        {
            comCourse comCourse = new comCourse();
            return comCourse.delete(ID);

        }
        public void save()
        {
            try
            {
                comCourse comCourse = new comCourse();
                clsCourse clsCourse = new clsCourse();
                string mode = Request.Form["mode"];
                clsCourse.ID = int.Parse(Request.Form["ID"]);
                clsCourse.courseID = Request.Form["courseID"];
                clsCourse.courseName = Request.Form["courseName"];
                clsCourse.instructor = Request.Form["instructor"];
                clsCourse.trainingType = Request.Form["trainingType"];

                if (mode != null && mode.Equals("insert"))
                {

                    comCourse.insert(clsCourse);
                }
                else if (mode != null && mode.Equals("update"))
                {
                    comCourse.update(clsCourse);
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