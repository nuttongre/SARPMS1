
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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public partial class SarConfig : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getcblReportProject();
            getcblReportActivity();
            GetRate();
            getddlYear();
            GetData(CurrentUser.SchoolID);
            ckFullText();
        }
        txtUpdateLink.Attributes.Add("onkeyup", "Cktxt(0);");
        txtLogSarLink.Attributes.Add("onkeyup", "Cktxt(0);");
        txtForwardMail.Attributes.Add("onkeyup", "Cktxt(0);");
        //txtIdentity.Attributes.Add("onkeyup", "CkIdentity();");
        //txtIdentity2.Attributes.Add("onkeyup", "CkIdentity2();");
    }
    private void GetRate()
    {
        rbtlRate.Items.Insert(0, new ListItem(" แบบเก่า (1 ตารางทุกหมวดน้ำหนักคะแนน)", "0"));
        rbtlRate.Items.Insert(1, new ListItem(" แบบใหม่ (2 ตารางในบางหมวดน้ำหนักคะแนน)", "1"));
        rbtlRate.Items.Insert(2, new ListItem(" แบบเขต 1 กทม. (12 มาตรฐาน)", "2"));
        rbtlRate.Items.Insert(3, new ListItem(" แบบมาตรฐานใหม่ (4 มาตรฐาน)", "3"));
        rbtlRate.DataBind();
    }
    private void getddlYear()
    {
        btc.getdllStudyYear(ddlYearS);
        btc.getDefault(ddlYearS, "StudyYear", "StudyYear");
    }
    private void getcblReportProject()
    {
        cblReportProject.Items.Insert(0, new ListItem(" แบบที่ 1 ", "0"));
        cblReportProject.Items.Insert(1, new ListItem(" แบบที่ 2 ", "1"));
    }
    private void getcblReportActivity()
    {
        cblReportActivity.Items.Insert(0, new ListItem(" ใบคำขอ ", "0"));
    }
    private void getReport(string strReport, CheckBoxList cbl)
    {
        string[] ckReport = strReport.Split(',');
        for (int i = 0; i <= cbl.Items.Count - 1; i++)
        {
            for (int j = 0; j <= ckReport.Length - 1; j++)
            {
                if (cbl.Items[i].Value == ckReport[j].ToString())
                {
                    cbl.Items[i].Selected = true;
                    break;
                }
            }
        }
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select *, IsNull(ckSale, 0) ck_Sale From MR_School Where SchoolID = '" + id + "'"));

        if (dv.Count != 0)
        {
            txtIdentity.Text = dv[0]["IdentityName"].ToString();
            txtIdentity2.Text = dv[0]["IdentityName2"].ToString();
            txtUpdateLink.Text = dv[0]["UpdateLink"].ToString();
            txtLogSarLink.Text = dv[0]["LogSarLink"].ToString();
            txtForwardMail.Text = dv[0]["MailTo"].ToString();
            txtPositionResponsible.Text = dv[0]["PositionResponsible"].ToString();
            txtPositionHeadGroupSara.Text = dv[0]["PositionHeadGroupSara"].ToString();
            txtPositionHeadGroup.Text = dv[0]["PositionHeadGroup"].ToString();

            rbtlYearType.SelectedValue = Convert.ToInt32(dv[0]["ckBudgetYear"]).ToString();
            rbtlIdentity1.SelectedValue = Convert.ToInt32(dv[0]["iNameShow"]).ToString();
            rbtlIdentity2.SelectedValue = Convert.ToInt32(dv[0]["iNameShow2"]).ToString();
            rbtlStrategicObjectives.SelectedValue = Convert.ToInt32(dv[0]["ckStrategicObjectives"]).ToString();
            rbtlStrategic.SelectedValue = Convert.ToInt32(dv[0]["ckStrategic"]).ToString();
            rbtlCorporateStrategy.SelectedValue = Convert.ToInt32(dv[0]["ckCorporateStrategy"]).ToString();
            rbtlStrategicPlan.SelectedValue = Convert.ToInt32(dv[0]["ckStrategicPlan"]).ToString();
            rbtlMainActivity.SelectedValue = Convert.ToInt32(dv[0]["ckMainActivity"]).ToString();
            rbtlStrategies.SelectedValue = Convert.ToInt32(dv[0]["ckStrategies"]).ToString();
            rbtlActivityStatus.SelectedValue = Convert.ToInt32(dv[0]["ckActivityStatus"]).ToString();
            rbtlAcAssessment.SelectedValue = Convert.ToInt32(dv[0]["ckAcAssessment"]).ToString();
            rbtlFullText.SelectedValue = Convert.ToInt32(dv[0]["ckFullText"]).ToString();

            rbtlStandardNation.SelectedValue = Convert.ToInt32(dv[0]["ckStandardNation"]).ToString();
            rbtlStandardMinistry.SelectedValue = Convert.ToInt32(dv[0]["ckStandardMinistry"]).ToString();

            rbtlRate.SelectedValue = Convert.ToInt32(dv[0]["ckRate"]).ToString();

            cbReportW.Checked = Convert.ToBoolean(dv[0]["ckWord"]);
            cbReportE.Checked = Convert.ToBoolean(dv[0]["ckExcel"]);
            cbReportP.Checked = Convert.ToBoolean(dv[0]["ckPDF"]);

            getReport(dv[0]["ckReportProject"].ToString(), cblReportProject);
            getReport(dv[0]["ckReportActivity"].ToString(), cblReportActivity);

            if (CurrentUser.RoleLevel < 98)
            {
                btSave.Visible = false;
            }
            else
            {
                btSave.Visible = true;
            }
        }
    }
    private string ckReport(CheckBoxList cbl)
    {
        string ckReport = "";
        for (int i = 0; i < cbl.Items.Count; i++)
        {
            if (cbl.Items[i].Selected == true)
            {
                ckReport += cbl.Items[i].Value +",";
            }
        }
        if (ckReport != "")
        {
            return ckReport.Substring(0, ckReport.Length - 1);
        }
        else
        {
            return ckReport;
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        string ckReportPj = ckReport(cblReportProject);
        string ckReportAc = ckReport(cblReportActivity);

        Int32 i = Conn.Update("MR_School", "Where SchoolID = '" + CurrentUser.SchoolID + "' ", "IdentityName, IdentityName2, iNameShow, iNameShow2, ckStrategicObjectives, ckStandardNation, ckStandardMinistry, ckRate, ckStrategic, ckFullText, ckBudgetYear, UpdateLink, LogSarLink, MailTo, PositionResponsible, PositionHeadGroupSara, PositionHeadGroup, ckStrategicPlan, ckCorporateStrategy, ckMainActivity, ckStrategies, ckActivityStatus, ckAcAssessment, ckWord, ckExcel, ckPDF, UpdateUser, UpdateDate, ckReportProject, ckReportActivity",
            txtIdentity.Text, txtIdentity2.Text, rbtlIdentity1.SelectedValue, rbtlIdentity2.SelectedValue, rbtlStrategicObjectives.SelectedValue, rbtlStandardNation.SelectedValue, rbtlStandardMinistry.SelectedValue, Convert.ToInt32(rbtlRate.SelectedValue), rbtlStrategic.SelectedValue, rbtlFullText.SelectedValue, rbtlYearType.SelectedValue, txtUpdateLink.Text, txtLogSarLink.Text, txtForwardMail.Text, txtPositionResponsible.Text, txtPositionHeadGroupSara.Text, txtPositionHeadGroup.Text, rbtlStrategicPlan.SelectedValue, rbtlCorporateStrategy.SelectedValue, rbtlMainActivity.SelectedValue, rbtlStrategies.SelectedValue, rbtlActivityStatus.SelectedValue, rbtlAcAssessment.SelectedValue, cbReportW.Checked, cbReportE.Checked, cbReportP.Checked, CurrentUser.ID, DateTime.Now, ckReportPj, ckReportAc);

        if (rbtlckRate.SelectedIndex == 0)
        {
            try
            {
                Conn.Execute("GenRate", "RateType", rbtlRate.SelectedValue);
                Conn.Execute("GenScoreGroupSideAndStandard", "RateType, StudyYear", rbtlRate.SelectedValue, Convert.ToInt32(ddlYearS.SelectedValue));
                Conn.Execute("GenIndRate", "RateType, StudyYear", rbtlRate.SelectedValue, Convert.ToInt32(ddlYearS.SelectedValue));
            }
            catch (Exception ex)
            {

            }
        }

        if (rbtlYearType.SelectedValue == "1") // ปีงบประมาณ
        {
            Conn.Execute("ckMenuBudgetYear", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuBudgetYear", "ck", 0);
        }

        if (rbtlStandardNation.SelectedValue == "1") // มาตรฐานชาติ
        {
           Conn.Execute("ckMenuStandardNation", "ck", 1);
        }
        else
        {
           Conn.Execute("ckMenuStandardNation", "ck", 0);
        }

        if (rbtlStandardMinistry.SelectedValue == "1") // มาตรฐานกระทรวง
        { 
           Conn.Execute("ckMenuStandardMinistry", "ck", 1);
        }
        else
        {
           Conn.Execute("ckMenuStandardMinistry", "ck", 0);
        }

        if (rbtlStrategicObjectives.SelectedValue == "1") // วัตถุประสงค์เชิงกลยุทธ์
        {
            Conn.Execute("ckMenuStrategicObjectives", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuStrategicObjectives", "ck", 0);
        }

        if (rbtlStrategic.SelectedValue == "1") // ยุทธศาสตร์
        {
            Conn.Execute("ckMenuStrategic", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuStrategic", "ck", 0);
        }

        if (rbtlStrategicPlan.SelectedValue == "1") // กลยุทธ์ระดับแผนงาน
        {
            Conn.Execute("ckMenuStrategicPlan", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuStrategicPlan", "ck", 0);
        }

        if (rbtlCorporateStrategy.SelectedValue == "1") // กลยุทธ์ระดับองค์กร
        {
            Conn.Execute("ckMenuCorporateStrategy", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuCorporateStrategy", "ck", 0);
        }

        if (rbtlMainActivity.SelectedValue == "1") // กิจกรรมหลัก
        {
            Conn.Execute("ckMenuMainActivity", "ck", 1);
        }
        else
        {
            Conn.Execute("ckMenuMainActivity", "ck", 0);
        }
        
        btc.Msg_Head(Img1, MsgHead, true, "2", i);
        rbtlckRate.SelectedIndex = 1;
        PanelRate.Enabled = false;
        GetData(CurrentUser.SchoolID);
    }
    protected void rbtlFullText_SelectedIndexChanged(object sender, EventArgs e)
    {
        ckFullText();
    }
    private void ckFullText()
    {
        if (rbtlFullText.SelectedIndex == 0)
        {
            lblExFullText.Text = "Ex. มาตรฐานที่ 1. xxxxxxxxxxx";
        }
        else
        {
            lblExFullText.Text = "Ex. มาตฐานที่ 1, 2, 3, 4";
        }
    }
    protected void rbtlckRate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbtlckRate.SelectedIndex == 0)
        {
            PanelRate.Enabled = true;
        }
        else
        {
            PanelRate.Enabled = false;
        }
    }
    protected void cblReportProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblReportProject.Text = "";
        if (cblReportProject.SelectedIndex == 0)
        {
            lblReportProject.Text = "- แสดงรายละเอียดกิจกรรมประงบประมาณตามประเภทของงบประมาณ";
        }
        if (cblReportProject.SelectedIndex == 1)
        {
            lblReportProject.Text = "- แสดงรายละเอียดกิจกรรมแบบแจงค่าใช้จ่ายรายกิจกรรม";
        }
    }
}
