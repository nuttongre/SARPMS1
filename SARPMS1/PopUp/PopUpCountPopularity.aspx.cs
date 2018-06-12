using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class PopUpCountPopularity : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();           
        }
    }
    public override void DataBind()
    {
        string StrSql = " Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, "
                + " p.SetBudget, p.Sort "
                + " From Projects p, dtPopularity dt"
                + " Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode "
                + " And dt.PopularityID = '" + Request.QueryString["id"] + "' ";
                   
        DataView dv = Conn.Select(string.Format(StrSql + " Order By p.Sort "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
    }
    public string GetBudget(decimal setBudget, decimal Budget)
    {
        if (Budget > setBudget)
        {
            return "<span style=\"color:red;\">" + Budget.ToString("#,##0.00") + "</span>";
        }
        else
        {
            return "<span>" + Budget.ToString("#,##0.00") + "</span>";
        }
    }
}
