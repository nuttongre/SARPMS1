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

public partial class ReportCountFourthAssessmentView : System.Web.UI.Page
{
    protected override void OnPreInit(EventArgs e)
    {
        BTC btc = new BTC();
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    DataView dv1;
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, null);

            getddlYear(1);
            GetData();
        }
        else
        {
            GetData();
        }
    }
    private void getddlYear(int mode)
    {
        BTC btc = new BTC();
        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    private void GetData()
    {
        Connection Conn = new Connection();

        string strSql = @"Select a.FourthAssessmentSideID, 'ด้านที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.FourthAssessmentSideName FullName, a.FourthAssessmentSideName, a.Sort, 
                           b.FourthAssessmentIndicatorID,'ตัวบ่งชี้ที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.FourthAssessmentIndicatorName FullSubName, b.FourthAssessmentIndicatorName, b.Sort, 
                           0 As CountPj, 0 As CountSt 
                           From FourthAssessmentSide a Left Join FourthAssessmentIndicator b On a.FourthAssessmentSideID = b.FourthAssessmentSideID 
                           Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '{0}' 
                           Group By a.FourthAssessmentSideID, a.FourthAssessmentSideName, a.Sort, b.FourthAssessmentIndicatorID, b.FourthAssessmentIndicatorName, b.Sort 
                           Order By a.Sort, b.Sort ";
        dv1 = Conn.Select(String.Format(strSql, ddlYearB.SelectedValue));

        strSql = @"Select dtA.ProjectsCode, dtA.FourthAssessmentIndicatorID
						   From Projects P, dtFourthAssessment dtA
						   Where P.StudyYear = '{0}' And P.SchoolID = '{1}' And P.DelFlag = 0 And P.ProjectsCode = dtA.ProjectsCode ";
        DataView dvDtFA = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue, CurrentUser.SchoolID));

        if (dv1.Count != 0)
        {
          
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["FullName"] = (dv1[i]["FullName"].ToString().Length > 100 ? dv1[i]["FullName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullName"]);
                dv1[i]["FullSubName"] = (dv1[i]["FullSubName"].ToString().Length > 100 ? dv1[i]["FullSubName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullSubName"]);

                dvDtFA.RowFilter = " FourthAssessmentIndicatorID = '" + dv1[i]["FourthAssessmentIndicatorID"].ToString() + "' ";
                dv1[i]["CountPj"] = dvDtFA.Count;
            }

            DataView dv2 = dv1.ToTable(true, "FourthAssessmentSideID", "FullName", "FourthAssessmentSideName").DefaultView;

            rptMain.DataSource = dv2;
            rptMain.DataBind();
        }
        else
        {
            rptMain.DataSource = null;
            rptMain.DataBind();
        }
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        GetData();
    }
    protected void rptMain_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater repD = (Repeater)e.Item.FindControl("rptSub");
        string MID = ((DataRowView)e.Item.DataItem)["FourthAssessmentSideID"].ToString();
        dv1.RowFilter = string.Format("FourthAssessmentSideID='{0}'", MID);
        repD.DataSource = dv1;
        repD.DataBind();
    }
}
