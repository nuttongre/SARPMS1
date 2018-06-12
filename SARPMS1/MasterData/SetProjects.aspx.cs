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

public partial class SetProjects : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            ClearAll();
            txtNewYear.Text = btc.getdvDefault("StudyYear", "StudyYear");
            btc.getdllStudyYearForCopy(ddlSearchYear, txtNewYear.Text);

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
            }
            else
            {
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                DataBind();
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.ProjectsCode, a.StudyYear, a.ProjectsName, a.ProjectsDetail, a.sDate, a.eDate, a.ProjectRegistration, "
                    + " a.Sort, IsNull(Sum(c.TotalAmount), 0) TotalAmount, e.Sort "
                    + " From Projects a Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
                    + " Left Join Department e On a.DeptCode = e.DeptCode "
                    + " Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode "
                    + " Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode "
                    + " Where a.DelFlag = 0 And a.IsApprove = 1 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' " // And (a.CopyFlag Is Null Or a.CopyFlag = 0) "
                    + " And a.ProjectsCode Not In (Select RefProjectsCode From Projects Where DelFlag = 0 And RefProjectsCode Is Not NULL And StudyYear = '" + txtNewYear.Text + "')  "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

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
            StrSql = StrSql + " And a.ProjectsName Like '%" + txtSearch.Text + "%' ";
        }

        DataView dv = Conn.Select(string.Format(StrSql + " Group By a.ProjectsCode, a.StudyYear, a.ProjectsName, a.ProjectsDetail, a.Sort, a.sDate, a.eDate, a.ProjectRegistration, e.Sort Order By e.Sort, a.Sort "));

        //เช็คผลรวม
        try
        {
            DataTable dt = dv.ToTable();
            TotalAmount = Convert.ToDecimal(dt.Compute("Sum(TotalAmount)", dv.RowFilter));
        }
        catch (Exception ex)
        {
        }

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.CheckListDataField = "ProjectsCode";
        GridView1.DataBind();
    }
    private void ClearAll()
    {
        txtSearch.Text = "";        
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        DataView dvSide = Conn.Select("Select * From Side Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if (dvSide.Count != 0)
        {
            return true;
        }

        DataView dvStandard = Conn.Select("Select * From Standard Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if (dvStandard.Count != 0)
        {
            return true;
        }

        DataView dvIndicators = Conn.Select("Select b.* From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And a.StudyYear = '" + StudyYearNext + "'");
        if (dvIndicators.Count != 0)
        {
            return true;
        }
        return false;
    }
    private string genProjectRegistration(string DeptID)
    {
        string genID = "001";
        string strSql = @"Select IsNull(Max(Cast(SUBSTRING(ProjectRegistration, 4, 3) As int)), 0) + 1 As AppCode 
            From Projects Where SchoolID = '{0}' And DeptCode = '{1}' And StudyYear = '{2}'";
        DataView dv = Conn.Select(string.Format(strSql, CurrentUser.SchoolID, DeptID, txtNewYear.Text));
        if (dv.Count > 0)
        {
            genID = Convert.ToInt32(dv[0]["AppCode"]).ToString("000");
        }
        return btc.getDeptShortName(CurrentUser.DeptID) + genID;
    }
    private void bt_Save()
    {
        string strSql = "";
        Int32 result = 0;
        StringBuilder strbSql = new StringBuilder();

        if (GridView1.SelectedItems.Length == 0) return;
        for (Int32 i = 0; i <= GridView1.SelectedItems.Length - 1; i++)
        {
            
            //โครงการเดิม
            strSql = " Select * , Isnull(SetBudget, 0) Set_Budget "
                    + " From Projects "
                    + " Where DelFlag = 0 And IsApprove = 1 And ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
            DataView dvProjects = Conn.Select(strSql);

            if (dvProjects.Count != 0)
            {
                //Update ว่าเคยเลือกคัดลอกไปแล้ว
                //Conn.Update("Projects", "Where ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "'", "CopyFlag", 1);

                //คัดลอกโครงการ
                string NewProjectsID = Guid.NewGuid().ToString();
                if (cbProject.Checked)
                {
                    strbSql.AppendFormat("INSERT INTO Projects (ProjectsCode, StudyYear, ProjectsName, Purpose, Purpose2, Target, Target2, Period1, ProjectsDetail, ResponsibleName, ResponsiblePosition, IdentityName, IdentityName2, Sort, Df, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate, StrategicPlanID, ProjectRegistration, IOCode, ProjectTypeID, SubProjectTypeID, SDate, EDate, EvaTool, Place1, DeptCode, DeptJoinCode, StrategicPlan, RefProjectsCode) VALUES ('{0}','{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}','{12}',{13},{14},{15},'{16}','{17}','{18}','{19}','{20}','{21}',N'{22}','{23}','{24}','{25}','{26}','{27}',N'{28}',N'{29}','{30}','{31}','{32}','{33}');",
                        NewProjectsID, txtNewYear.Text, dvProjects[0]["ProjectsName"].ToString(), dvProjects[0]["Purpose"].ToString(), dvProjects[0]["Purpose2"].ToString(), dvProjects[0]["Target"].ToString(), dvProjects[0]["Target2"].ToString(), dvProjects[0]["Period1"].ToString(), dvProjects[0]["ProjectsDetail"].ToString(), dvProjects[0]["ResponsibleName"].ToString(), dvProjects[0]["ResponsiblePosition"].ToString(), dvProjects[0]["IdentityName"].ToString(), dvProjects[0]["IdentityName2"].ToString(), dvProjects[0]["Sort"].ToString(), 0, 0, CurrentUser.SchoolID, dvProjects[0]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", dvProjects[0]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", dvProjects[0]["StrategicPlanID"].ToString(), genProjectRegistration(dvProjects[0]["DeptCode"].ToString()), dvProjects[0]["IOCode"].ToString(), dvProjects[0]["ProjectTypeID"].ToString(), dvProjects[0]["SubProjectTypeID"].ToString(), Convert.ToDateTime(dvProjects[0]["SDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Convert.ToDateTime(dvProjects[0]["EDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", dvProjects[0]["EvaTool"].ToString(), dvProjects[0]["Place1"].ToString(), dvProjects[0]["DeptCode"].ToString(), dvProjects[0]["DeptJoinCode"].ToString(), dvProjects[0]["StrategicPlan"].ToString(), dvProjects[0]["ProjectsCode"].ToString());

                    strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID,ProjectsCode,EmpID,StepNo) VALUES ('{0}','{1}','{2}',{3});",
                        Guid.NewGuid().ToString(), NewProjectsID, dvProjects[0]["CreateUser"].ToString(), 0);
                }

                //อัตลักษณ์
                strSql = " Select * From dtIdentityName "
                        + " Where ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
                DataView dvIdentityName = Conn.Select(strSql);
                if (dvIdentityName.Count != 0)
                {
                    for (int j = 0; j < dvIdentityName.Count; j++)
                    {
                        strbSql.AppendFormat("INSERT INTO dtIdentityName (ProjectsCode, IdentityNameCode)VALUES('{0}','{1}');", NewProjectsID, dvIdentityName[j]["IdentityNameCode"].ToString());
                    }
                }

                ////KPI
                //strSql = " Select * From dtCorporateStrategy "
                //        + " Where ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
                //DataView dvCorporateStrategy = Conn.Select(strSql);
                //if (dvCorporateStrategy.Count != 0)
                //{
                //    for (int j = 0; j <= dvCorporateStrategy.Count; j++)
                //    {
                //        strbSql.AppendFormat("INSERT INTO dtCorporateStrategy (ProjectsCode, CorporateStrategyID)VALUES('{0}','{1}');", NewProjectsID, dvCorporateStrategy[j]["CorporateStrategyID"].ToString());
                //    }
                //}

                ////มาตรฐานชาติ
                //strSql = " Select * From dtStandardNation "
                //        + " Where ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
                //DataView dvStandardNation = Conn.Select(strSql);

                //if (dvStandardNation.Count != 0)
                //{
                //    for (int j = 0; j <= dvStandardNation.Count; j++)
                //    {
                //        Conn.AddNew("dtStandardNation", "ProjectsCode, StandardNationCode", NewProjectsID, dvStandardNation[j]["StandardNationCode"].ToString());
                //    }
                //}
                
                ////มาตรฐานกระทรวง
                //strSql = " Select * From dtStandardMinistry "
                //        + " Where ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
                //DataView dvStandardMinistry = Conn.Select(strSql);

                //if (dvStandardMinistry.Count != 0)
                //{
                //    for (int j = 0; j <= dvStandardMinistry.Count; j++)
                //    {
                //        Conn.AddNew("dtStandardMinistry", "ProjectsCode, StandardMinistryCode", NewProjectsID, dvStandardMinistry[j]["StandardMinistryCode"].ToString());
                //    }
                //}
                
                //กิจกรรมเดิม
                strSql = " Select * "
                        + " From Activity "
                        + " Where DelFlag = 0 And ProjectsCode = '" + GridView1.SelectedItems[i].ToString() + "' ";
                DataView dvActivity = Conn.Select(strSql);

                if (dvActivity.Count != 0)
                {
                    //คัดลอกกิจกรรม
                    for (int j = 0; j < dvActivity.Count; j++)
                    {
                        string NewActivityID = Guid.NewGuid().ToString();

                        if (cbActivity.Checked)
                        {
                            strbSql.AppendFormat("INSERT INTO Activity (ActivityCode, StrategiesCode, ProjectsCode, ActivityName, IdentityName, IdentityName2, ActivityDetail, Purpose, Target, Target2, Participants, Operation1, Period1, Place1, Emp1, Period2, Place2, Emp2, Operation3, Period3, Place3, Emp3, Solutions, Evaluation, EvaIndicators, EvaAssessment, EvaTool, Expected, VolumeExpect, Place, CostsType, TotalAmount, StudyYear, BudgetYear, Term, YearB, SDate, EDate, RealSDate, RealEDate, AlertDay, Sort, Df, Status, Resource, DeptCode, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate, ActivityStatus, MainActivityID)VALUES('{0}', '{1}', '{2}', N'{3}', N'{4}', N'{5}', N'{6}', N'{7}', N'{8}', N'{9}', N'{10}', N'{11}', N'{12}', N'{13}', N'{14}', N'{15}', N'{16}', N'{17}', N'{18}', N'{19}', N'{20}', N'{21}', N'{22}', N'{23}', N'{24}', N'{25}', N'{26}', N'{27}', {28}, N'{29}', '{30}', {31}, {32}, {33}, {34}, {35}, '{36}', '{37}', '{38}', '{39}', {40}, {41}, {42}, {43}, N'{44}', '{45}', {46}, '{47}', '{48}', '{49}', '{50}', '{51}', {52}, '{53}');",
                                NewActivityID, "", NewProjectsID, dvActivity[j]["ActivityName"].ToString(), "", "", dvActivity[j]["ActivityDetail"].ToString(), dvActivity[j]["Purpose"].ToString(), dvActivity[j]["Target"].ToString(), dvActivity[j]["Target2"].ToString(), dvActivity[j]["Participants"].ToString(), dvActivity[j]["Operation1"].ToString(), dvActivity[j]["Period1"].ToString(), dvActivity[j]["Place1"].ToString(), dvActivity[j]["Emp1"].ToString(), dvActivity[j]["Period2"].ToString(), dvActivity[j]["Place2"].ToString(), dvActivity[j]["Emp2"].ToString(), dvActivity[j]["Operation3"].ToString(), dvActivity[j]["Period3"].ToString(), dvActivity[j]["Place3"].ToString(), dvActivity[j]["Emp3"].ToString(), dvActivity[j]["Solutions"].ToString(), dvActivity[j]["Evaluation"].ToString(), dvActivity[j]["EvaIndicators"].ToString(), dvActivity[j]["EvaAssessment"].ToString(), dvActivity[j]["EvaTool"].ToString(), dvActivity[j]["Expected"].ToString(), Convert.ToDecimal(dvActivity[j]["VolumeExpect"]), dvActivity[j]["Place"].ToString(), dvActivity[j]["CostsType"].ToString(), Convert.ToDecimal(dvActivity[j]["TotalAmount"]), Convert.ToInt32(txtNewYear.Text), Convert.ToInt32(txtNewYear.Text), dvActivity[j]["Term"].ToString(), Convert.ToInt32(txtNewYear.Text), Convert.ToDateTime(dvActivity[j]["SDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Convert.ToDateTime(dvActivity[j]["EDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Convert.ToDateTime(dvActivity[j]["RealSDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Convert.ToDateTime(dvActivity[j]["RealEDate"]).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Convert.ToInt32(dvActivity[j]["AlertDay"]), Convert.ToInt32(dvActivity[j]["Sort"]), 1, '0', dvActivity[j]["Resource"].ToString(), dvActivity[j]["DeptCode"].ToString(), 0, CurrentUser.SchoolID, dvActivity[j]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", new CultureInfo("en-gb")), dvActivity[j]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", new CultureInfo("en-gb")), 0, dvActivity[j]["MainActivityID"].ToString());

                            //งบประมาณ
                            strSql = " Select *, IsNull(TotalBudgetTerm1, 0) Total_BudgetTerm1, IsNull(TotalBudgetTerm2, 0) Total_BudgetTerm2 From CostsDetail Where ActivityCode = '" + dvActivity[j]["ActivityCode"].ToString() + "'";
                            DataView dvCostsDetail = Conn.Select(strSql);

                            if (dvCostsDetail.Count != 0)
                            {
                                for (int k = 0; k < dvCostsDetail.Count; k++)
                                {
                                    //คัดลอกงบประมาณ
                                    strbSql.AppendFormat("INSERT INTO CostsDetail (ActivityCode, ListName, EntryCostsCode, BudgetTypeCode, BudgetTypeOtherName, TotalP, TotalD, TotalG, TotalMoney, TotalMoney2, ItemID, TotalBudgetTerm1, TotalBudgetTerm2, ListNo)VALUES('{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',{6},{7},{8},{9},'{10}',{11},{12},{13});",
                                        NewActivityID, dvCostsDetail[k]["ListName"].ToString().Trim(), dvCostsDetail[k]["EntryCostsCode"].ToString(), dvCostsDetail[k]["BudgetTypeCode"].ToString(), dvCostsDetail[k]["BudgetTypeOtherName"].ToString(), dvCostsDetail[k]["TotalP"].ToString(), Convert.ToDecimal(dvCostsDetail[k]["TotalD"]), Convert.ToDecimal(dvCostsDetail[k]["TotalG"]), Convert.ToDecimal(dvCostsDetail[k]["TotalMoney"]), 0, Guid.NewGuid().ToString(), Convert.ToDecimal(dvCostsDetail[k]["Total_BudgetTerm1"]), Convert.ToDecimal(dvCostsDetail[k]["Total_BudgetTerm2"]), k);
                                }
                            }

                            //การดำเนินงาน
                            strSql = " Select * From ActivityOperation2 "
                                    + " Where ActivityCode = '" + dvActivity[j]["ActivityCode"].ToString() + "' ";
                            DataView dvActivityOperation2 = Conn.Select(strSql);

                            if (dvActivityOperation2.Count != 0)
                            {
                                for (int k = 0; k < dvActivityOperation2.Count; k++)
                                {
                                   strbSql.AppendFormat("INSERT INTO ActivityOperation2 (ActivityCode, RecNum, Operation2, Budget2, BudgetOther)VALUES('{0}',{1},N'{2}',{3}, {4});",
                                    NewActivityID, Convert.ToDecimal(dvActivityOperation2[k]["RecNum"]), dvActivityOperation2[k]["Operation2"].ToString(), Convert.ToDecimal(dvActivityOperation2[k]["Budget2"]), Convert.ToDecimal(dvActivityOperation2[k]["BudgetOther"]));
                                }
                            }

                            //หน่วยงาน
                            strSql = " Select * From dtAcDept Where ActivityCode = '" + dvActivity[j]["ActivityCode"].ToString() + "'";
                            DataView dvAcDept = Conn.Select(strSql);

                            if (dvAcDept.Count != 0)
                            {
                                for (int k = 0; k < dvAcDept.Count; k++)
                                {
                                    //คัดลอกหน่วยงาน
                                    strbSql.AppendFormat("INSERT INTO dtAcDept (ActivityCode, DeptCode)VALUES('{0}','{1}');", NewActivityID, dvAcDept[k]["DeptCode"].ToString());
                                }
                            }

                            //ผู้รับผิดชอบ
                            strSql = " Select * From dtAcEmp Where ActivityCode = '" + dvActivity[j]["ActivityCode"].ToString() + "'";
                            DataView dvAcEmp = Conn.Select(strSql);

                            if (dvAcEmp.Count != 0)
                            {
                                for (int k = 0; k < dvAcEmp.Count; k++)
                                {
                                    //คัดลอกผู้รับผิดชอบ
                                    strbSql.AppendFormat("INSERT INTO dtAcEmp (ActivityCode, EmpCode)VALUES('{0}','{1}');", NewActivityID, dvAcEmp[k]["EmpCode"].ToString());
                                }
                            }
                        }
                        //ตัวชี้วัดเดิม
                        strSql = " Select * "
                                + " From Indicators2 "
                                + " Where DelFlag = 0 And ActivityCode = '" + dvActivity[j]["ActivityCode"].ToString() + "' ";
                        DataView dvIndicators2 = Conn.Select(strSql);

                        if (dvIndicators2.Count != 0)
                        {
                            //คัดลอกตัวชี้วัด
                            for (int k = 0; k < dvIndicators2.Count; k++)
                            {
                                string NewIndicators2ID = Guid.NewGuid().ToString();

                                if (cbIndicator2.Checked)
                                {
                                    strbSql.AppendFormat("INSERT INTO Indicators2 (Indicators2Code, ProjectsCode, ActivityCode, IndicatorsName2, Weight, WeightType, OffAll, OffThat, APerCent, CkCriterion, Sort, Df, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate) VALUES ('{0}','{1}','{2}',N'{3}',{4},{5},{6},{7},{8},{9},{10},{11},'{12}','{13}','{14}','{15}','{16}','{17}');", 
                                        NewIndicators2ID, NewProjectsID, NewActivityID, dvIndicators2[k]["IndicatorsName2"].ToString(), dvIndicators2[k]["Weight"].ToString(), dvIndicators2[k]["WeightType"].ToString(), Convert.ToDouble(dvIndicators2[k]["OffAll"]), 0, 0, 0, dvIndicators2[k]["Sort"].ToString(), 1, 0, CurrentUser.SchoolID, dvIndicators2[k]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", new CultureInfo("en-gb")), dvIndicators2[k]["CreateUser"].ToString(), DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", new CultureInfo("en-gb")));
                                }
                            }
                        }
                    }
                }
            }
        }
        result = Conn.Execute(strbSql.ToString());
        btc.Msg_Head(Img1, MsgHead, true, "1", result);
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
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
    protected void cbIndicator2_CheckedChanged(object sender, EventArgs e)
    {
        if (cbIndicator2.Checked)
        {
            cbActivity.Checked = true;
            cbActivity.Enabled = false;
        }
        else
        {
            cbActivity.Enabled = true;
        }
    }
    protected string getSDateEDate(object Sdate, object Edate)
    {
        string Link = "-";
        if ((!string.IsNullOrEmpty(Sdate.ToString())) && (!string.IsNullOrEmpty(Edate.ToString())))
        {
            Link = Convert.ToDateTime(Sdate).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(Edate).ToString("dd/MM/yyyy");
        }
        return Link;
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
}
