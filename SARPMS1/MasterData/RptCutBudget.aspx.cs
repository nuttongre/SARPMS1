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

public partial class RptCutBudget : System.Web.UI.Page
{
    BTC btc = new BTC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btc.LinkReport(linkReport);
            getddlYear(0);
            //getddlReportType();
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
    //private void getddlReportType()
    //{ 
    //    ddlReportType.Items.Insert(0, new ListItem("หน่วยงานใหญ่", "0"));
    //    ddlReportType.Items.Insert(1, new ListItem("หน่วยงานย่อย", "1"));
    //}
}
