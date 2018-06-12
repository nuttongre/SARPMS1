using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class SarView3 : System.Web.UI.Page
{
    BTC btc = new BTC();
    protected override void OnPreInit(EventArgs e)
    {
        //BTC btc = new BTC();
        //DataView dv = btc.getAdmission(CurrentUser.UserRoleID);
        //if (dv.Count != 0)
        //{
        //    if (Convert.ToInt32(dv[0]["IsManager"]) == 1)
        //    {
        //        this.MasterPageFile = "~/Master/MasterOriginal2.master";
        //    }
        //}
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            getddlYear();
            getddlDepartment();
            btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));

            string yearid = Request["year"];
            string ckview = Request["ckview"];
            string deptid = Request["deptid"];
            string empid = Request["empid"];
            if (!String.IsNullOrEmpty(yearid))
            {
                ddlYearB.SelectedValue = yearid;
            }
            if (!string.IsNullOrEmpty(ckview))
            {
                if (ckview == "0")
                {
                    rbtlView1.Checked = true;
                    rbtlView2.Checked = false;
                }
                else
                {
                    rbtlView1.Checked = false;
                    rbtlView2.Checked = true;
                }
            }
            if (!string.IsNullOrEmpty(deptid))
            {
                ddlSearchDept.SelectedValue = deptid;
            }
            if (!string.IsNullOrEmpty(empid))
            {
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                ddlSearchEmp.SelectedValue = empid;
            }
            ddlYearB.Enabled = false;
            ddlSearchDept.Enabled = false;
            ddlSearchEmp.Enabled = false;
            getStandard();
            DataBind();
        }
    }
    private void getddlYear()
    {
        BTC btc = new BTC();
        btc.getdllStudyYear(ddlYearB);
        btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
    }
    private void getddlDepartment()
    {
        BTC btc = new BTC();
        btc.getddlDepartment(ddlSearchDept);
        ddlSearchDept.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        //btc.CkAllDept(ddlSearchDept);
    }
    public void getStandard()  //มาตรฐาน
    {
        DataView dv, dv1, dv2, dv3, dv4;
        Connection Conn = new Connection();
        BTC btc = new BTC();

        string strSql = " Select b.StandardCode, 'มาตรฐานที่ ' + Cast(b.Sort As nVarChar) + '. - ' + b.StandardName as StandardName, "
                + " IsNull(Sum(c.WeightScore), 0) WeightScore, b.Sort, '' As FullName, b.ScoreGroupID "
                + " From Side a Left Join Standard b On a.SideCode = b.SideCode "
                + " Left Join Indicators c On b.StandardCode = c.StandardCode "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 "
                + " And a.StudyYear = '" + ddlYearB.SelectedValue + "' And b.StudyYear = '" + ddlYearB.SelectedValue + "' "
                + " And b.StandardCode = '" + Request.QueryString["stdid"] + "' "
                + " Group By b.StandardCode, StandardName, b.Sort "
                + " Order By b.Sort ";
        dv = Conn.Select(strSql);

        double CkCriterion = 0;
        string strColor = "black";
        double SummarizeAvg = 0;
        double SummarizeCount = 0;

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                strSql = " Select b.IndicatorsCode, b.WeightScore, Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + SubString(b.IndicatorsName,1,80) + ' ( ' + Cast(b.WeightScore As nVarChar) + ' )' As IndicatorsName "
                     + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                     + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' "
                     + " And b.StandardCode = '" + dv[i]["StandardCode"].ToString() + "' Order By a.Sort, b.Sort ";
                dv1 = Conn.Select(strSql);

                double IndPercent = 0;
                double ckIndScore = 0;
                for (int j = 0; j < dv1.Count; j++)
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (ddlSearchDept.SelectedIndex != 0)
                    {
                        strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                    }
                    if (ddlSearchEmp.SelectedIndex != 0)
                    {
                        strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
                    }
                    dv2 = Conn.Select(strSql + " Group By a.ProjectsCode ");

                    double PjPercent = 0;
                    for (int k = 0; k < dv2.Count; k++)
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                           + " From Activity a, Evaluation b "
                           + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                           + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                           + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                        if (ddlSearchDept.SelectedIndex != 0)
                        {
                           strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                           + " From Activity a, Evaluation b, dtAcDept c "
                           + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                           + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                           + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                           + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                        }
                        if (ddlSearchEmp.SelectedIndex != 0)
                        {
                           strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                           + " From Activity a, Evaluation b, dtAcEmp c "
                           + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                           + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                           + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                           + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
                        }
                        dv3 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                        double AcPercent = 0;
                        for (int l = 0; l < dv3.Count; l++)
                        {
                            strSql = " Select a.ActivityCode "
                               + " From Activity a, Evaluation b "
                               + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                               + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                               + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                               + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                            if (ddlSearchDept.SelectedIndex != 0)
                            {
                               strSql = " Select a.ActivityCode "
                               + " From Activity a, Evaluation b, dtAcDept c "
                               + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                               + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                               + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                               + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                               + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                            }
                            if (ddlSearchEmp.SelectedIndex != 0)
                            {
                               strSql = " Select a.ActivityCode "
                               + " From Activity a, Evaluation b, dtAcEmp c "
                               + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                               + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                               + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                               + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                               + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
                            }
                            dv4 = Conn.Select(strSql);

                            AcPercent += (Convert.ToDouble(dv3[l]["CkAPercent"]) * 100) / (Convert.ToDouble(dv4.Count) * 100);
                        }

                        PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv3.Count) * 100);
                    }

                    if (dv2.Count != 0)
                    {
                        IndPercent = (PjPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
                    }
                    else
                    {
                        IndPercent = 0;
                    }

                    double IndScore = 0;
                    IndScore = (IndPercent * Convert.ToDouble(dv1[j]["WeightScore"])) / 100;

                    //string[] IndCriterion = new BTC().ckTCriteria(Convert.ToDouble(dv1[j]["WeightScore"]), IndScore).Split(':');
                    //ckIndScore += Convert.ToDouble(IndCriterion[0]);

                    ckIndScore += Convert.ToDouble(IndScore.ToString("#0.00"));
                }

                double hScore = 0;
                //hScore = (ckIndScore / Convert.ToDouble(dv1.Count));

                hScore = ckIndScore;

                string[] Tcriterion = new BTC().ckTCriteria(Convert.ToDouble(dv[i]["ScoreGroupID"]).ToString(), hScore).Split(':');
                double ckScore = Convert.ToDouble(Tcriterion[0]);
                string ckTranslation = Tcriterion[1].ToString();

                //strColor = btc.getColorMaster(hScore, Convert.ToDouble(dv[i]["WeightScore"]));
                if (ckScore > 1)
                {
                    strColor = "#0B610B";
                }
                else
                {
                    strColor = "Red";
                }

                double ckPercen = (hScore * 100) / Convert.ToDouble(dv[i]["WeightScore"]);

                SummarizeCount += ckScore;

                lblSummarize.Text = string.Format("<img src=\"../Image/icon/" + ((ckScore > 1) ? "ballg" : "ballr") + ".png\" style=\"border:none;width:36px;height:39px;\"/>&nbsp;&nbsp;<span style=\"color:" + ((rbtlView1.Checked) ? "#08088A" : strColor) + ";font-size:" + btc.fontView1 + "pt;font-weight:bold;width:600px;overflow:hidden;\" title=\"{5}\">{0}</span><span style=\"width:100px; text-align:right ;float:right; margin:20px 20px 0 0;color:" + strColor + ";font-size:" + btc.fontView1 + "pt; font-weight:bold;\">{2}</span><span style=\"width:50px; text-align:right; float:Right; padding:20px 58px 0 0; color:" + strColor + "; font-size:" + btc.fontView1 + "pt; font-weight:bold;\">{1}</span><span style=\"float:right; width:70px; padding:20px 60px 0 0; color:" + strColor + "; font-size:" + btc.fontView1 + "pt; text-align:right; font-weight:bold;\">{3}</span><span style=\"float:right; padding:20px 120px 0 0; color:#000000; font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{4}</span><p style=\"clear:both; float:none;\"></p><hr />", (dv[i]["StandardName"].ToString().Length > btc.strCut4 ? dv[i]["StandardName"].ToString().Substring(0, btc.strCut4) + "..." : dv[i]["StandardName"]), ckScore, ckTranslation, " " + hScore.ToString("#,##0.00") + " ", dv[i]["WeightScore"], dv[i]["StandardName"]);
            }
        }
        else
        {
            lblSummarize.Text = "";
        }
            DataView dvHead = Conn.Select("Select a.SideCode, a.SideName, b.StandardCode, 'มาตรฐานที่ ' + Cast(b.Sort As nVarChar) As StandardName From Side a, Standard b Where a.SideCode = b.SideCode And b.StandardCode = '" + Request.QueryString["stdid"] + "'");
            Repeater2.DataSource = dvHead;
            Repeater2.DataBind();   
    }

    public override void DataBind()  //ตัวบ่งชี้
    {
        DataView dv, dv1, dv2, dv3;
        Connection Conn = new Connection();
        BTC btc = new BTC();

        string strSql = " Select b.IndicatorsCode, b.WeightScore, 'ตัวบ่งชี้ที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName As IndicatorsName, '' As FullName, b.ScoreGroupID "
                    + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' "
                    + " And b.StandardCode = '" + Request.QueryString["stdid"] + "' Order By a.Sort, b.Sort ";
        dv = Conn.Select(strSql);

        double CkCriterion = 0;
        string strColor = "#2b8216";
        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (ddlSearchDept.SelectedIndex != 0)
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
            }
            if (ddlSearchEmp.SelectedIndex != 0)
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
            }
            dv1 = Conn.Select(strSql + " Group By a.ProjectsCode ");

            double PjPercent = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (ddlSearchDept.SelectedIndex != 0)
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                }
                if (ddlSearchEmp.SelectedIndex != 0)
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b, dtAcEmp c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
                }
                dv2 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                double AcPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (ddlSearchDept.SelectedIndex != 0)
                    {
                        strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
                    }
                    if (ddlSearchEmp.SelectedIndex != 0)
                    {
                        strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b, dtAcEmp c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
                    }
                    dv3 = Conn.Select(strSql);

                    AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (Convert.ToDouble(dv3.Count) * 100);
                }

                PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
            }

            if (dv1.Count != 0)
            {
                CkCriterion = (PjPercent * 100) / (Convert.ToDouble(dv1.Count) * 100);
            }
            else
            {
                CkCriterion = 0;
            }

            double avg = 0;
            avg = CkCriterion;

            double hScore = 0;
            hScore = (avg * Convert.ToDouble(dv[i]["WeightScore"])) / 100;

            string[] Tcriterion = new BTC().ckTCriteria(Convert.ToDouble(dv[i]["ScoreGroupID"]).ToString(), hScore).Split(':');
            double ckScore = Convert.ToDouble(Tcriterion[0]);
            string ckTranslation = Tcriterion[1].ToString();

            //strColor = btc.getColorMaster(hScore, Convert.ToDouble(dv[i]["WeightScore"]));
            if (ckScore > 1)
            {
                strColor = "#0B610B";
            }
            else
            {
                strColor = "Red";
            }

            dv[i]["FullName"] = string.Format("<img src=\"../Image/icon/" + ((ckScore > 1) ? "ballg" : "ballr") + ".png\" style=\"border:none;width:32px;height:35px;\"/>&nbsp;&nbsp;<span style=\"color:" + ((rbtlView1.Checked) ? "#045FB4" : strColor) + ";font-size:" + btc.fontView2 + "pt;font-weight:bold;width:630px;overflow:hidden;\" title=\"{5}\">{0}</span><span style=\"width:100px; text-align:right ;float:right; margin:20px 20px 0 0;color:" + strColor + ";font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{2}</span><span style=\"width:50px; text-align:right; float:Right; padding:20px 55px 0 0; color:" + strColor + "; font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{1}</span><span style=\"float:right; width:70px; padding:20px 65px 0 0; color:" + strColor + "; font-size:" + btc.fontView2 + "pt; text-align:right; font-weight:bold;\">{3}</span><span style=\"float:right; padding:20px 115px 0 0; color:#000000; font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{4}</span><p style=\"clear:both; float:none;\"></p><hr />", (dv[i]["IndicatorsName"].ToString().Length > btc.strCut4 ? dv[i]["IndicatorsName"].ToString().Substring(0, btc.strCut4) + "..." : dv[i]["IndicatorsName"]), ckScore, ckTranslation, " " + hScore.ToString("#,##0.00") + " ", dv[i]["WeightScore"], dv[i]["IndicatorsName"]);

            Repeater1.DataSource = dv;
            Repeater1.DataBind();
        }
    }

    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        getStandard();
        DataBind();
    }
    protected void rbtView_OnSelectedChanged(object sender, EventArgs e)
    {
        getStandard();
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        getStandard();
        DataBind();
    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        getStandard();
        DataBind();
    }
}
