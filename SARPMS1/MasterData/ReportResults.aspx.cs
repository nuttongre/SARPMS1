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

public partial class ReportResults : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, null);

            btc.LinkReport(linkReport);
            getddlYear(0);
            getddlProjects(ddlSearchYear.SelectedValue);
            getddlActivity(ddlSearch.SelectedValue);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        break;
                    case "3":
                        break;
                }
            }
        }
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
    }
    private void getddlProjects(string StudyYear)
    {
        DataView dv = Conn.Select("Select a.ProjectsCode, a.ProjectsName FullName, a.Sort From Projects a Where a.DelFlag = 0 And a.StudyYear = '" + StudyYear + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' Order By a.Sort");
        if (dv.Count != 0)
        {
            ddlSearch.DataSource = dv;
            ddlSearch.DataTextField = "FullName";
            ddlSearch.DataValueField = "ProjectsCode";
            ddlSearch.DataBind();
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch.Enabled = true;
        }
        else
        {
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch.Enabled = false;
        }
        ddlSearch.SelectedIndex = 0;
    }
    private void getddlActivity(string ProjectsCode)
    {
        btc.getddlActivity(0, ddlSearchActivity, ProjectsCode, Cookie.GetValue2("ckActivityCode"));
    }  
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProjects(ddlSearchYear.SelectedValue);
        getddlActivity(ddlSearch.SelectedValue);
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)                
    {
        getddlActivity(ddlSearch.SelectedValue);
    }    
}
