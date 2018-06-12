using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class Controls_Banner : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(CurrentUser.UserName))
            {
                SearchSchoolName();
            }
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

        ckImgBtVisible();
    }
    private void ckImgBtVisible()
    {
        BTC btc = new BTC();
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) != 1)
        {
            ImgBt1.Visible = false;
            ImgBt2.Visible = false;
        }
        else
        {
            DataView dv;
            dv = new BTC().getMasterSchool();
            if (Convert.ToInt32(dv[0]["IsCon"]) == 0)
            {
                ImgBt1.Visible = true;
                ImgBt2.Visible = false;
            }
            else
            {
                ImgBt1.Visible = false;
                ImgBt2.Visible = true;
            }
        }
    }
    protected void txtSchoolName_OnClick(object sender, EventArgs e)
    { 
        Response.Redirect("../MasterData/MR_School.aspx?mode=2&id=" + CurrentUser.SchoolID);
    }
    protected void ImgBt1_OnClick(object sender, EventArgs e)
    {
        Connection Conn = new Connection();
        Conn.Update("MR_School", "Where SchoolID = '" + CurrentUser.SchoolID + "'", "IsCon, ConUser", 1, CurrentUser.ID);
        ckImgBtVisible();
    }
    protected void ImgBt2_OnClick(object sender, EventArgs e)
    {
        Connection Conn = new Connection();
        Conn.Update("MR_School", "Where SchoolID = '" + CurrentUser.SchoolID + "'", "IsCon, ConUser", 0, CurrentUser.ID);
        ckImgBtVisible();
    }
}
