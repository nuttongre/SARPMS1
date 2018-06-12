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

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }
    protected void lblLogIn_Click(object sender, EventArgs e)
    {
        Response.Redirect(FormsAuthentication.LoginUrl);
    }


    protected override void OnInit(EventArgs e)
    {
        if (!IsPostBack && !Program.Settings.IsValid) BTC.DisplayInValidLicense(Page);
        //base.OnInit;
    }
}
