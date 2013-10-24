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
    public partial class quizlist : System.Web.UI.Page
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
        public static string selectAllQuizList()
        {
            comQuiz comQuiz = new comQuiz();
            return utility.GetJSONString(comQuiz.selectAllQuizList().Tables[0]);

        }
        [WebMethod]
        public static string selectAllQuizByQuizListID(int quizListID)
        {
            comQuiz comQuiz = new comQuiz();
            return utility.GetJSONString(comQuiz.selectAllQuizByQuizListID(quizListID).Tables[0]);

        }
        [WebMethod]
        public static string getLastID()
        {
            comQuiz comQuiz = new comQuiz();
            return utility.GetJSONString(comQuiz.getLastID().Tables[0]);

        }
        [WebMethod]
        public static Boolean deleteQuizList(int quizListID)
        {
            comQuiz comQuiz = new comQuiz();
            return comQuiz.deleteQuizList(quizListID);

        }
        [WebMethod]
        public static string getSessionQuiz()
        {
            DataTable dt = new DataTable();

            dt = (DataTable)HttpContext.Current.Session["quiz"];

            if (dt != null)
            {
                return utility.GetJSONString(dt);
            }
            else
            {
                return "{\"Table\" : \"\"}";
            }
        }
        [WebMethod]
        public static void setSessionQuiz(int quizListID)
        {
            DataTable dt = new DataTable();
            comQuiz comQuiz = new comQuiz();
            dt=comQuiz.selectAllQuizByQuizListID(quizListID).Tables[0];
            dt.Columns.Add("quizuid");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["quizuid"] = i;
            }
                HttpContext.Current.Session["quiz"] = dt;
        }
        [WebMethod]
        public static void clearSessionQuiz()
        {
            HttpContext.Current.Session.Remove("quiz");
        }
        [WebMethod]
        public static string saveQuiz(string question, string choice1, string choice2, string choice3, string choice4, string answer, string status, string mode, string quizuid)
        {
            try
            {
                DataTable dt = new DataTable();

                if (HttpContext.Current.Session["quiz"] != null)
                {
                    dt = (DataTable)HttpContext.Current.Session["quiz"];
                }
                else
                {
                    dt.TableName = "Table";
                    dt.Columns.Add("quizuid");
                    dt.Columns.Add("question");
                    dt.Columns.Add("choice1");
                    dt.Columns.Add("choice2");
                    dt.Columns.Add("choice3");
                    dt.Columns.Add("choice4");
                    dt.Columns.Add("answer");
                    dt.Columns.Add("status");
                }


                if (mode != null && mode.Equals("insertQuiz"))
                {
                    DataRow dr = dt.NewRow();
                    dr["quizuid"] = dt.Rows.Count;
                    dr["question"] = question;
                    dr["choice1"] = choice1;
                    dr["choice2"] = choice2;
                    dr["choice3"] = choice3;
                    dr["choice4"] = choice4;
                    dr["answer"] = answer;
                    dr["status"] = status;
                    dt.Rows.Add(dr);
                }
                else if (mode != null && mode.Equals("updateQuiz"))
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (dt.Rows[i]["quizuid"].Equals(quizuid))
                        {
                            dt.Rows[i]["question"] = question;
                            dt.Rows[i]["choice1"] = choice1;
                            dt.Rows[i]["choice2"] = choice2;
                            dt.Rows[i]["choice3"] = choice3;
                            dt.Rows[i]["choice4"] = choice4;
                            dt.Rows[i]["answer"] = answer;
                            dt.Rows[i]["status"] = status;
                        }
                    }
                }
                HttpContext.Current.Session["quiz"] = dt;
                return "true";
            }
            catch
            {
                return "false";

            }

        }
        [WebMethod]
        public static string deleteQuiz(string quizuid)
        {
            try
            {
                DataTable dt = new DataTable();

                if (HttpContext.Current.Session["quiz"] != null)
                {
                    dt = (DataTable)HttpContext.Current.Session["quiz"];
                }
                else
                {
                    dt.TableName = "Table";
                    dt.Columns.Add("quizuid");
                    dt.Columns.Add("question");
                    dt.Columns.Add("choice1");
                    dt.Columns.Add("choice2");
                    dt.Columns.Add("choice3");
                    dt.Columns.Add("choice4");
                    dt.Columns.Add("answer");
                    dt.Columns.Add("status");
                }
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["quizuid"].Equals(quizuid))
                    {
                        dt.Rows.RemoveAt(i);
                    }
                }
                HttpContext.Current.Session["quiz"] = dt;
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
                comQuiz comQuiz = new comQuiz();
                clsQuizList clsQuizList = new clsQuizList();
                clsQuiz clsQuiz = new clsQuiz();
                DataTable dtUSER;
                DataTable dtQuiz;
                dtUSER = (DataTable)Session["USER"];
                if (Session["quiz"] != null)
                {
                    dtQuiz = (DataTable)Session["quiz"];
                }
                else
                {
                    dtQuiz = new DataTable();
                }
                string mode = Request.Form["mode"];
                clsQuizList.quizListID = int.Parse(Request.Form["quizListID"]);
                clsQuizList.userID = (int)dtUSER.Rows[0]["userID"];
                clsQuizList.title = Request.Form["title"];
                clsQuizList.description = Request.Form["description"];
                clsQuizList.dateTimeFrom = DateTime.Parse(Request.Form["dateTimeFrom"]);
                clsQuizList.dateTimeTo = DateTime.Parse(Request.Form["dateTimeTo"]);
                clsQuizList.quizNumber = Request.Form["quizNumber"];
                clsQuizList.numberQuiz = int.Parse(Request.Form["numberQuiz"]);
                clsQuizList.status = int.Parse(Request.Form["status"]);
                clsQuizList.courseID = int.Parse(Request.Form["courseID"]);
                clsQuizList.location = Request.Form["location"];

                if (mode != null && mode.Equals("insert"))
                {
                    int quizListID = int.Parse(Request.Form["quizListID"]);
                    if (comQuiz.insertQuizList(clsQuizList))
                    {
                        for (int i = 0; i < dtQuiz.Rows.Count; i++)
                        {
                            clsQuiz.quizListID = quizListID;
                            clsQuiz.question = dtQuiz.Rows[i]["question"].ToString();
                            clsQuiz.choice1 = dtQuiz.Rows[i]["choice1"].ToString();
                            clsQuiz.choice2 = dtQuiz.Rows[i]["choice2"].ToString();
                            clsQuiz.choice3 = dtQuiz.Rows[i]["choice3"].ToString();
                            clsQuiz.choice4 = dtQuiz.Rows[i]["choice4"].ToString();
                            clsQuiz.answer = int.Parse(dtQuiz.Rows[i]["answer"].ToString());
                            clsQuiz.status = int.Parse(dtQuiz.Rows[i]["status"].ToString());
                            comQuiz.insertQuiz(clsQuiz);
                        }
                    }


                }
                else if (mode != null && mode.Equals("update"))
                {
                    if (comQuiz.updateQuizList(clsQuizList))
                    {
                        comQuiz.deleteQuiz(clsQuizList.quizListID);
                        for (int i = 0; i < dtQuiz.Rows.Count; i++)
                        {
                            clsQuiz.quizListID = clsQuizList.quizListID;
                            clsQuiz.question = dtQuiz.Rows[i]["question"].ToString();
                            clsQuiz.choice1 = dtQuiz.Rows[i]["choice1"].ToString();
                            clsQuiz.choice2 = dtQuiz.Rows[i]["choice2"].ToString();
                            clsQuiz.choice3 = dtQuiz.Rows[i]["choice3"].ToString();
                            clsQuiz.choice4 = dtQuiz.Rows[i]["choice4"].ToString();
                            clsQuiz.answer = int.Parse(dtQuiz.Rows[i]["answer"].ToString());
                            clsQuiz.status = int.Parse(dtQuiz.Rows[i]["status"].ToString());
                            comQuiz.insertQuiz(clsQuiz);
                        }
                    }
                }
                Session.Remove("quiz");
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