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

public partial class ClearIndicatorsError : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                    case "7":
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.EvaluationCode, b.Indicators2Code, b.IndicatorsName2, c.IndicatorsName 
                From Evaluation a Left Join Indicators2 b On a.Indicators2Code = b.Indicators2Code
                Left Join Indicators c On a.IndicatorsCode = c.IndicatorsCode
                Where a.Indicators2Code = '{0}' ";

        DataView dv = Conn.Select(string.Format(StrSql, txtSearch.Text));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
         DataBind();
    }
    private void Delete(string id)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(id)) return;

        i = Conn.Delete("Evaluation", "Where EvaluationCode = '" + id + "'");
        Response.Redirect("ClearIndicatorsError.aspx?ckmode=3&Cr=" + i);
    }
}
