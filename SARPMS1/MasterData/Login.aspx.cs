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
using Star.Security.Cryptography;

public partial class LogIn : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getImageLogo();
            lblLastUpdate.InnerHtml = "Last Update : " + Star.VersionControl.Versions.DateCreate.ToString("dd/MM/yyyy");
            lblVersion.InnerHtml = Star.VersionControl.Versions.ProductName + " V. " + Star.VersionControl.Versions.ProductVersion;
           
            string strSql = " Select * From Config ";
            DataView dv = Conn.Select(strSql);  // get วันที่ Update ล่าสุด เพื่อเช็คค่า

            TimeSpan ts = Convert.ToDateTime(dv[0]["LastUpdate"].ToString()).Subtract(DateTime.Now);  // เทียบวันที่เท่ากัน //DateTime.ParseExact(dv[0]["LastUpdate"].ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture).Subtract(DateTime.Now);
            if (ts.Days < 0)
            {
                if (Star.Product.ProductKey.ProductID == null)
                    Star.Product.ProductKey.ProductID = Program.ProductID;

                string UpdateLink = btc.SchoolFieldName("UpdateLink", "");
                Star.VersionControl.VersionHandler version = new Star.VersionControl.VersionHandler(UpdateLink);   //Url ที่ใช้ Download
                if (!version.IsLastVersion && version.LastVersion != null)
                {
                    Conn.Update("Config", "", "LastUpdate, Version", DateTime.Now, version.LastVersion);
                    //Page.Cache.Remove("CNFG");
                }
            }
        }
    }
    private void getImageLogo()
    {
        string strSql = " Select Top 1 SchoolName, LogoPath From Mr_School ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            ImgLogo.ImageUrl = dv[0]["LogoPath"].ToString();
            lblSchoolName.InnerHtml = dv[0]["Schoolname"].ToString();
        }
    }
    protected void btLogin_Click(object sender, EventArgs e)
    {
        //เช็คจำนวนผู้ใช้-----------------------------------------------------------
        ClientLimit cl = new ClientLimit();
        cl.ClearTimeOut();
        if (cl.UserCount >= cl.UserLimit)
        {
            lblError.Text = "จำนวนผู้เข้าใช้งานเต็ม";
            return;
        }
        //--------------------------------------------------------------------
        if (UserProvider.ValidateUser(txtUserName.Text, Text.Encrypt(txtPassword.Text), false, false) == true)
        {
            if (string.IsNullOrEmpty(Request.QueryString["returnUrl"]))
            {
                btc.UpdateStatusActivity();
                Response.Redirect(FormsAuthentication.DefaultUrl);
            }
            else
            {
                btc.UpdateStatusActivity();
                Response.Redirect(Request.QueryString["returnUrl"]);
            }
        }
        else
        {
            lblError.Text = "User Name หรือ Password ผิดพลาด";
        }
    }
}
