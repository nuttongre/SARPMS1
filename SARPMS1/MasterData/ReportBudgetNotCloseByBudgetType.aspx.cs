using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ReportBudgetNotCloseByBudgetType : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btc.LinkReport(linkReport);
            getddlYear(0);
            getddlProjects(ddlSearchYear.SelectedValue);
            btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
            btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
            btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
            getddlReportType();
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        break;
                    case "3":
                        break;
                }
            }
        }
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
    }
    private void getddlProjects(string StudyYear)
    {
        string strSql = " Select a.ProjectsCode, a.ProjectsName FullName, a.Sort "
                + " From Projects a, Activity b Where a.DelFlag = 0 And b.DelFlag = 0 "
                + " And a.ProjectsCode = b.ProjectsCode "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "'  ";

        //if (rbtStudyYear.Checked)
        //{
            strSql += " And b.StudyYear = '" + StudyYear + "' ";
        //}
        //else
        //{
        //    strSql += " And b.BudgetYear = '" + StudyYear + "' ";
        //}
        DataView dv = Conn.Select(strSql + " Group By a.ProjectsCode, a.ProjectsName, a.Sort Order By a.Sort ");
        if (dv.Count != 0)
        {
            ddlSearch.DataSource = dv;
            ddlSearch.DataTextField = "FullName";
            ddlSearch.DataValueField = "ProjectsCode";
            ddlSearch.DataBind();
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch.Enabled = true;
        }
        else
        {
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch.SelectedIndex = 0;
            ddlSearch.Enabled = false;
        }
    }
    private void getddlReportType()
    {
        ddlReportType.Items.Insert(0, new ListItem("รายงานสรุปงาน/กิจกรรมและงบประมาณที่ขออนุมัติดำเนินการ (เงินที่ตั้ง)", "53"));
        ddlReportType.Items.Insert(1, new ListItem("รายงานสรุปการใช้งบประมาณ (เงินที่ใช้ไป)", "52"));
        ddlReportType.SelectedIndex = 0;
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProjects(ddlSearchYear.SelectedValue);       
    }
    //protected void rbtYearType(object sender, EventArgs e)
    //{
    //    getddlProjects(ddlSearchYear.SelectedValue);
    //    if (rbtStudyYear.Checked)
    //    {
    //        lblYear.InnerHtml = "ปีการศึกษา : ";
    //    }
    //    else
    //    {
    //        lblYear.InnerHtml = "ปีงบประมาณ : ";
    //    }
    //}
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept.SelectedValue);
    }
}
