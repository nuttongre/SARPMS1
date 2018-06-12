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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public partial class SarManage : System.Web.UI.Page
{
    BTC btc = new BTC();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
                
        }
        txtPassword.Attributes.Add("onkeyup", "ckPassword();");
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (txtPassword.Text == "st@rs0ft")
        {
            tblMenu.Visible = true;
            lblCkPassword.Visible = false;
            Link1.HRef = btc.SchoolFieldName("LogSarLink", CurrentUser.SchoolID);
            Link2.HRef = "../MasterData/ApproveAll.aspx";
            Link3.HRef = "../Setting/MyAdmissionView.aspx";
            Link4.HRef = "../MasterData/SarConfig.aspx";
            Link5.HRef = "../MasterData/ClearAll.aspx";
            Link6.HRef = "../MasterData/ClearUser.aspx";
            Link7.HRef = "../MasterData/ClearIndicatorsError.aspx";
        }
        else
        {
            tblMenu.Visible = false;
            lblCkPassword.Visible = true;
        }
    }
}
