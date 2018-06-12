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

public partial class PopUpActCount : System.Web.UI.Page
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
        string StrSql = " Select Distinct(a.ActivityCode) ActivityCode, b.ProjectsCode, b.ActivityName, b.DeptCode, "
                + " CostsType = Case b.CostsType When 0 Then 'เงินงบประมาณ' When 1 Then 'เงินระดม' End, "
                + " b.TotalAmount, b.SDate, b.EDate, b.Status, c.ProjectsName, '' DeptName, c.Sort, b.Sort "
                + " From Evaluation a, Activity b, Projects c " 
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                + " And b.ProjectsCode = c.ProjectsCode "
                + " And a.IndicatorsCode = '" + Request.QueryString["id"] + "' And a.StudyYear = '" + Request.QueryString["syear"] + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
                   
        DataView dv = Conn.Select(string.Format(StrSql + " Order By c.Sort, b.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
        }

        GridView1.DataSource = dv;
        GridView1.DataBind();
    }
    protected string DateFormat(object startDate, object endDate)
    {
        return Convert.ToDateTime(startDate).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(endDate).ToString("dd/MM/yyyy");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.ForeColor = btc.getColorRowsGrid(DataBinder.Eval(e.Row.DataItem, "status").ToString());
        }
    }
}
