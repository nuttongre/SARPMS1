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

public partial class PopUpIndicators : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();
        }
    }
    public override void DataBind()
    {
        string IndName = Request["indname"];
        string strSql = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '.  ' + a.StrategiesName FullName, b.IndicatorsName, b.RecNum "
                + " From Strategies a, StrategiesIndicators b "
               + " Where a.StrategiesCode = b.StrategiesCode And a.StrategiesCode = '" + Request["id"] + "' ";

        if (txtSearch.Text != "")
        {
            strSql = strSql + " And IndicatorsName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(strSql + " Order By b.RecNum ");
        if (dv.Count != 0)
        {
            lblStrategiesName.Text = dv[0]["FullName"].ToString();
            rpt1.DataSource = dv;
            lblSearchTotal.InnerHtml = dv.Count.ToString("#,##0");
            rpt1.DataBind();
            if (!string.IsNullOrEmpty(IndName))
            {
                txtID.Text = IndName + ",";
            }
        }
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
        if (Request["type"] == "c")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "CkIsSelect('c');", true);
        }
        if (Request["type"] == "r")
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "CkIsSelect('r');", true);
        }
    }
    protected string getCheckBox(string id, string name, int sort)
    {
        string strLink = "";
        string IndName = Request.QueryString["indname"];
        string[] refName = IndName.Split(',');
        string ckBox = "";
        for (int i = 0; i < refName.Length; i++)
        {
            if (refName[i].ToString().Trim() == name.Trim())
            {
                ckBox = "checked = 'true'";
                break;
            }
        }
        if (Request["type"] == "c")
        {
            strLink = "<input type=\"checkbox\" id=\"cb" + sort + "\" value=\"" + name + "\" " + ckBox + " onclick=\"setItem('c');\" /> "
                                + "<span class=\"spantxt2\">" + name + "</span>";
        }
        if (Request["type"] == "r")
        {
            strLink = "<input type=\"radio\" id=\"cb" + sort + "\" value=\"" + name + "\" name=\"a\" " + ckBox + " onclick=\"setItem('r');\" /> "
                                    + "<span class=\"spantxt2\">" + name + "</span>";
        }
        return strLink;
    }

    //public override void DataBind()
    //{
    //    string StrSql = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '.  ' + a.StrategiesName FullName, b.IndicatorsName, b.RecNum "
    //            + " From Strategies a, StrategiesIndicators b "
    //            + " Where a.StrategiesCode = b.StrategiesCode And a.StrategiesCode = '" + Request.QueryString["id"] + "' ";
                   
    //    DataView dv;
    //    BTC btc = new BTC();
    //    Connection Conn = new Connection();

    //    dv = Conn.Select(string.Format(StrSql + " Order By b.RecNum "));

    //    rptIncicators.DataSource = dv;
    //    rptIncicators.DataBind();
    //    if (dv.Count != 0)
    //    {
    //        lblStrategiesName.Text = dv[0]["FullName"].ToString();
    //    }
    //    else
    //    {
    //        lblStrategiesName.Text = "ยังไม่มีการระบุตัวชี้วัดความสำเร็จ";
    //    }
    //}
}
