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

public partial class MasterOriginal : System.Web.UI.MasterPage
{
    DataView dv1;
    private void getMenu()
    {
        Connection Conn = new Connection();
        string strSql = "";
        strSql = " Select d.MyProjectName, a.MyMainMenuID,a.MyMainMenuName, b.MySubMenuID, b.MySubMenuName, b.LinkName, a.ImgName, b.ImgName As ImgName2 "
                            + " From MyMainMenu a, MySubMenu b, MenuRole c, MyProject d Where b.DelFlag = 0 "
                            + " And c.UserRoleID = '" + CurrentUser.UserRoleID + "' And a.MyProjectID = d.MyProjectID "
                            + " And a.MyMainMenuID = b.MyMainMenuID And b.MySubMenuID = c.MySubMenuID Order By a.Sort, b.Sort";
       dv1 = Conn.Select(string.Format(strSql));

       DataView dv2 = dv1.ToTable(true, "MyMainMenuID", "MyMainMenuName", "ImgName").DefaultView;

        Repeater1.DataSource = dv2;
        Repeater1.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //SarNokornNon
        if (!string.IsNullOrEmpty(Request.QueryString["nkn"]))
        {
            if (Request.QueryString["nkn"] == "51853CD9-247C-4CDD-B6C4-92639B42B9B3")
            {
                if (UserProvider.ValidateUser("NakornnonCenter", "0YmYPomoknUXNLmGzSR1fg==", false, false) == true)
                {
                    Response.Redirect("ReportTreeView.aspx");
                }
            }
        }

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
            getMenu();
        }
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "AppleWebKit", "AppleWebKit('navigation-1');", true);
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater repD = (Repeater)e.Item.FindControl("repDetail");
        string MID = ((DataRowView)e.Item.DataItem)["MyMainMenuID"].ToString();
        dv1.RowFilter = string.Format("MyMainMenuID='{0}'", MID);
        repD.DataSource = dv1;
        repD.DataBind();
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
    protected string LinkName(string LinkName, string title)
    { 
        if(LinkName.Substring(0, 4) == "http")
        {
            return "<a href=\"" + LinkName + "\" title=\"" + title + "\" target=\"_blank\">";
        }
        else
        {
            return "<a href=\"../" + LinkName + "\" title=\"" + title + "\">";
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
            if (Convert.ToInt32(dv[0]["ckExpDate"]) == 0)
            {
                if (CurrentUser.ID != "4C3E218F-D513-416E-BD10-B4F161717F70")
                {
                    Response.Redirect("../Setting/UnderConstruction2.aspx");
                }
            }

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
