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
using System.Collections;

namespace QuizOnline
{
    public partial class announcement : System.Web.UI.Page
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
            else
            {
            string text = System.IO.File.ReadAllText(@AppDomain.CurrentDomain.BaseDirectory+"announcement.html");
            txtannouncement.Value = HttpUtility.HtmlDecode(text);
            }
        }
        public void save()
        {
            try
            {
                System.IO.File.WriteAllText(@AppDomain.CurrentDomain.BaseDirectory + "announcement.html", HttpUtility.HtmlDecode(Request.Form["txtannouncement"]),System.Text.Encoding.UTF8);
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