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
using Star.Security.Cryptography;
using System.IO;
using System.Net.Mail;
using System.Xml;

public partial class Problems : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getMasterData();            
        }
        txtSubject.Attributes.Add("onkeyup", "Cktxt(0);");
        txtProblems.Attributes.Add("onkeyup", "Cktxt(0);");
        txtFrom.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSchoolName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTel.Attributes.Add("onkeyup", "Cktxt(0);");
        txtEmail.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getMasterData()
    {
        string strSql = " Select a.EmpID, a.UserName, a.EmpName, a.Email, a.Tel, b.SchoolName "
                    + " From Employee a, MR_School b "
                    + " Where a.SchoolID = b.SchoolID And a.DelFlag = 0 And b.DelFlag = 0 "
                    + " And a.EmpID = '" + CurrentUser.ID + "' ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count > 0)
        {
            txtFrom.Text = dv[0]["EmpName"].ToString();
            txtSchoolName.Text = dv[0]["SchoolName"].ToString();
            txtTel.Text = dv[0]["Tel"].ToString();
            txtEmail.Text = dv[0]["Email"].ToString();
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        btc.SendMail("0", "" + txtSubject.Text + "," + txtProblems.Text + "," + txtFrom.Text + "  " + txtSchoolName.Text + " " + "  ‡∫Õ√Ï‚∑√  : " + txtTel.Text + " E-mail : " + txtEmail.Text + "");
        btc.Msg_Head(Img1, MsgHead, true, "10", 1);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ClearAll();
    }
    private void ClearAll()
    {
        txtSubject.Text = "";
        txtProblems.Text = "";
    }
}