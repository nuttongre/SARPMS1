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

public partial class Projects : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    DataView dvApproveFlow = null;
    DataView dvTotalAmout = null;

    decimal TotalAmount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            TotalAmount = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);
            
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        divProjectRegistration.Visible = false;
                        SetItem();
                        btc.getcblStrategicPlan(cblStrategicPlan, ddlYearS.SelectedValue, CurrentUser.DeptID);
                        string gotoid = Request.QueryString["id"];
                        txtResponsibleName.Text = CurrentUser.FirstName.ToString();
                        txtResponsiblePosition.Text = spnResponsibleName.Text;
                        btc.GenSort(txtSort, "Projects", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        //SetItem();
                        btc.btEnable(btSaveAgain, false);
                        btc.btEnable(btSaveAndGo, false);
                        GetData(Request.QueryString["id"]);
                        DataBind();
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        break;
                }
            }
            else
            {
                btc.CkAdmission(GridView1, btAdd, null);
                getddlYear(0);
                //getddlStrategies(0, ddlSearchYear.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                DataBind();
            }
        }
        //txtProjectRegistration.Attributes.Add("onkeyup", "Cktxt(0);");
        //txtIOCode.Attributes.Add("onkeyup", "Cktxt(0);");
        txtProjectsDetail.Attributes.Add("onkeyup", "Cktxt(0);");
        txtProjects.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPurpose.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPurpose2.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTarget.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTarget2.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPeriod1.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPlace.Attributes.Add("onkeyup", "Cktxt(0);");
        //txtExpected.Attributes.Add("onkeyup", "Cktxt(0);");
        txtResponsibleName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtResponsiblePosition.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "return Cktxt(0);");
        ddlSDay.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSMonth.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSYear.Attributes.Add("onchange", "ckddlDate(1);");
        ddlEDay.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEMonth.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEYear.Attributes.Add("onchange", "ckddlDate(2);");
    }
    private void SetItem()
    {
        btc.getddlDay(ddlSDay);
        btc.getddlMonth2(ddlSMonth);
        btc.getddlYear(ddlSYear, 5);
        btc.getddlDay(ddlEDay);
        btc.getddlMonth2(ddlEMonth);
        btc.getddlYear(ddlEYear, 5);
        txtSDay.Text = DateTime.Now.ToShortDateString();
        txtEDay.Text = DateTime.Now.ToShortDateString();

        getlblResponsibleName();
        getrbtlProjectType();
        getrbtlSubProjectType();
        getcblStandardNation(ddlYearS.SelectedValue);
        getcblStandardMinistry(ddlYearS.SelectedValue);
        getcblStrategicObjectives(ddlYearS.SelectedValue);
        getcblStrategic(ddlYearS.SelectedValue);
        getcblIdentityName2();
        btc.getcblCorporateStrategy(divCorporateStrategy, cblCorporateStrategy, ddlYearS.SelectedValue, cblStrategies); //KPI
        btc.getddlStrategicPlan(divStrategicPlan, ddlStrategicPlan, ddlYearS.SelectedValue);
        btc.getddlDepartment(1, ddlDept, CurrentUser.MainSubDeptID, CurrentUser.DeptID, null);
        btc.getddlDepartmentJoin(1, ddlDeptJoin, "", ddlDept.SelectedValue);
        ddlDept.Enabled = false;

        //getcblStrategies(ddlYearS.SelectedValue);
        btc.getcblStrategies(divStrategies, cblStrategies, ddlYearS.SelectedValue);
        btc.IdentityNameEnable(lblIdentityName, txtIdentityName, "IdentityName", "iNameShow", divIdentityName);
        btc.IdentityNameCblEnable(lblIdentityName2, cblIdentityName2, "IdentityName2", "iNameShow2", divIdentityName2);
        btc.IdentityNameCblEnable(lblStrategicObjectives, cblStrategicObjectives, "", "ckStrategicObjectives", divStrategicObjectives);
        btc.IdentityNameCblEnable(lblStandardNation, cblStandardNation, "", "ckStandardNation", divStandardNation);
        btc.IdentityNameCblEnable(lblStandardMinistry, cblStandardMinistry, "", "ckStandardMinistry", divStandardMinistry);
        btc.IdentityNameCblEnable(lblStrategic, cblStrategic, "", "ckStrategic", divStrategic);
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
            btc.getdllStudyYear(ddlYearS);
            btc.getDefault(ddlYearS, "StudyYear", "StudyYear");
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
    //    }
    //}
    private void getlblResponsibleName()
    {
        string[] lblName = btc.getlblResponsibleName().Split(',');
        spnResponsibleName.Text = lblName[0];
    }
    private void getrbtlProjectType()
    {
        btc.getrbtlProjectType(rbtlProjectType);
    }
    private void getrbtlSubProjectType()
    {
        btc.getrbtlSubProjectType(rbtlSubProjectType, rbtlProjectType.SelectedValue);
    }
    private void getcblStandardNation(string StudyYear)
    {
        btc.getcblStandardNation(cblStandardNation, StudyYear);
    }
    private void getcblStandardMinistry(string StudyYear)
    {
        btc.getcblStandardMinistry(cblStandardMinistry, StudyYear);
    }
    private void getcblStrategicObjectives(string StudyYear)
    {
        btc.getcblStrategicObjectives(cblStrategicObjectives, StudyYear);
    }
    private void getcblStrategic(string StudyYear)
    {
        btc.getcblStrategic(cblStrategic, StudyYear);
    }
    private void getcblIdentityName2()
    {
        btc.getcblIdentityName2(cblIdentityName2);
    }
    private void getcblStrategies(string StudyYear)
    {
        btc.getcblStrategies(cblStrategies, StudyYear);
    }
    public override void DataBind()
    {
        TotalAmount = 0;
        string StrSql = "";

        if (Request.QueryString["mode"] != "2")
        {
            StrSql = @"Select P.ProjectsCode, P.ProjectsName, P.IsApprove, P.UserApprove, P.DateApprove, P.Comment,
            PD.EmpID, PD.IsApprove As IsApprove2, PD.CreateDate As DateApprove2, PD.Comment As Comment2 
            From Projects P Left Join ProjectsApproveDetail PD On PD.ProjectsCode = P.ProjectsCode
            Where P.DelFlag = 0 And P.StudyYear = '{0}' And P.SchoolID = '{1}' ";
            dvApproveFlow = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

            StrSql = @"Select P.ProjectsCode, IsNull(Sum(CD.TotalMoney), 0) TotalMoney From Projects P 
            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
            Where P.DelFlag = 0 And P.StudyYear = '{0}' Group By P.ProjectsCode ";
            dvTotalAmout = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue));

            StrSql = @" Select a.ProjectsCode, a.StudyYear, a.ProjectsName, a.Df, Ep.EmpID, Ep.EmpName, 
            a.Sort, e.DeptName, a.IsApprove, a.ProjectRegistration, a.IsWait, a.CreateDate
            From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
            Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
            Left Join Employee d On PD.EmpID = d.EmpID  
            Left Join Employee Ep On a.CreateUser = Ep.EmpID
            Left Join Department e On a.DeptCode = e.DeptCode
            Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
            Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
            Where a.DelFlag = 0 And d.DelFlag = 0 And d.hideFlag = 0 And a.StudyYear = '{0}' And a.SchoolID = '{1}' ";

            //if (ddlSearch2.SelectedIndex != 0)
            //{
            //    StrSql += " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
            //}
            if (ddlSearchMainDept.SelectedIndex != 0)
            {
                StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
            }
            if (ddlSearchMainSubDept.SelectedIndex != 0)
            {
                if (CurrentUser.RoleLevel != 65)
                {
                    StrSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
                }
            }
            if (ddlSearchDept.SelectedIndex != 0)
            {
                if (CurrentUser.RoleLevel != 65)
                {
                    StrSql += " And e.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
                }
            }
            if (ddlSearchEmp.SelectedIndex != 0)
            {
                StrSql += " And a.CreateUser = '" + ddlSearchEmp.SelectedValue + "'";
            }
            if (txtSearch.Text != "")
            {
                StrSql += " And a.ProjectsName Like '%" + txtSearch.Text + "%' ";
            }
            if (CurrentUser.RoleLevel > 1) //&& (CurrentUser.RoleLevel != 98))
            {
                StrSql += " And PD.EmpID = '" + CurrentUser.ID + "'";
            }
            DataView dv = Conn.Select(string.Format(StrSql + " Group By a.ProjectsCode, a.StudyYear, a.ProjectsName, a.Df, Ep.EmpID, Ep.EmpName, a.Sort, e.DeptName, a.IsApprove, a.ProjectRegistration, a.IsWait, a.CreateDate Order By a.CreateDate Desc, a.ProjectRegistration Desc ", ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

            ////เช็คผลรวม
            //try
            //{
            //    DataTable dt = dvTotalAmout.ToTable();
            //    TotalAmount = Convert.ToDecimal(dt.Compute("Sum(TotalMoney)", dvTotalAmout.RowFilter));
            //}
            //catch (Exception ex)
            //{
            //}

            GridView1.DataSource = dv;
            lblSearchTotal.InnerText = dv.Count.ToString("#,##0");
            GridView1.DataBind();

            StrSql = @" Select ckReportProject From MR_School Where SchoolID = '{0}' And DelFlag = 0 ";
            DataView dvCkReport = Conn.Select(string.Format(StrSql, CurrentUser.SchoolID));
            if (dvCkReport.Count != 0)
            {
                string[] ckReportProject = dvCkReport[0]["ckReportProject"].ToString().Split(',');

                GridView1.Columns[5].Visible = false;
                GridView1.Columns[6].Visible = false;
                for (int i = 0; i < ckReportProject.Length; i++)
                {
                    if (ckReportProject[i] == "0")
                    {
                        GridView1.Columns[5].Visible = true;
                    }
                    if (ckReportProject[i] == "1")
                    {
                        GridView1.Columns[6].Visible = true;
                    }
                }
            }

//            //----GrandTotal-----------
//            StrSql = @" Select IsNull(Sum(CD.TotalMoney), 0) TotalAmount From Projects P 
//            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
//            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
//            Left Join dtAcDept dt ON A.DeptCode = dt.DeptCode 
//            Left Join Department D On D.DeptCode = dt.DeptCode
//            Left Join MainSubDepartment MD On MD.MainSubDeptCode = D.MainSubDeptCode
//            Where P.DelFlag = 0 And P.StudyYear = '{0}' 
//            And a.SchoolID = '{1}' ";
//            if (ddlSearchMainDept.SelectedIndex != 0)
//            {
//                StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
//            }
//            if (ddlSearchMainSubDept.SelectedIndex != 0)
//            {
//                StrSql += " And MD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
//            }
//            if (ddlSearchDept.SelectedIndex != 0)
//            {
//                StrSql += " And D.DeptCode = '" + ddlSearchDept.SelectedValue + "' "; 
//            }
//            DataView dvTotal = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));
//            ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount"]).ToString("#,##0.00") : "0.00";
            //----EndGrandTotal-----------

            if (Request.QueryString["mode"] == "1")
            {
                StrSql = @" Select ProjectsName From Projects Where DelFlag = 0  And CreateUser = '{0}' Order By Sort Desc ";
                DataView dv2 = Conn.Select(string.Format(StrSql, CurrentUser.ID));
                GridView2.DataSource = dv2;
                GridView2.DataBind();
            }
        }
        else { //grid FlowApprove
            StrSql = @" Select MSD.MainSubDeptCode, MSD.MainSubDeptName, AFD.ApproveFlowDetailID,
            AFD.UserRoleID, UR.UserRoleName, AFD.ApprovePositionID, AP.ApprovePositionName, AFD.ApproveStepID, APS.ApproveStepName,
            AFD.BudgetLimit, AFD.ckStatus, AFD.Sort As StepNo, 
            PAD.ProjectsCode, P.ProjectsName, PAD.EmpID, E.EmpName, P.CreateUser, PAD.IsApprove As IsApprove2, PAD.CreateDate, PAD.Comment, PAD.StepNo As Step, IsNull(P.IsApprove, 0) IsApprove
            From ApproveFlow AF Inner Join ApproveFlowDetail AFD On AF.MainSubDeptCode = AFD.ApproveFlowID
            Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
            Inner Join ApproveStep APS On AFD.ApproveStepID = APS.ApproveStepID
            Inner Join UserRole UR On AFD.UserRoleID = UR.UserRoleID 
            Inner Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
            Left Join ProjectsApproveDetail PAD On AFD.ApproveFlowDetailID = PAD.ApproveFlowDetailID
            Left Join Projects P On PAD.ProjectsCode = P.ProjectsCode
            Left Join Employee E On PAD.EmpID = E.EmpID
            Where AF.MainSubDeptCode = '{0}' And P.ProjectsCode = '{1}'
            Order By AFD.Sort ";
            DataView dv = Conn.Select(string.Format(StrSql, hdfMainSubDeptCode.Value, Request.QueryString["id"]));
            gridApproveFlow.DataSource = dv;
            gridApproveFlow.DataBind();

            if (dv.Count != 0)
            {
                divApprove.Visible = true;
                dv.RowFilter = "Step = Max(Step)";
                if (dv[0]["EmpID"].ToString() == CurrentUser.ID)
                {
                    if (!string.IsNullOrEmpty(dv[0]["IsApprove"].ToString()))
                    {
                        if (Convert.ToInt32(dv[0]["IsApprove"]) != 1)
                        {
                            divBtApprove.Visible = true;
                        }
                    }
                    else
                    {
                        divBtApprove.Visible = true;
                    }
                }
            }
            else
            {
                StrSql = @"Select P.ProjectsName, PAD.EmpID, E.EmpName, PAD.IsApprove, PAD.CreateDate, PAD.Comment, PAD.StepNo As Step
                From ProjectsApproveDetail PAD
                Left Join Projects P On PAD.ProjectsCode = P.ProjectsCode
                Left Join Employee E On PAD.EmpID = E.EmpID
                Where PAD.StepNo = 0 And P.ProjectsCode = '{0}' And E.EmpID = '{1}'";
                dv = Conn.Select(string.Format(StrSql, Request.QueryString["id"], CurrentUser.ID));
                if (dv.Count != 0)
                {
                    divApprove.Visible = true;
                    gridApproveFlow.Visible = false;
                    if (dv[0]["EmpID"].ToString() == CurrentUser.ID)
                    {
                        divBtApprove.Visible = true;
                    }
                }
                else
                {
                    divApprove.Visible = false;
                    gridApproveFlow.Visible = false;
                }
            }
        }
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select P.*, IsNull(P.SetBudget, 0) Set_Budget, D.MainSubDeptCode, IsNull(P.IsApprove, 0) Is_Approve
            From Projects P Inner Join Department D On P.DeptCode = D.DeptCode 
            Where ProjectsCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, id));
        DataView dv1 = Conn.Select(string.Format("Select StandardNationCode From dtStandardNation Where ProjectsCode = '" + id + "' "));
        DataView dv2 = Conn.Select(string.Format("Select StandardMinistryCode From dtStandardMinistry Where ProjectsCode = '" + id + "' "));
        DataView dv333 = Conn.Select(string.Format("Select StrategicObjectivesCode From dtStrategicObjectives Where ProjectsCode = '" + id + "' "));
        DataView dv9 = Conn.Select(string.Format("Select StrategicCode From dtStrategic Where ProjectsCode = '" + id + "' "));
        DataView dv18 = Conn.Select(string.Format("Select StrategicPlanID From dtStrategicPlan Where ProjectsCode = '" + id + "' "));
        DataView dv19 = Conn.Select(string.Format("Select CorporateStrategyID From dtCorporateStrategy Where ProjectsCode = '" + id + "' "));

        if (dv.Count != 0)
        {
            ddlYearS.SelectedValue = dv[0]["StudyYear"].ToString();
            SetItem();
            if (btc.CkUseData(id, "ProjectsCode", "Activity", " And DelFlag = 0 "))
            {
                ddlYearS.Enabled = false;
            }
            ddlStrategicPlan.SelectedValue = dv[0]["StrategicPlanID"].ToString();
            txtStrategicPlan.Text = dv[0]["StrategicPlan"].ToString();
            txtProjects.Text = dv[0]["ProjectsName"].ToString();
            hdfMainSubDeptCode.Value = dv[0]["MainSubDeptCode"].ToString();
            txtIdentityName.Text = dv[0]["IdentityName"].ToString();
            txtIdentityName2.Text = dv[0]["IdentityName2"].ToString();
            txtPurpose.Text = dv[0]["Purpose"].ToString();
            txtPurpose2.Text = dv[0]["Purpose2"].ToString();
            txtTarget.Text = dv[0]["Target"].ToString();
            txtTarget2.Text = dv[0]["Target2"].ToString();
            txtPeriod1.Text = dv[0]["Period1"].ToString();
            hdfCreateUser.Value = dv[0]["CreateUser"].ToString();
            txtProjectsDetail.Text = dv[0]["ProjectsDetail"].ToString(); 
            txtResponsibleName.Text = dv[0]["ResponsibleName"].ToString();
            txtResponsiblePosition.Text = dv[0]["ResponsiblePosition"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            txtProjectRegistration.Text = dv[0]["ProjectRegistration"].ToString();
            txtIOCode.Text = dv[0]["IOCode"].ToString();
            txtULCode.Text = dv[0]["ULCode"].ToString();
            rbtlProjectType.SelectedValue = dv[0]["ProjectTypeID"].ToString();
            getrbtlSubProjectType();
            rbtlSubProjectType.SelectedValue = dv[0]["SubProjectTypeID"].ToString();
            txtPlace.Text = dv[0]["Place1"].ToString();
            txtEvaTool.Text = dv[0]["EvaTool"].ToString();
            btc.getddlDepartment(1, ddlDept, "", CurrentUser.DeptID, null);
            ddlDept.SelectedValue = dv[0]["DeptCode"].ToString();
            btc.getddlDepartmentJoin(1, ddlDeptJoin, "", ddlDept.SelectedValue);
            ddlDeptJoin.SelectedValue = dv[0]["DeptJoinCode"].ToString();
            ddlDept.Enabled = false;
            hdfIsWait.Value = dv[0]["IsWait"].ToString();
            btc.getcblStrategicPlan(cblStrategicPlan, ddlYearS.SelectedValue, dv[0]["DeptCode"].ToString());

            if (!string.IsNullOrEmpty(dv[0]["SDate"].ToString()))
            {
                txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString();
                ddlSDay.SelectedValue = Convert.ToDateTime(dv[0]["SDate"]).Day.ToString("00");
                ddlSMonth.SelectedValue = Convert.ToDateTime(dv[0]["SDate"]).Month.ToString("00");
                ddlSYear.SelectedValue = (Convert.ToDateTime(dv[0]["SDate"]).Year + 543).ToString();
            }
            if (!string.IsNullOrEmpty(dv[0]["EDate"].ToString()))
            {
                txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString();
                ddlEDay.SelectedValue = Convert.ToDateTime(dv[0]["EDate"]).Day.ToString("00");
                ddlEMonth.SelectedValue = Convert.ToDateTime(dv[0]["EDate"]).Month.ToString("00");
                ddlEYear.SelectedValue = (Convert.ToDateTime(dv[0]["EDate"]).Year + 543).ToString();
            }
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Projects", "ProjectsCode", id);

        if (!string.IsNullOrEmpty(dv[0]["IsApprove"].ToString()))
        {
            if (Convert.ToInt32(dv[0]["IsApprove"]) == 1)
            {
                lblApprove.Text = "<span style=\"font-weight:bold;\"> อนุมัติโครงการโดย : </span>" + btc.getEmpName(dv[0]["UserApprove"].ToString()) + "<br /><span style=\"font-weight:bold;\"> วันที่ : </span>" + Convert.ToDateTime(dv[0]["DateApprove"]).ToString("dd/MM/yyyy");
                lblComment.Text = "<span style=\"font-weight:bold;\">ความคิดเห็น : </span>" + dv[0]["Comment"].ToString();
                lblApprove.ForeColor = System.Drawing.Color.Green;
                lblComment.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblApprove.Text = "<span style=\"font-weight:bold;\">ไม่อนุมัติโครงการโดย : </span>" + btc.getEmpName(dv[0]["UserApprove"].ToString()) + "<br /><span style=\"font-weight:bold;\"> วันที่ : </span>" + Convert.ToDateTime(dv[0]["DateApprove"]).ToString("dd/MM/yyyy");
                lblComment.Text = "<span style=\"font-weight:bold;\">ความคิดเห็น : </span>" + dv[0]["Comment"].ToString();
                lblApprove.ForeColor = System.Drawing.Color.Red;
                lblComment.ForeColor = System.Drawing.Color.Red;
            }
        }

        if (CurrentUser.RoleLevel >= 98)
        {
            lbtEditCreate.Visible = true;
        }
        if (hdfCreateUser.Value != CurrentUser.ID)
        {
            if (CurrentUser.RoleLevel < 98)
            {
                btSave.Visible = false;
            }
            if (Convert.ToInt32(dv[0]["Is_Approve"]) == 1)
            {
                btSave.Visible = false;
            }
        }
        else
        {
            getddlHeadDept();
            btWait.Visible = false;
            if (btc.ckApproveFlow(id)) //เช็คว่ามีการ Approve ไปแล้วหรือยัง
            {
                if (!string.IsNullOrEmpty(dv[0]["IsWait"].ToString()))
                {
                    if (Convert.ToInt32(dv[0]["IsWait"]) == 1)
                    {
                        btSave.Visible = true;
                    }
                    else
                    {
                        btSave.Visible = false;
                    }
                }
                else
                {
                    btSave.Visible = false;
                }
            }
        }

        if (dv18.Count != 0)
        {
            for (int i = 0; i <= cblStrategicPlan.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv18.Count - 1; j++)
                {
                    if (cblStrategicPlan.Items[i].Value == dv18[j]["StrategicPlanID"].ToString())
                    {
                        cblStrategicPlan.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (btc.ckIdentityName("ckStrategies"))
        {
            DataView dv100 = Conn.Select(string.Format("Select StrategiesCode From dtStrategies Where ProjectsCode = '" + id + "'"));
            if (dv100.Count != 0)
            {
                for (int i = 0; i <= cblStrategies.Items.Count - 1; i++)
                {
                    for (int j = 0; j <= dv100.Count - 1; j++)
                    {
                        if (cblStrategies.Items[i].Value == dv100[j]["StrategiesCode"].ToString())
                        {
                            cblStrategies.Items[i].Selected = true;
                            break;
                        }
                    }
                }
            }
        }

        btc.getcblCorporateStrategy(divCorporateStrategy, cblCorporateStrategy, ddlYearS.SelectedValue, cblStrategies); //KPI
        if (dv19.Count != 0)
        {
            for (int i = 0; i <= cblCorporateStrategy.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv19.Count - 1; j++)
                {
                    if (cblCorporateStrategy.Items[i].Value == dv19[j]["CorporateStrategyID"].ToString())
                    {
                        cblCorporateStrategy.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (dv1.Count != 0)
        {
            for (int i = 0; i <= cblStandardNation.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv1.Count - 1; j++)
                {
                    if (cblStandardNation.Items[i].Value == dv1[j]["StandardNationCode"].ToString())
                    {
                        cblStandardNation.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (dv2.Count != 0)
        {
            for (int i = 0; i <= cblStandardMinistry.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv2.Count - 1; j++)
                {
                    if (cblStandardMinistry.Items[i].Value == dv2[j]["StandardMinistryCode"].ToString())
                    {
                        cblStandardMinistry.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (dv333.Count != 0)
        {
            for (int i = 0; i <= cblStrategicObjectives.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv333.Count - 1; j++)
                {
                    if (cblStrategicObjectives.Items[i].Value == dv333[j]["StrategicObjectivesCode"].ToString())
                    {
                        cblStrategicObjectives.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (dv9.Count != 0)
        {
            for (int i = 0; i <= cblStrategic.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv9.Count - 1; j++)
                {
                    if (cblStrategic.Items[i].Value == dv9[j]["StrategicCode"].ToString())
                    {
                        cblStrategic.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }

        if (btc.ckIdentityName("iNameShow2"))
        {
            DataView dv101 = Conn.Select(string.Format("Select IdentityNameCode From dtIdentityName Where ProjectsCode = '" + id + "'"));
            if (dv101.Count != 0)
            {
                for (int i = 0; i <= cblIdentityName2.Items.Count - 1; i++)
                {
                    for (int j = 0; j <= dv101.Count - 1; j++)
                    {
                        if (cblIdentityName2.Items[i].Value == dv101[j]["IdentityNameCode"].ToString())
                        {
                            cblIdentityName2.Items[i].Selected = true;
                            break;
                        }
                    }
                }
            }
        }
    }
    private void getddlHeadDept()
    {
       string strSql = @"Select MSD.MainSubDeptCode, MSD.MainSubDeptName, AFD.ApproveFlowDetailID,
                AFD.UserRoleID, UR.UserRoleName, AFD.ApprovePositionID, AP.ApprovePositionName, AFD.ApproveStepID, APS.ApproveStepName,
                AFD.BudgetLimit, AFD.ckStatus, AFD.Sort As StepNo, E.EmpID, E.EmpName
                From ApproveFlow AF Inner Join ApproveFlowDetail AFD On AF.MainSubDeptCode = AFD.ApproveFlowID
                Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
                Inner Join ApproveStep APS On AFD.ApproveStepID = APS.ApproveStepID
                Inner Join UserRole UR On AFD.UserRoleID = UR.UserRoleID 
                Inner Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
		        Inner Join Employee E On E.UserRoleID = UR.UserRoleID
		        Inner Join EmpDept ED On E.EmpID = ED.EmpID
                Where AF.MainSubDeptCode = '{0}' And ED.DeptCode = '{1}' And AFD.ckStatus = 'S' And E.HideFlag = 0
                Order By AFD.Sort";
        DataView dvHeadDept = Conn.Select(string.Format(strSql, CurrentUser.MainSubDeptID, CurrentUser.DeptID));
        if (dvHeadDept.Count > 0)
        {
            ddlHeadDept.DataSource = dvHeadDept;
            ddlHeadDept.DataTextField = "EmpName";
            ddlHeadDept.DataValueField = "EmpID";
            ddlHeadDept.DataBind();
            if (dvHeadDept.Count > 1)
            {
                ddlHeadDept.Visible = true;
                lblHeadDept.Visible = true;
                ddlHeadDept.Items.Insert(0, new ListItem("- เลือก -", ""));
                ddlHeadDept.SelectedIndex = 0;
            }
            else
            {
                ddlHeadDept.Visible = false;
                lblHeadDept.Visible = false;
                ddlHeadDept.Items.Insert(0, new ListItem("- เลือก -", ""));
                ddlHeadDept.SelectedIndex = 1;
            }
        }
        else
        {
            ddlHeadDept.Items.Clear();
            ddlHeadDept.Visible = false;
            lblHeadDept.Visible = false;
            ddlHeadDept.Items.Insert(0, new ListItem("- เลือก -", ""));
            ddlHeadDept.SelectedIndex = 0;
        }
    }
    private void ClearAll()
    {
        txtProjectRegistration.Text = "";
        txtIOCode.Text = "";
        txtProjects.Text = "";
        txtProjectsDetail.Text = "";
        txtPurpose.Text = "";
        txtPurpose2.Text = "";
        txtTarget.Text = "";
        txtTarget2.Text = "";
        txtEvaTool.Text = "";
        txtPeriod1.Text = "";
        txtPlace.Text = "";
        txtProjectsDetail.Text = "";
        txtResponsibleName.Text = "";
        txtResponsiblePosition.Text = "";
        txtSearch.Text = "";
        rbtlProjectType.SelectedIndex = 0;
        getrbtlSubProjectType();
        cblIdentityName2.ClearSelection();
        cblStandardMinistry.ClearSelection();
        cblStandardNation.ClearSelection();
        cblStrategicObjectives.ClearSelection();
        cblStrategic.ClearSelection();
        txtStrategicPlan.Text = "";
        cblStrategicPlan.ClearSelection();
        cblIdentityName2.ClearSelection();
        cblCorporateStrategy.ClearSelection();
        cblStrategies.ClearSelection();
        //ddlDeptJoin.SelectedIndex = 0;
        txtSDay.Text = DateTime.Now.ToShortDateString();
        txtEDay.Text = DateTime.Now.ToShortDateString();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private Boolean ckCBLCheck(CheckBoxList cbl, Label lblError)
    {
        Boolean ck = false;
        for (int j = 0; j <= cbl.Items.Count - 1; j++)
        {
            if (cbl.Items[j].Selected)
            {
                ck = true;
            }
        }
        if (ck)
        {
            lblError.Visible = false;
        }
        else
        {
            lblError.Visible = true;
        }
        return ck;
    }
    private string genProjectRegistration()
    {
        string genID = "001";
        string strSql = @"Select IsNull(Max(Cast(SUBSTRING(ProjectRegistration, 4, 3) As int)), 0) + 1 As AppCode 
            From Projects Where SchoolID = '{0}' And DeptCode = '{1}' And StudyYear = '{2}'";
        DataView dv = Conn.Select(string.Format(strSql, CurrentUser.SchoolID, CurrentUser.DeptID, ddlYearS.SelectedValue));
        if (dv.Count > 0)
        {
            genID = Convert.ToInt32(dv[0]["AppCode"]).ToString("000");
        }
        return btc.getDeptShortName(CurrentUser.DeptID) + genID;
    }
    private void bt_Save(string CkAgain)
    {
        int result = 0;
        StringBuilder strbSql = new StringBuilder();

        Int32 i = 0;

        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            if ((ckCBLCheck(cblStrategies, lblErrorStrategies)) && (ckCBLCheck(cblCorporateStrategy, lblErrorCorporateStrategy)))
            {
                string NewID = Guid.NewGuid().ToString();
                strbSql.AppendFormat("INSERT INTO Projects (ProjectsCode, StudyYear, ProjectsName, Purpose, Purpose2, Target, Target2, Period1, ProjectsDetail, ResponsibleName, ResponsiblePosition, IdentityName, IdentityName2, Sort, Df, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate, StrategicPlanID, ProjectRegistration, IOCode, ProjectTypeID, SubProjectTypeID, SDate, EDate, EvaTool, Place1, DeptCode, DeptJoinCode, StrategicPlan, ULCode) VALUES ('{0}','{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}','{12}',{13},{14},{15},'{16}','{17}','{18}','{19}','{20}','{21}',N'{22}','{23}','{24}','{25}','{26}','{27}',N'{28}',N'{29}','{30}','{31}','{32}','{33}');",
                    NewID, ddlYearS.SelectedValue, txtProjects.Text, txtPurpose.Text, txtPurpose2.Text, txtTarget.Text, txtTarget2.Text, txtPeriod1.Text, txtProjectsDetail.Text, txtResponsibleName.Text, txtResponsiblePosition.Text, txtIdentityName.Text, txtIdentityName2.Text, txtSort.Text, 1, 0, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", ddlStrategicPlan.SelectedValue, genProjectRegistration(), txtIOCode.Text, rbtlProjectType.SelectedValue, rbtlSubProjectType.SelectedValue, Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), txtEvaTool.Text, txtPlace.Text, ddlDept.SelectedValue, ddlDeptJoin.SelectedValue, txtStrategicPlan.Text, txtULCode.Text);

                strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID,ProjectsCode,EmpID,StepNo) VALUES ('{0}','{1}','{2}',{3});",
                    Guid.NewGuid().ToString(), NewID, CurrentUser.ID, 0);

                for (int j = 0; j <= cblStrategicPlan.Items.Count - 1; j++)
                {
                    if (cblStrategicPlan.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtStrategicPlan (ProjectsCode, StrategicPlanID)VALUES('{0}','{1}');", NewID, cblStrategicPlan.Items[j].Value);
                    }
                }

                for (int j = 0; j <= cblCorporateStrategy.Items.Count - 1; j++)
                {
                    if (cblCorporateStrategy.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtCorporateStrategy (ProjectsCode, CorporateStrategyID)VALUES('{0}','{1}');", NewID, cblCorporateStrategy.Items[j].Value);
                    }
                }

                for (int j = 0; j <= cblStandardNation.Items.Count - 1; j++)
                {
                    if (cblStandardNation.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtStandardNation (ProjectsCode, StandardNationCode)VALUES('{0}','{1}');", NewID, cblStandardNation.Items[j].Value);
                    }
                }

                for (int j = 0; j <= cblStandardMinistry.Items.Count - 1; j++)
                {
                    if (cblStandardMinistry.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtStandardMinistry (ProjectsCode, StandardMinistryCode)VALUES('{0}','{1}');", NewID, cblStandardMinistry.Items[j].Value);
                    }
                }

                if (btc.ckIdentityName("ckStrategies"))
                {
                    for (int j = 0; j <= cblStrategies.Items.Count - 1; j++)
                    {
                        if (cblStrategies.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategies (ProjectsCode, StrategiesCode)VALUES('{0}','{1}');", NewID, cblStrategies.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStrategicObjectives"))
                {
                    for (int j = 0; j <= cblStrategicObjectives.Items.Count - 1; j++)
                    {
                        if (cblStrategicObjectives.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategicObjectives (ProjectsCode, StrategicObjectivesCode)VALUES('{0}','{1}');", NewID, cblStrategicObjectives.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStrategic"))
                {
                    for (int j = 0; j <= cblStrategic.Items.Count - 1; j++)
                    {
                        if (cblStrategic.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategic (ProjectsCode, StrategicCode)VALUES('{0}','{1}');", NewID, cblStrategic.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("iNameShow2"))
                {
                    for (int j = 0; j <= cblIdentityName2.Items.Count - 1; j++)
                    {
                        if (cblIdentityName2.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtIdentityName (ProjectsCode, IdentityNameCode)VALUES('{0}','{1}');", NewID, cblIdentityName2.Items[j].Value);
                        }
                    }
                }

                result = Conn.Execute(strbSql.ToString());
                if (CkAgain == "N")
                {
                    Response.Redirect("Projects.aspx?ckmode=1&Cr=" + result);
                }
                if (CkAgain == "Y")
                {
                    MultiView1.ActiveViewIndex = 1;
                    btc.Msg_Head(Img1, MsgHead, true, "1", result);
                    ClearAll();
                    SetItem();
                    btc.GenSort(txtSort, "Projects", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
                    GridView2.Visible = true;
                    DataBind();
                }
                if (CkAgain == "G")
                {
                    Response.Redirect("Activity.aspx?mode=1&id=" + NewID + "&syear=" + ddlYearS.SelectedValue);
                }
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
            if ((ckCBLCheck(cblStrategies, lblErrorStrategies)) && (ckCBLCheck(cblCorporateStrategy, lblErrorCorporateStrategy)))

            if ((ckCBLCheck(cblIdentityName2, lblErrorIdentityName2)) && (ckCBLCheck(cblStrategies, lblErrorStrategies)) && (ckCBLCheck(cblCorporateStrategy, lblErrorCorporateStrategy)))
            {
                i = Conn.Update("Projects", "Where ProjectsCode = '" + Request.QueryString["id"] + "' ", "StudyYear, ProjectsName, Purpose, Purpose2, Target, Target2, Period1, ProjectsDetail, ResponsibleName, ResponsiblePosition, IdentityName, IdentityName2, Sort, SchoolID, UpdateUser, UpdateDate, StrategicPlanID, IOCode, ProjectTypeID, SubProjectTypeID, SDate, EDate, EvaTool, Place1, DeptCode, DeptJoinCode, StrategicPlan, ULCode",
                    ddlYearS.SelectedValue, txtProjects.Text, txtPurpose.Text, txtPurpose2.Text, txtTarget.Text, txtTarget2.Text, txtPeriod1.Text, txtProjectsDetail.Text, txtResponsibleName.Text, txtResponsiblePosition.Text, txtIdentityName.Text, txtIdentityName2.Text, txtSort.Text, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now, ddlStrategicPlan.SelectedValue, txtIOCode.Text, rbtlProjectType.SelectedValue, rbtlSubProjectType.SelectedValue, Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), txtEvaTool.Text, txtPlace.Text, ddlDept.SelectedValue, ddlDeptJoin.SelectedValue, txtStrategicPlan.Text, txtULCode.Text);

                if (!string.IsNullOrEmpty(hdfIsWait.Value))
                {
                    if (hdfIsWait.Value == "True")
                    {
                        strbSql.AppendFormat("Update Projects Set IsWait = 0, ckSend = 1 Where ProjectsCode = '{0}'; ", Request.QueryString["id"]);
                    }
                }
                strbSql.AppendFormat("Delete dtStrategicPlan Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                for (int j = 0; j <= cblStrategicPlan.Items.Count - 1; j++)
                {
                    if (cblStrategicPlan.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtStrategicPlan (ProjectsCode, StrategicPlanID)VALUES('{0}','{1}');", Request.QueryString["id"], cblStrategicPlan.Items[j].Value);
                    }
                }

                strbSql.AppendFormat("Delete dtCorporateStrategy Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                for (int j = 0; j <= cblCorporateStrategy.Items.Count - 1; j++)
                {
                    if (cblCorporateStrategy.Items[j].Selected)
                    {
                        strbSql.AppendFormat("INSERT INTO dtCorporateStrategy (ProjectsCode, CorporateStrategyID)VALUES('{0}','{1}');", Request.QueryString["id"], cblCorporateStrategy.Items[j].Value);
                    }
                }

                if (btc.ckIdentityName("ckStandardNation"))
                {
                    strbSql.AppendFormat("Delete dtStandardNation Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    //Conn.Delete("dtStandardNation", "Where ProjectsCode = '" + Request.QueryString["id"] + "' ");
                    for (int j = 0; j <= cblStandardNation.Items.Count - 1; j++)
                    {
                        if (cblStandardNation.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStandardNation (ProjectsCode, StandardNationCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblStandardNation.Items[j].Value);
                            ///i = Conn.AddNew("dtStandardNation", "ProjectsCode, StandardNationCode", Request.QueryString["id"], cblStandardNation.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStandardMinistry"))
                {
                    strbSql.AppendFormat("Delete dtStandardMinistry Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    //Conn.Delete("dtStandardMinistry", "Where ProjectsCode = '" + Request.QueryString["id"] + "' ");
                    for (int j = 0; j <= cblStandardMinistry.Items.Count - 1; j++)
                    {
                        if (cblStandardMinistry.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStandardMinistry (ProjectsCode, StandardMinistryCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblStandardMinistry.Items[j].Value);
                            //i = Conn.AddNew("dtStandardMinistry", "ProjectsCode, StandardMinistryCode", Request.QueryString["id"], cblStandardMinistry.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStrategies"))
                {
                    strbSql.AppendFormat("Delete dtStrategies Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    for (int j = 0; j <= cblStrategies.Items.Count - 1; j++)
                    {
                        if (cblStrategies.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategies (ProjectsCode, StrategiesCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblStrategies.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStrategicObjectives"))
                {
                    strbSql.AppendFormat("Delete dtStrategicObjectives Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    for (int j = 0; j <= cblStrategicObjectives.Items.Count - 1; j++)
                    {
                        if (cblStrategicObjectives.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategicObjectives (ProjectsCode, StrategicObjectivesCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblStrategicObjectives.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("ckStrategic"))
                {
                    strbSql.AppendFormat("Delete dtStrategic Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    //Conn.Delete("dtStrategic", "Where ProjectsCode = '" + Request.QueryString["id"] + "' ");
                    for (int j = 0; j <= cblStrategic.Items.Count - 1; j++)
                    {
                        if (cblStrategic.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtStrategic (ProjectsCode, StrategicCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblStrategic.Items[j].Value);
                        }
                    }
                }

                if (btc.ckIdentityName("iNameShow2"))
                {
                    strbSql.AppendFormat("Delete dtIdentityName Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                    for (int j = 0; j <= cblIdentityName2.Items.Count - 1; j++)
                    {
                        if (cblIdentityName2.Items[j].Selected)
                        {
                            strbSql.AppendFormat("INSERT INTO dtIdentityName (ProjectsCode, IdentityNameCode)VALUES('{0}','{1}');", Request.QueryString["id"], cblIdentityName2.Items[j].Value);
                        }
                    }
                }

                result = Conn.Execute(strbSql.ToString());
                Response.Redirect("Projects.aspx?ckmode=2&Cr=" + result);
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
    private void Delete(string id)
    {
        int result = 0;
        StringBuilder strbSql = new StringBuilder();

        if (String.IsNullOrEmpty(id)) return;
        Int32 i = 0;
        if (CurrentUser.RoleLevel < 98)
        {
            if (btc.CkUseData(id, "ProjectsCode", "Activity", " And DelFlag = 0 "))
            {
                Response.Redirect("Projects.aspx?ckmode=3&Cr=" + i);
            }
            else
            {
                i = Conn.Update("Projects", "Where ProjectsCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);

                strbSql.AppendFormat("Delete dtStandardNation Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                strbSql.AppendFormat("Delete dtStandardMinistry Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                strbSql.AppendFormat("Delete dtStrategicObjectives Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                strbSql.AppendFormat("Delete dtStrategic Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                strbSql.AppendFormat("Delete dtPlan Where ProjectsCode = '{0}';", Request.QueryString["id"]);
                strbSql.AppendFormat("Delete dtStrategies Where ProjectsCode = '{0}';", Request.QueryString["id"]);

                result = Conn.Execute(strbSql.ToString());
                Response.Redirect("Projects.aspx?ckmode=3&Cr=" + i);
            }
        }
        else
        {
            //i = Conn.Update("Projects", "Where ProjectsCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            strbSql.AppendFormat("Update Projects Set DelFlag = 1, UpdateUser = '{1}', UpdateDate = '{2}' Where ProjectsCode = '{0}';", Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");
            strbSql.AppendFormat("Update Activity Set DelFlag = 1, UpdateUser = '{1}', UpdateDate = '{2}' Where ProjectsCode = '{0}';", Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");
            strbSql.AppendFormat("Update Indicators2 Set DelFlag = 1, UpdateUser = '{1}', UpdateDate = '{2}' Where ProjectsCode = '{0}';", Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");
            strbSql.AppendFormat("Update Evaluation Set DelFlag = 1, UpdateUser = '{1}', UpdateDate = '{2}' Where ProjectsCode = '{0}';", Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");

            strbSql.AppendFormat("Delete dtStandardNation Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            strbSql.AppendFormat("Delete dtStandardMinistry Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            strbSql.AppendFormat("Delete dtStrategicObjectives Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            strbSql.AppendFormat("Delete dtStrategic Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            strbSql.AppendFormat("Delete dtPlan Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            strbSql.AppendFormat("Delete dtStrategies Where ProjectsCode = '{0}';", Request.QueryString["id"]);

            //strbSql.AppendFormat("Delete ActivityOperation2 Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete dtAcDept Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete dtAcEmp Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete dtFactor Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete dtEditBudgetAc Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete dtEditDateAc Where ActivityCode = '{0}';", Request.QueryString["id"]);
            //strbSql.AppendFormat("Delete CostsDetail Where ActivityCode = '{0}';", Request.QueryString["id"]);

            result = Conn.Execute(strbSql.ToString());
            Response.Redirect("Projects.aspx?ckmode=3&Cr=" + result);
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearS_SelectedIndexChanged(object sender, EventArgs e)
    {
        getcblStandardNation(ddlYearS.SelectedValue);
        getcblStandardMinistry(ddlYearS.SelectedValue);
        getcblStrategicObjectives(ddlYearS.SelectedValue);
        getcblStrategic(ddlYearS.SelectedValue);
        //getcblStrategies(ddlYearS.SelectedValue);
        btc.getcblStrategies(divStrategies, cblStrategies, ddlYearS.SelectedValue);
        btc.getcblCorporateStrategy(divCorporateStrategy, cblCorporateStrategy, ddlYearS.SelectedValue, cblStrategies); //KPI
        btc.getcblStrategicPlan(cblStrategicPlan, ddlYearS.SelectedValue, CurrentUser.DeptID);
        btc.GenSort(txtSort, "Projects", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
    }
    protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
        //DataBind();
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
    protected string checkedit(string id, string EmpID, string strName)
    {
        if (!string.IsNullOrEmpty(strName))
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            if (EmpID == CurrentUser.ID || CurrentUser.RoleLevel == 98)
            {
                return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\"><img style=\"border: 0; cursor: pointer;\" title=\"แก้ไข\" src=\"../Image/edit.gif\" /></a>", id);
            }
            else
            {
                return string.Format("");
            }
        }
    }
    protected string checkdelete(string id, string EmpID, object IsApprove)
    {
        if (EmpID == CurrentUser.ID || CurrentUser.RoleLevel == 98)
        {
            if (!string.IsNullOrEmpty(IsApprove.ToString()))
            {
                if (Convert.ToInt32(IsApprove) == 1)
                {
                    //if (EmpID == CurrentUser.ID)
                    //{
                        return string.Format("");
                    //}
                    //else
                    //{
                    //    return String.Format("<a href=\"javascript:deleteItem('{0}');\"><img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>", id);
                    //}
                }
                else
                {
                    return String.Format("<a href=\"javascript:deleteItem('{0}');\"><img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>", id);
                }
            }
            else
            {
                return String.Format("<a href=\"javascript:deleteItem('{0}');\"><img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>", id);
            }
        }
        else
        {
            return string.Format("");
        }
    }
    protected string checkGoto(string id, string EmpID)
    {
        if (EmpID == CurrentUser.ID || CurrentUser.RoleLevel == 98)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"gotoItem('{0}');\"><img style=\"border: 0; cursor: pointer;\" title=\"สร้างกิจกรรมใหม่ภายใต้โครงการนี้\" src=\"../Image/goto.png\" /></a>", id);
        }
        else
        {
            return string.Format("");
        }
    }
    protected string GetBudget(string ProjectsCode)
    {
        string Total = "0.00";
        DataRow[] dr = dvTotalAmout.Table.Select("ProjectsCode = '" + ProjectsCode + "'");
        if (dr.Length > 0)
        {
            Total = Convert.ToDecimal(dr[0]["TotalMoney"]).ToString("#,##0.00");
            TotalAmount += Convert.ToDecimal(dr[0]["TotalMoney"]);
        }
        return "<span>" + Total + "</span>";
    }
    protected decimal GetTotalBudget()
    {
        return TotalAmount;
    }
    protected string GetstatusIsApprove(object ProjectsCode, object IsWait)
    {
        if (string.IsNullOrEmpty(IsWait.ToString()))
        {
            DataRow[] dr = dvApproveFlow.Table.Select("ProjectsCode = '" + ProjectsCode + "' And EmpID = '" + CurrentUser.ID + "' ");
            if (dr.Length > 0)
            {
                if (!string.IsNullOrEmpty(dr[0]["IsApprove2"].ToString()))
                {
                    if (Convert.ToInt32(dr[0]["IsApprove2"]) == 1)
                    {
                        return string.Format("<img style=\"border:0;\" title=\"อนุมัติ\" src=\"../Image/signature.png\" />");
                    }
                    else
                    {
                        return string.Format("<img style=\"border:0;\" title=\"ไม่อนุมัติ\" src=\"../Image/UnApprove.png\" />");
                    }
                }
                else
                {
                    return string.Format("<img style=\"border:0; width:24px; height:24px;\" title=\"รอการตัดสินใจ\" src=\"../Image/giphy.gif\" />");
                }
            }
            else
            {
                return string.Format("<img style=\"border:0; width:24px; height:24px;\" title=\"รอการตัดสินใจ\" src=\"../Image/giphy.gif\" />");
            }
        }
        else
        {
            if (Convert.ToInt32(IsWait) == 1)
            {
                return string.Format("<img style=\"border:0; width:24px; height:24px;\" title=\"ข้อข้อมูลเพิ่มเติม/ขอแก้ไขเพิ่มเติม\" src=\"../Image/WaitIcon.png\" />");
            }
            else
            {
                return string.Format("<img style=\"border:0; width:24px; height:24px;\" title=\"ข้อข้อมูลเพิ่มเติม/ขอแก้ไขเพิ่มเติม\" src=\"../Image/WaitIconR.png\" />");
            }
        }
    }
    protected string statusIsApprove(object IsApprove)
    {
        if (Request.QueryString["mode"] != "2")
        {
            if (!string.IsNullOrEmpty(IsApprove.ToString()))
            {
                if (Convert.ToInt32(IsApprove) == 1)
                {
                    return string.Format("<img style=\"border:0;\" title=\"ลงนามอนุมัติ\" src=\"../Image/ok.png\" />");
                }
                else
                {
                    return string.Format("<img style=\"border:0;\" title=\"ไม่ลงนามอนุมัติ\" src=\"../Image/no.png\" />");
                }
            }
            else
            {
                return string.Format("<img style=\"border:0;width:24px; height:24px;\" title=\"รอการอนุมัติ\" src=\"../Image/giphy.gif\" />");
            }
        }
        else
        {
            if (!string.IsNullOrEmpty(IsApprove.ToString()))
            {
                if (Convert.ToInt32(IsApprove) == 1)
                {
                    return string.Format("<img style=\"border:0;\" title=\"อนุมัติ\" src=\"../Image/signature.png\" />");
                }
                else
                {
                    return string.Format("<img style=\"border:0;\" title=\"ไม่อนุมัติ\" src=\"../Image/UnApprove.png\" />");
                }
            }
            else
            {
                return string.Format("<img style=\"border:0;width:24px; height:24px;\" title=\"รอการตัดสินใจ\" src=\"../Image/giphy.gif\" />");
            }
        }
    }
    protected string DateIsApprove(object ApproveDate)
    {
        if (!string.IsNullOrEmpty(ApproveDate.ToString()))
        {
            return string.Format(Convert.ToDateTime(ApproveDate).ToString("dd/MM/yyyy"));
        }
        else
        {
            return string.Format("-");
        }
    }
    protected string strComment(object Comment)
    {
        string comment = "-";
        if (!string.IsNullOrEmpty(Comment.ToString()))
        {
            comment = Comment.ToString();
        }
        return comment;
    }
    protected void spnResponsibleName_TextChanged(object sender, EventArgs e)
    {
        UpdatelblResponsibleName();
    }
    private void UpdatelblResponsibleName()
    {
        Conn.Update("MR_School", "Where SchoolID = '" + CurrentUser.SchoolID + "'", "spnResponsibleName", spnResponsibleName.Text);
    }
    private void ModeCreate(Boolean enabled)
    {    
        divSearchCreateUser.Visible = enabled;
        txtSearchCreateUser.Text = "";
        divbtnEditCreate.Visible = enabled;
        divddlCreateUser.Visible = enabled;
        ddlCreateUser.Items.Clear();
        ddlCreateUser.Items.Insert(0, new ListItem("ค้นหารายการก่อน", ""));
        ddlCreateUser.Enabled = false;
    }
    protected void lbtEditCreate_Click(object sender, EventArgs e)
    {
        ModeCreate(true);
    }
    private void getddlEditCreate()
    {
        string strSql = @" Select E.EmpID, E.EmpName + ' ('+ D.DeptName + ')' As EmpName from Employee E, Department D 
                Where E.DelFlag = 0 And E.DeptCode = D.DeptCode And EmpName Like N'%" + txtSearchCreateUser.Text + "%'";
            DataView dv = Conn.Select(strSql);
            if (dv.Count != 0)
            {
                ddlCreateUser.DataSource = dv;
                ddlCreateUser.DataTextField = "EmpName";
                ddlCreateUser.DataValueField = "EmpID";
                ddlCreateUser.DataBind();
                ddlCreateUser.Enabled = true;
            }
            else
            {
                ddlCreateUser.Items.Clear();
                ddlCreateUser.Items.Insert(0, new ListItem("ไม่พบรายการ", ""));
                ddlCreateUser.Enabled = false;
            }
        //}
    }
    protected void btnCancelCreate_Click(object sender, EventArgs e)
    {
        ModeCreate(false);
    }
    protected void btnEditCreate_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(ddlCreateUser.SelectedValue))
        {
            Conn.Update("Projects", "Where ProjectsCode = '" + Request.QueryString["id"] + "'", "CreateUser", ddlCreateUser.SelectedValue);
            ModeCreate(false);
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Projects", "ProjectsCode", Request.QueryString["id"]);
        }
    }
    protected void btSearchCreateUser_Click(object sender, EventArgs e)
    {
        getddlEditCreate();
    }

    protected void rbtlProjectType_SelectedIndexChanged(object sender, EventArgs e)
    {
        getrbtlSubProjectType();
    }
    protected void cblStrategies_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getcblCorporateStrategy(divCorporateStrategy, cblCorporateStrategy, ddlYearS.SelectedValue, cblStrategies); //KPI
    }
    protected void ddlDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlDepartmentJoin(1, ddlDeptJoin, "", ddlDept.SelectedValue);
    }
    protected void btApprove_Click(object sender, EventArgs e)
    {
        Int32 result = 0;
        if (btc.ckUserPassword(CurrentUser.ID, txtPassword.Text))
        {
            if (hdfCreateUser.Value == CurrentUser.ID)
            {
                if (ddlHeadDept.SelectedIndex == 0)
                {
                    lblErrorHeadDept.Visible = true;
                    return;
                }
                else
                {
                    result = btc.getProjectsApproveDetail(Request.QueryString["id"], hdfMainSubDeptCode.Value, CurrentUser.ID, true, txtComment.Text, ddlHeadDept.SelectedValue);
                    Response.Redirect("Projects.aspx?ckmode=12&Cr=" + result);

                }
            }
            else
            {
                result = btc.getProjectsApproveDetail(Request.QueryString["id"], hdfMainSubDeptCode.Value, CurrentUser.ID, true, txtComment.Text, "");
                Response.Redirect("Projects.aspx?ckmode=12&Cr=" + result);
            }
        }
        else
        {
            lblErrorPassword.Visible = true;
        }
    }
    protected void btUnApprove_Click(object sender, EventArgs e)
    {
        Int32 result = 0;
        StringBuilder strbSql = new StringBuilder();

        if (btc.ckUserPassword(CurrentUser.ID, txtPassword.Text))
        {
            strbSql.AppendFormat("Update Projects Set IsApprove = 0, IsWait = NULL, ckSend = NULL, UserApprove = '{1}', DateApprove = '{2}', Comment = N'{3}' Where ProjectsCode = '{0}';",
                Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), txtComment.Text);

            strbSql.AppendFormat("Delete ProjectsApproveDetail Where ProjectsCode = '{0}' And StepNo <> 0;", Request.QueryString["id"]);

            strbSql.AppendFormat("Update ProjectsApproveDetail Set IsApprove = NULL, CreateDate = NULL, Comment = NUll Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            result = Conn.Execute(strbSql.ToString());

            //result = Conn.Update("Projects", "Where ProjectsCode = '" + Request.QueryString["id"] + "'", "IsApprove, UserApprove, DateApprove, Comment", 0, CurrentUser.ID, DateTime.Now, txtComment.Text);
            //Conn.Delete("ProjectsApproveDetail", "Where ProjectsCode = '" + Request.QueryString["id"] + "' And StepNo <> 0 ");
            //result = btc.getProjectsApproveDetail(Request.QueryString["id"], hdfMainSubDeptCode.Value, CurrentUser.ID, false, txtComment.Text);
            Response.Redirect("Projects.aspx?ckmode=12&Cr=" + result);
        }
        else
        {
            lblErrorPassword.Visible = true;
        }
    }
    protected void btWait_Click(object sender, EventArgs e)
    {
        Int32 result = 0;
        StringBuilder strbSql = new StringBuilder();

        if (btc.ckUserPassword(CurrentUser.ID, txtPassword.Text))
        {
            strbSql.AppendFormat("Update ProjectsApproveDetail Set CreateDate = '{2}', Comment = N'{3}' Where ProjectsCode = '{0}' And EmpID = '{1}' And StepNo = (Select Max(StepNo) From ProjectsApproveDetail Where ProjectsCode = '{0}');",
                Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), txtComment.Text);


            strbSql.AppendFormat("Update Projects Set IsWait = 1, ckSend = NULL, UserApprove = '{1}', DateApprove = '{2}', Comment = N'{3}' Where ProjectsCode = '{0}';",
                Request.QueryString["id"], CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), txtComment.Text);

            //strbSql.AppendFormat("Delete ProjectsApproveDetail Where ProjectsCode = '{0}' And StepNo <> 0;", Request.QueryString["id"]);

            //strbSql.AppendFormat("Update ProjectsApproveDetail Set IsApprove = NULL, CreateDate = NULL, Comment = NUll Where ProjectsCode = '{0}';", Request.QueryString["id"]);
            result = Conn.Execute(strbSql.ToString());

            Response.Redirect("Projects.aspx?ckmode=12&Cr=" + result);
        }
        else
        {
            lblErrorPassword.Visible = true;
        }
    }
}
