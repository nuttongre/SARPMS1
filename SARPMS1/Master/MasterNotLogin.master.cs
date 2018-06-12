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

public partial class MasterNotLogin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
        {
            getSchoolName();
        }
    }
    private void getSchoolName()
    {
        Connection Conn = new Connection();
        DataView dv = Conn.Select("Select SchoolName From MR_School Where DelFlag = 0");
        if (dv.Count != 0)
        {
            Label1.Text = dv[0]["SchoolName"].ToString();
        }
    }
    protected override void OnInit(EventArgs e)
    {
       
    }
}
