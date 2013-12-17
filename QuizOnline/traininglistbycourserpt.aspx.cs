using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using QuizOnline.component;

namespace QuizOnline
{
    public partial class traininglistbycourserpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String courseID =Request.QueryString["courseID"];
                comTraining comTraining = new comTraining();
                DataSet ds = new DataSet();
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/report/traininglistbycourse.rdlc");
                ds = comTraining.selectTrainingListBycourseID(courseID);
                ReportDataSource datasource = new ReportDataSource("DataSet1", ds.Tables[0]);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(datasource);
            }
        }
    }
}