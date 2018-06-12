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

public partial class CutBudget : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount1 = 0;
    decimal TotalAmount2 = 0;
    decimal TotalAmount3 = 0;

    protected override void OnInit(EventArgs e)
    {
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "javascript", "function loadPage(){" + Page.ClientScript.GetPostBackEventReference(btAutoRefresh, null, false) + ";}", true);
        base.OnInit(e);
    }
    protected override void OnPreInit(EventArgs e)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "setupRefresh();", true);
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
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
                getddlProjectsNotStrategies(ddlSearchYear.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
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
    private void getddlProjectsNotStrategies(string StudyYear)
    {
        int mode = 0;
        DataView dv = new BTC().getddlProjectsNotStrategies(StudyYear, mode);
        if (dv.Count != 0)
        {
            ddlSearchProjects.DataSource = dv;
            ddlSearchProjects.DataTextField = "FullName";
            ddlSearchProjects.DataValueField = "ProjectsCode";
            ddlSearchProjects.DataBind();
            ddlSearchProjects.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));

            if (Cookie.GetValue2("ckProjectsCode") == null)
            {
                ddlSearchProjects.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddlSearchProjects.SelectedValue = Cookie.GetValue2("ckProjectsCode").ToString();
                }
                catch (Exception ex)
                {
                    ddlSearchProjects.SelectedIndex = 0;
                }
            }
        }
        else
        {
            ddlSearchProjects.Items.Clear();
            ddlSearchProjects.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearchProjects.SelectedIndex = 0;
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select b.ActivityCode AcCode, 'กิจกรรม' + b.ActivityName As FullName, b.Status,  
        IsNull(b.TotalAmount, 0) TotalAmount1, IsNull(b.TotalAmount2, 0) TotalAmount2, (IsNull(b.TotalAmount, 0) - IsNull(b.TotalAmount2, 0)) TotalBalance, 
        '' As DeptName, IsNull(b.ApproveFlag, 0) ApproveFlag, b.UpdateDate
        From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
        Left Join Activity b On a.ProjectsCode = b.ProjectsCode 
        Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
        Left Join Department e On a.DeptCode = e.DeptCode
        Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
        Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
        Where b.DelFlag = 0 And b.SchoolID = '{0}' And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And e.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql += " And b.ActivityName Like '%" + txtSearch.Text + "%'  ";
        }
        if (ddlSearchProjects.SelectedIndex != 0)
        {
            StrSql += " And b.ProjectsCode = '" + ddlSearchProjects.SelectedValue + "' ";
        }
        StrSql += " Group By b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, b.Status, b.ApproveFlag, b.UpdateDate ";

        //if (ddlSearchDept.SelectedIndex == 0)
        //{
        //    StrSql = " Select c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, c.Status, "
        //            + " IsNull(c.TotalAmount, 0) TotalAmount1, "
        //            + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
        //            + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' As DeptName, IsNull(c.ApproveFlag, 0) ApproveFlag, c.UpdateDate "
        //            + " From Activity c "
        //            + " Where c.DelFlag = 0 "
        //            + " And c.SchoolID = '" + CurrentUser.SchoolID + "' ";

        //    if (rbtStudyYear.Checked)
        //    {
        //        StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
        //    }

        //    if (txtSearch.Text != "")
        //    {
        //        StrSql = StrSql + " And c.ActivityName Like '%" + txtSearch.Text + "%'  ";
        //    }
        //    if (ddlSearchProjects.SelectedIndex != 0)
        //    {
        //        StrSql = StrSql + " And c.ProjectsCode = '" + ddlSearchProjects.SelectedValue + "' ";
        //    }

        //    StrSql = StrSql + " Group By c.ActivityCode, c.ActivityName, c.TotalAmount, c.TotalAmount2, c.Status, c.ApproveFlag, c.UpdateDate ";
        //}
        //else
        //{
        //    StrSql = " Select c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, c.Status, "
        //            + " IsNull(c.TotalAmount, 0) TotalAmount1, "
        //            + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
        //            + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' As DeptName, IsNull(c.ApproveFlag, 0) ApproveFlag, c.UpdateDate "
        //            + " From Activity c, dtAcDept d "
        //            + " Where c.DelFlag = 0 And c.ActivityCode = d.ActivityCode "
        //            + " And c.SchoolID = '" + CurrentUser.SchoolID + "' "
        //            + " And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";

        //    if (rbtStudyYear.Checked)
        //    {
        //        StrSql += " And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And c.BudgetYear = '" + ddlSearchYear.SelectedValue + "' ";
        //    }

        //    if (txtSearch.Text != "")
        //    {
        //        StrSql = StrSql + " And c.ActivityName Like '%" + txtSearch.Text + "%'  ";
        //    }
        //    if (ddlSearchProjects.SelectedIndex != 0)
        //    {
        //        StrSql = StrSql + " And c.ProjectsCode = '" + ddlSearchProjects.SelectedValue + "' ";
        //    }
        //}
        DataView dv = Conn.Select(string.Format(StrSql, CurrentUser.SchoolID));
        if (dv.Count != 0)
        {
            for (int j = 0; j < dv.Count; j++)
            {
                dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["AcCode"].ToString());
            }
        }

        //เช็คผลรวม
        try
        {
            DataTable dt = dv.ToTable();
            TotalAmount1 = Convert.ToDecimal(dt.Compute("Sum(TotalAmount1)", dv.RowFilter));
            TotalAmount2 = Convert.ToDecimal(dt.Compute("Sum(TotalAmount2)", dv.RowFilter));
            TotalAmount3 = Convert.ToDecimal(dt.Compute("Sum(TotalBalance)", dv.RowFilter));
        }
        catch (Exception ex)
        { 
        }

            GridView1.DataSource = dv;
            lblSearchTotal.InnerText = dv.Count.ToString();
            GridView1.DataBind();
        
        getBudget();

        //----GrandTotal-----------
        if (ddlSearchDept.SelectedIndex == 0)
        {
            StrSql = " Select "
                    + " IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                    + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, "
                    + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
                    + " From Activity c "
                    + " Where c.DelFlag = 0  "
                    + " And c.SchoolID = '" + CurrentUser.SchoolID + "' And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        }
        else
        {
            StrSql = " Select "
                    + " IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
                    + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, "
                    + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
                    + " From Activity c, dtAcDept d "
                    + " Where c.DelFlag = 0 And c.ActivityCode = d.ActivityCode "
                    + " And c.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        }

        DataView dvTotal = Conn.Select(StrSql);
        ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount1"]).ToString("#,##0.00") : "0.00";
        ToltalBudget2.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount2"]).ToString("#,##0.00") : "0.00";
        TotalBalance.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalBalance"]).ToString("#,##0.00") : "0.00";

        StrSql = @" Select IsNull(Sum(I.Subsidies), 0) Subsidies, IsNull(Sum(I.Revenue), 0) Revenue, IsNull(Sum(I.Reserve), 0) Reserve, 
                    IsNull(Sum(I.Free), 0) Free, IsNull(Sum(I.Other), 0) Other, IsNull((Sum(I.Subsidies) + Sum(I.Revenue) + Sum(I.Reserve) + Sum(I.Free)), 0) As TotalAmount  
                    From Income I Inner Join Department D On I.DeptCode = D.DeptCode
                    Inner Join MainSubDepartment MD On D.MainSubDeptCode = MD.MainSubDeptCode
                    Where I.DelFlag = 0 And I.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And I.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }
        DataView dvIncome = Conn.Select(string.Format(StrSql));
        if (dvIncome.Count > 0)
        {
            lblInComeSubsidies.Text = Convert.ToDecimal(dvIncome[0]["Subsidies"]).ToString("#,##0.00");
            lblInComeRevenue.Text = Convert.ToDecimal(dvIncome[0]["Revenue"]).ToString("#,##0.00");
            lblInComeFree.Text = Convert.ToDecimal(dvIncome[0]["Free"]).ToString("#,##0.00");
            lblInComeReserve.Text = Convert.ToDecimal(dvIncome[0]["Reserve"]).ToString("#,##0.00");
            lblInComeTotal.Text = Convert.ToDecimal(dvIncome[0]["TotalAmount"]).ToString("#,##0.00");
        }
        else
        {
            lblInComeSubsidies.Text = "0.00";
            lblInComeRevenue.Text = "0.00";
            lblInComeFree.Text = "0.00";
            lblInComeReserve.Text = "0.00";
            lblInComeTotal.Text = "0.00";
        }

        //----EndGrandTotal----------
    }
    private void getBudget()
    {
        //เงินรายจ่าย
        string StrSql = " Select IsNull(Sum(TotalMoney),0) TotalMoney, IsNull(Sum(TotalMoney2),0) TotalMoney2 "
                    + " From Activity b, CostsDetail c, BudgetType d, dtAcDept dt, Department dp, MainSubDepartment MD "
                    + " Where b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And c.BudgetTypeCode = d.BudgetTypeCode "
                    + " And b.ActivityCode = dt.ActivityCode And dt.DeptCode = dp.DeptCode And dp.MainSubDeptCode = MD.MainSubDeptCode "
                    + " And d.ckType = 1 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And dp.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }

        DataView dvOutSubsidies = Conn.Select(string.Format(StrSql));
        if (dvOutSubsidies.Count > 0)
        {
            lblSetSubsidies.Text = Convert.ToDecimal(dvOutSubsidies[0]["TotalMoney"]).ToString("#,##0.00");
            lblOutSubsidies.Text = Convert.ToDecimal(dvOutSubsidies[0]["TotalMoney2"]).ToString("#,##0.00");
        }

        StrSql = " Select IsNull(Sum(TotalMoney),0) TotalMoney, IsNull(Sum(TotalMoney2),0) TotalMoney2 "
                    + " From Activity b, CostsDetail c, BudgetType d, dtAcDept dt, Department dp, MainSubDepartment MD "
                    + " Where b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And c.BudgetTypeCode = d.BudgetTypeCode "
                    + " And b.ActivityCode = dt.ActivityCode And dt.DeptCode = dp.DeptCode And dp.MainSubDeptCode = MD.MainSubDeptCode "
                    + " And d.ckType = 2 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And dp.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }

        DataView dvOutRevenue = Conn.Select(string.Format(StrSql));
        if (dvOutRevenue.Count > 0)
        {
            lblSetRevenue.Text = Convert.ToDecimal(dvOutRevenue[0]["TotalMoney"]).ToString("#,##0.00");
            lblOutRevenue.Text = Convert.ToDecimal(dvOutRevenue[0]["TotalMoney2"]).ToString("#,##0.00");
        }

        StrSql = " Select IsNull(Sum(TotalMoney),0) TotalMoney, IsNull(Sum(TotalMoney2),0) TotalMoney2 "
                    + " From Activity b, CostsDetail c, BudgetType d, dtAcDept dt, Department dp, MainSubDepartment MD "
                    + " Where b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And c.BudgetTypeCode = d.BudgetTypeCode "
                    + " And b.ActivityCode = dt.ActivityCode And dt.DeptCode = dp.DeptCode And dp.MainSubDeptCode = MD.MainSubDeptCode "
                    + " And d.ckType = 3 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And dp.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }

        DataView dvOutFree = Conn.Select(string.Format(StrSql));
        if (dvOutFree.Count > 0)
        {
            lblSetFree.Text = Convert.ToDecimal(dvOutFree[0]["TotalMoney"]).ToString("#,##0.00");
            lblOutFree.Text = Convert.ToDecimal(dvOutFree[0]["TotalMoney2"]).ToString("#,##0.00");
        }

        StrSql = " Select IsNull(Sum(TotalMoney),0) TotalMoney, IsNull(Sum(TotalMoney2),0) TotalMoney2 "
                    + " From Activity b, CostsDetail c, BudgetType d, dtAcDept dt, Department dp, MainSubDepartment MD "
                    + " Where b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And c.BudgetTypeCode = d.BudgetTypeCode "
                    + " And b.ActivityCode = dt.ActivityCode And dt.DeptCode = dp.DeptCode And dp.MainSubDeptCode = MD.MainSubDeptCode "
                    + " And d.ckType = 5 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And dp.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }

        DataView dvOutOther = Conn.Select(string.Format(StrSql));
        if (dvOutOther.Count > 0)
        {
            lblSetOther.Text = Convert.ToDecimal(dvOutOther[0]["TotalMoney"]).ToString("#,##0.00");
            lblOutOther.Text = Convert.ToDecimal(dvOutOther[0]["TotalMoney2"]).ToString("#,##0.00");
        }
        lblSetTotal.Text = (Convert.ToDecimal(lblSetSubsidies.Text) + Convert.ToDecimal(lblSetRevenue.Text) + Convert.ToDecimal(lblSetFree.Text) + Convert.ToDecimal(lblSetOther.Text)).ToString("#,##0.00");
        lblTotalOut.Text = (Convert.ToDecimal(lblOutSubsidies.Text) + Convert.ToDecimal(lblOutRevenue.Text) + Convert.ToDecimal(lblOutFree.Text) + Convert.ToDecimal(lblOutOther.Text)).ToString("#,##0.00");

        lblBalanceSubsidies.Text = (Convert.ToDecimal(lblSetSubsidies.Text) - Convert.ToDecimal(lblOutSubsidies.Text)).ToString("#,##0.00");
        lblBalanceRevenue.Text = (Convert.ToDecimal(lblSetRevenue.Text) - Convert.ToDecimal(lblOutRevenue.Text)).ToString("#,##0.00");
        lblBalanceFree.Text = (Convert.ToDecimal(lblSetFree.Text) - Convert.ToDecimal(lblOutFree.Text)).ToString("#,##0.00");
        lblBalanceOther.Text = (Convert.ToDecimal(lblSetOther.Text) - Convert.ToDecimal(lblOutOther.Text)).ToString("#,##0.00");

        lblTotalBalance.Text = (Convert.ToDecimal(lblBalanceSubsidies.Text) + Convert.ToDecimal(lblBalanceRevenue.Text) + Convert.ToDecimal(lblBalanceFree.Text) + Convert.ToDecimal(lblBalanceOther.Text)).ToString("#,##0.00");

        btc.lblColor(lblBalanceSubsidies, Convert.ToDecimal(lblBalanceSubsidies.Text));
        btc.lblColor(lblBalanceRevenue, Convert.ToDecimal(lblBalanceRevenue.Text));
        btc.lblColor(lblBalanceFree, Convert.ToDecimal(lblBalanceFree.Text));
        btc.lblColor(lblBalanceOther, Convert.ToDecimal(lblBalanceOther.Text));
        btc.lblColor(lblTotalBalance, Convert.ToDecimal(lblTotalBalance.Text));
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProjectsNotStrategies(ddlSearchYear.SelectedValue);
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
    protected void ddlSearchProjects_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckProjectsCode", ddlSearchProjects.SelectedValue);
        DataBind();
    }
    protected string checkapprove(string id, int ckOld)
    {
        string str = "<a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + " onclick=\"printRpt(4,'w','{0}', " + ckOld + ");\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบขออนุมัติกิจกรรม แบบเอกสาร Word\" src=\"../Image/WordIcon.png\"</a>"
            + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(4,'e','{0}', " + ckOld + ");\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบขออนุมัติกิจกรรม แบบเอกสาร Excel\" src=\"../Image/Excel.png\"</a>"
            + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(4,'p','{0}', " + ckOld + ");\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบขออนุมัติกิจกรรม แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\"</a>";
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
        {
            return String.Format(str, id);
        }
        else
        {
            DataView dv = Conn.Select("Select ApproveFlag From Activity Where DelFlag = 0 And ActivityCode = '" + id + "' And ApproveFlag = 1");
            if (dv.Count != 0)
            {

                return String.Format(str, id);
            }
            else
            {
                return string.Format("");
            }
        }
    }
    protected void dgSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
    protected decimal GetTotalAmount1(decimal Budget)
    {
        //TotalAmount1 += Budget;
        return Budget;
    }
    protected decimal GetSumTotalAmount1()
    {
        return TotalAmount1;
    }
    protected decimal GetTotalAmount2(decimal Budget)
    {
        //TotalAmount2 += Budget;
        return Budget;
    }
    protected decimal GetSumTotalAmount2()
    {
        return TotalAmount2;
    }
    protected decimal GetTotalAmount3(decimal Budget)
    {
        //TotalAmount3 += Budget;
        return Budget;
    }
    protected decimal GetSumTotalAmount3()
    {
        return TotalAmount3;
    }
    protected string PjOrAcName(string id, string strName)
    {
        return String.Format("<a href=\"javascript:;\" onclick=\"newtabItem('{0}');\" title=\"แก้ไขงบประมาณ\">{1}</a>", id, strName);
    }
    protected void btAutoRefresh_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected string spnCutBudget(string id, string UpdateTime)
    {
        try
        {
            DateTime updatedate;
            updatedate = Convert.ToDateTime(UpdateTime);

            if (updatedate.AddMinutes(5) >= DateTime.Now)
            {
                string strSql = "Select "
                    + " NewBg = (Select TotalAmount From Activity Where ActivityCode = '" + id + "'), "
                    + " OldBg = (Select Top 1 OldBudget From dtEditBudgetAc Where ActivityCode = '" + id + "' Order By UpdateDate Desc)";
                DataView dv = Conn.Select(strSql);
                if (dv.Count != 0)
                {
                    if (Convert.ToDecimal(dv[0]["NewBg"]) > Convert.ToDecimal(dv[0]["OldBg"]))
                    {
                        return "spnCutbudgetG";
                    }
                    else
                    {
                        return "spnCutbudgetR";
                    }
                }
                else
                {
                    return "spnCutbudgetG";
                }
            }
            else
            {
                return "spnCutbudgetB";
            }
        }
        catch (Exception ex)
        {
            return "spnCutbudgetB";
        }
    }
}
