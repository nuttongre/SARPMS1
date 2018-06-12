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

public partial class ClearUser : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }
            DataBind();
        }
    }
    public override void DataBind()
    {
        string strSql = " SELECT a.EmpID, a.UserName, a.Pwd, a.EmpName, '' DeptName, c.UserRoleName, HideFlag "
                + " FROM Employee a "
                + " Left Join UserRole c On a.UserRoleID = c.UserRoleID "
                + " Where a.DelFlag = 0 And a.EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70') ";
        DataView dv = Conn.Select(string.Format(strSql + " Order By HideFlag, a.UserName "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getEmpDeptName(dv[i]["EmpID"].ToString());
            }
        }
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 i = Conn.Delete("Employee", "Where EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70', '7bf87169-cc54-4292-929e-2bb95138e6a0', 'c6c00066-b3ae-4082-bb93-2f045ac2c8d9', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6')");
        Conn.Delete("EmpDept", "Where EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70', '7bf87169-cc54-4292-929e-2bb95138e6a0', 'c6c00066-b3ae-4082-bb93-2f045ac2c8d9', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6')");
        Response.Redirect("ClearUser.aspx?ckmode=3&Cr=" + i);  
    }
}
