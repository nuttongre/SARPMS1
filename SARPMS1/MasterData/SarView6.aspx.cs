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

public partial class SarView6 : System.Web.UI.Page
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
            getActivity();
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
    private void getActivity() //กิจกรรม
    {
        DataView dv, dv1;
        Connection Conn = new Connection();
        BTC btc = new BTC();

        string strSql = " Select a.ActivityCode, 'กิจกรรม - ' + a.ActivityName ActivityName, a.Sort, Sum(b.APercent) CkAPercent, '' DeptName "
                    + " From Activity a, Evaluation b "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                    + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                    + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (ddlSearchDept.SelectedIndex != 0)
        {
            strSql = " Select a.ActivityCode, 'กิจกรรม - ' + a.ActivityName ActivityName, a.Sort, Sum(b.APercent) CkAPercent, '' DeptName "
                    + " From Activity a, Evaluation b, dtAcDept c "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode  "
                    + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                    + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            strSql = " Select a.ActivityCode, 'กิจกรรม - ' + a.ActivityName ActivityName, a.Sort, Sum(b.APercent) CkAPercent, '' DeptName "
                    + " From Activity a, Evaluation b, dtAcEmp c "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode  "
                    + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                    + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
        }
        dv = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort ");

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
        }

        double CkAPercent;
        string strColor;
        string strEva = "";
        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select a.ActivityCode "
                + " From Activity a, Evaluation b "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                + " And b.ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' "
                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (ddlSearchDept.SelectedIndex != 0)
            {
                strSql = " Select a.ActivityCode "
                + " From Activity a, Evaluation b, dtAcDept c "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                + " And b.ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' "
                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                + " And c.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
            }
            if (ddlSearchEmp.SelectedIndex != 0)
            {
                strSql = " Select a.ActivityCode "
                + " From Activity a, Evaluation b, dtAcEmp c "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And a.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                + " And b.ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' "
                + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                + " And c.EmpCode = '" + ddlSearchEmp.SelectedValue + "' ";
            }
            dv1 = Conn.Select(strSql);

            CkAPercent = (Convert.ToDouble(dv[i]["CkAPercent"]) * 100) / (Convert.ToDouble(dv1.Count) * 100);

            if (CkAPercent < 50)
            {
                strColor = "Red";//"#f87373";
                strEva = "(ไม่ผ่าน)";
            }
            else
            {
                strColor = "#0B610B";
                strEva = "(ผ่าน)";
            }

            lblSummarize.Text = string.Format("<img src=\"../Image/icon/" + ((CkAPercent >= 50) ? "ballg" : "ballr") + ".png\" style=\"border:none;width:36px;height:39px;\"/>&nbsp;&nbsp;<span onclick=\"getPopUpActivity('{5}')\" style=\"cursor:pointer; color:" + ((rbtlView1.Checked) ? "#6E6E6E" : strColor) + ";font-size:" + btc.fontView1 + "pt;font-weight:bold;width:630px;overflow:hidden;\" title=\"{4}\">{0}</span><span style=\"width:120px; text-align:right ;float:right; margin:20px 20px 0 0;color:" + strColor + ";font-size:" + btc.fontView1 + "pt; font-weight:bold;\">{2}</span><span style=\"width:50px; text-align:right; float:Right; padding:20px 55px 0 0; color:" + strColor + "; font-size:" + btc.fontView1 + "pt; font-weight:bold;\">{1}</span><span style=\"float:right; width:140px; padding:20px 25px 0 0; color:" + strColor + "; font-size:" + btc.fontView1 + "pt; text-align:right; font-weight:bold;\">{3}%</span><p style=\"clear:both; float:none;\"></p><hr />", (dv[i]["ActivityName"].ToString().Length > btc.strCut4 ? dv[i]["ActivityName"].ToString().Substring(0, btc.strCut4) + "..." : dv[i]["ActivityName"]), "", strEva, " " + CkAPercent.ToString("#,##0.00") + " ", dv[i]["DeptName"], dv[i]["ActivityCode"].ToString());

            DataView dvHead = Conn.Select("Select Top 1 a.SideCode, a.SideName, b.StandardCode, 'มาตรฐานที่ ' + Cast(b.Sort As nVarChar) As StandardName, c.IndicatorsCode, 'ตัวบ่งชี้ที่ ' + Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) As IndicatorsName, d.ProjectsCode, d.ProjectsName, f.ActivityCode, f.ActivityName From Side a, Standard b, Indicators c, Projects d, Activity f, Evaluation e Where a.SideCode = b.SideCode And b.StandardCode = c.StandardCode And d.ProjectsCode = e.ProjectsCode And e.IndicatorsCode = c.IndicatorsCode And d.ProjectsCode = f.ProjectsCode And c.IndicatorsCode = '" + Request.QueryString["idtid"] + "' And e.ProjectsCode = '" + Request.QueryString["pjid"] + "' And f.ActivityCode = '" + Request.QueryString["acid"] + "'");
            Repeater2.DataSource = dvHead;
            Repeater2.DataBind();
        }
    }
    public override void DataBind() //ตัวชี้วัด
    {
        DataView dv;
        Connection Conn = new Connection();
        BTC btc = new BTC();

        string strSql = " Select a.Indicators2Code, 'ตัวชี้วัด - ' + a.IndicatorsName2 IndicatorsName2, '%' As WeightType, a.Sort, b.APercent, b.CkCriterion, '' As FullName "
                    + " From Indicators2 a, Evaluation b "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.Indicators2Code = b.Indicators2Code  "
                    + " And b.ProjectsCode = '" + Request.QueryString["pjid"] + "' "
                    + " And b.IndicatorsCode = '" + Request.QueryString["idtid"] + "' "
                    + " And b.ActivityCode = '" + Request.QueryString["acid"] + "' "
                    + " And b.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " Group By a.Indicators2Code, a.IndicatorsName2, a.WeightType, a.Sort, b.APercent, b.CkCriterion Order By a.Sort";
        dv = Conn.Select(strSql);

        string strColor;
        string strEva = "";
        for (int i = 0; i < dv.Count; i++)
        {
            if (dv[i]["CkCriterion"].ToString() == "0")
            {
                strColor = "Red";//"#f87373";
                strEva = "(ไม่ผ่าน)";
            }
            else
            {
                strColor = "#0B610B";
                strEva = "(ผ่าน)";
            }

            dv[i]["FullName"] = string.Format("<img src=\"../Image/icon/" + ((Convert.ToDouble(dv[i]["APercent"]) >= 50) ? "ballg" : "ballr") + ".png\" style=\"border:none;width:32px;height:35px;\"/>&nbsp;&nbsp;<span style=\"color:" + strColor + ";font-size:" + btc.fontView2 + "pt;font-weight:bold;width:630px;overflow:hidden;\" title=\"{4}\">{0}</span><span style=\"width:100px; text-align:right ;float:right; margin:20px 20px 0 0;color:" + strColor + ";font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{2}</span><span style=\"width:50px; text-align:right; float:Right; padding:20px 55px 0 0; color:" + strColor + "; font-size:" + btc.fontView2 + "pt; font-weight:bold;\">{1}</span><span style=\"float:right; width:120px; padding:20px 40px 0 0; color:" + strColor + "; font-size:" + btc.fontView2 + "pt; text-align:right; font-weight:bold;\">{3}%</span><p style=\"clear:both; float:none;\"></p><hr />", (dv[i]["IndicatorsName2"].ToString().Length > btc.strCut4 ? dv[i]["IndicatorsName2"].ToString().Substring(0, btc.strCut4) + "..." : dv[i]["IndicatorsName2"]), "", strEva, " " + Convert.ToDouble(dv[i]["APercent"]).ToString("#,##0.00") + " ", dv[i]["IndicatorsName2"]);
            //tNodeActivity.Text = string.Format("<img src=\"../Image/icon/" + ((CkAPercent >= 50) ? "icon5g" : "icon5r") + ".png\" style=\"float:left;border:none;padding:0 0 0 35px;\"/>&nbsp;&nbsp;<span title=\"หน่วยงาน : {3}\" style=\"font-size:11pt;color:" + ((rbtlView1.Checked) ? "#6E6E6E" : strColor) + ";\">{0}</span>&nbsp;&nbsp;&nbsp;<span style=\"font-size:12pt;color:" + strColor + ";\">{2}%</span>&nbsp;&nbsp;&nbsp;<span style=\"font-size:12pt;color:" + strColor + ";\">{1}</span>", dv[i]["ActivityName"].ToString(), strEva, CkAPercent.ToString("#,##0.00"), dv[i]["DeptName"].ToString());

            Repeater1.DataSource = dv;
            Repeater1.DataBind();
        }
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
       DataBind();
    }
    protected void rbtView_OnSelectedChanged(object sender, EventArgs e)
    {
        DataBind();
        getActivity();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
