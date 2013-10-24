using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuizOnline.entity;
using QuizOnline.component;
namespace QuizOnline
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string checkUser(string username,string password)
        {
            clsUsers clsUsers = new clsUsers();
            comUsers comUser = new comUsers();

            clsUsers.username = username;
            clsUsers.password = utility.MD5(password);
            
            return comUser.checkUser(clsUsers).ToString();

        }
    }
}