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

public partial class MasterPopUp: System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        //    if (String.IsNullOrEmpty(this.Page.User.Identity.Name))
        //    {
        //        FormsAuthentication.RedirectToLoginPage();
        //    }
        //}
        //catch
        //{
        //    FormsAuthentication.RedirectToLoginPage();
        //}
        if (!IsPostBack)
        {
        }
    }
    //เช็คสิทธ์การเข้าใช้แต่ละหน้า
    protected Boolean CheckPage
    {
        get
        {
            string Page = Request.RawUrl.Replace("?" + Request.QueryString.ToString(), "").Replace(ResolveUrl("~/"), "");

            DataView dv = new Connection().Select("R.MysubMenuID", "MysubMenu M inner join MenuRole R on M.MysubMenuID=R.MysubMenuID",
            string.Format("Where LinkName='{0}' And UserRoleID='{1}'", Page, CurrentUser.UserRoleID));
            if (!string.IsNullOrEmpty(dv[0]["MysubMenuID"].ToString()))
                return true;
            return false;
        }
    }
}
