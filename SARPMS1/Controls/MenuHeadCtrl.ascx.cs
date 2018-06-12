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

public partial class Controls_MenuHeadCtrl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CkAlert();
        }
    }
    private void CkAlert()
    {
        Connection Conn = new Connection();
        string strSql = " Select * From Config ";
        DataView dv = Conn.Select(strSql);  // get วันที่ Update ล่าสุด เพื่อเช็คค่า

        bool notification = !string.IsNullOrEmpty(dv[0]["Version"].ToString());
        if (notification)
        {
            lblCkUpdate.Text = "<a href=\"../Setting/License.aspx\">มี version ใหม่</a>";
            lblCkUpdate.Visible = true;
        }
    }
    protected void lblLogOut_Click(object sender, EventArgs e)
    {
        //เช็คจำนวนผู้ใช้------Clearค่า------------------------------------------------
        new ClientLimit().RemoveClient(CurrentUser.ID);
        //----------------------------------------------------------------------

        Cookie.SetValue2("ckMainDeptID", "");
        Cookie.SetValue2("ckMainSubDeptID", "");
        Cookie.SetValue2("ckDeptID", "");
        Cookie.SetValue2("ckEmpID", "");
        Cookie.SetValue2("ckRoleID", "");
        Cookie.SetValue2("ckStrategiesCode", "");
        Cookie.SetValue2("ckProjectsCode", "");
        Cookie.SetValue2("ckActivityCode", "");
        Cookie.SetValue2("ckSideCode", "");
        Cookie.SetValue2("ckStandardCode", "");

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format("Select UserName From Employee Where EmpID = '" + CurrentUser.ID + "'"));
        FormsAuthentication.SignOut();
        if (dv.Count != 0)
        {
            Conn.AddNew("Transection", "UserName, IPAddress, Action, Datetime", dv.Table.Rows[0]["UserName"], Request.UserHostAddress, 3, DateTime.Now);
        }
        Response.Redirect(FormsAuthentication.LoginUrl);
    }
}
