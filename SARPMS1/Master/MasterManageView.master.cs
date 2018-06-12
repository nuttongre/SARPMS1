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

public partial class MasterManageView : System.Web.UI.MasterPage
{
    DataView dv1;
    protected void Page_Load(object sender, EventArgs e)
    {
        //เช็คจำนวนผู้ใช้-------
        //UserProvider.CheckTimeOut();
        //-----------------
        try
        {
            if (String.IsNullOrEmpty(this.Page.User.Identity.Name))
            {
               FormsAuthentication.RedirectToLoginPage();
            }
            else
            {
               
            }
        }
        catch
        {
            FormsAuthentication.RedirectToLoginPage();
        }

    }
    protected override void OnInit(EventArgs e)
    {
        if (!IsPostBack && !Program.Settings.IsValid) BTC.DisplayInValidLicense(Page);
        //base.OnInit;

        BTC btc = new BTC();
        DataView dv = btc.getMasterSchool();
        if (dv.Count != 0)
        {
            if (Convert.ToInt32(dv[0]["IsCon"]) == 1)
            {
                if (btc.ckGetAdmission(CurrentUser.UserRoleID) != 1)
                {
                    Response.Redirect("../Setting/UnderConstruction.aspx");
                }
            }
        }
    }
}
