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

public partial class EvaluationProjectsQuality : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    DataView dvApproveFlow = null;
    DataView dvTotalAmout = null;
    DataView dvStatusApprove = null;
    DataView dvAcTotal = null;
    DataView dvAcFinal = null;

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
            btc.ckBudgetYear(lblSearchYear, null);
            
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        //SetItem();
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        break;
                }
            }
            else
            {
                getddlYear(0);
                //getddlStrategies(0, ddlSearchYear.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                DataBind();
            }
        }
        txtConclusion.Attributes.Add("onkeyup", "Cktxt(0);");
        txtPerformance.Attributes.Add("onkeyup", "Cktxt(0);");
        txtProblem.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSolutions.Attributes.Add("onkeyup", "Cktxt(0);");
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
    public override void DataBind()
    {
        TotalAmount = 0;
        string StrSql = "";
        StrSql = @"Select P.ProjectsCode, IsNull(Sum(CD.TotalMoney), 0) TotalMoney From Projects P 
            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
            Where P.DelFlag = 0 And P.StudyYear = '{0}' Group By P.ProjectsCode ";
        dvTotalAmout = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue));

        StrSql = @"Select a.ProjectsCode, Count(a.ActivityCode) AcTotal 
		From Activity a Inner Join dtAcDept dt On a.ActivityCode = dt.ActivityCode
		Inner Join Department d On dt.DeptCode = d.DeptCode
		Inner Join MainSubDepartment MS On MS.MainSubDeptCode = d.MainSubDeptCode
		Inner Join MainDepartment MD On MD.MainDeptCode = MS.MainDeptCode
		Where a.DelFlag = 0 And a.StudyYear = '{0}'";
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MS.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
		
       dvAcTotal = Conn.Select(string.Format(StrSql + " Group By a.ProjectsCode ", ddlSearchYear.SelectedValue));

       StrSql = @"Select a.ProjectsCode, Count(a.ActivityCode) AcFinal 
		From Activity a Inner Join dtAcDept dt On a.ActivityCode = dt.ActivityCode
		Inner Join Department d On dt.DeptCode = d.DeptCode
		Inner Join MainSubDepartment MS On MS.MainSubDeptCode = d.MainSubDeptCode
		Inner Join MainDepartment MD On MD.MainDeptCode = MS.MainDeptCode
		Where a.DelFlag = 0 And a.StudyYear = '{0}' And a.Status = 3 ";
		if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql += " And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            StrSql += " And MS.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
       dvAcFinal = Conn.Select(string.Format(StrSql + " Group By a.ProjectsCode ", ddlSearchYear.SelectedValue));

        StrSql = @" Select a.ProjectsCode, a.StudyYear, a.ProjectsName, a.Df, Ep.EmpID, Ep.EmpName, 
            a.Sort, e.DeptName, a.IsApprove, IsNull(a.Quality, 0) As Quality, 0 As AcTotal, 0 As AcFinal, a.Conclusion
            From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
            Left Join ProjectsApproveDetail PD On PD.ProjectsCode = a.ProjectsCode
            Left Join Employee d On PD.EmpID = d.EmpID  
            Left Join Employee Ep On a.CreateUser = Ep.EmpID
            Left Join Department e On a.DeptCode = e.DeptCode
            Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
            Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
            Where a.DelFlag = 0 And d.DelFlag = 0 And d.hideFlag = 0 And a.IsApprove = 1 And a.StudyYear = '{0}' And a.SchoolID = '{1}' ";

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
            StrSql += " And a.ProjectsName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Group By a.ProjectsCode, a.StudyYear, a.ProjectsName, a.Df, Ep.EmpID, Ep.EmpName, a.Sort, e.DeptName, a.IsApprove, a.Quality, a.Conclusion Order By a.Sort Desc ", ddlSearchYear.SelectedValue, CurrentUser.SchoolID));
        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                DataRow[] drAcTotal = dvAcTotal.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "'");
                if (drAcTotal.Length > 0)
                {
                    dv[i]["AcTotal"] = Convert.ToInt32(drAcTotal[0]["AcTotal"]);
                }

                DataRow[] drAcFinal = dvAcFinal.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "'");
                if (drAcFinal.Length > 0)
                {
                    dv[i]["AcFinal"] = Convert.ToInt32(drAcFinal[0]["AcFinal"]);
                }
            }
        }
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

//        //----GrandTotal-----------
//        StrSql = @" Select IsNull(Sum(CD.TotalMoney), 0) TotalAmount From Projects P 
//            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
//            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
//            Where P.DelFlag = 0 And P.StudyYear = '{0}' 
//            And a.SchoolID = '{1}' ";
//        DataView dvTotal = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));
//        ToltalBudget.InnerHtml = (dvTotal.Count != 0) ? Convert.ToDecimal(dvTotal[0]["TotalAmount"]).ToString("#,##0.00") : "0.00";
//        //----EndGrandTotal-----------
    }
    private void SetItem()
    {
        txtSDay.Text = DateTime.Now.ToShortDateString();
        txtEDay.Text = DateTime.Now.ToShortDateString();

        getrbtlProjectType();
        getrbtlSubProjectType();
        getcblStrategic(ddlYearS.SelectedValue);
        getcblIdentityName2();
        //btc.getcblStrategicPlan(cblStrategicPlan, ddlYearS.SelectedValue);
        btc.getcblCorporateStrategy(divCorporateStrategy, cblCorporateStrategy, ddlYearS.SelectedValue, cblStrategies); //KPI
        btc.getddlStrategicPlan(divStrategicPlan, ddlStrategicPlan, ddlYearS.SelectedValue);
        btc.getddlDepartment(1, ddlDept, CurrentUser.MainSubDeptID, CurrentUser.DeptID, null);
        btc.getddlDepartmentJoin(1, ddlDeptJoin, "", ddlDept.SelectedValue);

        //getcblStrategies(ddlYearS.SelectedValue);
        btc.getcblStrategies(divStrategies, cblStrategies, ddlYearS.SelectedValue);
        btc.IdentityNameEnable(lblIdentityName, txtIdentityName, "IdentityName", "iNameShow", divIdentityName);
        btc.IdentityNameCblEnable(lblIdentityName2, cblIdentityName2, "IdentityName2", "iNameShow2", divIdentityName2);
        btc.IdentityNameCblEnable(lblStrategicObjectives, cblStrategicObjectives, "", "ckStrategicObjectives", divStrategicObjectives);
        btc.IdentityNameCblEnable(lblStandardNation, cblStandardNation, "", "ckStandardNation", divStandardNation);
        btc.IdentityNameCblEnable(lblStandardMinistry, cblStandardMinistry, "", "ckStandardMinistry", divStandardMinistry);
        btc.IdentityNameCblEnable(lblStrategic, cblStrategic, "", "ckStrategic", divStrategic);
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select P.*, IsNull(P.SetBudget, 0) Set_Budget, D.MainSubDeptCode 
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
            lblYearS.Text = ddlYearS.SelectedItem.Text;
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
            rbtlProjectType.SelectedValue = dv[0]["ProjectTypeID"].ToString();
            rbtlProjectType.Enabled = false;
            getrbtlSubProjectType();
            rbtlSubProjectType.SelectedValue = dv[0]["SubProjectTypeID"].ToString();
            rbtlSubProjectType.Enabled = false;
            txtPlace.Text = dv[0]["Place1"].ToString();
            txtEvaTool.Text = dv[0]["EvaTool"].ToString();
            btc.getddlDepartment(1, ddlDept, "", CurrentUser.DeptID, null);
            ddlDept.SelectedValue = dv[0]["DeptCode"].ToString();
            lblDept.Text = ddlDept.SelectedItem.Text;
            btc.getddlDepartmentJoin(1, ddlDeptJoin, "", ddlDept.SelectedValue);
            ddlDeptJoin.SelectedValue = dv[0]["DeptJoinCode"].ToString();
            if (!string.IsNullOrEmpty(dv[0]["DeptJoinCode"].ToString()))
            {
                lblDeptJoin.Text = ddlDeptJoin.SelectedItem.Text;
            }
            else
            {
                lblDeptJoin.Text = "-";
            }
            ddlDeptJoin.Visible = false;
            ddlDept.Visible = false;
            txtConclusion.Text = dv[0]["Conclusion"].ToString();
            txtPerformance.Text = dv[0]["Performance"].ToString();
            txtProblem.Text = dv[0]["Problem"].ToString();
            txtSolutions.Text = dv[0]["Solutions"].ToString();

            if (!string.IsNullOrEmpty(dv[0]["SDate"].ToString()))
            {
                txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString();
            }
            if (!string.IsNullOrEmpty(dv[0]["EDate"].ToString()))
            {
                txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString();
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

        if (hdfCreateUser.Value != CurrentUser.ID)
        {
            if (CurrentUser.RoleLevel < 98)
            {
                btSave.Visible = false;
            }
        }
        else
        {
            //if (btc.ckApproveFlow(id)) //เช็คว่ามีการ Approve ไปแล้วหรือยัง
            //{
            //    btSave.Visible = false;
            //}
        }

        //if (dv18.Count != 0)
        //{
        //    for (int i = 0; i <= cblStrategicPlan.Items.Count - 1; i++)
        //    {
        //        for (int j = 0; j <= dv18.Count - 1; j++)
        //        {
        //            if (cblStrategicPlan.Items[i].Value == dv18[j]["StrategicPlanID"].ToString())
        //            {
        //                cblStrategicPlan.Items[i].Selected = true;
        //                break;
        //            }
        //        }
        //    }
        //}

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
        cblStrategies.Enabled = false;

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
        cblCorporateStrategy.Enabled = false;

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
        cblIdentityName2.Enabled = false;
    }

    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    //protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
    //    DataBind();
    //}
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
    public string GetBudget(string ProjectsCode)
    {
        //TotalAmount += Budget;
        string Total = "0.00";
        DataRow[] dr = dvTotalAmout.Table.Select("ProjectsCode = '" + ProjectsCode + "'");
        if (dr.Length > 0)
        {
            Total = Convert.ToDecimal(dr[0]["TotalMoney"]).ToString("#,##0.00");
            TotalAmount += Convert.ToDecimal(dr[0]["TotalMoney"]);
        }
        return "<span>" + Total + "</span>";
    }
    public decimal GetTotalBudget()
    {
        return TotalAmount;
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
    [System.Web.Services.WebMethod]
    public static string SaveQuality(object ProjectsCode, object Quality)
    {
        StringBuilder sql = new StringBuilder();
        sql.AppendFormat("Update Projects Set Quality = {1} Where ProjectsCode = '{0}'; ",
            ProjectsCode.ToString(), Quality.ToString());

        try
        {
            Connection Conn = new Connection();
            string st = sql.ToString();
            int result = Conn.Execute(sql.ToString());
            return "การบันทึกข้อมูลเสร็จสมบูรณ์";
        }
        catch (Exception ex)
        {
            return "เกิดข้อผิดพลาดในการบันทึกข้อมูล: " + ex.Message;
        }
    }
    protected string getPjQuality(object inx, object ProjectsCode, object Quality, object Conclusion)
    {
        string Link = Quality.ToString();
        if (CurrentUser.RoleLevel >= 98)
        {
            if (!string.IsNullOrEmpty(Conclusion.ToString()))
            {
                Link = "<input id=\"txtQuality" + inx.ToString() + "\" name=\"txtQuality" + inx.ToString() + "\" type=\"text\" maxlength=\"3\" onkeyup=\"txtZero(this, 0); CktxtExamScore(this);\" onclick=\"SelecttxtAll(this);\" onblur=\"SaveData(" + inx.ToString() + ");\" onkeypress=\"return KeyNumber(event);\" class=\"txtBoxNum txt100\" value=\" " + Quality.ToString() + " \" />";
            }
        }
        return Link;
    }
    protected string checkedit(string id, string EmpID, string strName, object actotal, object acfinal)
    {
        if (!string.IsNullOrEmpty(strName))
        {
            if (EmpID == CurrentUser.ID || CurrentUser.RoleLevel >= 98)
            {
                if (Convert.ToInt32(actotal) == Convert.ToInt32(acfinal))
                {
                    return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
                }
                else
                {
                    return string.Format(strName);
                }
            }
            else
            {
                return string.Format(strName);
            }
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
    private void getrbtlProjectType()
    {
        btc.getrbtlProjectType(rbtlProjectType);
    }
    private void getrbtlSubProjectType()
    {
        btc.getrbtlSubProjectType(rbtlSubProjectType, rbtlProjectType.SelectedValue);
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
    protected void ddlYearS_SelectedIndexChanged(object sender, EventArgs e)
    {
        //getcblStrategies(ddlYearS.SelectedValue);
        btc.getcblStrategies(divStrategies, cblStrategies, ddlYearS.SelectedValue);
        btc.GenSort(txtSort, "Projects", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
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
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save("N");
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;

        if (Request.QueryString["mode"] == "2")
        {
            i = Conn.Update("Projects", "Where ProjectsCode = '" + Request.QueryString["id"] + "' ", "Conclusion, Performance, Problem, Solutions",
                txtConclusion.Text, txtPerformance.Text, txtProblem.Text, txtSolutions.Text);
                Response.Redirect("EvaluationProjectsQuality.aspx?ckmode=2&Cr=" + i);
        }
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
    protected string checkapprove(string id, object Conclusion)
    {
        if (!string.IsNullOrEmpty(Conclusion.ToString()))
        {
            string str = "<a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + " onclick=\"printRpt(66,'w','{0}');\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบสรุปโครงการ แบบเอกสาร Word\" src=\"../Image/WordIcon.png\"</a>"
                + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("E") + " onclick=\"printRpt(66,'e','{0}');\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบสรุปโครงการ แบบเอกสาร Excel\" src=\"../Image/Excel.png\"</a>"
                + "<a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(66,'p','{0}');\"><img style=\"border: 0; cursor :pointer;\" title=\"เรียกดูใบสรุปโครงการ แบบเอกสาร PDF\" src=\"../Image/PdfIcon.png\"</a>";
            return String.Format(str, id);
        }
        else {
            return "";
        }
    }
}
