using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Setting_UnderConstruction2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getUser();
        }
    }
    private void getUser()
    {
        //BTC btc = new BTC();
        //DataView dv = btc.getMasterSchool();
        //if (dv.Count != 0)
        //{
            lblConUser.Text = "บริษัท สตาร์ซอฟท์แวร์ จำกัด โทร 02-9658975 - 6";
        //}
    }
}
