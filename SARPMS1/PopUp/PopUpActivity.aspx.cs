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
using System.Text;

public partial class PopUpActivity : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    DataView dvBudget;
    DataView dvOperation2;
    decimal TotalMoney;
    decimal TotalMoneyOperation;
    decimal TotalCostsWeight;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }               
            getddlYear(0);
            getddlStrategies(0, ddlSearchYear.SelectedValue);
            getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
            getddlDepartment();
            btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
            //btc.CkGroup(ddlSearchDept, ddlSearchEmp, Cookie.GetValue2("AcDept").ToString(), Cookie.GetValue2("AcEmp").ToString());
            
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        SetItem();
                        string gotoid = Request.QueryString["id"];
                        if (!string.IsNullOrEmpty(gotoid))
                        {
                            DataView dvCk = Conn.Select("Select StudyYear, StrategiesCode, ProjectsCode From Projects Where ProjectsCode = '" + gotoid + "'");
                            ddlYearB.SelectedValue = dvCk[0]["StudyYear"].ToString();
                            getddlStrategies(1, ddlYearB.SelectedValue);
                            ddlStrategies.SelectedValue = dvCk[0]["StrategiesCode"].ToString();
                            getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
                            ddlProjects.SelectedValue = gotoid;
                            getProjectsDetail(gotoid);
                        }
                        else
                        {
                            getddlStrategies(1, ddlYearB.SelectedValue);
                            getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
                        }
                        btc.btEnable(btEditDate, false);
                        btc.btEnable(btEditBudget, false);
                        txtYearB.Text = ddlYearB.SelectedItem.Text;
                        txtBudgetYear.Text = ddlYearB.SelectedItem.Text;
                        btc.GenSort(txtSort, "Activity", " And ProjectsCode = '" + ddlProjects.SelectedValue + "'");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0); SumTotal();", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        SetItem();
                        btc.btEnable(btSaveAgain, false);
                        btc.btEnable(btSaveAndGo, false);

                        DataView ckApproveBudget = Conn.Select("Select IsNull(ApproveFlag, 0) ApproveFlag From Activity Where ActivityCode = '" + Request["id"] + "'");
                        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
                        {
                            if (Convert.ToInt32(ckApproveBudget[0]["ApproveFlag"]) == 0)
                            {
                                btc.btEnable(btApproveBudget, true);
                            }
                            else
                            {
                                DataView dvApproveUser = Conn.Select("Select ApproveUser From Activity Where ActivityCode = '" + Request["id"] + "'");
                                if (!string.IsNullOrEmpty(dvApproveUser[0]["ApproveUser"].ToString()))
                                {
                                    string ApproveName = "";
                                    ApproveName = btc.getEmpName(dvApproveUser[0]["ApproveUser"].ToString());
                                    lblAlertApprove.Text = "*** กิจกรรมนี้ได้ถูกอนุมัติแล้ว โดยคุณ " + ApproveName + " ถ้าต้องการแก้ไขวันที่ดำเนินการหรือแก้ไขงบประมาณ  กรุณาติดต่อฝ่ายแผนงาน";
                                }
                                lblAlertApprove.Visible = true;
                            }
                        }
                        else
                        {
                            if (Convert.ToInt32(ckApproveBudget[0]["ApproveFlag"]) != 0)
                            {
                                btc.btEnable(btEditDate, false);
                                btc.btEnable(btEditBudget, false);
                                DataView dvApproveUser = Conn.Select("Select ApproveUser From Activity Where ActivityCode = '" + Request["id"] + "'");
                                if (!string.IsNullOrEmpty(dvApproveUser[0]["ApproveUser"].ToString()))
                                {
                                    string ApproveName = "";
                                    ApproveName = btc.getEmpName(dvApproveUser[0]["ApproveUser"].ToString());
                                    lblAlertApprove.Text = "*** กิจกรรมนี้ได้ถูกอนุมัติแล้ว โดยคุณ " + ApproveName + " ถ้าต้องการแก้ไขวันที่ดำเนินการหรือแก้ไขงบประมาณ  กรุณาติดต่อฝ่ายแผนงาน";
                                }
                                lblAlertApprove.Visible = true;
                            }
                        }
                        GetData(Request["id"]);
                        if (btc.CkActivityBudgetDetail(Request["id"]))
                        {
                            btEditBudget.Enabled = false;
                            btEditBudget.ToolTip = "ไม่สามารถแก้ไขงบประมาณได้เนื่องจากกมีการเบิกงบย่อยแล้ว";
                        }
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                }
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "javascript", "function loadDept(){" + Page.ClientScript.GetPostBackEventReference(btSearchDept, null, false) + ";} function loadIndicators(){" + Page.ClientScript.GetPostBackEventReference(btSearchInd, null, false) + ";}", true);
            }
            else
            {
                DataBind();
            }
        }
        ddlStrategies.Attributes.Add("onchange", "Cktxt(0);");
        ddlProjects.Attributes.Add("onchange", "Cktxt(0);");
        txtActivity.Attributes.Add("onkeyup", "Cktxt(0);");
        txtActivityDetail.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPurpose.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTarget.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTarget2.Attributes.Add("onkeyup", "Cktxt(0);");
        txtOperation2.Attributes.Add("onkeyup", "Cktxt(0);");
        txtExpected.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPlace.Attributes.Add("onkeyup", "Cktxt(0);");
        txtDepartment.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
        txtEmp.Attributes.Add("onkeyup", "Cktxt(0);");
        txtAlertDay.Attributes.Add("onkeyup", "AlertDayNull(); CkAlertDay(0);");
        ddlTerm.Attributes.Add("onchange", "CkYear();");
        ddlYearB.Attributes.Add("onchange", "CkYear();");
        ddlSDay.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSMonth.Attributes.Add("onchange", "ckddlDate(1);"); 
        ddlSYear.Attributes.Add("onchange", "ckddlDate(1);");
        ddlEDay.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEMonth.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEYear.Attributes.Add("onchange", "ckddlDate(2);");
        ddlRealSDay.Attributes.Add("onchange", "ckddlRealDate(1);");
        ddlRealSMonth.Attributes.Add("onchange", "ckddlRealDate(1);");
        ddlRealSYear.Attributes.Add("onchange", "ckddlRealDate(1);");
        ddlRealEDay.Attributes.Add("onchange", "ckddlRealDate(2);");
        ddlRealEMonth.Attributes.Add("onchange", "ckddlRealDate(2);");
        ddlRealEYear.Attributes.Add("onchange", "ckddlRealDate(2);");
        ddlBudgetType.Attributes.Add("onchange", "cktxtBudgetType();");
        txtListName.Attributes.Add("onkeyup", "ckAddBudget();");
    }
    private void SetItem()
    {
        lblckYearType.Text = Convert.ToInt32(btc.ckIdentityName("ckBudgetYear")).ToString();
        getlblTarget();
        getddlEntryCosts();
        getddlBudgetType();
        btc.getrbtlType(rbtlType);
        btc.getddlTerm(Convert.ToInt32(lblckYearType.Text), ddlTerm);

        btc.getddlDay(ddlSDay);
        btc.getddlMonth2(ddlSMonth);
        btc.getddlYear(ddlSYear, 5);
        btc.getddlDay(ddlEDay);
        btc.getddlMonth2(ddlEMonth);
        btc.getddlYear(ddlEYear, 5);
        btc.getddlDay(ddlRealSDay);
        btc.getddlMonth2(ddlRealSMonth);
        btc.getddlYear(ddlRealSYear, 5);
        btc.getddlDay(ddlRealEDay);
        btc.getddlMonth2(ddlRealEMonth);
        btc.getddlYear(ddlRealEYear, 5);

        btc.IdentityNameEnable(lblIdentityName, txtIdentityName, "IdentityName", "iNameShow", divIdentityName);
        btc.IdentityNameEnable(lblIdentityName2, txtIdentityName2, "IdentityName2", "iNameShow2", divIdentityName2);
    }
    private void getlblTarget()
    {
        string[] lblTarget = btc.getlblTarget().Split(',');
        lblTarget1.Text = lblTarget[0];
        lblTarget2.Text = lblTarget[1];
    }
    private void getddlEntryCosts()
    {
        ddlEntryCosts.DataSource = new BTC().getddlEntryCosts();
        ddlEntryCosts.DataTextField = "EntryCostsName";
        ddlEntryCosts.DataValueField = "EntryCostsCode";
        ddlEntryCosts.DataBind();
        ddlEntryCosts.Items.Insert(0, new ListItem("-ไม่เลือก-", ""));
    }
    private void getddlBudgetType()
    {
        ddlBudgetType.DataSource = new BTC().getddlBudgetType();
        ddlBudgetType.DataTextField = "BudgetTypeName";
        ddlBudgetType.DataValueField = "BudgetTypeCode";
        ddlBudgetType.DataBind();
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
    private void getddlStrategies(int mode, string StudyYear)
    {
        if (mode == 0)
        {
            btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));
        }

        if (mode == 1)
        {
            btc.getddlStrategies(1, ddlStrategies, StudyYear, null);
        }
    }
    private void getddlProjects(int mode, string StudyYear, string StrategiesCode)
    {
        if (mode == 0)
        {
            btc.getddlProjects(0, ddlSearch, StudyYear, StrategiesCode, Cookie.GetValue2("ckProjectsCode"));
        }

        if (mode == 1)
        {
            btc.getddlProjects(1, ddlProjects, StudyYear, StrategiesCode, null);
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
        string StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, IsNull(b.ApproveFlag, 0) ApproveFlag, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, 0 As ConnectInd, 0 As ConnectEva "
                    + " From Projects a, Activity b "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, IsNull(b.ApproveFlag, 0) ApproveFlag, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, 0 As ConnectInd, 0 As ConnectEva "
                    + " From Projects a, Activity b, dtAcDept c "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, IsNull(b.ApproveFlag, 0) ApproveFlag, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, 0 As ConnectInd, 0 As ConnectEva "
                    + " From Projects a, Activity b, dtAcEmp c "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
            }
            else
            {
                StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, IsNull(b.ApproveFlag, 0) ApproveFlag, "
                        + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, 0 As ConnectInd, 0 As ConnectEva "
                        + " From Projects a, Activity b, dtAcEmp c, dtAcDept d "
                        + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And b.ActivityCode = d.ActivityCode "
                        + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
            }            
        }
        if (ddlSearch2.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        }
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.ActivityName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.CreateDate Desc "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
            dv[j]["ConnectInd"] = btc.getAcIndicators2(dv[j]["ActivityCode"].ToString());
            dv[j]["ConnectEva"] = btc.getAcEvaluation(dv[j]["ActivityCode"].ToString());
        }

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        DataView dv1 = Conn.Select(string.Format(StrSql + " And b.Status In (0,4) Order By b.CreateDate Desc "));

        for (int j = 0; j < dv1.Count; j++)
        {
            dv1[j]["DeptName"] = btc.getAcDeptName(dv1[j]["ActivityCode"].ToString());
        }

        //----GrandTotal-----------
        StrSql = "Select IsNull(Sum(b.TotalAmount), 0) TotalAmount "
                    + " From Projects a, Activity b "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql = "Select IsNull(Sum(b.TotalAmount), 0) TotalAmount "
                    + " From Projects a, Activity b, dtAcDept c "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = "Select IsNull(Sum(b.TotalAmount), 0) TotalAmount "
                    + " From Projects a, Activity b, dtAcEmp c "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
            }
            else
            {
                StrSql = "Select IsNull(Sum(b.TotalAmount), 0) TotalAmount "
                        + " From Projects a, Activity b, dtAcEmp c, dtAcDept d "
                        + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And b.ActivityCode = d.ActivityCode "
                        + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
            }
        }

        DataView dvTotal = Conn.Select(StrSql);
        ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount"]).ToString("#,##0.00") : "0.00";
        //----EndGrandTotal-----------

        GridView3.DataSource = dv;
        GridView3.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv;
        string strSql = " Select a.StudyYear, b.* "
                    + " From Projects a, Activity b "
                    + " Where b.ActivityCode = '{0}' And a.ProjectsCode = b.ProjectsCode ";
        dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlStrategies(1, ddlYearB.SelectedValue);
            ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
            ddlProjects.SelectedValue = dv[0]["ProjectsCode"].ToString();
            if (btc.CkUseData(id, "ActivityCode", "Indicators2", " And DelFlag = 0 "))
            {
                ddlYearB.Enabled = false;
                ddlStrategies.Enabled = false;
                ddlProjects.Enabled = false;
            }
            txtIdentityName.Text = dv[0]["IdentityName"].ToString();
            txtIdentityName2.Text = dv[0]["IdentityName2"].ToString();
            txtActivity.Text = dv[0]["ActivityName"].ToString();
            txtActivityDetail.Text = dv[0]["ActivityDetail"].ToString();
            txtPurpose.Text = dv[0]["Purpose"].ToString();
            txtTarget.Text = dv[0]["Target"].ToString();
            txtTarget2.Text = dv[0]["Target2"].ToString();
            txtOperation1.Text = dv[0]["Operation1"].ToString();
            txtPeriod1.Text = dv[0]["Period1"].ToString();
            txtPlace1.Text = dv[0]["Place1"].ToString();
            txtEmp1.Text = dv[0]["Emp1"].ToString();
            txtPeriod2.Text = dv[0]["Period2"].ToString();
            txtPlace2.Text = dv[0]["Place2"].ToString();
            txtEmp2.Text = dv[0]["Emp2"].ToString();
            txtOperation3.Text = dv[0]["Operation3"].ToString();
            txtPeriod3.Text = dv[0]["Period3"].ToString();
            txtPlace3.Text = dv[0]["Place3"].ToString();
            txtEmp3.Text = dv[0]["Emp3"].ToString();
            txtSolutions.Text = dv[0]["Solutions"].ToString();
            txtEvaluation.Text = dv[0]["Evaluation"].ToString();
            txtEvaIndicators.Text = dv[0]["EvaIndicators"].ToString();
            txtEvaAssessment.Text = dv[0]["EvaAssessment"].ToString();
            txtEvaTool.Text = dv[0]["EvaTool"].ToString();
            txtExpected.Text = dv[0]["Expected"].ToString();
            txtVolumeExpect.Text = string.IsNullOrEmpty(dv[0]["VolumeExpect"].ToString()) ? "0" : Convert.ToDecimal(dv[0]["VolumeExpect"]).ToString("#,##0");
            txtPlace.Text = dv[0]["Place"].ToString();
            rbtlType.SelectedValue = dv[0]["CostsType"].ToString();
            ddlTerm.SelectedValue = dv[0]["Term"].ToString();
            txtYearB.Text = dv[0]["YearB"].ToString();
            txtBudgetYear.Text = dv[0]["BudgetYear"].ToString();

            strSql = " Select ActivityCode, RecNum As id, Operation2, Budget2 "
                + " From ActivityOperation2 "
                + " Where ActivityCode = '{0}' ";
            dvOperation2 = Conn.Select(string.Format(strSql + " Order By RecNum ", id));

            if (dvOperation2.Count != 0)
            {
                btDelOperation2.Visible = true;
                if (Session["Operation2ac"] == null)
                {
                    DataTable dt1 = new DataTable();
                    dt1.Columns.Add("id");
                    dt1.Columns.Add("Operation2");
                    dt1.Columns.Add("Budget2");

                    DataRow dr;
                    for (int i = 0; i < dvOperation2.Count; i++)
                    {
                        dr = dt1.NewRow();
                        dr["id"] = dvOperation2[i]["id"].ToString();
                        dr["Operation2"] = dvOperation2[i]["Operation2"].ToString();
                        dr["Budget2"] = dvOperation2[i]["Budget2"].ToString();
                        dt1.Rows.Add(dr);
                    }
                    dvOperation2 = dt1.DefaultView;
                    Session["Operation2ac"] = dt1;

                    GridViewOperation2.DataSource = dvOperation2;
                    GridViewOperation2.CheckListDataField = "id";
                    GridViewOperation2.DataBind();
                }
            }

            string EmpName = "";
            string EmpCode = "";
            strSql = "Select a.*, b.EmpName From dtAcEmp a, Employee b Where b.DelFlag = 0 And a.EmpCode = b.EmpID And a.ActivityCode = '{0}'";
            DataView dvEmp = Conn.Select(string.Format(strSql, id));
            if (dvEmp.Count != 0)
            {
                for (int i = 0; i < dvEmp.Count; i++)
                {
                    EmpName += dvEmp[i]["EmpName"].ToString();
                    EmpCode += dvEmp[i]["EmpCode"].ToString();
                    if (i != dvEmp.Count - 1)
                    {
                        EmpName += ",";
                        EmpCode += ",";
                    }
                }
                txtEmp.Text = EmpName;
                userid.Value = EmpCode;
            }

            string DeptName = "";
            string DeptCode = "";
            strSql = "Select a.*, b.DeptName From dtAcDept a, Department b Where b.DelFlag = 0 And a.DeptCode = b.DeptCode And a.ActivityCode = '{0}'";
            DataView dvDept = Conn.Select(string.Format(strSql, id));
            if (dvDept.Count != 0)
            {
                for (int i = 0; i < dvDept.Count; i++)
                {
                    DeptName += dvDept[i]["DeptName"].ToString();
                    DeptCode += dvDept[i]["DeptCode"].ToString();
                    if (i != dvDept.Count - 1)
                    {
                        DeptName += ",";
                        DeptCode += ",";
                    }
                }
                txtDepartment.Text = DeptName;
                JId.Value = DeptCode;
            }

            string SubDeptName = "";
            string SubDeptCode = "";
            strSql = "Select a.*, b.SubDeptName From dtAcSubDept a, SubDepartment b Where b.DelFlag = 0 And a.SubDeptCode = b.SubDeptCode And a.ActivityCode = '{0}'";
            DataView dvSubDept = Conn.Select(string.Format(strSql, id));
            if (dvSubDept.Count != 0)
            {
                for (int i = 0; i < dvSubDept.Count; i++)
                {
                    SubDeptName += dvSubDept[i]["SubDeptName"].ToString();
                    SubDeptCode += dvSubDept[i]["SubDeptCode"].ToString();
                    if (i != dvSubDept.Count - 1)
                    {
                        SubDeptName += ",";
                        SubDeptCode += ",";
                    }
                }
                txtSubDept.Text = SubDeptName;
                SubDeptid.Value = SubDeptCode;
            }

            txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString();
            ddlSDay.SelectedValue = Convert.ToDateTime(dv[0]["SDate"]).Day.ToString("00");
            ddlSMonth.SelectedValue = Convert.ToDateTime(dv[0]["SDate"]).Month.ToString("00");
            ddlSYear.SelectedValue = (Convert.ToDateTime(dv[0]["SDate"]).Year + 543).ToString();
            ddlSDay.Enabled = false;
            ddlSMonth.Enabled = false;
            ddlSYear.Enabled = false;
            txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString();
            ddlEDay.SelectedValue = Convert.ToDateTime(dv[0]["EDate"]).Day.ToString("00");
            ddlEMonth.SelectedValue = Convert.ToDateTime(dv[0]["EDate"]).Month.ToString("00");
            ddlEYear.SelectedValue = (Convert.ToDateTime(dv[0]["EDate"]).Year + 543).ToString();
            ddlEDay.Enabled = false;
            ddlEMonth.Enabled = false;
            ddlEYear.Enabled = false;
            txtRealSDate.Text = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.ToShortDateString() : Convert.ToDateTime(dv[0]["RealSDate"]).ToShortDateString());
            ddlRealSDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.Day.ToString("00") : Convert.ToDateTime(dv[0]["RealSDate"]).Day.ToString("00"));
            ddlRealSMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.Month.ToString("00") : Convert.ToDateTime(dv[0]["RealSDate"]).Month.ToString("00"));
            ddlRealSYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? (DateTime.Now.Year + 543).ToString() : (Convert.ToDateTime(dv[0]["RealSDate"]).Year + 543).ToString());
            txtRealEDate.Text = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.ToShortDateString() : Convert.ToDateTime(dv[0]["RealEDate"]).ToShortDateString());
            ddlRealEDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.Day.ToString("00") : Convert.ToDateTime(dv[0]["RealEDate"]).Day.ToString("00"));
            ddlRealEMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? DateTime.Now.Month.ToString("00") : Convert.ToDateTime(dv[0]["RealEDate"]).Month.ToString("00"));
            ddlRealEYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["RealSDate"].ToString()) ? (DateTime.Now.Year + 543).ToString() : (Convert.ToDateTime(dv[0]["RealEDate"]).Year + 543).ToString());
            txtAlertDay.Text = dv[0]["AlertDay"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Activity", "ActivityCode", id);
            if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
            {
                lbtEditCreate.Visible = true;
            }
        }      

        strSql = " Select a.*, a.ListName As EntryCostsName, a.EntryCostsCode As EntryCostsCode, '' As txtCostsName, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End "
                + " From CostsDetail a, BudgetType b "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
        dvBudget = Conn.Select(string.Format(strSql + " Order By b.Sort ", id));

        if (dvBudget.Count != 0)
        {
            for (int i = 0; i < dvBudget.Count; i++)
            {
                dvBudget[i]["txtCostsName"] = new BTC().getEntryCostsName(dvBudget[i]["EntryCostsCode"].ToString());
            }
            if (Session["budget"] == null)
            {
                DataTable dt1 = new DataTable();
                dt1.Columns.Add("id");
                dt1.Columns.Add("EntryCostsName");
                dt1.Columns.Add("txtCostsName");
                dt1.Columns.Add("EntryCostsCode");
                dt1.Columns.Add("BudgetTypeName");
                dt1.Columns.Add("BudgetTypeCode");
                dt1.Columns.Add("TotalP");
                dt1.Columns.Add("TotalD");
                dt1.Columns.Add("TotalG");
                dt1.Columns.Add("TotalMoney", typeof(decimal));

                DataRow dr;
                for (int i = 0; i < dvBudget.Count; i++)
                {
                    dr = dt1.NewRow();
                    dr["id"] = dr.Table.Rows.Count;
                    dr["EntryCostsName"] = dvBudget[i]["EntryCostsName"].ToString();
                    dr["txtCostsName"] = dvBudget[i]["txtCostsName"].ToString();
                    dr["EntryCostsCode"] = dvBudget[i]["EntryCostsCode"].ToString();
                    dr["BudgetTypeName"] = dvBudget[i]["BudgetTypeName"].ToString();
                    dr["BudgetTypeCode"] = dvBudget[i]["BudgetTypeCode"].ToString();
                    dr["TotalP"] = dvBudget[i]["TotalP"].ToString();
                    dr["TotalD"] = dvBudget[i]["TotalD"].ToString();
                    dr["TotalG"] = dvBudget[i]["TotalG"].ToString();
                    dr["TotalMoney"] = dvBudget[i]["TotalMoney"].ToString();
                    dt1.Rows.Add(dr);
                }
                dvBudget = dt1.DefaultView;
                Session["budget"] = dt1;

                GridViewBudget.DataSource = dvBudget;
                GridViewBudget.CheckListDataField = "id";
                GridViewBudget.DataBind();
                btaddBudget.Visible = false;
                btDelBudget.Visible = false;
                GridViewBudget.Columns[8].Visible = false;
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
            }
        }
        btDelBudget.Visible = false;
        btaddBudget.Visible = false;
        getLogDate(Request["id"]);
        getLogBudget(Request["id"]);
        getSummarizeBudget();
    }
    private void getProjectsDetail(string ProjectsID)
    {
        string strSql = " Select StrategiesCode, ProjectsDetail, Purpose, Target, Target2, Expected From Projects Where DelFlag = 0 And ProjectsCode = '" + ProjectsID + "'";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            txtActivityDetail.Text = dv[0]["ProjectsDetail"].ToString();
            txtPurpose.Text = dv[0]["Purpose"].ToString();
            txtTarget.Text = dv[0]["Target"].ToString();
            txtTarget2.Text = dv[0]["Target2"].ToString();
            txtExpected.Text = dv[0]["Expected"].ToString();
        }
        else
        {
            ddlStrategies.SelectedIndex = 0;
            txtActivityDetail.Text = "";
            txtPurpose.Text = "";
            txtTarget.Text = "";
            txtTarget2.Text = "";
            txtExpected.Text = "";
        }
    }
    private void getLogDate(string id)
    {
        DataView dv = Conn.Select("Select a.*, b.EmpName, '' As LogDateName from dtEditDateAc a, Employee b Where a.UpdateUser = b.EmpID And a.ActivityCode = '" + id + "' Order By a.UpdateDate Desc");
        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["LogDateName"] = "วันที่เริ่มกิจกรรมเดิม : " + Convert.ToDateTime(dv[i]["OldSDate"]).ToShortDateString() + ", วันที่สิ้นสุดกิจกรรมเดิม : " + Convert.ToDateTime(dv[i]["OldEDate"]).ToShortDateString() + " - ผู้แก้ไขล่าสุด : " + dv[i]["EmpName"].ToString() + " - " + Convert.ToDateTime(dv[i]["UpdateDate"]).ToShortDateString();
            }
            lblLogDate.Text = "แก้ไขวันที่ล่าสุด : ";
            rptLogEditDate.DataSource = dv;
            rptLogEditDate.DataBind();
            rptLogEditDate.Visible = true;
        }
        else
        {
            rptLogEditDate.DataSource = dv;
            rptLogEditDate.DataBind();
            rptLogEditDate.Visible = false;
        }
    }
    private void getLogBudget(string id)
    {
        DataView dv = Conn.Select("Select a.*, b.EmpName, '' As LogBudgetName from dtEditBudgetAc a, Employee b Where a.UpdateUser = b.EmpID And a.ActivityCode = '" + id + "' Order By a.UpdateDate Desc");
        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["LogBudgetName"] = "งบประมาณเดิม : " + Convert.ToDecimal(dv[i]["OldBudget"]).ToString("#,##0.00") + " - ผู้แก้ไขล่าสุด : " + dv[i]["EmpName"].ToString() + " - " + Convert.ToDateTime(dv[i]["UpdateDate"]).ToShortDateString();
            }
            lblLogBudget.Text = "แก้ไขงบประมาณล่าสุด : ";
            rptLogEditBudget.DataSource = dv;
            rptLogEditBudget.DataBind();
            rptLogEditBudget.Visible = true;
        }
        else
        {
            rptLogEditBudget.DataSource = dv;
            rptLogEditBudget.DataBind();
            rptLogEditBudget.Visible = false;
        }     
    }
    private void ClearAll()
    {
        Session.Remove("budget");
        GridViewBudget.DataSource = null;
        GridViewBudget.DataBind();

        Session.Remove("Operation2ac");
        GridViewOperation2.DataSource = null;
        GridViewOperation2.DataBind();

        getSummarizeBudget();

        txtActivity.Text = "";
        txtActivityDetail.Text = "";
        txtPurpose.Text = "";
        txtTarget.Text = "";
        txtTarget2.Text = "";
        txtOperation1.Text = "";
        txtPeriod1.Text = "";
        txtPlace1.Text = "";
        txtEmp1.Text = "";
        txtPeriod2.Text = "";
        txtPlace2.Text = "";
        txtEmp2.Text = "";
        txtOperation3.Text = "";
        txtPeriod3.Text = "";
        txtPlace3.Text = "";
        txtEmp3.Text = "";
        txtSolutions.Text = "";
        txtEvaluation.Text = "";
        txtEvaIndicators.Text = "";
        txtEvaAssessment.Text = "";
        txtEvaTool.Text = "";
        txtExpected.Text = "";
        txtEmp.Text = "";
        txtDepartment.Text = "";
        userid.Value = "";
        JId.Value = "";
        txtSubDept.Text = "";
        SubDeptid.Value = "";
        txtPlace.Text = "";
        rbtlType.SelectedIndex = 0;
        txtSDay.Text = DateTime.Now.ToShortDateString();
        txtEDay.Text = DateTime.Now.ToShortDateString();
        txtRealSDate.Text = DateTime.Now.ToShortDateString(); 
        txtRealEDate.Text = DateTime.Now.ToShortDateString();
        txtAlertDay.Text = "0";
        txtVolumeExpect.Text = "0";
        // txtSort.Text = "";
        txtSearch.Text = "";
        lblTotalAmount.Text = "0.00";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {       
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            //btc.UpdateDefault("Activity");
            Int32 i = Conn.AddNew("Activity", "ActivityCode, StrategiesCode, ProjectsCode, ActivityName, IdentityName, IdentityName2, ActivityDetail, Purpose, Target, Target2, Operation1, Period1, Place1, Emp1, Period2, Place2, Emp2, Operation3, Period3, Place3, Emp3, Solutions, Evaluation, EvaIndicators, EvaAssessment, EvaTool, Expected, VolumeExpect, Place, CostsType, TotalAmount, StudyYear, BudgetYear, Term, YearB, SDate, EDate, RealSDate, RealEDate, AlertDay, Sort, Df, Status, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlStrategies.SelectedValue, ddlProjects.SelectedValue, txtActivity.Text, txtIdentityName.Text, txtIdentityName2.Text, txtActivityDetail.Text, txtPurpose.Text, txtTarget.Text, txtTarget2.Text, txtOperation1.Text, txtPeriod1.Text, txtPlace1.Text, txtEmp1.Text, txtPeriod2.Text, txtPlace2.Text, txtEmp2.Text, txtOperation3.Text, txtPeriod3.Text, txtPlace3.Text, txtEmp3.Text, txtSolutions.Text, txtEvaluation.Text, txtEvaIndicators.Text, txtEvaAssessment.Text, txtEvaTool.Text, txtExpected.Text, Convert.ToDecimal(txtVolumeExpect.Text), txtPlace.Text, rbtlType.SelectedValue, Convert.ToDecimal(lblTotalAmount.Text), ddlYearB.SelectedValue, txtBudgetYear.Text, ddlTerm.SelectedValue, txtYearB.Text, Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), Convert.ToDateTime(txtRealSDate.Text).ToString("s"), Convert.ToDateTime(txtRealEDate.Text).ToString("s"), txtAlertDay.Text, txtSort.Text, 1, 0, 0, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (userid.Value != "")
            {
                string[] EmpID = userid.Value.Split(',');
                for (int j = 0; j < EmpID.Length; j++)
                {
                    Conn.AddNew("dtAcEmp", "ActivityCode, EmpCode", NewID, EmpID[j]);
                }
            }
            if (JId.Value != "")
            {
                string[] DeptID = JId.Value.Split(',');
                for (int j = 0; j < DeptID.Length; j++)
                {
                    Conn.AddNew("dtAcDept", "ActivityCode, DeptCode", NewID, DeptID[j]);
                }
            }
            if (SubDeptid.Value != "")
            {
                string[] SubDeptID = SubDeptid.Value.Split(',');
                for (int j = 0; j < SubDeptID.Length; j++)
                {
                    Conn.AddNew("dtAcSubDept", "ActivityCode, SubDeptCode", NewID, SubDeptID[j]);
                }
            }
            //Operation
            if (Session["Operation2ac"] != null)
            {
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["Operation2ac"];
                dvOperation2 = dt1.DefaultView;
                for (int j = 0; j < dvOperation2.Count; j++)
                {
                    Conn.AddNew("ActivityOperation2", "ActivityCode, RecNum, Operation2, Budget2", NewID, Convert.ToDecimal(dvOperation2[j]["id"]), dvOperation2[j]["Operation2"].ToString(), Convert.ToDecimal(dvOperation2[j]["Budget2"]));
                }
            }

            //Budget
            if (Session["budget"] != null)
            {
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["budget"];
                dvBudget = dt1.DefaultView;
                for (int j = 0; j < dvBudget.Count; j++)
                {
                    Conn.AddNew("CostsDetail", "ActivityCode, ListName, EntryCostsCode, BudgetTypeCode, BudgetTypeOtherName, TotalP, TotalD, TotalG, TotalMoney, TotalMoney2", NewID, dvBudget[j]["EntryCostsName"].ToString(), dvBudget[j]["EntryCostsCode"].ToString(), dvBudget[j]["BudgetTypeCode"].ToString(), dvBudget[j]["BudgetTypeName"].ToString(), dvBudget[j]["TotalP"], Convert.ToDecimal(dvBudget[j]["TotalD"]), Convert.ToDecimal(dvBudget[j]["TotalG"]), Convert.ToDecimal(dvBudget[j]["TotalMoney"]), 0);
                }
            }

            btc.UpdateStatusActivity();

            if (CkAgain == "N")
            {
                Response.Redirect("Activity.aspx?ckmode=1&Cr=" + i);   
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                SetItem();
                getProjectsDetail(ddlProjects.SelectedValue);
                btc.GenSort(txtSort, "Activity", " And ProjectsCode = '" + ddlProjects.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
                GridView3.Visible = true;
                DataBind();
            }
            if (CkAgain == "G")
            {
                Session.Remove("budget");
                Response.Redirect("Indicators2.aspx?mode=1&id=" + NewID + "&syear=" + ddlYearB.SelectedValue + "&stgid=" + ddlStrategies.SelectedValue + "&pjid=" + ddlProjects.SelectedValue);
            }
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("Activity", "Where ActivityCode = '" + Request["id"] + "' ", "StrategiesCode, ProjectsCode, ActivityName, IdentityName, IdentityName2, ActivityDetail, Purpose, Target, Target2, Operation1, Period1, Place1, Emp1, Period2, Place2, Emp2, Operation3, Period3, Place3, Emp3, Solutions, Evaluation, EvaIndicators, EvaAssessment, EvaTool, Expected, VolumeExpect, Place, CostsType, StudyYear, BudgetYear, Term, YearB, RealSDate, RealEDate, AlertDay, Sort, SchoolID, UpdateUser, UpdateDate", ddlStrategies.SelectedValue, ddlProjects.SelectedValue, txtActivity.Text, txtIdentityName.Text, txtIdentityName2.Text, txtActivityDetail.Text, txtPurpose.Text, txtTarget.Text, txtTarget2.Text, txtOperation1.Text, txtPeriod1.Text, txtPlace1.Text, txtEmp1.Text, txtPeriod2.Text, txtPlace2.Text, txtEmp2.Text, txtOperation3.Text, txtPeriod3.Text, txtPlace3.Text, txtEmp3.Text, txtSolutions.Text, txtEvaluation.Text, txtEvaIndicators.Text, txtEvaAssessment.Text, txtEvaTool.Text, txtExpected.Text, Convert.ToDecimal(txtVolumeExpect.Text), txtPlace.Text, rbtlType.SelectedValue, ddlYearB.SelectedValue, txtBudgetYear.Text, ddlTerm.SelectedValue, txtYearB.Text, Convert.ToDateTime(txtRealSDate.Text).ToString("s"), Convert.ToDateTime(txtRealEDate.Text).ToString("s"), txtAlertDay.Text, txtSort.Text, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now);
            Conn.Delete("dtAcEmp", "Where ActivityCode = '" + Request["id"] + "' ");
            Conn.Delete("dtAcDept", "Where ActivityCode = '" + Request["id"] + "' ");
            Conn.Delete("dtAcSubDept", "Where ActivityCode = '" + Request["id"] + "' ");
            if (userid.Value != "")
            {
                string[] EmpID = userid.Value.Split(',');
                for (int j = 0; j < EmpID.Length; j++)
                {
                    Conn.AddNew("dtAcEmp", "ActivityCode, EmpCode", Request["id"], EmpID[j]);
                }
            }
            if (JId.Value != "")
            {
                string[] DeptID = JId.Value.Split(',');
                for (int j = 0; j < DeptID.Length; j++)
                {
                    Conn.AddNew("dtAcDept", "ActivityCode, DeptCode", Request["id"], DeptID[j]);
                }
            }
            if (SubDeptid.Value != "")
            {
                string[] SubDeptID = SubDeptid.Value.Split(',');
                for (int j = 0; j < SubDeptID.Length; j++)
                {
                    Conn.AddNew("dtAcSubDept", "ActivityCode, SubDeptCode", Request["id"], SubDeptID[j]);
                }
            }
            //Operation
            if (Session["Operation2ac"] != null)
            {
                Conn.Delete("ActivityOperation2", "Where ActivityCode = '" + Request["id"] + "'");
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["Operation2ac"];
                dvOperation2 = dt1.DefaultView;
                for (int j = 0; j < dvOperation2.Count; j++)
                {
                    Conn.AddNew("ActivityOperation2", "ActivityCode, RecNum, Operation2, Budget2", Request["id"], Convert.ToDecimal(dvOperation2[j]["id"]), dvOperation2[j]["Operation2"].ToString(), Convert.ToDecimal(dvOperation2[j]["Budget2"]));
                }
            }

            btc.UpdateStatusActivity();
            Response.Redirect("PopUpActivity.aspx?mode=2&id=" + Request["id"] + "&ckmode=2&Cr=" + i);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "PopUpClose();", true);
        }
    }
    protected void SearchDept_Click(object sender, EventArgs e)
    {
        DataView dv, dv1;
        if (userid.Value != "")
        {
            string[] EmpID = userid.Value.Split(',');
            string NewEmpID = "";
            for (int j = 0; j < EmpID.Length; j++)
            {
                NewEmpID += "'" + EmpID[j] + "'";
                if (j != EmpID.Length - 1)
                {
                    NewEmpID += ",";
                }
            }

            string strSql = " Select Distinct(EmpID) EmpID, EmpName From Employee "
                        + " Where DelFlag = 0 And EmpID In(" + NewEmpID + ")";
            dv = Conn.Select(strSql);
            if (dv.Count != 0)
            {
                string EmpCode = "";
                string EmpName = "";
                for (int i = 0; i < dv.Count; i++)
                {
                    EmpCode += dv[i]["EmpID"].ToString();
                    EmpName += dv[i]["EmpName"].ToString();
                    if (i != dv.Count - 1)
                    {
                        EmpCode += ",";
                        EmpName += ",";
                    }
                    txtEmp.Text = EmpName;
                    userid.Value = EmpCode;
                }
            }
        }

        if (JId.Value != "")
        {
            string[] DeptID = JId.Value.Split(',');
            string NewDeptID = "";
            for (int j = 0; j < DeptID.Length; j++)
            {
                NewDeptID += "'" + DeptID[j] + "'";
                if (j != DeptID.Length - 1)
                {
                    NewDeptID += ",";
                }
            }

            string strSql = " Select Distinct(DeptCode) DeptCode, DeptName From Department "
                        + " Where DelFlag = 0 And DeptCode In(" + NewDeptID + ")";
            dv1 = Conn.Select(strSql);
            if (dv1.Count != 0)
            {
                string DeptCode = "";
                string DeptName = "";
                for (int i = 0; i < dv1.Count; i++)
                {
                    DeptCode += dv1[i]["DeptCode"].ToString();
                    DeptName += dv1[i]["DeptName"].ToString();
                    if (i != dv1.Count - 1)
                    {
                        DeptCode += ",";
                        DeptName += ",";
                    }
                    txtDepartment.Text = DeptName;
                    JId.Value = DeptCode;
                }
            }
        }
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void btSearchInd_Click(object sender, EventArgs e)
    {
        if (hdfEvaIndicators.Value != "")
        {
            string[] RefID = hdfEvaIndicators.Value.Split(',');
            string NewID = "";
            for (int j = 0; j < RefID.Length; j++)
            {
                NewID += "'" + RefID[j] + "'";
                if (j != RefID.Length - 1)
                {
                    NewID += ",";
                }
            }

            string strSql = " Select RecNum As ID, IndicatorName As Name From StrategiesIndicators "
                        + " Where StrategiesCode = '" + ddlStrategies.SelectedValue + "' And RecNum In (" + NewID + ")";

            DataView dv = Conn.Select(strSql);
            if (dv.Count != 0)
            {
                string ID = "";
                string Name = "";

                for (int i = 0; i < dv.Count; i++)
                {
                    ID += dv[i]["ID"].ToString();
                    Name += dv[i]["Name"].ToString();
                    if (i != dv.Count - 1)
                    {
                        ID += ",";
                        Name += ",";
                    }
                    txtEvaIndicators.Text = Name;
                    hdfEvaIndicators.Value = ID;
                }
            }
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
    protected void btSaveAndGo_Click(object sender, EventArgs e)
    {
        bt_Save("G");
    }
    private void enableMode(Boolean enables)
    {
        btEditDate.Enabled = !enables;
        btEditBudget.Enabled = enables;

        ddlSDay.Enabled = enables;
        ddlSMonth.Enabled = enables;
        ddlSYear.Enabled = enables;
        ddlEDay.Enabled = enables;
        ddlEMonth.Enabled = enables;
        ddlEYear.Enabled = enables;

        btDelBudget.Visible = !enables;
        btaddBudget.Visible = !enables;
        GridViewBudget.Columns[8].Visible = !enables;      
    }
    protected void btEditDate_Click(object sender, EventArgs e)
    {
        btc.btEnable(btSave, false);
        btc.btEnable(btSaveEditDate, true);
        btc.btEnable(btSaveEditBudget, false);
        btc.btEnable(btCancelEdit2, true);
        enableMode(true);
    }
    protected void btEditBudget_Click(object sender, EventArgs e)
    {
        btc.btEnable(btSave, false);
        btc.btEnable(btSaveEditDate, false);
        btc.btEnable(btSaveEditBudget, true);
        btc.btEnable(btCancelEdit, true);
        enableMode(false);
    }
    protected void btApproveBudget_Click(object sender, EventArgs e)
    {
        Conn.Update("Activity", "Where ActivityCode = '" + Request["id"] + "'", "ApproveFlag, ApproveUser", 1, CurrentUser.ID);
        btApproveBudget.Visible = false;
        DataView dvApproveUser = Conn.Select("Select ApproveUser From Activity Where ActivityCode = '" + Request["id"] + "'");
        if (!string.IsNullOrEmpty(dvApproveUser[0]["ApproveUser"].ToString()))
        {
            string ApproveName = "";
            ApproveName = btc.getEmpName(dvApproveUser[0]["ApproveUser"].ToString());
            lblAlertApprove.Text = "*** กิจกรรมนี้ได้ถูกอนุมัติแล้ว โดยคุณ " + ApproveName + " ถ้าต้องการแก้ไขวันที่ดำเนินการหรือแก้ไขงบประมาณ  กรุณาติดต่อฝ่ายแผนงาน";
        }
        lblAlertApprove.Visible = true;
    }
    protected void btSaveEditDate_Click(object sender, EventArgs e)
    {
        DataView dv = Conn.Select("Select SDate, EDate From Activity Where ActivityCode = '" + Request["id"] + "'");
        Conn.AddNew("dtEditDateAc", "ActivityCode, OldSDate, OldEdate, UpdateUser, UpdateDate", Request["id"], dv[0]["SDate"], dv[0]["EDate"], CurrentUser.ID, DateTime.Now);

        Int32 i = Conn.Update("Activity", "Where ActivityCode = '" + Request["id"] + "' ", "SDate, EDate, UpdateUser, UpdateDate", Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), CurrentUser.ID, DateTime.Now);
        btc.UpdateStatusActivity();
        ClearEdit();
    }
    protected void btSaveEditBudget_Click(object sender, EventArgs e)
    {
        DataView dv = Conn.Select("Select TotalAmount From Activity Where ActivityCode = '" + Request["id"] + "'");
        Conn.AddNew("dtEditBudgetAc", "ActivityCode, OldBudget, UpdateUser, UpdateDate", Request["id"], dv[0]["TotalAmount"], CurrentUser.ID, DateTime.Now);

        Int32 i = Conn.Update("Activity", "Where ActivityCode = '" + Request["id"] + "' ", "TotalAmount, UpdateUser, UpdateDate", Convert.ToDecimal(lblTotalAmount.Text), CurrentUser.ID, DateTime.Now);

        //Budget
        if (Session["budget"] != null)
        {
            Conn.Delete("CostsDetail", "Where ActivityCode = '" + Request["id"] + "'");
            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["budget"];
            dvBudget = dt1.DefaultView;
            for (int j = 0; j < dvBudget.Count; j++)
            {
                Conn.AddNew("CostsDetail", "ActivityCode, ListName, EntryCostsCode, BudgetTypeCode, BudgetTypeOtherName, TotalP, TotalD, TotalG, TotalMoney, TotalMoney2", Request["id"], dvBudget[j]["EntryCostsName"].ToString().Trim(), dvBudget[j]["EntryCostsCode"].ToString(), dvBudget[j]["BudgetTypeCode"].ToString(), dvBudget[j]["BudgetTypeName"].ToString(), dvBudget[j]["TotalP"], Convert.ToDecimal(dvBudget[j]["TotalD"]), Convert.ToDecimal(dvBudget[j]["TotalG"]), Convert.ToDecimal(dvBudget[j]["TotalMoney"]), 0);
            }
        }
        ClearEdit();
    }
    protected void btCancelEdit_Click(object sender, EventArgs e)
    {
        ClearEdit();
    }
    private void ClearEdit()
    {
        btEditDate.Enabled = true;
        btEditBudget.Enabled = true;
        GridViewBudget.Columns[8].Visible = false;
        btc.btEnable(btSave, true);
        btc.btEnable(btSaveEditDate, false);
        btc.btEnable(btSaveEditBudget, false);
        btc.btEnable(btCancelEdit, false);
        btc.btEnable(btCancelEdit2, false);

        ddlSDay.Enabled = false;
        ddlSMonth.Enabled = false;
        ddlSYear.Enabled = false;
        ddlEDay.Enabled = false;
        ddlEMonth.Enabled = false;
        ddlEYear.Enabled = false;

        btaddBudget.Visible = false;
        btDelBudget.Visible = false;

        getddlDepartment();
        getLogDate(Request["id"]);
        getLogBudget(Request["id"]);
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        int i = 0;
        if (btc.CkUseData(id, "ActivityCode", "Indicators2", " And DelFlag = 0 "))
        {
            Response.Redirect("Activity.aspx?ckmode=3&Cr=" + i);
        }
        else
        {
            i = Conn.Update("Activity", "Where ActivityCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Conn.Update("ActivityDetail", "Where ActivityCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Conn.Delete("ActivityOperation2", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtAcDept", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtAcEmp", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtAcSubDept", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtFactor", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtEditBudgetAc", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("dtEditDateAc", "Where ActivityCode = '" + Request["id"] + "'");
            Conn.Delete("CostsDetail", "Where ActivityCode = '" + Request["id"] + "'");
            Response.Redirect("Activity.aspx?ckmode=3&Cr=" + i);
        }
    }
    protected void ddlProjects_OnSelectedChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Activity", " And ProjectsCode = '" + ddlProjects.SelectedValue + "'");
        getProjectsDetail(ddlProjects.SelectedValue);
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlStrategies(0, ddlSearchYear.SelectedValue);
        getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
        DataBind();
    }
    protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("AcStrategies", ddlSearch2.SelectedValue);
        getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("AcProjects", ddlSearch.SelectedValue);
        ddlSearch2.SelectedValue = btc.getStrategiesCodeOfProj(ddlSearch.SelectedValue);
        Cookie.SetValue2("AcStrategies", ddlSearch2.SelectedValue);
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("AcDept", ddlSearchDept.SelectedValue);
        //Session["AcDept"] = ddlSearchDept.SelectedValue;
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("AcEmp", ddlSearchEmp.SelectedValue);
        //Session["AcEmp"] = ddlSearchEmp.SelectedValue;
        DataBind();
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        getddlStrategies(1, ddlYearB.SelectedValue);
        getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void ddlStrategies_OnSelectedChanged(object sender, EventArgs e)
    {
        getddlProjects(1, ddlYearB.SelectedValue, ddlStrategies.SelectedValue);
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.ForeColor = btc.getColorRowsGrid(DataBinder.Eval(e.Row.DataItem, "status").ToString());
        }
    }
    protected void btaddOperation2_Click(object sender, EventArgs e)
    {
        if (Session["Operation2ac"] == null)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("id");
            dt1.Columns.Add("Operation2");
            dt1.Columns.Add("budget2");

            DataRow dr;
            dr = dt1.NewRow();
            dr["id"] = dr.Table.Rows.Count;
            dr["Operation2"] = txtOperation2.Text;
            dr["budget2"] = txtBudget2.Text;
            dt1.Rows.Add(dr);

            dvOperation2 = dt1.DefaultView;
            Session["Operation2ac"] = dt1;
        }
        else
        {
            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["Operation2ac"];

            if (txtid2.Text == "")
            {
                DataView ckdv = ((DataTable)Session["Operation2ac"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int i = 0; i < ckdv.Count; i++)
                    {
                        if (ckdv[i]["Operation2"].ToString() == txtOperation2.Text)
                        {
                            lblckOperation2.Visible = true;
                            return;
                        }
                    }
                }
                DataRow dr;
                dr = dt1.NewRow();
                dr["id"] = dr.Table.Rows.Count;
                dr["Operation2"] = txtOperation2.Text;
                dr["budget2"] = txtBudget2.Text;
                dt1.Rows.Add(dr);
            }
            else
            {
                DataView ckdv = ((DataTable)Session["Operation2ac"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int j = 0; j < ckdv.Count; j++)
                    {
                        if ((ckdv[j]["id"].ToString() != txtid2.Text) && (ckdv[j]["Operation2"].ToString() == txtOperation2.Text))
                        {
                            lblckOperation2.Visible = true;
                            return;
                        }
                    }
                }
                Int32 i = Convert.ToInt32(txtid2.Text);
                dt1.Rows[i]["Operation2"] = txtOperation2.Text;
                dt1.Rows[i]["budget2"] = txtBudget2.Text;
            }
            lblckOperation2.Visible = false;

            dvOperation2 = dt1.DefaultView;
            Session["Operation2ac"] = dt1;
        }
        //dvBudget.Sort = "YearE DESC";
        ClearOperation2();
        GridViewOperation2.DataSource = dvOperation2;
        GridViewOperation2.CheckListDataField = "id";
        GridViewOperation2.DataBind();
        if (dvOperation2.Count > 0)
        {
            btDelOperation2.Visible = true;
        }
    }
    private void ClearOperation2()
    {
        txtid2.Text = "";
        txtOperation2.Text = "";
        txtBudget2.Text = "0";
    }
    protected void btDelOperation2_Click(object sender, EventArgs e)
    {
        if (GridViewOperation2.SelectedItems.Length == 0) return;
        DataTable dt1 = new DataTable();
        dt1 = (DataTable)Session["Operation2ac"];
        DataRow[] dra = dt1.Select("id in (" + string.Join(",", GridViewOperation2.SelectedItems) + ")");
        foreach (DataRow dr in dra)
            dr.Delete();
        dt1.AcceptChanges();
        dvOperation2 = dt1.DefaultView;
        Session["Operation2ac"] = dt1;
        GridViewOperation2.DataSource = dvOperation2;
        GridViewOperation2.DataBind();
        if (dvOperation2.Count == 0)
        {
            btDelOperation2.Visible = false;
        }
    }
    protected void btaddBudget_Click(object sender, EventArgs e)
    {
        if (Session["budget"] == null)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("id");
            dt1.Columns.Add("EntryCostsName");
            dt1.Columns.Add("txtCostsName");
            dt1.Columns.Add("EntryCostsCode");
            dt1.Columns.Add("BudgetTypeName");
            dt1.Columns.Add("BudgetTypeCode");
            dt1.Columns.Add("TotalP");
            dt1.Columns.Add("TotalD");
            dt1.Columns.Add("TotalG");
            dt1.Columns.Add("TotalMoney", typeof(decimal));

            DataRow dr;
            dr = dt1.NewRow();
            dr["id"] = dr.Table.Rows.Count;
            dr["EntryCostsName"] = txtListName.Text;
            dr["txtCostsName"] = (ddlEntryCosts.SelectedIndex == 0) ? "" : ddlEntryCosts.SelectedItem.Text;
            dr["EntryCostsCode"] = ddlEntryCosts.SelectedValue;
            dr["BudgetTypeName"] = (ddlBudgetType.SelectedIndex != 3) ? ddlBudgetType.SelectedItem.Text.ToString() : ddlBudgetType.SelectedItem.Text.ToString() + " (" + txtBudgetType.Text + ") ";
            dr["BudgetTypeCode"] = ddlBudgetType.SelectedValue.ToString();
            dr["TotalP"] = txtP.Text;
            dr["TotalD"] = txtD.Text;
            dr["TotalG"] = txtG.Text;
            dr["TotalMoney"] = (Convert.ToDecimal(txtD.Text) * Convert.ToDecimal(txtG.Text));
            dt1.Rows.Add(dr);

            dvBudget = dt1.DefaultView;
            Session["budget"] = dt1;
        }
        else
        {
            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["budget"];

            if (txtid.Text == "")
            {
                DataView ckdv = ((DataTable)Session["budget"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int i = 0; i < ckdv.Count; i++)
                    {
                        if ((ckdv[i]["EntryCostsName"].ToString() == txtListName.Text) && (ckdv[i]["BudgetTypeCode"].ToString() == ddlBudgetType.SelectedValue.ToString()))
                        {
                            lblckBudget.Visible = true;
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
                            return;
                        }
                    }
                }

                DataRow dr;
                dr = dt1.NewRow();
                dr["id"] = dr.Table.Rows.Count;
                dr["EntryCostsName"] = txtListName.Text;
                dr["txtCostsName"] = (ddlEntryCosts.SelectedIndex == 0) ? "" : ddlEntryCosts.SelectedItem.Text;
                dr["EntryCostsCode"] = ddlEntryCosts.SelectedValue;
                dr["BudgetTypeName"] = (ddlBudgetType.SelectedIndex != 3) ? ddlBudgetType.SelectedItem.Text.ToString() : ddlBudgetType.SelectedItem.Text.ToString() + " (" + txtBudgetType.Text + ") ";
                dr["BudgetTypeCode"] = ddlBudgetType.SelectedValue.ToString();
                dr["TotalP"] = txtP.Text;
                dr["TotalD"] = txtD.Text;
                dr["TotalG"] = txtG.Text;
                dr["TotalMoney"] = (Convert.ToDecimal(txtD.Text) * Convert.ToDecimal(txtG.Text));
                dt1.Rows.Add(dr);
            }
            else
            {
                DataView ckdv = ((DataTable)Session["budget"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int j = 0; j < ckdv.Count; j++)
                    {
                        if ((ckdv[j]["id"].ToString() != txtid.Text) && (ckdv[j]["EntryCostsName"].ToString() == txtListName.Text) && (ckdv[j]["BudgetTypeCode"].ToString() == ddlBudgetType.SelectedValue.ToString()))
                        {
                            lblckBudget.Visible = true;
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
                            return;
                        }
                    }
                }

                Int32 i = Convert.ToInt32(txtid.Text);
                dt1.Rows[i]["EntryCostsName"] = txtListName.Text;
                dt1.Rows[i]["txtCostsName"] = (ddlEntryCosts.SelectedIndex == 0) ? "" : ddlEntryCosts.SelectedItem.Text;
                dt1.Rows[i]["EntryCostsCode"] = ddlEntryCosts.SelectedValue;
                dt1.Rows[i]["BudgetTypeName"] = (ddlBudgetType.SelectedIndex != 3) ? ddlBudgetType.SelectedItem.Text.ToString() : ddlBudgetType.SelectedItem.Text.ToString() + " (" + txtBudgetType.Text + ") ";
                dt1.Rows[i]["BudgetTypeCode"] = ddlBudgetType.SelectedValue.ToString();
                dt1.Rows[i]["TotalP"] = txtP.Text;
                dt1.Rows[i]["TotalD"] = txtD.Text;
                dt1.Rows[i]["TotalG"] = txtG.Text;
                dt1.Rows[i]["TotalMoney"] = (Convert.ToDecimal(txtD.Text) * Convert.ToDecimal(txtG.Text));
            }
            lblckBudget.Visible = false;

            dvBudget = dt1.DefaultView;
            Session["budget"] = dt1;
        }
        //dvBudget.Sort = "YearE DESC";
        ClearBudget();
        GridViewBudget.DataSource = dvBudget;
        GridViewBudget.CheckListDataField = "id";
        GridViewBudget.DataBind();
        if (dvBudget.Count > 0)
        {
            btDelBudget.Visible = true;
        }
        getSummarizeBudget();
    }
    private void ClearBudget()
    {
        txtid.Text = "";
        txtListName.Text = "";
        ddlEntryCosts.SelectedIndex = 0;
        ddlBudgetType.SelectedIndex = 0;
        txtBudgetType.Text = "";
        txtP.Text = "";
        txtD.Text = "0";
        txtG.Text = "0";
        lblTotal.Text = "0.00";
    }
    protected void btDelBudget_Click(object sender, EventArgs e)
    {
        if (GridViewBudget.SelectedItems.Length == 0) return;
        DataTable dt1 = new DataTable();
        dt1 = (DataTable)Session["budget"];
        DataRow[] dra = dt1.Select("id in (" + string.Join(",", GridViewBudget.SelectedItems) + ")");
        foreach (DataRow dr in dra)
            dr.Delete();
        dt1.AcceptChanges();
        dvBudget = dt1.DefaultView;
        Session["budget"] = dt1;
        GridViewBudget.DataSource = dvBudget;
        GridViewBudget.DataBind();
        getSummarizeBudget();
        if (dvBudget.Count == 0)
        {
            btDelBudget.Visible = false;
            lblTotalAmount.Text = "0";
        }
    }
    public decimal GetTotalMoney(decimal Budget)
    {
        TotalMoney += Budget;
        return Budget;
    }
    public decimal GetSumTotalMoney()
    {
        lblTotalAmount.Text = TotalMoney.ToString("#,##0.00");
        return TotalMoney;
    }
    public decimal GetTotalMoneyOperation(decimal Budget)
    {
        TotalMoneyOperation += Budget;
        return Budget;
    }
    public decimal GetSumTotalMoneyOperation()
    {
        return TotalMoneyOperation;
    }
    private void getSummarizeBudget()
    {
        if (Session["budget"] != null)
        {
            DataTable dt1, dt2, dt3;
            dt2 = new DataTable();
            dt1 = (DataTable)Session["budget"];
            
            dt2 = dt1.DefaultView.ToTable(true, "BudgetTypeCode", "BudgetTypeName");
            //dt2.Columns.Add("BudgetTypeName");
            dt2.Columns.Add("TotalMoney");
            
            foreach (DataRow dr in dt2.Rows)
                dr["TotalMoney"] = dt1.Compute("SUM(TotalMoney)", "BudgetTypeCode='" + dr["BudgetTypeCode"] + "'");

            if (dt2.Rows.Count != 0)
            {
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    if (dt2.Rows[i]["BudgetTypeCode"].ToString() == "88f2efd0-b802-4528-8ca8-aae8d8352649")
                    {
                        dt2.Rows[i]["BudgetTypeName"] = "อื่น ๆ";
                    }
                }
            }
            dt3 = dt2.DefaultView.ToTable(true, "BudgetTypeCode", "BudgetTypeName", "TotalMoney");
            //Session["budget"] = dt1;
            rptBudget.DataSource = dt3;
            rptBudget.DataBind();
            dt3.Columns["BudgetTypeName"].ColumnName = "name";
            dt3.Columns["TotalMoney"].ColumnName = "data";
            dt3.AcceptChanges();
            ReportGraph(dt3.DefaultView);
        }
        else
        {
            rptBudget.DataSource = null;
            rptBudget.DataBind();
        }
    }
    protected string checkapprove(string id)
    {
        string str = "<a href=\"javascript:;\" onclick=\"printRpt(4,'w','{0}');\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบขออนุมัติกิจกรรม แบบเอกสาร Word\" src=\"../Image/WordIcon.png\"</a>"
            + "<a href=\"javascript:;\" onclick=\"printRpt(4,'p','{0}');\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบขออนุมัติกิจกรรม แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\"</a>";
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
    decimal TotalAmount = 0;
    public decimal GetBudget(decimal Budget)
    {
        TotalAmount += Budget;
        return Budget;
    }
    public decimal GetTotalBudget()
    {
        return TotalAmount;
    }
    private void ModeCreate(Boolean enabled)
    {
        ddlCreateUser.Visible = enabled;
        btnEditCreate.Visible = enabled;
        btnCancelCreate.Visible = enabled;
    }
    protected void lbtEditCreate_Click(object sender, EventArgs e)
    {
        getddlEditCreate();
        ModeCreate(true);
    }
    private void getddlEditCreate()
    {
        string newuid = "";
        if (userid.Value != "")
        {
            string[] uID = userid.Value.Split(',');
            for (int j = 0; j < uID.Length; j++)
            {
                newuid += " '" + uID[j] + "' ";
                if (j != uID.Length - 1)
                {
                    newuid += ",";
                }
            }

            string strSql = "Select EmpID, EmpName From Employee Where EmpID In (" + newuid + ")";        
            DataView dv = Conn.Select(strSql);
            if (dv.Count != 0)
            {
                ddlCreateUser.DataSource = dv;
                ddlCreateUser.DataTextField = "EmpName";
                ddlCreateUser.DataValueField = "EmpID";
                ddlCreateUser.DataBind();
            }
        }
    }
    protected void btnCancelCreate_Click(object sender, EventArgs e)
    {
        ModeCreate(false);
    }
    protected void btnEditCreate_Click(object sender, EventArgs e)
    {
        Conn.Update("Activity", "Where ActivityCode = '" + Request.QueryString["id"] + "'", "CreateUser", ddlCreateUser.SelectedValue);
        GetData(Request.QueryString["id"]);
        ModeCreate(false);
    }
    protected string DateFormat(object startDate, object endDate)
    {
        return Convert.ToDateTime(startDate).ToString("dd/MM/yy") + " - " + Convert.ToDateTime(endDate).ToString("dd/MM/yy");
    }
    protected string GenConnection(int ConnectInd, int ConnectEva)
    { 
        Int32 ckConnect = 0;
        string Detail = "";
        if(ConnectInd > 0)
        {
            ckConnect += 1;
            Detail = "กำหนดตัวชี้วัดแล้ว";
        }
        else
        {
            Detail = "ยังไม่ได้กำหนดตัวชี้วัด";
        }
        if(ConnectEva > 0)
        {
            ckConnect += 1;
            if(Detail == "")
            {
                Detail = "เชื่อมโยงตัวบ่งชี้แล้ว";
            }
            else
            {
                Detail += ", เชื่อมโยงตัวบ่งชี้แล้ว";
            }
        }
        else
        {
            if(Detail == "")
            {
                Detail = "ยังไม่เชื่อมโยงตัวบ่งชี้";
            }
            else
            {
                Detail += ", ยังไม่เชื่อมโยงตัวบ่งชี้";
            }
        }

        if (ckConnect == 2)
        {
            return "<img style=\"border: none; \" title=\"กำหนดตัวชี้วัดและเชื่อมโยงตัวบ่งชี้สมบูรณ์แล้ว\" src='../Image/Connect.png' />";
        }
        else
        {
            //if (ckConnect == 1)
            //{
            //    return "<img style=\"border: none; \" title=\"" + Detail + "\" src='../Image/Connect1.png' />";
            //}
            //else
            //{
                return "<img style=\"border: none; \" title=\"" + Detail + "\" src='../Image/UnConnect.png' />";
            //}
        }       
    }
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    TotalAmount = 0;
    //    DataBind();
    //}
    protected void lblTarget1_TextChanged(object sender, EventArgs e)
    {
        UpdatelblTarget();
    }
    protected void lblTarget2_TextChanged(object sender, EventArgs e)
    {
        UpdatelblTarget();
    }
    private void UpdatelblTarget()
    {
        Conn.Update("MR_School", "Where SchoolID = '" + CurrentUser.SchoolID + "'", "txtTarget1, txtTarget2", lblTarget1.Text, lblTarget2.Text);
    }

    protected StringBuilder chartData;
    protected string chartType;

    void ReportGraph(DataView dv)
    {
        string[] column = { "data1=รายรับ", "data2=รายจ่าย" };
       // VisibleGraph(1, 2, 3, 4);

        //Suffix = "numberSuffix='%25'";
        MaxValue = "yAxisMaxValue ='100'";
        GetChart("Pie2D", dv, "", null, false, "งบประมาณแต่ละประเภท", "");
        graphPnl.Text = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", "Pie2D")), "", chartData.ToString(), "AA", "300", "150", false);
    }
    #region Methods

    string Suffix = null;
    string MaxValue = null;
    string xaxisname = "";
    string yaxisname = "";
    protected void GetChart(string chartName, DataView dv, string column, string[] columns, Boolean compare, string caption, string subCaption)
    {
        if (!string.IsNullOrEmpty(chartName))
        {
            chartType = string.Format("../Charts/{0}.swf", chartName);
            if (chartName == "MSLine" || chartName == "MSColumn2D") compare = true;

            if (dv.Count.Equals(0)) return;

            string baseFont = "Microsoft Sans Serif";
            string baseFontColor = "787878";
            string bgColor = "FFFFFF";
            string canvasBgColor = "FFFFFF";
            string outCnvBaseFont = "Tahoma";
            string outCnvBaseFontColor = "787878";
            string rotateNames = "rotateNames='" + 0 + "'";
            string[] color = { "F31E38", "3C1EF3", "1EF328", "E61EF3", "1EE2F3", "F3EB1E", "FF7777", "FA33BB", "F3A01E", "238627", "78177E", "82B5D5", "7A4E28", "9D9F0C", "F97CC3", "A2919B", "ADFAF4" };
            int baseFontSize = 13;
            int outCnvBaseFontSize = 12;
            int showLimits = 0;

            chartData = new StringBuilder();
            if (chartName != "ScrollColumn2D")// ถ้าไม่ใช่กราฟแบบ scroll
            {
                chartData.Append(string.Format("<chart  palette='2' decimalPrecision='0' showLimits='1' " + Suffix + " " + MaxValue + " " + rotateNames + " shownames='1' showValues='1'  showPercentageValues='1' showPercentageInLabel ='1' animation='1'  caption='{0}' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor));

                if (compare)//gen xml แบบ เปรียบเทียบ
                {
                    chartData.Append("<categories font='Arial' fontSize='11' fontColor='000000'>");

                    //-------========
                    int i = 0;
                    if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
                    {
                        foreach (string col in column.Split(','))
                        {
                            chartData.Append(string.Format("<category name='{0}' />", col));
                        }
                        chartData.Append("</categories>");

                        foreach (string col in columns)
                        {
                            string[] value = col.Split('=');
                            chartData.Append(string.Format("<dataset seriesname='{0}' color='{1}' alpha='70'>", value[0], GetColor(color, i)));
                            string[] v = value[1].Split(',');
                            int c = 0;
                            foreach (string col1 in column.Split(','))
                            {
                                chartData.Append(string.Format("<set value='{0}' />", dv[0][v[c]]));
                                c++;
                            }
                            chartData.Append("</dataset>");
                            i++;
                        }
                    }
                    else//gen xml แบบ record
                    {
                        foreach (DataRowView dr in dv)
                        {
                            chartData.Append(string.Format("<category name='{0}' />", dr["name"]));
                        }
                        chartData.Append("</categories>");

                        foreach (string col in columns)
                        {
                            string[] value = col.Split('=');
                            chartData.Append(string.Format("<dataset seriesname='{0}' color='{1}' alpha='70'>", value[0], GetColor(color, i)));
                            foreach (DataRowView dr in dv)
                            {
                                chartData.Append(string.Format("<set value='{0}' />", dr[value[1]]));
                            }
                            chartData.Append("</dataset>");
                            i++;
                        }
                    }
                }
                else
                {
                    int i = 0;
                    if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
                    {
                        foreach (string col in column.Split(','))
                        {
                            chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", col, dv[0][col], GetColor(color, i)));
                            i++;
                        }
                    }
                    else//gen xml แบบ record 2 คอลัม
                    {
                        foreach (DataRowView dr in dv)
                        {
                            chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", dr["name"], dr["data"], GetColor(color, i)));
                            i++;
                        }
                    }
                }
                chartData.Append("</chart >");
            }
            else //ถ้าเป็นกราฟแบบ scroll
            {
                chartData.Append(string.Format("<chart palette='2' showLimits='1' shownames='1' showValues='1' " + Suffix + " " + rotateNames + " caption='{0}' shownames='1' showvalues='0' useRoundEdges='1' legendBorderAlpha='0' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor));
                chartData.Append("<categories> ");
                if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
                {
                    foreach (string col in column.Split(','))
                    {
                        chartData.Append(string.Format("<category label='{0}'  />", col));
                    }
                    chartData.Append("</categories>");

                    chartData.Append("<dataset showValues='1'>");
                    int i = 0;
                    foreach (string col in column.Split(','))
                    {
                        chartData.Append(string.Format("<set value='{0}' color='{1}'/>", dv[0][col], GetColor(color, i)));
                        i++;
                    }
                }
                else//gen xml แบบ record 2 คอลัม
                {
                    foreach (DataRowView dr in dv)
                    {
                        chartData.Append(string.Format("<category label='{0}'  />", dr["name"]));
                    }
                    chartData.Append("</categories>");

                    chartData.Append("<dataset showValues='1'>");
                    int i = 0;
                    foreach (DataRowView dr in dv)
                    {
                        chartData.Append(string.Format("<set value='{0}' color='{1}'/>", dr["data"], GetColor(color, i)));
                        i++;
                    }
                }
                chartData.Append("</dataset>");
                chartData.Append("</chart>");
            }
        }
    }

    protected string GetColor(string[] color, int num)
    {
        string colorCode;
        if (num < color.Length)
        {
            colorCode = color[num];
        }
        else
        {
            colorCode = color[num % color.Length];
        }
        return colorCode;
    }
    #endregion

}
