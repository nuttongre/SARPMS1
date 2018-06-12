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

public partial class PopUp_PopUpProjOld : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string YearB = "";
            string stID = "";
            string idtID = "";
            string sgID = "";

            YearB = Request.QueryString["YearB"];
            stID = Request.QueryString["st"];
            idtID = Request.QueryString["idt"];
            sgID = Request.QueryString["sg"];

            getddlYear(0, YearB);
            if (stID != "" && idtID != "")
            {
                getddlStandard(0);
                ddlSearch.SelectedIndex = Convert.ToInt32(stID);
                getddlIndicators(0, ddlSearch.SelectedValue);
                ddlSearch1.SelectedIndex = Convert.ToInt32(idtID);
            }
            else
            {
                getddlStandard(0);
                ddlSearch.SelectedIndex = 0;
                getddlIndicators(0, ddlSearch.SelectedValue);
                ddlSearch1.SelectedIndex = 0;
            }
            getddlStrategies(0, ddlSearchYear.SelectedValue);
            ddlSearch2.SelectedValue = sgID;
            DataBind();           
        }
    }
    private void getddlYear(int mode, string YearB)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            ddlSearchYear.SelectedValue = (Convert.ToInt32(YearB) - 1).ToString();
        }
    }
    private void getddlStandard(int mode)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getddlStandard(0, ddlSearch, ddlSearchYear.SelectedValue, "", Cookie.GetValue2("ckStandardCode"));
        }
    }
    private void getddlIndicators(int mode, string StandardCode)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getddlIndicators(0, ddlSearch1, StandardCode);
        }
    }
    private void getddlStrategies(int mode, string StudyYear)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));
        }
    }
    public override void DataBind()
    {
        string StrSql = " Select b.ProjectsName, c.ActivityName, d.IndicatorsName2, c.Note, "
                    + " d.Weight, WeightType = Case d.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, a.OffAll, a.OffThat, a.CkCriterion "
                    + " From Evaluation a, Projects b, Activity c, Indicators2 d, Standard e, Indicators f "
                    + " Where a.ProjectsCode = b.ProjectsCode And a.ActivityCode = c.ActivityCode " 
                    + " And a.Indicators2Code = d.Indicators2Code And a.StandardCode = e.StandardCode "
                    + " And a.IndicatorsCode = f.IndicatorsCode And a.DelFlag = 0 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.StandardCode = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearch1.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.IndicatorsCode = '" + ddlSearch1.SelectedValue + "' ";
        }
        if (ddlSearch2.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.StrategiesCode = '" + ddlSearch2.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And c.ActivityName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv;
        Connection Conn = new Connection();
        //Response.Write(StrSql + " Order By b.Sort, c.Sort, d.Sort ");
        //    return;
        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, c.Sort, d.Sort "));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerHtml = dv.Count.ToString();
        GridView1.DataBind();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlIndicators(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
   
}
