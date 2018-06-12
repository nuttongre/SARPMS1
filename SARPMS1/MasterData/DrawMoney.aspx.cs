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
using Star.Web.UI.Controls;

using System.Collections.Generic;
using System.Linq;
using System.Web.Services.Protocols;
using System.IO;
using System.Xml;


public partial class DrawMoney : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount1 = 0;
    decimal TotalAmount2 = 0;
    decimal TotalAmount3 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            btc.LinkReport(linkReport);

            //àªç¤»Õ§º»ÃÐÁÒ³
            btc.ckBudgetYear(lblSearchYear, null);

            Cookie.SetValue2("ckActivityStatus", btc.ckIdentityName("ckActivityStatus")); //àªç¤âËÁ´µÔ´µÒÁ§Ò¹

            string mode = Request.QueryString["mode"];
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
            else
            {
                getddlYear(0);
                //getddlStrategies(0, ddlSearchYear.SelectedValue);
                getddlProjects(0, ddlSearchYear.SelectedValue, "");
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                DataBind();
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
    //private void getddlStrategies(int mode, string StudyYear)
    //{
    //    if (mode == 0)
    //    {
    //        btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));          
    //    }
    //}
    private void getddlProjects(int mode, string StudyYear, string StrategiesCode)
    {
        if (mode == 0)
        {
            btc.getddlProjects(0, ddlSearch, StudyYear, StrategiesCode, Cookie.GetValue2("ckProjectsCode"));
        }
    }
    protected string DateFormat(object startDate, object endDate)
    {
        return Convert.ToDateTime(startDate).ToString("dd/MM/yy") + " - " + Convert.ToDateTime(endDate).ToString("dd/MM/yy");
    }
    public override void DataBind()
    {
        string strSql = @" Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, b.ApproveFlag, 
        b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, 0.0 As TotalBalance, 
        IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus, 
        a.Sort As SortPrj, b.Sort As SortAc
        From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
        Left Join Activity b On a.ProjectsCode = b.ProjectsCode
        Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
        Left Join Employee d On PD.EmpID = d.EmpID  
        Left Join Employee Ep On a.CreateUser = Ep.EmpID
        Left Join Department e On a.DeptCode = e.DeptCode
        Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
        Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
        Where b.DelFlag = 0 And ApproveFlag = 1 And a.StudyYear = '{0}' And b.SchoolID = '{1}' ";

        //string StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
        //            + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, 0.0 As TotalBalance, "
        //            + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus "
        //            + " From Projects a, Activity b "
        //            + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
        //            + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //if (ddlSearchDept.SelectedIndex != 0)
        //{
        //    StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
        //            + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, 0.0 As TotalBalance, "
        //            + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus "
        //            + " From Projects a, Activity b, dtAcDept c "
        //            + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
        //            + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
        //            + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        //}
        //if (ddlSearchEmp.SelectedIndex != 0)
        //{
        //    if (ddlSearchDept.SelectedIndex == 0)
        //    {
        //        StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
        //                + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, 0.0 As TotalBalance, "
        //                + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus "
        //                + " From Projects a, Activity b, dtAcEmp c "
        //                + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
        //                + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
        //    }
        //    else
        //    {
        //        StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
        //                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, 0.0 As TotalBalance, "
        //                    + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus "
        //                    + " From Projects a, Activity b, dtAcEmp c, dtAcDept d "
        //                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And b.ActivityCode = d.ActivityCode "
        //                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        //    }
        //}
        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    strSql += " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            strSql += " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "'";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            strSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            strSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchDept.SelectedIndex != 0)
        {
            strSql += " And e.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            strSql += " And a.CreateUser = '" + ddlSearchEmp.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            strSql += " And b.ActivityName Like '%" + txtSearch.Text + "%' ";
        }
        strSql += @" Group By a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, b.Status, b.Df, b.ApproveFlag, 
        b.CostsType, b.TotalAmount, b.TotalAmount2, b.Term, b.YearB, b.ActivityStatus, a.Sort, b.Sort
        Order By a.Sort Desc, b.Sort Desc ";
        DataView dv = Conn.Select(string.Format(strSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        for (int j = 0; j < dv.Count; j++)
        {
            decimal TtAmount2 = Convert.ToDecimal(btc.getNTotalAmount(dv[j]["ActivityCode"].ToString()));
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());

            if (TtAmount2 != 0)
            {
                dv[j]["TotalAmount2"] = TtAmount2.ToString();
            }
            dv[j]["TotalBalance"] = (Convert.ToDecimal(dv[j]["TotalAmount"]) - Convert.ToDecimal(dv[j]["TotalAmount2"])).ToString();
        }

        //àªç¤¼ÅÃÇÁ
        try
        {
            DataTable dt = dv.ToTable();
            TotalAmount1 = Convert.ToDecimal(dt.Compute("Sum(TotalAmount)", dv.RowFilter));
            TotalAmount2 = Convert.ToDecimal(dt.Compute("Sum(TotalAmount2)", dv.RowFilter));
            TotalAmount3 = Convert.ToDecimal(dt.Compute("Sum(TotalBalance)", dv.RowFilter));
        }
        catch (Exception ex)
        { 
        }

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        //----GrandTotal-----------
        //strSql = "Select a.ActivityCode, IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //            + " From Activity a, Projects b "
        //            + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ApproveFlag = 1 "
        //            + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //if (ddlSearchDept.SelectedIndex != 0)
        //{
        //    strSql = "Select a.ActivityCode, IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //            + " From Activity a, Projects b, dtAcDept c "
        //            + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ApproveFlag = 1 "
        //            + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //            + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        //}
        //if (ddlSearchEmp.SelectedIndex != 0)
        //{
        //    if (ddlSearchDept.SelectedIndex == 0)
        //    {
        //        strSql = "Select a.ActivityCode, IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //                + " From Activity a, Projects b, dtAcEmp c "
        //                + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ApproveFlag = 1 "
        //                + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
        //    }
        //    else
        //    {
        //        strSql = "Select a.ActivityCode, IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //                    + " From Activity a, Projects b, dtAcEmp c, dtAcDept d "
        //                    + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode And a.ApproveFlag = 1 "
        //                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        //    }
        //}

        strSql = @" Select b.ActivityCode, IsNull(Sum(b.TotalAmount), 0) TotalAmount, IsNull(Sum(b.TotalAmount2), 0) TotalAmount2
        From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
        Left Join Activity b On a.ProjectsCode = b.ProjectsCode
        Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
        Left Join Employee d On PD.EmpID = d.EmpID  
        Left Join Employee Ep On a.CreateUser = Ep.EmpID
        Left Join Department e On a.DeptCode = e.DeptCode
        Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
        Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
        Where b.DelFlag = 0 And ApproveFlag = 1 And a.StudyYear = '{0}' And b.SchoolID = '{1}' ";

        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    strSql += " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            strSql += " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "'";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            strSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            strSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchDept.SelectedIndex != 0)
        {
            strSql += " And e.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            strSql += " And a.CreateUser = '" + ddlSearchEmp.SelectedValue + "'";
        }

        DataView dvTotal = Conn.Select(string.Format(strSql + " Group By b.ActivityCode ", ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        for (int j = 0; j < dvTotal.Count; j++)
        {
            decimal TtAmount2 = Convert.ToDecimal(btc.getNTotalAmount(dvTotal[j]["ActivityCode"].ToString()));

            if (TtAmount2 != 0)
            {
                dvTotal[j]["TotalAmount2"] = TtAmount2.ToString();
            }
        }

        try
        {
            DataTable dt = dvTotal.ToTable();
            ToltalBudget.InnerHtml = Convert.ToDecimal(dt.Compute("Sum(TotalAmount)", dvTotal.RowFilter)).ToString("#,##0.00");
            ToltalBudget2.InnerHtml = Convert.ToDecimal(dt.Compute("Sum(TotalAmount2)", dvTotal.RowFilter)).ToString("#,##0.00");
            TotalBalance.InnerHtml = (Convert.ToDecimal(ToltalBudget.InnerHtml) - Convert.ToDecimal(ToltalBudget2.InnerHtml)).ToString("#,##0.00");
        }
        catch (Exception ex)
        {
        }
        //----EndGrandTotal-----------
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        //getddlStrategies(0, ddlSearchYear.SelectedValue);
        getddlProjects(0, ddlSearchYear.SelectedValue, "");
        DataBind();
    }
    //protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
    //    getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
    //    DataBind();
    //}
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckProjectsCode", ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept.SelectedValue);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckEmpID", ddlSearchEmp.SelectedValue);
        DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalBalance").ToString()) == 0)
            {
                e.Row.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalBalance").ToString()) > 0)
                {
                    e.Row.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    e.Row.ForeColor = System.Drawing.Color.Red;
                }
            }       
        }
    }
    public decimal GetTotalAmount1(decimal Budget)
    {
        //TotalAmount1 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount1()
    {
        return TotalAmount1;
    }
    public decimal GetTotalAmount2(decimal Budget)
    {
        //TotalAmount2 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount2()
    {
        return TotalAmount2;
    }
    public decimal GetTotalAmount3(decimal Budget)
    {
        //TotalAmount3 += Budget;
        return Budget;
    }
    public decimal GetSumTotalAmount3()
    {
        return TotalAmount3;
    }
    protected string getActivityStatus(string ActivityStatus)
    {
        return btc.getSpanColorStatus(Convert.ToBoolean(Cookie.GetValue2("ckActivityStatus")), ActivityStatus);
    }
}
