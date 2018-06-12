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

public partial class MasterOriginal2 : System.Web.UI.MasterPage
{
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
                lbUsername.Text = Configurations.Client["my_firstname", true];
            }
        }
        catch
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        if (!IsPostBack)
        {
            SearchSchoolName();
        }
    }
    private void SearchSchoolName()
    {
        DataView dv;
        dv = new BTC().getMasterSchool();
        txtSchoolName.Text = dv.Table.Rows[0]["SchoolName"].ToString();
        if (dv[0]["LogoPath"].ToString() != "")
        {
            ImgLogo.ImageUrl = dv[0]["LogoPath"].ToString();
            ImgLogo.Visible = true;
        }
        else
        {
            ImgLogo.Visible = false;
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
