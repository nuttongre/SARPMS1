using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ReportCalendar : System.Web.UI.Page
{
    BTC btc = new BTC();
    protected override void OnPreInit(EventArgs e)
    {
        BTC btc = new BTC();
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            getddlYear();
            getddlMonth();
            getddlDepartment();
            btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
            //btc.CkGroup(ddlSearchDept, ddlSearchEmp, Cookie.GetValue2("ClDept").ToString(), Cookie.GetValue2("ClEmp").ToString());
            getData();
        }
    }
    private void getddlYear()
    {
        BTC btc = new BTC();
        btc.getdllStudyYear(ddlYearB);
        btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
    }
    private void getddlMonth()
    {
        BTC btc = new BTC();
        btc.getddlMonth2(ddlMonth);
        ddlMonth.Items.Insert(0, new ListItem("-ทั้งหมด-", "00"));
    }
    private void getddlDepartment()
    {
        BTC btc = new BTC();
        btc.getddlDepartment(ddlSearchDept);
        ddlSearchDept.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        btc.CkAllDept(ddlSearchDept);
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ClDept", ddlSearchDept.SelectedValue);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        getData();
    }
    private void getData()
    { 
        DataView dv;
        BTC btc = new BTC();
        Connection Conn = new Connection();

        string strSql = " Select ActivityCode, ActivityName, StudyYear, RealSDate As SDate, RealEDate As EDate, '' EmpName, '' DeptName "
                    + " From Activity Where DelFlag = 0  And StudyYear = '" + ddlYearB.SelectedValue + "' "
                    + " And SchoolID = '" + CurrentUser.SchoolID + "'";

        if (ddlMonth.SelectedValue != "00")
        { 
            strSql += " And '" + Convert.ToInt32(ddlMonth.SelectedValue) + "' Between Month(RealSDate) And Month(RealEDate) ";
        }

        if (!string.IsNullOrEmpty(ddlSearchDept.SelectedValue))
        {
            strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                    + " From Activity a, dtAcDept c "
                    + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + ddlYearB.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";

            if (ddlMonth.SelectedValue != "00")
            {
                strSql += " And '" + Convert.ToInt32(ddlMonth.SelectedValue) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
            }
        }
        if (!string.IsNullOrEmpty(ddlSearchEmp.SelectedValue))
        {
            if (string.IsNullOrEmpty(ddlSearchDept.SelectedValue))
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                        + " From Activity a, dtAcEmp c "
                        + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode "
                        + " And a.StudyYear = '" + ddlYearB.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";

                if (ddlMonth.SelectedValue != "00")
                {
                    strSql += " And '" + Convert.ToInt32(ddlMonth.SelectedValue) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
                }
            }
            else
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                            + " From Activity a, dtAcEmp c, dtAcDept d "
                            + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                            + " And a.StudyYear = '" + ddlYearB.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";

                if (ddlMonth.SelectedValue != "00")
                {
                    strSql += " And '" + Convert.ToInt32(ddlMonth.SelectedValue) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
                }
            }
        }
        dv = Conn.Select(string.Format(strSql + " Order By RealSDate"));

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["EmpName"] = btc.getAcEmpName(dv[i]["ActivityCode"].ToString());
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        GridView1.DataSource = dv;
        GridView1.DataBind();

    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ClEmp", ddlSearchEmp.SelectedValue);
        getData();
    }
    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        getData();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        getData();
    }
}
