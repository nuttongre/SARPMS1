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

public partial class ReportCountSufficeView : System.Web.UI.Page
{
    protected override void OnPreInit(EventArgs e)
    {
        BTC btc = new BTC();
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    DataView dv1 = null, dvIndicator = null;
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

        string strSql = @"Select a.SufficeSideID, 'ด้านที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.SufficeSideName FullName, a.SufficeSideName, a.Sort, 
                           b.SufficeStandardID,'องค์ประกอบที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.SufficeStandardName FullSubName, b.SufficeStandardName, b.Sort, 
                           0 As CountPj, 0 As CountSt 
                           From SufficeSide a Left Join SufficeStandard b On a.SufficeSideID = b.SufficeSideID 
                           Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '{0}' 
                           Group By a.SufficeSideID, a.SufficeSideName, a.Sort, b.SufficeStandardID, b.SufficeStandardName, b.Sort 
                           Order By a.Sort, b.Sort ";
        dv1 = Conn.Select(String.Format(strSql, ddlYearB.SelectedValue));

        strSql = @"Select a.SufficeSideID, a.Sort, 
                           b.SufficeStandardID, b.Sort, 
                           c.SufficeIndicatorID, 'ตัวบ่งชี้ที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) + ' ' + c.SufficeIndicatorName FullsSubName, c.SufficeIndicatorName, c.Sort,
                           0 As CountPj, 0 As CountSt, 0 As CountInd 
                           From SufficeSide a Left Join SufficeStandard b On a.SufficeSideID = b.SufficeSideID 
                           Left Join SufficeIndicator c On b.SufficeStandardID = c.SufficeStandardID
                           Where a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And a.StudyYear = '{0}' 
                           Group By a.SufficeSideID, a.Sort, b.SufficeStandardID, b.Sort, c.SufficeIndicatorID, c.SufficeIndicatorName, c.Sort
                           Order By a.Sort, b.Sort, c.Sort ";
        dvIndicator = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @"Select dtA.ProjectsCode, dtA.SufficeIndicatorID
						   From Projects P, dtSuffice dtA
						   Where P.StudyYear = '{0}' And P.SchoolID = '{1}' And P.DelFlag = 0 And P.ProjectsCode = dtA.ProjectsCode ";
        DataView dvDtFA = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue, CurrentUser.SchoolID));

        if (dv1.Count != 0)
        {
            string strIndicator = "";
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["FullName"] = (dv1[i]["FullName"].ToString().Length > 100 ? dv1[i]["FullName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullName"]);

                dvIndicator.RowFilter = " SufficeStandardID = '" + dv1[i]["SufficeStandardID"].ToString() + "' ";

                string strClass = "imgR";
                string strCountClass = "spantxtCountRed";
                if (dvIndicator.Count != 0)
                {
                    strIndicator = "<ul class=\"ulIndicators\">";
                    for (int j = 0; j < dvIndicator.Count; j++)
                    {
                        strClass = "imgR";
                        strCountClass = "spantxtCountRed";
                        dvDtFA.RowFilter = " SufficeIndicatorID = '" + dvIndicator[j]["SufficeIndicatorID"].ToString() + "' ";
                        if (dvDtFA.Count != 0)
                        {
                            strClass = "imgG";
                            strCountClass = "spantxtCountNormal";
                        }
                        strIndicator += "<li class=\"" + strClass + "\">" + "<span class=\"" + strCountClass + "\" title=\"" + dvDtFA.Count.ToString() + "\" onclick=\"popup('" + dvIndicator[j]["SufficeIndicatorID"].ToString() + "', '" + ddlYearB.SelectedValue +"');\">" + dvDtFA.Count.ToString() + "</span> <span class=\"spantxtIndicatorsAct\" title=\"" + dvIndicator[j]["FullsSubName"].ToString() + "\">" + (dvIndicator[j]["FullsSubName"].ToString().Length > 100 ? dvIndicator[j]["FullsSubName"].ToString().Substring(0, 100) + "..." : dvIndicator[j]["FullsSubName"].ToString()) + "</span></li>";
                    }
                    strIndicator += "</ul>";
                }
                dv1[i]["FullSubName"] = (dv1[i]["FullSubName"].ToString().Length > 100 ? dv1[i]["FullSubName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullSubName"]) + strIndicator;

                //dvDtFA.RowFilter = " SufficeIndicatorID = '" + dv1[i]["SufficeIndicatorID"].ToString() + "' ";
                //dv1[i]["CountPj"] = dvDtFA.Count;
            }

            DataView dv2 = dv1.ToTable(true, "SufficeSideID", "FullName", "SufficeSideName").DefaultView;

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
        string MID = ((DataRowView)e.Item.DataItem)["SufficeSideID"].ToString();
        dv1.RowFilter = string.Format("SufficeSideID='{0}'", MID);
        repD.DataSource = dv1;
        repD.DataBind();
    }
}
