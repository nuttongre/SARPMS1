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

public partial class Evaluation : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }

            lblSideSearch.Text = "มาตรฐาน";
            lblStandardSearch.Text = "ตัวบ่งชี้";
            lblSide.Text = "มาตรฐาน";
            lblStandard.Text = "ตัวบ่งชี้";

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);
           
            string mode = Request.QueryString["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        string gotoid = Request.QueryString["id"];
                        if (!string.IsNullOrEmpty(gotoid))
                        {
                            GetDataGo(gotoid);  //ดึงข้อมูลมาทำต่อ
                            getddlSide(1);
                        }
                        else
                        {
                            getddlSide(1);
                            //getddlStrategies(1, ddlYearB.SelectedValue);
                            getddlProjects(1, ddlYearB.SelectedValue, "");
                            getddlActivity(1, ddlProjects.SelectedValue);
                            getActivityDetail(ddlActivity.SelectedValue);
                            getddlIndicators2(1, ddlActivity.SelectedValue);
                            getWeight(ddlIndicators2.SelectedValue);
                        }
                        getddlStandard(1, ddlSide.SelectedValue);
                        ddlStandard.SelectedIndex = 0;
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        break;
                }
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "javascript2", "function loadDetail(){" + Page.ClientScript.GetPostBackEventReference(btAc, null, false) + ";}", true);
            }
            else
            {
                getddlYear(0);
                getddlSide(0);
                getddlStandard(0, ddlSearchSide.SelectedValue);
                //getddlStrategies(0, ddlSearchYear.SelectedValue);
                getddlProjects(0, ddlSearchYear.SelectedValue, "");
                getddlActivity(0, ddlSearch.SelectedValue);
                getddlIndicators2(0, ddlSearch1.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                DataBind();
            }
        }
        ddlStandard.Attributes.Add("onchange", "Cktxt(0); CktxtOld();");
        //ddlStrategies.Attributes.Add("onchange", "Cktxt(0);");
        ddlProjects.Attributes.Add("onchange", "Cktxt(0);");
        ddlActivity.Attributes.Add("onchange", "Cktxt(0);");
        txtAll.Attributes.Add("onkeyup", "CkNum();");
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
    //private void getddlStrategies(int mode, string StudyYear)
    //{
    //    if (mode == 0)
    //    {
    //        btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));
    //    }

    //    if (mode == 1)
    //    {
    //        btc.getddlStrategies(1, ddlStrategies, StudyYear, null);
    //    }  
    //}
    private void getddlProjects(int mode, string StudyYear, string StrategiesCode)
    {
        if (mode == 0)
        {
            btc.getddlProjects(0, ddlSearch, StudyYear, StrategiesCode, Cookie.GetValue2("ckProjectsCode"));
        }
        if (mode == 1)
        {
            btc.getddlProjectsForAddActivity(1, ddlProjects, StudyYear, StrategiesCode, null);
        }
        if (mode == 2)
        {
            btc.getddlProjects(1, ddlProjects, StudyYear, StrategiesCode, null);
        }
    }
    private void getddlActivity(int mode, string ProjectsCode)
    {
        if (mode == 0)
        {
            btc.getddlActivity(0, ddlSearch1, ProjectsCode, Cookie.GetValue2("ckActivityCode"));
        }

        if (mode == 1)
        {
            btc.getddlActivity(1, ddlActivity, ProjectsCode, null);
        }
    }
    private void getddlIndicators2(int mode, string ActivityCode)
    {
        if (mode == 0)
        {
            btc.getddlIndicators2(0, ddlSearch3, ActivityCode, Cookie.GetValue2("ckIndicators2"));          
        }

        if (mode == 1)
        {
            btc.getddlIndicators2(1, ddlIndicators2, ActivityCode, null);
        }
    }
    private void getWeight(string Indicators2Code)
    {
        DataView dv;
        dv = btc.getWeight(Indicators2Code);
        if (dv.Count != 0)
        {
            txtWeight.Text = Convert.ToInt32(dv[0]["Weight"]).ToString("#,##0");
            txtAll.Text = Convert.ToInt32(dv[0]["OffAll"]).ToString("#,##0");
            lblWeightType.InnerText = (Convert.ToInt32(dv[0]["WeightType"]) == 0) ? "%" : "";
        }
        else
        {
            txtWeight.Text = "0";
            txtAll.Text = "0";
            lblWeightType.InnerText = "%";
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "javascript", "CkPercent();", true);
        }
    }
    private void getddlSide(int mode)
    {
        if (mode == 0)
        {
            btc.getddlSide(0, ddlSearchSide, ddlSearchYear.SelectedValue, Cookie.GetValue2("ckSideCode"));
        }

        if (mode == 1)
        {
            btc.getddlSide(1, ddlSide, ddlYearB.SelectedValue, null);
        }
    }
    private void getddlStandard(int mode, string SideCode)
    {
        if (mode == 0)
        {
            btc.getddlStandard(0, ddlSearchStandard, ddlSearchYear.SelectedValue, SideCode, Cookie.GetValue2("ckStandard"));
        }

        if (mode == 1)
        {
            btc.getddlStandardNotInEvaluation(1, ddlStandard, ddlYearB.SelectedValue, ddlSide.SelectedValue, null, ddlIndicators2.SelectedValue);
        }
    }
    private void getddlDepartment()
    {
        btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
    }
    private void getActivityDetail(string ActivityCode)
    {
        DataView dv = btc.getActivityDetail(ActivityCode);
        if (dv.Count != 0)
        {
            txtActivityDetail.Text = dv[0]["ActivityDetail"].ToString();
            lblType.Text = dv[0]["CostsType"].ToString();
            lblTerm.Text = dv[0]["Term"].ToString() + "/" + dv[0]["YearB"].ToString();
            lblBudgetYear.Text = dv[0]["BudgetYear"].ToString();
            txtTotalAmount.Text = Convert.ToDouble(dv[0]["TotalAmount"]).ToString("#,##0.00");
            lblDepartment.Text = dv[0]["DeptName"].ToString();
            lblEmpName.Text = dv[0]["EmpName"].ToString();
            txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString();
            txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString();
        }
        else
        {
            txtActivityDetail.Text = "";
            lblType.Text = "";
            lblTerm.Text = "";
            lblBudgetYear.Text = "";
            txtTotalAmount.Text = "0.00";
            lblDepartment.Text = "";
            lblEmpName.Text = "";
            txtSDay.Text = "";
            txtEDay.Text = "";
        }
    }
    public override void DataBind()
    {
        string strSideName = "'มาตรฐานที่ '";
        string strStandardName = "'ตัวบ่งชี้ที่ '";

        string StrSql = "Select a.EvaluationCode, b.StandardCode, {1} + Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) StandardName, {0} + Cast(s.Sort As nVarChar) SideName, "
                    + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                    + " a.OffAll, a.OffThat, a.APercent, a.CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                    + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, b.Sort SortStd, s.Sort SortSide "
                    + " From Evaluation a Inner Join Standard b On a.StandardCode = b.StandardCode "
                    + " Inner Join Projects c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                    + " Inner Join Activity d On a.ActivityCode = d.ActivityCode "
                    + " Inner Join Indicators2 e On a.Indicators2Code = e.Indicators2Code "
                    + " Inner Join Side s On b.SideCode = s.SideCode "
                    + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

 
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql = "Select a.EvaluationCode, b.StandardCode, {1} + Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) StandardName, {0} + Cast(s.Sort As nVarChar) SideName, "
                    + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                    + " a.OffAll, a.OffThat, a.APercent, a.CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                    + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, b.Sort SortStd, s.Sort SortSide "
                    + " From Evaluation a Inner Join Standard b On a.StandardCode = b.StandardCode "
                    + " Inner Join Projects c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                    + " Inner Join Activity d On a.ActivityCode = d.ActivityCode "
                    + " Inner Join Indicators2 e On a.Indicators2Code = e.Indicators2Code "
                    + " Inner Join dtAcDept g On d.ActivityCode = g.ActivityCode "
                    + " Inner Join Side s On b.SideCode = s.SideCode "
                    + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And g.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = "Select a.EvaluationCode, b.StandardCode, {1} + Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) StandardName, {0} + Cast(s.Sort As nVarChar) SideName, "
                        + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                        + " a.OffAll, a.OffThat, a.APercent, a.CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                        + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, b.Sort SortStd, s.Sort SortSide "
                        + " From Evaluation a Inner Join Standard b On a.StandardCode = b.StandardCode "
                        + " Inner Join Projects c On a.ProjectsCode = c.ProjectsCode "
                        + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                        + " Inner Join Activity d On a.ActivityCode = d.ActivityCode "
                        + " Inner Join Indicators2 e On a.Indicators2Code = e.Indicators2Code "
                        + " Innner Join dtAcEmp g On d.ActivityCode = g.ActivityCode "
                        + " Inner Join Side s On b.SideCode = s.SideCode "
                        + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And g.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
            }
            else
            {
                StrSql = "Select a.EvaluationCode, b.StandardCode, {1} + Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) StandardName, {0} + Cast(s.Sort As nVarChar) SideName, "
                        + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                        + " a.OffAll, a.OffThat, a.APercent, a.CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                        + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, b.Sort SortStd, s.Sort SortSide "
                        + " From Evaluation a Inner Join Standard b On a.StandardCode = b.StandardCode "
                        + " Inner Join Projects c On a.ProjectsCode = c.ProjectsCode "
                        + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                        + " Inner Join Activity d On a.ActivityCode = d.ActivityCode "
                        + " Inner Join Indicators2 e On a.Indicators2Code = e.Indicators2Code "
                        + " Inner Join dtAcEmp g On d.ActivityCode = g.ActivityCode " 
                        + " Inner Join dtAcDept i On d.ActivityCode = i.ActivityCode " 
                        + " Inner Join Side s On b.SideCode = s.SideCode "
                        + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And g.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And i.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
            }
        }     
        if (ddlSearchStandard.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.StandardCode = '" + ddlSearchStandard.SelectedValue + "' ";
        }
        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    StrSql = StrSql + " And SS.StrategiesCode = '" + ddlSearch2.SelectedValue + "' ";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And c.ProjectsCode = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearch1.SelectedIndex != 0)
        {
            StrSql = StrSql + " And d.ActivityCode = '" + ddlSearch1.SelectedValue + "' ";
        }
        if (ddlSearch3.SelectedIndex != 0)
        {
            StrSql = StrSql + " And e.Indicators2Code = '" + ddlSearch3.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (d.ActivityName Like '%" + txtSearch.Text + "%' Or e.IndicatorsName2 Like '%" + txtSearch.Text + "%') ";
        }
        if (ddlSearchStandard.SelectedIndex == 0)
        {
            if ((ddlSearchDept.SelectedIndex == 0) && (ddlSearchEmp.SelectedIndex == 0))
            {
                StrSql = StrSql + " Union "
                            + " Select '' As EvaluationCode, '' As StandardCode, '' As StandardName, '' As SideName, "
                            + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                            + " 0 As OffAll, 0 As OffThat, 0 As APercent, 0 As CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                            + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, 0 As SortStd, 0 As SortSide "
                            + " From Projects c Inner Join Activity d On c.ProjectsCode = d.ProjectsCode "
                            + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                            + " Inner Join Indicators2 e On d.ActivityCode = e.ActivityCode " 
                            + " Where e.DelFlag = 0 "
                            + " And d.StudyYear = '" + ddlSearchYear.SelectedValue + "' And d.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And e.Indicators2Code Not In(Select Indicators2Code From Evaluation) ";
            }
            else
            {
                if ((ddlSearchDept.SelectedIndex != 0) && (ddlSearchEmp.SelectedIndex == 0))
                {
                    StrSql = StrSql + " Union "
                            + " Select '' As EvaluationCode, '' As StandardCode, '' As StandardName, '' As SideName, "
                            + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                            + " 0 As OffAll, 0 As OffThat, 0 As APercent, 0 As CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                            + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, 0 As SortStd, 0 As SortSide "
                            + " From Projects c Inner Join Activity d On c.ProjectsCode = d.ProjectsCode "
                            + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                            + " Inner Join Indicators2 e On d.ActivityCode = e.ActivityCode " 
                            + " Inner Join dtAcDept g On d.ActivityCode = g.ActivityCode "
                            + " Where e.DelFlag = 0 "
                            + " And d.StudyYear = '" + ddlSearchYear.SelectedValue + "' And d.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And e.Indicators2Code Not In(Select Indicators2Code From Evaluation) "
                            + " And g.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                }
                if (ddlSearchEmp.SelectedIndex != 0)
                {
                    StrSql = StrSql + " Union "
                            + " Select '' As EvaluationCode, '' As StandardCode, '' As StandardName, '' As SideName, "
                            + " c.ProjectsCode, c.ProjectsName, d.ActivityCode, d.ActivityName, d.SDate, d.EDate, d.Status, "
                            + " 0 As OffAll, 0 As OffThat, 0 As APercent, 0 As CkCriterion, e.Indicators2Code, e.IndicatorsName2, '' DeptName, "
                            + " c.Sort SortPj, d.Sort SortAc, e.Sort SortInt2, 0 As SortStd, 0 As SortSide "
                            + " From Projects c Inner Join Activity d On c.ProjectsCode = d.ProjectsCode "
                            + " Left Join dtStrategies SS On c.ProjectsCode = SS.ProjectsCode "
                            + " Inner Join Indicators2 e On d.ActivityCode = e.ActivityCode "
                            + " Inner Join dtAcEmp g On d.ActivityCode = g.ActivityCode "
                            + " Where e.DelFlag = 0 "
                            + " And d.StudyYear = '" + ddlSearchYear.SelectedValue + "' And d.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And e.Indicators2Code Not In(Select Indicators2Code From Evaluation) "
                            + " And g.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
                }
            }
            //if (ddlSearch2.SelectedIndex != 0)
            //{
            //    StrSql = StrSql + " And SS.StrategiesCode = '" + ddlSearch2.SelectedValue + "' ";
            //}
            if (ddlSearch.SelectedIndex != 0)
            {
                StrSql = StrSql + " And c.ProjectsCode = '" + ddlSearch.SelectedValue + "' ";
            }
            if (ddlSearch1.SelectedIndex != 0)
            {
                StrSql = StrSql + " And d.ActivityCode = '" + ddlSearch1.SelectedValue + "' ";
            }
            if (ddlSearch3.SelectedIndex != 0)
            {
                StrSql = StrSql + " And e.Indicators2Code = '" + ddlSearch3.SelectedValue + "' ";
            }
            if (txtSearch.Text != "")
            {
                StrSql = StrSql + " And (d.ActivityName Like '%" + txtSearch.Text + "%' Or e.IndicatorsName2 Like '%" + txtSearch.Text + "%') ";
            }
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By SortPj Desc, SortAc Desc, SortInt2 Desc, SortStd, SortSide", strSideName, strStandardName));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
        }
        if (dv.Count != 0)
        {
            btnDelete.Visible = true;
        }
        else
        {
            btnDelete.Visible = false;
        }
        GridView1.DataSource = dv;
        GridView1.CheckListDataField = "EvaluationCode";
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        StrSql = " Select a.EvaluationCode, a.StandardCode, a.ProjectsCode, a.ActivityCode, a.Indicators2Code, {1} + Cast(d.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.StandardName StandardName, "
                + " d.SideCode, {0} + Cast(d.Sort As nVarChar) + ' - ' + d.SideName SideName "
                + " From Evaluation a, Standard b, Projects P, Activity Ac, Side d "
                + " Where a.StandardCode = b.StandardCode And b.SideCode = d.SideCode And a.ProjectsCode = P.ProjectsCode And a.ActivityCode = Ac.ActivityCode "
                + " And a.Indicators2Code = '" + ddlIndicators2.SelectedValue + "' ";

        DataView dv1 = Conn.Select(string.Format(StrSql + " Order By d.Sort, b.Sort", strSideName, strStandardName));

        GridView2.DataSource = dv1;
        GridView2.DataBind();
    }
    protected string DateFormat(object startDate, object endDate)
    {
        return Convert.ToDateTime(startDate).ToString("dd/MM/yy") + " - " + Convert.ToDateTime(endDate).ToString("dd/MM/yy");
    }
    protected string strEvaluation(string Indicators2Code, string Name)
    {
        if (Name == "")
        {
            return "<a href=\"Evaluation.aspx?mode=1&id=" + Indicators2Code + "\"><img style=\"border: 0; cursor: pointer;\" title=\"เชื่อมโยงตัวบ่งชี้ภายใต้ตัวชี้วัดนี้\" src=\"../Image/goto.png\" /></a>";
        }
        else
        {
            return Name;
        }
    }
    private void GetDataGo(string id)
    {
        DataView dv;
        if (String.IsNullOrEmpty(id)) return;
        string strSql = " Select a.*, b.StudyYear, c.ActivityDetail, c.CostsType, IsNull(c.TotalAmount, 0) TotalAmount, c.BudgetYear, c.Term, c.YearB, "
                + " c.DeptCode, c.SDate, c.EDate "
                + " From Indicators2 a, Projects b, Activity c "
                + " Where a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode "
                + " And a.Indicators2Code =  '" + id + "' ";
        dv = Conn.Select(string.Format(strSql));
        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            //getddlStrategies(1, ddlYearB.SelectedValue);
            //ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            getddlProjects(1, ddlYearB.SelectedValue, "");
            ddlProjects.SelectedValue = dv[0]["ProjectsCode"].ToString();
            getddlActivity(1, ddlProjects.SelectedValue);
            ddlActivity.SelectedValue = dv[0]["ActivityCode"].ToString();
            getActivityDetail(ddlActivity.SelectedValue);
            getddlIndicators2(1, ddlActivity.SelectedValue);
            ddlIndicators2.SelectedValue = dv[0]["Indicators2Code"].ToString();
            getWeight(ddlIndicators2.SelectedValue);
            lblWeightType.InnerText = (Convert.ToInt32(dv[0]["WeightType"]) == 0) ? "%" : "";
            txtTotalAmount.Text = Convert.ToDouble(dv[0]["TotalAmount"]).ToString("#,##0.00");

            //if (ddlActivity.SelectedIndex == 0)
            //{
            //    A1.Visible = false;
            //}
            //else
            //{
            //    A1.Visible = true;
            //}
        }
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        dv = Conn.Select(string.Format("Select a.EvaluationCode, a.StandardCode, a.SideCode, "
            + " a.IndicatorsCode, c.StrategiesCode, a.ProjectsCode, a.ActivityCode, a.Indicators2Code, "
            + " a.OffAll, a.OffThat, a.APercent, a.CkCriterion, c.StudyYear, c.StrategiesCode "
            + " From Evaluation a, Standard b, Projects c, Activity d "
            + " Where a.DelFlag = '0' And a.StandardCode = b.StandardCode And a.ProjectsCode = c.ProjectsCode "
            + " And a.ActivityCode = d.ActivityCode And a.EvaluationCode = '" + id + "' "));

        if (dv.Count != 0)
        {
            getddlYear(1);
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlSide(1);
            ddlSide.SelectedValue = dv[0]["SideCode"].ToString();
            getddlStandard(1, ddlSide.SelectedValue);
            ddlStandard.SelectedValue = dv[0]["StandardCode"].ToString();
            //getddlStrategies(1, ddlYearB.SelectedValue);
            //ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            getddlProjects(1, ddlYearB.SelectedValue, "");
            ddlProjects.SelectedValue = dv[0]["ProjectsCode"].ToString();
            getddlActivity(1, ddlProjects.SelectedValue);
            ddlActivity.SelectedValue = dv[0]["ActivityCode"].ToString();
            getActivityDetail(ddlActivity.SelectedValue);
            getddlIndicators2(1, ddlActivity.SelectedValue);
            ddlIndicators2.SelectedValue = dv[0]["Indicators2Code"].ToString();
            getWeight(ddlIndicators2.SelectedValue);
            txtAll.Text = Convert.ToInt32(dv[0]["OffAll"]).ToString("#,##0");
        }
    }
    private void ClearAll()
    {
        txtSearch.Text = "";
        ddlSide.SelectedIndex = 0;
        ddlStandard.SelectedIndex = 0;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 CkCriterion = 0;
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            if (ddlStandard.SelectedIndex != 0)
            {
                i = Conn.AddNew("Evaluation", "EvaluationCode, StandardCode, StrategiesCode, ProjectsCode, ActivityCode, Indicators2Code, OffAll, OffThat, APerCent, CkCriterion, DelFlag, StudyYear, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                    NewID, ddlStandard.SelectedValue, "", ddlProjects.SelectedValue, ddlActivity.SelectedValue, ddlIndicators2.SelectedValue, Convert.ToDouble(txtAll.Text), 0, 0, CkCriterion, 0, ddlYearB.SelectedValue, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            }
            //Conn.Update("Activity", "Where ActivityCode = '" + ddlActivity.SelectedValue + "'", "Status", "1");
            btc.Msg_Head(Img1, MsgHead, true, "1", i);

            if (CkAgain == "N")
            {
                Response.Redirect("Evaluation.aspx?ckmode=1&Cr=" + i);   
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                GridView2.Visible = true;
                DataBind();                
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
            i = Conn.Update("Evaluation", "Where EvaluationCode = '" + Request.QueryString["id"] + "' ", "StandardCode, StrategiesCode, ProjectsCode, ActivityCode, Indicators2Code, OffAll, OffThat, APerCent, CkCriterion, StudyYear, SchoolID, UpdateUser, UpdateDate", 
                ddlStandard.SelectedValue, "", ddlProjects.SelectedValue, ddlActivity.SelectedValue, ddlIndicators2.SelectedValue, Convert.ToDouble(txtAll.Text), 0, 0, CkCriterion, ddlYearB.SelectedValue, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now);           
            Response.Redirect("Evaluation.aspx?ckmode=2&Cr=" + i);  
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save("N");
    }
    protected void btSaveAgain_Click(object sender, EventArgs e)
    {
        bt_Save("Y");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (GridView1.SelectedItems.Length == 0) return;
        string query = "DELETE Evaluation WHERE EvaluationCode IN('";
        query += String.Join("', '", GridView1.SelectedItems);
        query += "')";

        string strSql = " Select EvaluationCode, Indicators2Code from Evaluation WHERE EvaluationCode IN('";
        strSql += String.Join("', '", GridView1.SelectedItems);
        strSql += "')";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0) 
        {
            for (int i = 0; i < dv.Count; i++)
            {
                strSql = @" Select Indicators2Code from Evaluation Where EvaluationCode = '" + dv[i]["EvaluationCode"].ToString() + "'";
                DataView dv2 = Conn.Select(string.Format(strSql));
                if (dv2.Count != 0)
                {
                    strSql = @" Select Indicators2Code From Evaluation Where Indicators2Code = '" + dv2[0]["Indicators2Code"].ToString() + "'";
                    DataView dv1 = Conn.Select(string.Format(strSql));
                }
            } 
        }
       
        try
        {
            Conn.Execute(query);
            //Response.Redirect(Request.RawUrl);
            MultiView1.ActiveViewIndex = 0;
            btc.Msg_Head(Img1, MsgHead, true, "3", 1);
            DataBind();
        }
        catch (Exception ex)
        {
            MultiView1.ActiveViewIndex = 0;
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
            DataBind();
            //lblMessage.Text = "<img src=\"../Shared/images/no.png\" alt=\"เกิดข้อผิดพลาด\" />เกิดข้อผิดพลาดระหว่างดำเนินการ " + ex.Message;
        }
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        //DataView dv = Conn.Select(string.Format("Select DevelopLevelCode From Develop Where DevelopLevelCode = '" + id + "' And DelFlag = '0' "));
        //if (dv.Table.Rows.Count > 0)
        //{
        //    btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        //}
        //else
        //{
            string strSql = @" Select Indicators2Code from Evaluation Where EvaluationCode = '" + id + "'";
            DataView dv = Conn.Select(string.Format(strSql));
            if (dv.Count != 0)
            {
                strSql = @" Select Indicators2Code From Evaluation Where Indicators2Code = '" + dv[0]["Indicators2Code"].ToString() + "'";
                DataView dv1 = Conn.Select(string.Format(strSql));
            }
            Int32 j = Conn.Delete("Evaluation", "Where EvaluationCode = '" + id + "'");
            Response.Redirect("Evaluation.aspx?ckmode=3&Cr=" + j); 
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        getddlSide(1);
        getddlStandard(1, ddlSide.SelectedValue);
        //getddlStrategies(1, ddlYearB.SelectedValue);
        getddlProjects(1, ddlYearB.SelectedValue, "");
        getddlActivity(1, ddlProjects.SelectedValue);
        getActivityDetail(ddlActivity.SelectedValue);
        getddlIndicators2(1, ddlActivity.SelectedValue);
        getWeight(ddlIndicators2.SelectedValue);
        //if (ddlActivity.SelectedIndex == 0)
        //{
        //    A1.Visible = false;
        //}
        //else
        //{
        //    A1.Visible = true;
        //}
    }
    protected void ddlSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlStandard(1, ddlSide.SelectedValue);
    }
    //protected void ddlStrategies_OnSelectedChanged(object sender, EventArgs e)
    //{
    //    getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
    //    getddlActivity(1, ddlProjects.SelectedValue);
    //    getActivityDetail(ddlActivity.SelectedValue);
    //    getddlIndicators2(1, ddlActivity.SelectedValue);
    //    getWeight(ddlIndicators2.SelectedValue);
    //    //if (ddlActivity.SelectedIndex == 0)
    //    //{
    //    //    A1.Visible = false;
    //    //}
    //    //else
    //    //{
    //    //    A1.Visible = true;
    //    //}
    //}
    protected void ddlProjects_OnSelectedChanged(object sender, EventArgs e)
    {
        getddlActivity(1, ddlProjects.SelectedValue);
        getActivityDetail(ddlActivity.SelectedValue);
        getddlIndicators2(1, ddlActivity.SelectedValue);
        getWeight(ddlIndicators2.SelectedValue);
        //if (ddlActivity.SelectedIndex == 0)
        //{
        //    A1.Visible = false;
        //}
        //else
        //{
        //    A1.Visible = true;
        //}
    }
    protected void ddlActivity_OnSelectedChanged(object sender, EventArgs e)
    {
        //if (ddlActivity.SelectedIndex == 0)
        //{
        //    A1.Visible = false;
        //}
        //else
        //{
        //    A1.Visible = true;
        //}
        getActivityDetail(ddlActivity.SelectedValue);
        getddlIndicators2(1, ddlActivity.SelectedValue);
        getWeight(ddlIndicators2.SelectedValue);
    }
    protected void ddlIndicators2_OnSelectedChanged(object sender, EventArgs e)
    {
        getWeight(ddlIndicators2.SelectedValue);
        if (ddlIndicators2.SelectedIndex == 0)
        {
            ddlStandard.SelectedIndex = 0;
            ddlStandard.Enabled = false;
        }
        else
        {
            ddlStandard.SelectedIndex = 0;
            ddlStandard.Enabled = true;
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlStandard(0, ddlSearchSide.SelectedValue);
        //getddlStrategies(0, ddlSearchYear.SelectedValue);
        getddlProjects(0, ddlSearchYear.SelectedValue, "");
        getddlActivity(0, ddlSearch.SelectedValue);
        getddlIndicators2(0, ddlSearch1.SelectedValue);
        DataBind();
    }
    protected void ddlSearchSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckSideCode", ddlSearchSide.SelectedValue);
        getddlStandard(0, ddlSearchSide.SelectedValue);
        DataBind();
    }
    protected void ddlSearchStandard_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckStandard", ddlSearchStandard.SelectedValue);
        DataBind();
    }
    //protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
    //    getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
    //    getddlActivity(0, ddlSearch.SelectedValue);
    //    getddlIndicators2(0, ddlSearch1.SelectedValue);
    //    DataBind();
    //}
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckProjectsCode", ddlSearch.SelectedValue);
        getddlActivity(0, ddlSearch.SelectedValue);
        getddlIndicators2(0, ddlSearch1.SelectedValue);
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckActivityCode", ddlSearch1.SelectedValue);
        getddlIndicators2(0, ddlSearch1.SelectedValue);
        DataBind();
    }
    protected void ddlSearch3_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckIndicators2", ddlSearch3.SelectedValue);
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
    protected void btAc_OnClick(object sender, EventArgs e)
    {
        var id = ddlActivity.SelectedValue;
        getddlActivity(1, ddlProjects.SelectedValue);
        ddlActivity.SelectedValue = id;
        getActivityDetail(ddlActivity.SelectedValue);
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((DataBinder.Eval(e.Row.DataItem, "SideName").ToString() == "") && (DataBinder.Eval(e.Row.DataItem, "StandardName").ToString() == ""))
            {
                e.Row.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
