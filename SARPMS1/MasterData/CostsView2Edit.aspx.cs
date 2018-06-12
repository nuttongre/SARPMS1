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

public partial class CostsView2Edit : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount = 0;
    decimal TotalAmount2 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, null);

            Cookie.SetValue2("ckActivityStatus", btc.ckIdentityName("ckActivityStatus")); //เช็คโหมดติดตามงาน

            string mode = Request.QueryString["mode"];
            if (!String.IsNullOrEmpty(mode))
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
    private void getddlDepartment()
    {
        btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
    }
    public override void DataBind()
    {
        string StrSql = @"Select b.ActivityCode, b.ProjectsCode, a.ProjectsName, b.ActivityName, b.Status, 
                    CostsType = Case b.CostsType When 0 Then 'กิจกรรมใหม่' When 1 Then 'งานประจำ' When 2 Then ' กิจกรรมต่อเนื่อง' End, 
                    IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar) Term, 
                    b.SDate2, b.EDate2, IsNull(b.ActivityStatus, 0) As ActivityStatus, a.Sort, b.Sort 
                    From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
                    Left Join Activity b On a.ProjectsCode = b.ProjectsCode 
                    Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
                    Left Join Employee d On PD.EmpID = d.EmpID  
                    Left Join Employee Ep On a.CreateUser = Ep.EmpID
                    Left Join Department e On a.DeptCode = e.DeptCode
                    Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
                    Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                    Where b.DelFlag = 0 And b.ApproveFlag = 1
                    And b.StudyYear = '{0}' And b.SchoolID = '{1}' ";

//        if (ddlSearchDept.SelectedIndex != 0)
//        {
//            StrSql = @"Select a.ActivityCode, a.ProjectsCode, b.ProjectsName, a.ActivityName, a.Status, 
//                    CostsType = Case a.CostsType When 0 Then 'กิจกรรมใหม่' When 1 Then 'งานประจำ' When 2 Then ' กิจกรรมต่อเนื่อง' End, 
//                    IsNull(a.TotalAmount, 0) TotalAmount, IsNull(a.TotalAmount2, 0) TotalAmount2, Cast(a.Term As nVarChar) + '/' + Cast(a.YearB As nVarChar) Term, 
//                    a.SDate2, a.EDate2, IsNull(a.ActivityStatus, 0) As ActivityStatus 
//                    From Activity a Inner Join Projects b On a.ProjectsCode = b.ProjectsCode
//                    Inner Join dtAcDept c On a.ActivityCode = c.ActivityCode
//                    Left Join dtStrategies S On b.ProjectsCode = S.ProjectsCode
//                    Where a.DelFlag = 0  
//                    And a.StudyYear = '{0}' And a.SchoolID = '{1}' 
//                    And a.ApproveFlag = 1 And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
//        }
//        if (ddlSearchEmp.SelectedIndex != 0)
//        {
//            if (ddlSearchDept.SelectedIndex == 0)
//            {
//                StrSql = @"Select a.ActivityCode, a.ProjectsCode, b.ProjectsName, a.ActivityName, a.Status, 
//                        CostsType = Case a.CostsType When 0 Then 'งานกิจกรรม' When 1 Then 'งานประจำ' End, 
//                        IsNull(a.TotalAmount, 0) TotalAmount, IsNull(a.TotalAmount2, 0) TotalAmount2, Cast(a.Term As nVarChar) + '/' + Cast(a.YearB As nVarChar) Term, 
//                        a.SDate2, a.EDate2, IsNull(a.ActivityStatus, 0) As ActivityStatus 
//                        From Activity a Inner Join Projects b On a.ProjectsCode = b.ProjectsCode
//                        Inner Join dtAcEmp c On a.ActivityCode = c.ActivityCode
//                        Left Join dtStrategies S On b.ProjectsCode = S.ProjectsCode
//                        Where a.DelFlag = 0 
//                        And a.StudyYear = '{0}' And a.SchoolID = '{1}' 
//                        And a.ApproveFlag = 1 And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
//            }
//            else
//            {
//                StrSql = @"Select a.ActivityCode, a.ProjectsCode, b.ProjectsName, a.ActivityName, a.Status, 
//                            CostsType = Case a.CostsType When 0 Then 'งานกิจกรรม' When 1 Then 'งานประจำ' End, 
//                            IsNull(a.TotalAmount, 0) TotalAmount, IsNull(a.TotalAmount2, 0) TotalAmount2, Cast(a.Term As nVarChar) + '/' + Cast(a.YearB As nVarChar) Term, 
//                            a.SDate2, a.EDate2, IsNull(a.ActivityStatus, 0) As ActivityStatus 
//                            From Activity a Inner Join Projects b On a.ProjectsCode = b.ProjectsCode
//                            Inner Join dtAcEmp c On a.ActivityCode = c.ActivityCode
//                            Inner Join dtAcDept d On a.ActivityCode = d.ActivityCode
//                            Left Join dtStrategies S On b.ProjectsCode = S.ProjectsCode
//                            Where a.DelFlag = 0 
//                            And a.StudyYear = '{0}' And a.SchoolID = '{1}' 
//                            And a.ApproveFlag = 1 And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
//            }
//        }
        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    StrSql += " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql += " And b.ProjectsCode = '" + ddlSearch.SelectedValue + "'";
        }
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
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            StrSql += " And a.CreateUser = '" + ddlSearchEmp.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql += " And b.ActivityName Like '%" + txtSearch.Text + "%'";
        }
        StrSql += @" Group By b.ActivityCode, b.ProjectsCode, a.ProjectsName, b.ActivityName, b.Status, b.CostsType, b.TotalAmount, b.TotalAmount2, b.Term, b.YearB, 
                    b.SDate2, b.EDate2, b.ActivityStatus, a.Sort, b.Sort Order By a.Sort Desc, b.Sort Desc ";
        DataView dv = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        //เช็คผลรวม
        try
        {
            DataTable dt = dv.ToTable();
            TotalAmount = Convert.ToDecimal(dt.Compute("Sum(TotalAmount)", dv.RowFilter));
            TotalAmount2 = Convert.ToDecimal(dt.Compute("Sum(TotalAmount2)", dv.RowFilter));
        }
        catch (Exception ex)
        {
        }

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        //----GrandTotal-----------
        StrSql = @"Select IsNull(Sum(b.TotalAmount), 0) TotalAmount, IsNull(Sum(b.TotalAmount2), 0) TotalAmount2 
                From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
                    Left Join Activity b On a.ProjectsCode = b.ProjectsCode 
                    Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
                    Left Join Employee d On PD.EmpID = d.EmpID  
                    Left Join Employee Ep On a.CreateUser = Ep.EmpID
                    Left Join Department e On a.DeptCode = e.DeptCode
                    Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
                    Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                    Where b.DelFlag = 0 And b.ApproveFlag = 1
                    And b.StudyYear = '{0}' And b.SchoolID = '{1}' ";                    

        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    StrSql += " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql += " And b.ProjectsCode = '" + ddlSearch.SelectedValue + "'";
        }
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
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            StrSql += " And a.CreateUser = '" + ddlSearchEmp.SelectedValue + "'";
        }

        //if (ddlSearchDept.SelectedIndex != 0)
        //{
        //    StrSql = "Select IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //            + " From Activity a, Projects b, dtAcDept c "
        //            + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ApproveFlag = 1 "
        //            + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //            + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        //}
        //if (ddlSearchEmp.SelectedIndex != 0)
        //{
        //    if (ddlSearchDept.SelectedIndex == 0)
        //    {
        //        StrSql = "Select IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //                + " From Activity a, Projects b, dtAcEmp c "
        //                + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ApproveFlag = 1 "
        //                + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
        //    }
        //    else
        //    {
        //        StrSql = "Select IsNull(Sum(a.TotalAmount), 0) TotalAmount, IsNull(Sum(a.TotalAmount2), 0) TotalAmount2 "
        //                    + " From Activity a, Projects b, dtAcEmp c, dtAcDept d "
        //                    + " Where a.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode And a.ApproveFlag = 1 "
        //                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        //    }
        //}
        DataView dvTotal = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));
        ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount"]).ToString("#,##0.00") : "0.00";
        ToltalBudget2.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount2"]).ToString("#,##0.00") : "0.00";
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
            if ((DataBinder.Eval(e.Row.DataItem, "Status").ToString() == "3") || (DataBinder.Eval(e.Row.DataItem, "TotalAmount2").ToString() != "0"))
            {
                e.Row.ForeColor = System.Drawing.Color.Gray;
            }
            else
            {
                e.Row.Font.Bold = true;
            }

            //if (!(e.Row.RowType == DataControlRowType.Header))
            //{
            //    e.Row.Attributes.Add("onclick", "javascript:window.location='Costs2Edit.aspx?mode=2&id=" + DataBinder.Eval(e.Row.DataItem, "ActivityCode") + "'");
            //}
        }
    }
    protected string GetActivityName(string ActivityName, string ActivityCode, string Sts, string TtAmount2)
    {
        string color = "Black";
        if (Sts == "3" || TtAmount2 != "0")
        {
            color = "Gray";
        }
        return String.Format("<a href=\"Costs2Edit.aspx?mode=2&id={0}\" style=\"color:" + color + ";\">" + ActivityName + "</a>", ActivityCode);
    }
    protected string AttachShow(string id)
    {
        string strLink = "";
        DataView dv = Conn.Select("Select Count(ItemId) CountAtt From Multimedia Where ReferID = '" + id + "'");
        if (dv.Count != 0)
        {
            if (Convert.ToInt16(dv[0]["CountAtt"]) > 0)
            {
                strLink = "<a href=\"javascript:;\" onclick=\"AttachShow('" + id + "');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"แสดงไฟล์แนบ\" src=\"../Image/AttachIcon.png\" /></a>";
            }
        }
        return strLink;
    }
    protected string checkStatus(string id)
    {
        DataView dv = Conn.Select("Select Status From Activity Where DelFlag = 0 And ActivityCode = '" + id + "' And Status = 3");

        string strLink = "<a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + " onclick=\"printRpt(23,'w','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการปฏิบัตงานตามแผนปฏิบัติการ แบบเอกสาร Word\" src=\"../Image/WordIcon.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(23,'e','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการปฏิบัตงานตามแผนปฏิบัติการ แบบเอกสาร Excel\" src=\"../Image/Excel.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(23,'p','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการปฏิบัตงานตามแผนปฏิบัติการ แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\" /></a>";
        if (dv.Count != 0)
        {

            return String.Format(strLink, id);
        }
        else
        {
            return string.Format("");
        }
    }
    protected string checkResult(string id)
    {
        DataView dv = Conn.Select("Select Status From Activity Where DelFlag = 0 And ActivityCode = '" + id + "' And Status = 3");

        string strLink = "<a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + " onclick=\"printRpt(31,'w','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการดำเนินงาน แบบเอกสาร Word\" src=\"../Image/WordIcon.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(31,'e','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการดำเนินงาน แบบเอกสาร Excel\" src=\"../Image/Excel.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(31,'p','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานผลการดำเนินงาน แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\" /></a>";
        if (dv.Count != 0)
        {
            return String.Format(strLink, id);
        }
        else
        {
            return string.Format("");
        }
    }
    protected string checkRpt(string id)
    {
        DataView dv = Conn.Select("Select Status From Activity Where DelFlag = 0 And ActivityCode = '" + id + "' And Status = 3");

        string strLink = "<a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + " onclick=\"printRpt(11,'w','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานบันทึกค่าใช้จ่ายรายกิจกรรม แบบเอกสาร Word\" src=\"../Image/WordIcon.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(11,'e','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานบันทึกค่าใช้จ่ายรายกิจกรรม แบบเอกสาร Excel\" src=\"../Image/Excel.png\" /></a>"
                         + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(11,'p','{0}');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"เรียกดูรายงานบันทึกค่าใช้จ่ายรายกิจกรรม แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\" /></a>";
        if (dv.Count != 0)
        {
            return String.Format(strLink, id);
        }
        else
        {
            return string.Format("");
        }
    }
    public decimal GetBudget(decimal Budget)
    {
        //TotalAmount += Budget;
        return Budget;
    }
    public decimal GetTotalBudget()
    {
        return TotalAmount;
    }
    public decimal GetBudget2(decimal Budget)
    {
        //TotalAmount2 += Budget;
        return Budget;
    }
    public decimal GetTotalBudget2()
    {
        return TotalAmount2;
    }
    protected string getActivityStatus(string ActivityStatus)
    {
        return btc.getSpanColorStatus(Convert.ToBoolean(Cookie.GetValue2("ckActivityStatus")), ActivityStatus);
    }
}
