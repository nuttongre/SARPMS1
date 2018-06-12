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
using System.Text;
using System.Globalization;

public partial class Income : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalSubsidies = 0;
    decimal TotalRevenue = 0;
    decimal TotalFree = 0;
    decimal TotalReserve = 0;
    decimal TotalOther = 0;
    decimal TotalAmount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        LinkReport(linkReport1, 20);
                        LinkReport(linkReport2, 18);
                        LinkReport(linkReport3, 19);
                        getddlYear(1);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                }
            }
            else
            {
                getddlYear(0);
                btc.CkAdmission(GridView1, btAdd, null);
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

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select I.*, (I.Subsidies + I.Revenue + I.Reserve + I.Free + I.Other) As TotalAmount, D.DeptName 
                    From Income I Inner Join Department D On I.DeptCode = D.DeptCode
                    Inner Join MainSubDepartment MD On D.MainSubDeptCode = MD.MainSubDeptCode
                    Where I.DelFlag = 0 And I.StudyYear = '" + ddlSearchYear.SelectedValue + "'  ";

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
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And ( I.Subsidies Like '%" + txtSearch.Text + "%' Or I.Revenue Like '%" + txtSearch.Text + "%' Or I.Free Like '%" + txtSearch.Text + "%' Or I.Other Like '%" + txtSearch.Text + "%' )  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By I.StudyYear Asc, D.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv, dv1;
        string strSql = " Select IncomeCode, StudyYear, IsNull(Ma, 0) Ma, IsNull(Subsidies, 0) Subsidies, IsNull(MaRevenue, 0) MaRevenue, IsNull(Revenue, 0) Revenue,"
                        + " IsNull(MaFree, 0) MaFree, IsNull(Free, 0) Free, IsNull(MaReserve, 0) MaReserve, IsNull(Reserve, 0) Reserve,  "
                        + " IsNull(MaOther, 0) MaOther, IsNull(Other, 0) Other, DeptCode  "
                        + " From Income Where IncomeCode = '" + id + "'";
        dv = Conn.Select(string.Format(strSql));
        if (dv.Count != 0)
        {
            lblInComeCode.Text = dv[0]["IncomeCode"].ToString();
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlYearB.Enabled = false;
            txtMa.Text = Convert.ToDecimal(dv[0]["Ma"]).ToString("#,##0");
            txtSubsidies.Text = (Convert.ToDecimal(dv[0]["Subsidies"]) - Convert.ToDecimal(dv[0]["Ma"])).ToString("#,##0");
            txtMaRevenue.Text = Convert.ToDecimal(dv[0]["MaRevenue"]).ToString("#,##0");
            txtRevenue.Text = (Convert.ToDecimal(dv[0]["Revenue"]) - Convert.ToDecimal(dv[0]["MaRevenue"])).ToString("#,##0");
            txtMaFree.Text = Convert.ToDecimal(dv[0]["MaFree"]).ToString("#,##0");
            txtFree.Text = (Convert.ToDecimal(dv[0]["Free"]) - Convert.ToDecimal(dv[0]["MaFree"])).ToString("#,##0");
            txtMaReserve.Text = Convert.ToDecimal(dv[0]["MaReserve"]).ToString("#,##0");
            txtReserve.Text = (Convert.ToDecimal(dv[0]["Reserve"]) - Convert.ToDecimal(dv[0]["MaReserve"])).ToString("#,##0");
            txtMaOther.Text = Convert.ToDecimal(dv[0]["MaOther"]).ToString("#,##0");
            txtOther.Text = (Convert.ToDecimal(dv[0]["Other"]) - Convert.ToDecimal(dv[0]["MaOther"])).ToString("#,##0");
            if (dv[0]["DeptCode"].ToString() != CurrentUser.DeptID)
            {
                btSave.Visible = false;
            }
        }
        strSql = " Select IsNull(A1No, 0) A1No, IsNull(A1Value, 0) A1Value, IsNull(A2No, 0) A2No, IsNull(A2Value, 0) A2Value, IsNull(A3No, 0) A3No, IsNull(A3Value, 0) A3Value, "
            + " IsNull(P1No, 0) P1No, IsNull(P1Value, 0) P1Value, IsNull(P2No, 0) P2No, IsNull(P2Value, 0) P2Value, IsNull(P3No, 0) P3No, IsNull(P3Value, 0) P3Value, "
            + " IsNull(P4No, 0) P4No, IsNull(P4Value, 0) P4Value, IsNull(P5No, 0) P5No, IsNull(P5Value, 0) P5Value, IsNull(P6No, 0) P6No, IsNull(P6Value, 0) P6Value, "
            + " IsNull(M1No, 0) M1No, IsNull(M1Value, 0) M1Value, IsNull(M2No, 0) M2No, IsNull(M2Value, 0) M2Value, IsNull(M3No, 0) M3No, IsNull(M3Value, 0) M3Value, "
            + " IsNull(M4No, 0) M4No, IsNull(M4Value, 0) M4Value, IsNull(M5No, 0) M5No, IsNull(M5Value, 0) M5Value, IsNull(M6No, 0) M6No, IsNull(M6Value, 0) M6Value, "
            + " IsNull(ClassA1, 0) ClassA1, IsNull(ClassA2, 0) ClassA2, IsNull(ClassA3, 0) ClassA3, "
            + " IsNull(ClassP1, 0) ClassP1, IsNull(ClassP2, 0) ClassP2, IsNull(ClassP3, 0) ClassP3, IsNull(ClassP4, 0) ClassP4, IsNull(ClassP5, 0) ClassP5, IsNull(ClassP6, 0) ClassP6, "
            + " IsNull(ClassM1, 0) ClassM1, IsNull(ClassM2, 0) ClassM2, IsNull(ClassM3, 0) ClassM3, IsNull(ClassM4, 0) ClassM4, IsNull(ClassM5, 0) ClassM5, IsNull(ClassM6, 0) ClassM6 "
            + " From IncomeDetail Where IncomeCode = '{0}'";
        dv1 = Conn.Select(string.Format(strSql, id));
        if (dv1.Count != 0)
        {
            txtP1.Value = Convert.ToDecimal(dv1[0]["P1No"]).ToString("#,##0");
            txtPb1.Value = Convert.ToDecimal(dv1[0]["P1Value"]).ToString("#,##0");
            txtP2.Value = Convert.ToDecimal(dv1[0]["P2No"]).ToString("#,##0");
            txtPb2.Value = Convert.ToDecimal(dv1[0]["P2Value"]).ToString("#,##0");
            txtP3.Value = Convert.ToDecimal(dv1[0]["P3No"]).ToString("#,##0");
            txtPb3.Value = Convert.ToDecimal(dv1[0]["P3Value"]).ToString("#,##0");

            txtClassP1.Value = Convert.ToDecimal(dv1[0]["ClassP1"]).ToString("#,##0");
            txtClassP2.Value = Convert.ToDecimal(dv1[0]["ClassP2"]).ToString("#,##0");
            txtClassP3.Value = Convert.ToDecimal(dv1[0]["ClassP3"]).ToString("#,##0");

            txtM1.Value = Convert.ToDecimal(dv1[0]["M1No"]).ToString("#,##0");
            txtMb1.Value = Convert.ToDecimal(dv1[0]["M1Value"]).ToString("#,##0");
            txtM2.Value = Convert.ToDecimal(dv1[0]["M2No"]).ToString("#,##0");
            txtMb2.Value = Convert.ToDecimal(dv1[0]["M2Value"]).ToString("#,##0");
            txtM3.Value = Convert.ToDecimal(dv1[0]["M3No"]).ToString("#,##0");
            txtMb3.Value = Convert.ToDecimal(dv1[0]["M3Value"]).ToString("#,##0");

            txtClassM1.Value = Convert.ToDecimal(dv1[0]["ClassM1"]).ToString("#,##0");
            txtClassM2.Value = Convert.ToDecimal(dv1[0]["ClassM2"]).ToString("#,##0");
            txtClassM3.Value = Convert.ToDecimal(dv1[0]["ClassM3"]).ToString("#,##0");
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "InCome", "IncomeCode", id);
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        StringBuilder strbSql = new StringBuilder();
        Int32 i = 0;
        if ((btc.CkUseData(ddlYearB.SelectedValue, "StudyYear", "Income", "And DelFlag = 0 And DeptCode = '" + CurrentUser.DeptID + "'")) && Request.QueryString["mode"] != "2")
        {
            btc.Msg_Head(Img1, MsgHead, true, "7", 0);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
            return;
        }
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {           
            string NewID = Guid.NewGuid().ToString();
            strbSql.AppendFormat("INSERT INTO Income (IncomeCode, StudyYear, Ma, Subsidies, MaRevenue, Revenue, MaFree, Free, MaReserve, Reserve, MaOther, Other, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, DeptCode) VALUES ('{0}',{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},'{13}','{14}','{15}','{16}','{17}');",
            NewID, ddlYearB.SelectedValue, Convert.ToDecimal(txtMa.Text), Convert.ToDecimal(txtMa.Text) + Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtMaRevenue.Text), Convert.ToDecimal(txtMaRevenue.Text) + Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtMaFree.Text), Convert.ToDecimal(txtMaFree.Text) + Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtMaReserve.Text), Convert.ToDecimal(txtMaReserve.Text) + Convert.ToDecimal(txtReserve.Text), Convert.ToDecimal(txtMaOther.Text), Convert.ToDecimal(txtMaOther.Text) + Convert.ToDecimal(txtOther.Text), 0, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.DeptID);

            strbSql.AppendFormat("INSERT INTO IncomeDetail (IncomeCode, StudyYear, P1No, P1Value, P2No, P2Value, P3No, P3Value, M1No, M1Value, M2No, M2Value, M3No, M3Value, ClassP1, ClassP2, ClassP3, ClassM1, ClassM2, ClassM3) VALUES ('{0}',{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19});",
            NewID, ddlYearB.SelectedValue, Convert.ToDecimal(txtP1.Value), Convert.ToDecimal(txtPb1.Value), Convert.ToDecimal(txtP2.Value), Convert.ToDecimal(txtPb2.Value), Convert.ToDecimal(txtP3.Value), Convert.ToDecimal(txtPb3.Value), Convert.ToDecimal(txtM1.Value), Convert.ToDecimal(txtMb1.Value), Convert.ToDecimal(txtM2.Value), Convert.ToDecimal(txtMb2.Value), Convert.ToDecimal(txtM3.Value), Convert.ToDecimal(txtMb3.Value), Convert.ToDecimal(txtClassP1.Value), Convert.ToDecimal(txtClassP2.Value), Convert.ToDecimal(txtClassP3.Value), Convert.ToDecimal(txtClassM1.Value), Convert.ToDecimal(txtClassM2.Value), Convert.ToDecimal(txtClassM3.Value));

            //i = Conn.AddNew("Income", "IncomeCode, StudyYear, Ma, Subsidies, MaRevenue, Revenue, MaFree, Free, MaReserve, Reserve, MaOther, Other, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, DeptCode", 
            //    NewID, ddlYearB.SelectedValue, Convert.ToDecimal(txtMa.Text), Convert.ToDecimal(txtMa.Text) + Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtMaRevenue.Text), Convert.ToDecimal(txtMaRevenue.Text) + Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtMaFree.Text), Convert.ToDecimal(txtMaFree.Text) + Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtMaReserve.Text), Convert.ToDecimal(txtMaReserve.Text) + Convert.ToDecimal(txtReserve.Text), Convert.ToDecimal(txtMaOther.Text), Convert.ToDecimal(txtMaOther.Text) + Convert.ToDecimal(txtOther.Text), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.DeptID);
            //Conn.AddNew("IncomeDetail", "IncomeCode, StudyYear, P1No, P1Value, P2No, P2Value, P3No, P3Value, M1No, M1Value, M2No, M2Value, M3No, M3Value, ClassP1, ClassP2, ClassP3, ClassM1, ClassM2, ClassM3", 
            //    NewID, ddlYearB.SelectedValue, Convert.ToDecimal(txtP1.Value), Convert.ToDecimal(txtPb1.Value), Convert.ToDecimal(txtP2.Value), Convert.ToDecimal(txtPb2.Value), Convert.ToDecimal(txtP3.Value), Convert.ToDecimal(txtPb3.Value), Convert.ToDecimal(txtM1.Value), Convert.ToDecimal(txtMb1.Value), Convert.ToDecimal(txtM2.Value), Convert.ToDecimal(txtMb2.Value), Convert.ToDecimal(txtM3.Value), Convert.ToDecimal(txtMb3.Value), Convert.ToDecimal(txtClassP1.Value), Convert.ToDecimal(txtClassP2.Value), Convert.ToDecimal(txtClassP3.Value), Convert.ToDecimal(txtClassM1.Value), Convert.ToDecimal(txtClassM2.Value), Convert.ToDecimal(txtClassM3.Value));
            i = Conn.Execute(strbSql.ToString());
            Response.Redirect("Income.aspx?ckmode=1&Cr=" + i);      
        }
        if (Request.QueryString["mode"] == "2")
        {
            strbSql.AppendFormat("UPDATE Income Set Ma = {1}, Subsidies = {2}, MaRevenue = {3}, Revenue = {4}, MaFree = {5}, Free = {6}, MaReserve = {7}, Reserve = {8}, MaOther = {9}, Other = {10}, UpdateUser = '{11}', UpdateDate = '{12}' Where IncomeCode = '{0}';",
            Request.QueryString["id"], Convert.ToDecimal(txtMa.Text), Convert.ToDecimal(txtMa.Text) + Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtMaRevenue.Text), Convert.ToDecimal(txtMaRevenue.Text) + Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtMaFree.Text), Convert.ToDecimal(txtMaFree.Text) + Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtMaReserve.Text), Convert.ToDecimal(txtMaReserve.Text) + Convert.ToDecimal(txtReserve.Text), Convert.ToDecimal(txtMaOther.Text), Convert.ToDecimal(txtMaOther.Text) + Convert.ToDecimal(txtOther.Text), CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");

            strbSql.AppendFormat("UPDATE IncomeDetail Set P1No = {1}, P1Value = {2}, P2No = {3}, P2Value = {4}, P3No = {5}, P3Value = {6}, M1No = {7}, M1Value = {8}, M2No = {9}, M2Value = {10}, M3No = {11}, M3Value = {12}, ClassP1 = {13}, ClassP2 = {14}, ClassP3 = {15}, ClassM1 = {16}, ClassM2 = {17}, ClassM3 = {18} Where IncomeCode = '{0}';",
            Request.QueryString["id"], Convert.ToDecimal(txtP1.Value), Convert.ToDecimal(txtPb1.Value), Convert.ToDecimal(txtP2.Value), Convert.ToDecimal(txtPb2.Value), Convert.ToDecimal(txtP3.Value), Convert.ToDecimal(txtPb3.Value), Convert.ToDecimal(txtM1.Value), Convert.ToDecimal(txtMb1.Value), Convert.ToDecimal(txtM2.Value), Convert.ToDecimal(txtMb2.Value), Convert.ToDecimal(txtM3.Value), Convert.ToDecimal(txtMb3.Value), Convert.ToDecimal(txtClassP1.Value), Convert.ToDecimal(txtClassP2.Value), Convert.ToDecimal(txtClassP3.Value), Convert.ToDecimal(txtClassM1.Value), Convert.ToDecimal(txtClassM2.Value), Convert.ToDecimal(txtClassM3.Value));

            //i = Conn.Update("Income", "Where IncomeCode = '" + Request.QueryString["id"] + "' ", "Ma, Subsidies, MaRevenue, Revenue, MaFree, Free, MaReserve, Reserve, MaOther, Other, UpdateUser, UpdateDate", 
            //    Convert.ToDecimal(txtMa.Text), Convert.ToDecimal(txtMa.Text) + Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtMaRevenue.Text), Convert.ToDecimal(txtMaRevenue.Text) + Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtMaFree.Text), Convert.ToDecimal(txtMaFree.Text) + Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtMaReserve.Text), Convert.ToDecimal(txtMaReserve.Text) + Convert.ToDecimal(txtReserve.Text), Convert.ToDecimal(txtMaOther.Text), Convert.ToDecimal(txtMaOther.Text) + Convert.ToDecimal(txtOther.Text), CurrentUser.ID, DateTime.Now);
            //Conn.Update("IncomeDetail", "Where IncomeCode = '" + Request.QueryString["id"] + "' ", "P1No, P1Value, P2No, P2Value, P3No, P3Value, M1No, M1Value, M2No, M2Value, M3No, M3Value, ClassP1, ClassP2, ClassP3, ClassM1, ClassM2, ClassM3", 
            //    Convert.ToDecimal(txtP1.Value), Convert.ToDecimal(txtPb1.Value), Convert.ToDecimal(txtP2.Value), Convert.ToDecimal(txtPb2.Value), Convert.ToDecimal(txtP3.Value), Convert.ToDecimal(txtPb3.Value), Convert.ToDecimal(txtM1.Value), Convert.ToDecimal(txtMb1.Value), Convert.ToDecimal(txtM2.Value), Convert.ToDecimal(txtMb2.Value), Convert.ToDecimal(txtM3.Value), Convert.ToDecimal(txtMb3.Value), Convert.ToDecimal(txtClassP1.Value), Convert.ToDecimal(txtClassP2.Value), Convert.ToDecimal(txtClassP3.Value), Convert.ToDecimal(txtClassM1.Value), Convert.ToDecimal(txtClassM2.Value), Convert.ToDecimal(txtClassM3.Value));
            i = Conn.Execute(strbSql.ToString());
            Response.Redirect("Income.aspx?ckmode=2&Cr=" + i);   
        }
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 i = Conn.Update("Income", "Where IncomeCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
        Response.Redirect("Income.aspx?ckmode=3&Cr=" + i);   
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void LinkReport(Literal ltr, int num)
    {
        string link = " <a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + "  onclick=\"printRpt(" + num + ",'w', '');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"50px;\" height=\"50px;\" title=\"เรียกดูรายงาน แบบเอกสาร Word\" src=\"../Image/icon/WordIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(" + num + ",'e', '');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร Excel\" src=\"../Image/icon/ExcelIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(" + num + ",'p', '');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร PDF\" src=\"../Image/icon/PdfIcon.png\" /></a> ";
        ltr.Text = link;
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
    protected string checkDelete(object IncomeCode, object DeptCode)
    {
        string Link = " <a href=\"javascript:deleteItem('" + IncomeCode.ToString() + "');\"><img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>";
        if (DeptCode.ToString() != CurrentUser.DeptID)
        {
            Link = "";
        }
        return Link;
    }
    protected string getSubsidies(object Subsidies)
    {
        decimal subsidies = Convert.ToDecimal(Subsidies);
        TotalSubsidies += subsidies;
        return subsidies.ToString("#,##0.00");
    }
    protected string getTotalSubsidies()
    {
        return TotalSubsidies.ToString("#,##0.00");
    }
    protected string getRevenue(object Revenue)
    {
        decimal revenue = Convert.ToDecimal(Revenue);
        TotalRevenue += revenue;
        return revenue.ToString("#,##0.00");
    }
    protected string getTotalRevenue()
    {
        return TotalRevenue.ToString("#,##0.00");
    }
    protected string getFree(object Free)
    {
        decimal free = Convert.ToDecimal(Free);
        TotalFree += free;
        return free.ToString("#,##0.00");
    }
    protected string getTotalFree()
    {
        return TotalFree.ToString("#,##0.00");
    }
    protected string getReserve(object Reserve)
    {
        decimal reserve = Convert.ToDecimal(Reserve);
        TotalReserve += reserve;
        return reserve.ToString("#,##0.00");
    }
    protected string getTotalReserve()
    {
        return TotalReserve.ToString("#,##0.00");
    }
    protected string getOther(object Other)
    {
        decimal other = Convert.ToDecimal(Other);
        TotalOther += other;
        return other.ToString("#,##0.00");
    }
    protected string getTotalOther()
    {
        return TotalOther.ToString("#,##0.00");
    }
    protected string getSumAmount(object SumAmount)
    {
        decimal totalamount = Convert.ToDecimal(SumAmount);
        TotalAmount += totalamount;
        return totalamount.ToString("#,##0.00");
    }
    protected string getTotalAmount()
    {
        return TotalAmount.ToString("#,##0.00");
    }
}
