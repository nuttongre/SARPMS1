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
using Star.Security.Cryptography;

public partial class ClearAll : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getddlYear(1);
            DataBind();
        }
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            ddlYearB.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string strYear = "";
        if (ddlYearB.SelectedIndex != 0)
        {
            strYear = " And StudyYear = '" + ddlYearB.SelectedValue + "' ";
        }
        string StrSql = "Select (Select Count(ProjectsCode) From Projects Where DelFlag = 0 " + strYear + ") As CountProject , "
                    + " (Select Count(ActivityCode) From Activity Where DelFlag = 0 " + strYear + ") As CountActivity , "
                    + " (Select Count(b.Indicators2Code) From Activity a, Indicators2 b Where b.DelFlag = 0 And a.ActivityCode = b.ActivityCode " + strYear + ") As CountIndicators ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {        
        Int32 i = 0;
        string strYear = "";
        if (ddlYearB.SelectedIndex != 0)
        {
            strYear = " Where StudyYear = '" + ddlYearB.SelectedValue + "' ";

            try
            {
                i += Conn.Delete("ActivityCostsDetail", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("ActivityDetail", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("Indicators2", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("CostsDetail", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtAcDept", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtAcEmp", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtAcSubDept", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtEditBudgetAc", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtEditDateAc", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtStandardMinistry", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("dtStandardNation", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("dtStandardSPM", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("dtStrategySPM", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("dtStrategySPT", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("ProjectOperation2", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("ActivityOperation2", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtFactor", " Where ActivityCode In (Select ActivityCode From Activity " + strYear + ") ");
                i += Conn.Delete("dtStrategic", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("ProjectsMoneyDetail", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("ProjectsQuarterDetail", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("dtPolicy", " Where ProjectsCode In (Select ProjectsCode From Projects " + strYear + ") ");
                i += Conn.Delete("Evaluation", strYear);
                i += Conn.Delete("Activity", strYear);
                i += Conn.Delete("Projects", strYear);
                i += Conn.Delete("Income", strYear);
                i += Conn.Delete("IncomeDetail", strYear);
                i += Conn.Delete("IndicatorsQuality", strYear);
                i += Conn.Delete("Expenses", strYear);
                i += Conn.Delete("Strategic", strYear);
                //i += Conn.Delete("AttachFile", "");
                //i += Conn.Delete("SarAttach", "");
                //i += Conn.Delete("Strategies", "");
                //i += Conn.Delete("StrategiesIndicators", "");
                //i += Conn.Delete("AttachFile2", "");
                //i += Conn.Delete("Multimedia", "");
            }
            catch (Exception ex)
            {
                i = 0;
            }
        }
        else
        {
            try
            {
                i += Conn.Delete("Projects", "");
                i += Conn.Delete("Activity", "");
                i += Conn.Delete("ActivityCostsDetail", "");
                i += Conn.Delete("ActivityDetail", "");
                i += Conn.Delete("Indicators2", "");
                i += Conn.Delete("Evaluation", "");
                i += Conn.Delete("AttachFile", "");
                i += Conn.Delete("CostsDetail", "");
                i += Conn.Delete("dtAcDept", "");
                i += Conn.Delete("dtAcEmp", "");
                i += Conn.Delete("dtAcSubDept", "");
                i += Conn.Delete("dtEditBudgetAc", "");
                i += Conn.Delete("dtEditDateAc", "");
                i += Conn.Delete("dtStandardMinistry", "");
                i += Conn.Delete("dtStandardNation", "");
                i += Conn.Delete("dtStandardSPM", "");
                i += Conn.Delete("dtStrategySPM", "");
                i += Conn.Delete("dtStrategySPT", "");
                i += Conn.Delete("ProjectOperation2", "");
                i += Conn.Delete("ActivityOperation2", "");
                i += Conn.Delete("Income", "");
                i += Conn.Delete("IncomeDetail", "");
                i += Conn.Delete("SarAttach", "");
                //i += Conn.Delete("Strategies", "");
                //i += Conn.Delete("StrategiesIndicators", "");
                i += Conn.Delete("IndicatorsQuality", "");
                i += Conn.Delete("AttachFile2", "");
                i += Conn.Delete("Expenses", "");
                i += Conn.Delete("dtFactor", "");
                i += Conn.Delete("Strategic", "");
                i += Conn.Delete("dtStrategic", "");
                i += Conn.Delete("ProjectsMoneyDetail", "");
                i += Conn.Delete("ProjectsQuarterDetail", "");
                i += Conn.Delete("Multimedia", "");
                i += Conn.Delete("dtPolicy", "");
            }
            catch (Exception ex)
            {
                i = 0;
            }
        }
        
        Response.Redirect("ClearAll.aspx?ckmode=3&Cr=" + i); 
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
