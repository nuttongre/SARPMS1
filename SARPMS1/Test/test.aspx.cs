using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test_test : System.Web.UI.Page
{
    BTC btc = new BTC();
    protected void Page_Load(object sender, EventArgs e)
    {
        string UpdateLink = btc.SchoolFieldName("UpdateLink", CurrentUser.SchoolID);
        Response.Write(UpdateLink);
        Response.Write("<br/>");
        Response.Write(Star.Product.ProductKey.ProductID);
    }
}