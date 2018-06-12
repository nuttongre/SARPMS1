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
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

public partial class RenewContact : System.Web.UI.Page
{
    Connection Conn = new Connection();
    BTC btc = new BTC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }   

            getrbtlRenew();
            getExpDate();
        }
    }
    private void getrbtlRenew()
    {
        rbtlRenew.Items.Insert(0, new ListItem(" <img src=\"../Image/onR.png\" /> ปิด", "0"));
        rbtlRenew.Items.Insert(1, new ListItem(" <img src=\"../Image/onB.png\" /> เปิด", "1"));
    }
    private void getExpDate()
    {
        string tDay = DateTime.Now.ToString("dd/MM/yyyy");
        if (!string.IsNullOrEmpty(Request.QueryString["expdate"]))
        {
            tDay = Convert.ToDateTime(Request.QueryString["expdate"]).ToString("dd/MM/yyyy");
        }
        lblExpDate.Text = tDay;

        if (!string.IsNullOrEmpty(Request.QueryString["ckExpDate"]))
        {
            if (Request.QueryString["ckExpDate"] == "False")
            {
                rbtlRenew.SelectedIndex = 0;
            }
            else
            {
                rbtlRenew.SelectedIndex = 1;
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        int i = Conn.Update("MR_School", "", "ckExpDate, ExpDate", rbtlRenew.SelectedValue, Convert.ToDateTime(lblExpDate.Text).ToString("s"));
        Response.Redirect("RenewContact.aspx?ckmode=2&Cr=" + i + "&id=" + Request.QueryString["id"] + "&txtid=" + Request.QueryString["txtid"] + "&expdate=" + Request.QueryString["expdate"]);
    }
}
