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
    public partial class doquiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Boolean valid = true;
            if (Session["USER"] == null)
            {
                Response.Redirect("default.aspx");
            }
            DataTable userdt;
            userdt = (DataTable)Session["USER"];
            comUsers comUsers = new comUsers();
            DataTable dt;
            int userTypeID;
            dt = (DataTable)Session["USER"];
            userTypeID = Convert.ToInt32(dt.Rows[0]["userTypeID"]);
            userID.Value = dt.Rows[0]["userID"].ToString();
            
            if (!comUsers.checkRole(userTypeID, Request.ServerVariables["SCRIPT_NAME"]))
            {
                Response.Redirect("nopermission.aspx");
            }
            lbname.Text = userdt.Rows[0]["title"].ToString() + " " + userdt.Rows[0]["name"].ToString() + " " + userdt.Rows[0]["lastname"];
            if ((DateTime.Now - DateTime.Parse(userdt.Rows[0]["valueDate"].ToString())).TotalDays < 90)
            {
                valid = false;
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('อายุงานของคุณยังไม่ถึงเกณฑ์ในการทำแบบทดสอบนี้');_Redirect('main.aspx');", true);
            }
            
            if (!this.IsPostBack && !string.IsNullOrWhiteSpace(Request.QueryString["quizListID"])&& valid==true)
            {
                comQuiz comQuiz = new comQuiz();
                comAnswer comAnswer = new comAnswer();
                int quizListID = int.Parse(Request.QueryString["quizListID"]);
                if (comAnswer.checkPass(quizListID, Convert.ToInt32(userdt.Rows[0]["userID"])))
                {
                    valid = false;
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('คุณผ่านการทดสอบนี้แล้วไม่สามารถทำซ้ำได้อีก');_Redirect('main.aspx');", true);
                }
                dt = comAnswer.selectAnswerSheetByQuizListIDAndUserID(quizListID, Convert.ToInt32(userdt.Rows[0]["userID"])).Tables[0];
                if ( dt.Rows.Count!=0 && (DateTime.Now - DateTime.Parse(dt.Rows[0]["valueDate"].ToString())).TotalDays < 90 )
                {
                    valid = false;
                    int dayleft = 90 - Convert.ToInt32((DateTime.Now - DateTime.Parse(dt.Rows[0]["valueDate"].ToString())).TotalDays);
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('คุณยังไม่สามารถเข้าทำแบบทดสอบนี้ได้ กรุณาเข้ามาทำแบบทดสอบในอีก " + dayleft + " วัน');_Redirect('main.aspx');", true);
                }

                dt = new DataTable();
                dt = comQuiz.selectQuizListByID(quizListID).Tables[0];
                title.InnerText = dt.Rows[0]["title"].ToString();
                description.InnerHtml = HttpUtility.HtmlDecode(dt.Rows[0]["description"].ToString());
                dateTimeFrom.InnerText = dt.Rows[0]["dateTimeFrom"].ToString();
                dateTimeTo.InnerText = dt.Rows[0]["dateTimeTo"].ToString();
                quizNumber.InnerText = dt.Rows[0]["quizNumber"].ToString();
                numberQuiz.InnerText = dt.Rows[0]["numberQuiz"].ToString();
                courseID.Value = dt.Rows[0]["courseID"].ToString();
                location.Value = dt.Rows[0]["location"].ToString();
                txtquizListID.Value = quizListID.ToString();
                dt = new DataTable();
                dt = comQuiz.selectAllQuizByQuizListIDAndStatusRandom(quizListID).Tables[0];
                if (dt.Rows.Count != 0)
                {
                    dt.Columns.Add("no");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dt.Rows[i]["no"] = i + 1;
                    }
                    questions.DataSource = dt;
                    questions.DataBind();
                    answers.DataSource = dt;
                    answers.DataBind();
                }
            }
            else if (!this.IsPostBack && string.IsNullOrWhiteSpace(Request.QueryString["quizListID"]) && valid == true)
            {
                Response.Redirect("default.aspx");
            }
            else if (this.IsPostBack&& valid==true)
            {
                save();
            }
        }
        public void save()
        {
            try
            {
                List<int> listValues = new List<int>();
                int quizID;
                int answer;
                int useranswer;
                int correctAnswerNumber = 0;
                comQuiz comQuiz = new comQuiz();
                comAnswer comAnswer = new comAnswer();
                clsAnswerSheet clsAnswerSheet = new clsAnswerSheet();
                clsAnswerSheetDetail clsAnswerSheetDetail = new clsAnswerSheetDetail();
                clsAnswerSheet.quizListID = int.Parse(Request.Form["txtquizListID"]);
                clsAnswerSheet.userID = Convert.ToInt32(((DataTable)Session["USER"]).Rows[0]["userID"]);
                foreach (string key in Request.Form.AllKeys)
                {
                    if (key.StartsWith("a"))
                    {
                        useranswer = int.Parse(Request.Form[key]);
                        quizID = int.Parse(key.Split('a').Last());
                        answer = comQuiz.getCorrectChoiceByQuizID(quizID);
                        if (useranswer == answer)
                        {
                            listValues.Add(1);
                            correctAnswerNumber++;
                        }
                        else
                        {
                            listValues.Add(0);
                        }
                    }

                }
                clsAnswerSheet.correctAnswerNumber = correctAnswerNumber;
                clsAnswerSheet.status = correctAnswerNumber < listValues.Count ? 0 : 1;
                if (comAnswer.insertAnswerSheet(clsAnswerSheet))
                {
                    foreach (string key in Request.Form.AllKeys)
                    {
                        if (key.StartsWith("a"))
                        {
                            useranswer = Convert.ToInt32(Request.Form[key]);
                            quizID = Convert.ToInt32(key.Split('a').Last());
                            answer = comQuiz.getCorrectChoiceByQuizID(quizID);
                            clsAnswerSheetDetail.answerSheetID = int.Parse(comAnswer.getLastID().Tables[0].Rows[0]["LastID"].ToString()) - 1;
                            clsAnswerSheetDetail.quizID = quizID;
                            clsAnswerSheetDetail.userAnswer = useranswer;
                            if (useranswer == answer)
                            {

                                clsAnswerSheetDetail.answerStatus = 1;
                            }
                            else
                            {
                                clsAnswerSheetDetail.answerStatus = 0;
                            }
                            comAnswer.insertAnswerSheetDetail(clsAnswerSheetDetail);
                        }

                    }
                }
                Response.Write("true," + clsAnswerSheet.status);
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