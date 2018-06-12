using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Summary description for Global
/// </summary>
public class Global: HttpApplication
{
    //public static Role role;
	public Global()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        //role = new Role();
    }
    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }
    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }
    void Session_Start(object sender, EventArgs e)
    {
        LoadSettings();
    }
    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }
    public static void LoadSettings()
    {
        //Star.Web.UI.Controls.DataGridViewSettings settings = new Star.Web.UI.Controls.DataGridViewSettings();
        //settings.ImageFolder = "~/CSS/gridview";
        //settings.EmptyDataText = "ไม่พบข้อมูล";
        //settings.PageSize = 50;
        //settings.ConfirmDeleteItemsText = "ยืนยันการลบ รายการ";
        //settings.PagerSettings.PageButtonCount = 3;
        //settings.PagerSettings.Mode = PagerButtons.NumericFirstLast;
        //settings.PagerSettings.Position = PagerPosition.TopAndBottom;
        //Star.Web.UI.Controls.DataGridView.Settings = settings;
    }
    //public static bool IsValid
    //{
    //    get
    //    {
    //        string isValid = (string)HttpContext.Current.Cache["IsValid"];
    //        if (String.IsNullOrEmpty(isValid))
    //        {
    //            isValid = ValidateLicense().ToString();
    //            HttpContext.Current.Cache.Insert("IsValid", isValid, null, DateTime.Now.AddHours(5), System.Web.Caching.Cache.NoSlidingExpiration);
    //        }
    //        return Convert.ToBoolean(isValid);
    //    }
    //}
    //private static bool ValidateLicense()
    //{
        //try
        //{
        //    Star.Web.LicenseControl.LicenseHandler license = new Star.Web.LicenseControl.LicenseHandler();
        //    license.ProcessRequest(HttpContext.Current);
        //    return true;
        //}
        //catch
        //{
        //    return false;
        //}
    //} 
}
