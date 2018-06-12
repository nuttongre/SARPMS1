using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Star.Product;
using System.IO;
using Star.Web.LicenseControl;
using System.ComponentModel;
using System.Text;
using System.Configuration;

public partial class Tools_License : System.Web.UI.Page
{
    BTC btc = new BTC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Star.Product.ProductKey.ProductID == null)
            Star.Product.ProductKey.ProductID = Program.ProductID;

        Star.Web.LicenseControl.LicenseHandler license = new Star.Web.LicenseControl.LicenseHandler();
        pnlLicense.InnerHtml = license.ProcessRequestHtml(this.Context);
        Program.Settings = null;

        string UpdateLink = btc.SchoolFieldName("UpdateLink", CurrentUser.SchoolID);
        Star.VersionControl.VersionHandler version = new Star.VersionControl.VersionHandler(UpdateLink);
        version.RenderVersionToControl(AutoUpdate, "ระบบกำลังดำเนินการ<br/>ห้ามปิดหน้าจอนี้จนกว่าจะดำเนินการเสร็จ");

        Connection Conn = new Connection();
        Conn.Update("Config", "", "Version", "");
    }
}
