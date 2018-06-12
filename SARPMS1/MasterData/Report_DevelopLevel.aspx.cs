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

public partial class Report_DevelopLevel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getddlYear();
        }
    }
    private void getddlYear()
    {
        for (int i = 0; i < 5; i++)
        {
            ddlYearB.Items.Insert(i, new ListItem(((DateTime.Now.Year + 543) - 2 + i).ToString(), ((DateTime.Now.Year + 543) - 2 + i).ToString()));
        }
        ddlYearB.SelectedValue = (DateTime.Now.Year + 543).ToString();
    }
    protected void btPrint_Click(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(Page.GetType(), "print", "PrintReport();", true);
    }

}
