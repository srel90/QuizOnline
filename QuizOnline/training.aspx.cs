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
    public partial class training : System.Web.UI.Page
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
        public static string selectAllTraining()
        {
            comTraining comTraining = new comTraining();
            return utility.GetJSONString(comTraining.selectAllTraining().Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comTraining comTraining = new comTraining();
            return utility.GetJSONString(comTraining.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean delete(int trainingRegisterID)
        {
            comTraining comTraining = new comTraining();
            return comTraining.delete(trainingRegisterID);

        }
        [WebMethod]
        public static string insert(int userID,string valueDate,string courseID,string location)
        {
            try
            {
            comTraining comTraining = new comTraining();
            clsTraining clsTraining = new clsTraining();
            clsTraining.userID = userID;
            clsTraining.valueDate = DateTime.Parse(valueDate);
            clsTraining.courseID = courseID;
            clsTraining.location = location;
            comTraining.insert(clsTraining);
                return "true";
            }
            catch
            {
                return "false";

            }            
        }
        public void save()
        {
            try
            {
                comTraining comTraining = new comTraining();
                clsTraining clsTraining = new clsTraining();
                string mode = Request.Form["mode"];
                clsTraining.trainingRegisterID = int.Parse(Request.Form["trainingRegisterID"]);
                clsTraining.userID = int.Parse(Request.Form["userID"]);
                clsTraining.valueDate = DateTime.Parse(Request.Form["valueDate"]);
                clsTraining.trainingType = Request.Form["trainingType"];
                clsTraining.courseID = Request.Form["courseID"];
                clsTraining.generation = int.Parse(Request.Form["generation"]);
                clsTraining.location = Request.Form["location"];
                clsTraining.cost = Double.Parse(Request.Form["cost"]);

                if (mode != null && mode.Equals("insert"))
                {

                    comTraining.insert(clsTraining);
                }
                else if (mode != null && mode.Equals("update"))
                {
                    comTraining.update(clsTraining);
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