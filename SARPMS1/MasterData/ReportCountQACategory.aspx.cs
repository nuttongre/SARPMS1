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

public partial class ReportCountQACategory : System.Web.UI.Page
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

        string strSql = @"Select a.QACategoryID, 'หมวดเกณฑ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.QACategoryName FullQAName, a.QACategoryName, a.Sort, 
                           b.QACategorySubID,'หัวข้อเกณฑ์ที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.QACategorySubName FullQASubName, b.QACategorySubName, b.Sort, 
                           0 As CountAc, 0 As CountSt 
                           From QACategory a Left Join QACategorySub b On a.QACategoryID = b.QACategoryID 
                           Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '{0}' 
                           Group By a.QACategoryID, a.QACategoryName, a.Sort, b.QACategorySubID, b.QACategorySubName, b.Sort 
                           Order By a.Sort, b.Sort ";
        dv1 = Conn.Select(String.Format(strSql, ddlYearB.SelectedValue));

        if (dv1.Count != 0)
        {
          
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["FullQAName"] = (dv1[i]["FullQAName"].ToString().Length > 100 ? dv1[i]["FullQAName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullQAName"]);
                dv1[i]["FullQASubName"] = (dv1[i]["FullQASubName"].ToString().Length > 100 ? dv1[i]["FullQASubName"].ToString().Substring(0, 100) + "..." : dv1[i]["FullQASubName"]);

      

                strSql = " Select IsNull(Count(Distinct(ActivityCode)), 0) ActCount From QALink "
                + " Where QACategorySubID = '" + dv1[i]["QACategorySubID"].ToString() + "' "
                + " And DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ";
                DataView ckDv = Conn.Select(strSql);

                if (ckDv.Count != 0)
                {
                    dv1[i]["CountAc"] = Convert.ToInt32(ckDv[0]["ActCount"]);
                }
                else
                {
                    dv1[i]["CountAc"] = 0;
                }
            }

            DataView dv2 = dv1.ToTable(true, "QACategoryID", "FullQAName", "QACategoryName").DefaultView;

            rptQA.DataSource = dv2;
            rptQA.DataBind();
        }
        else
        {
            rptQA.DataSource = null;
            rptQA.DataBind();
        }
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        GetData();
    }
    protected void rptQA_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater repD = (Repeater)e.Item.FindControl("rptQASub");
        string MID = ((DataRowView)e.Item.DataItem)["QACategoryID"].ToString();
        dv1.RowFilter = string.Format("QACategoryID='{0}'", MID);
        repD.DataSource = dv1;
        repD.DataBind();
    }
}
