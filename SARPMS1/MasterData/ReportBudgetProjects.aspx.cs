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

public partial class ReportBudgetProjects : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected override void OnPreInit(EventArgs e)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getddlYear(0);
            //getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
            //btc.getDefault(ddlSearch, "Projects", "ProjectsCode");
            getddlProjects(ddlSearchYear.SelectedValue);
            btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
            btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
            btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
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
            DataBind();
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
        DataView dv = Conn.Select("Select a.ProjectsCode, a.ProjectsName FullName, a.Sort From Projects a, Activity b Where a.DelFlag = 0 And b.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And b.BudgetYear = '" + StudyYear + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' Group By a.ProjectsCode, a.ProjectsName, a.Sort Order By a.Sort");
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
    private void getddlDepartment()
    {
        btc.getddlDepartment(ddlSearchDept);
        ddlSearchDept.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        btc.CkAllDept(ddlSearchDept);
    }
    public override void DataBind()
    {
        string StrSql = "";

        if (ddlSearch.SelectedIndex == 0)
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear,'โครงการ' + a.ProjectsName As FullName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                        + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, '' As AcCode, "
                        + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance, '-' As DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
                }
                else
                {
                    StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
                }

                StrSql += " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

            }
            else
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear,'โครงการ' + a.ProjectsName As FullName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                        + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, '' As AcCode, "
                        + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance, '-' As DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
                }
                else
                {
                    StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
                }

                //+ " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                StrSql += " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' "
                   + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' "
                   + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
            }
        }
        else
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                        + " IsNull(c.TotalAmount, 0) TotalAmount1, "
                        + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
                        + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' As DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
                }
                else
                {
                    StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
                }

                StrSql += " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                   + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' "
                   + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                   + " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "'";

            }
            else
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                        + " IsNull(c.TotalAmount, 0) TotalAmount1, "
                        + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
                        + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' As DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
                }
                else
                {
                    StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
                }

                //+ " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                StrSql += " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' "
                + " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "'";

            }
        }
        if (txtSearch.Text != "")
        {
            StrSql += " And ( a.ProjectsName Like '%" + txtSearch.Text + "%' Or c.ActivityName Like '%" + txtSearch.Text + "%' )  ";
        }
        DataView dv;
        if (ddlSearch.SelectedIndex == 0)
        {
            StrSql += " Group By a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.Df, a.Sort, b.Sort, b.StrategiesName ";
        }
        else
        {
            StrSql += " Group By a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.Df, a.Sort, b.Sort, b.StrategiesName, c.ActivityCode, c.ActivityName, c.TotalAmount, c.TotalAmount2 ";
        }
        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            if (dv[j]["DeptName"].ToString() != "-")
            {
                dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["AcCode"].ToString());
            }
        }
        
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        //----GrandTotal-----------
        if (ddlSearchDept.SelectedIndex == 0)
        {
            StrSql = " Select IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                    + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, "
                    + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (btc.ckIdentityName("ckBudgetYear"))
            {
                StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
            }
            else
            {
                StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
            }
        }
        else
        {
            StrSql = " Select IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                    + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, "
                    + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                    + " And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (btc.ckIdentityName("ckBudgetYear"))
            {
                StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
            }
            else
            {
                StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
            }
        }

        DataView dvTotal = Conn.Select(StrSql);
        ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount1"]).ToString("#,##0.00") : "0.00";
        ToltalBudget2.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount2"]).ToString("#,##0.00") : "0.00";
        TotalBalance.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalBalance"]).ToString("#,##0.00") : "0.00";
        //----EndGrandTotal-----------
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProjects(ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept.SelectedValue);
        DataBind();
    }
    protected void dgSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
    decimal TotalAmount1;
    decimal TotalAmount2;
    decimal TotalAmount3;
    public decimal GetTotalAmount1(decimal Budget)
    {
        TotalAmount1 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount1()
    {
        return TotalAmount1;
    }
    public decimal GetTotalAmount2(decimal Budget)
    {
        TotalAmount2 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount2()
    {
        return TotalAmount2;
    }
    public decimal GetTotalAmount3(decimal Budget)
    {
        TotalAmount3 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount3()
    {
        return TotalAmount3;
    }
    protected string PjOrAcName(string id, string strName)
    {
        if (ddlSearch.SelectedIndex != 0)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"getPopUp(1,'{0}');\" title=\"รายละเอียดกิจกรรม\">{1}</a>", id, strName);
        }
        else
        {
            return string.Format(strName);
        }
    }
}
