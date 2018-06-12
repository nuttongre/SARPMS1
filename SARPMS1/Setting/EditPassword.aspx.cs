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
using Star.Security.Cryptography;

public partial class EditPassword : System.Web.UI.Page
{
    Connection Conn = new Connection();
    BTC btc = new BTC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
        txtOldPassword.Attributes.Add("onkeyup", "Cktxt(0);");
        txtNewPassword.Attributes.Add("onkeyup", "Cktxt(0);");
        txtConfirmPassword.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private Boolean CkOldPassword()
    {
        string sql = string.Format("Select Pwd From Employee Where EmpID = '" + CurrentUser.ID + "' And Pwd = '" + Text.Encrypt(txtOldPassword.Text) + "' ");     
        DataView dv = Conn.Select(sql);

        if (dv.Count == 0)
        {
            lblErrorOldPassword.Visible = true;
            return false;
        }
        else
        {
            lblErrorOldPassword.Visible = false;
        }
        return true;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (!CkOldPassword())
        {
            return;
        }

        Int32 i = Conn.Update("Employee", "WHERE EmpID = '" + CurrentUser.ID + "' ", "Pwd", Text.Encrypt(txtNewPassword.Text));
        ServiceReference2.ProfileServiceSoapClient PmsServices = new ServiceReference2.ProfileServiceSoapClient();
        PmsServices.setPassword(CurrentUser.ID, Text.Encrypt(txtNewPassword.Text));
        
        ClearAll();
        btc.Msg_Head(Img1, MsgHead, true, "2", i);
    }
    private void ClearAll()
    {
        txtOldPassword.Text = "";
        txtNewPassword.Text = "";
        txtConfirmPassword.Text = "";
    }
}
