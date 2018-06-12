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

public partial class EmpByDepartmentView : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDepartment();
            DataBind();
        }
    }
    private void getDepartment()
    {
        ddlDepartment.DataSource = btc.getddlDepartment();
        ddlDepartment.DataTextField = "DeptName";
        ddlDepartment.DataValueField = "DeptCode";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlDepartment.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        string strSql = " Select b.*, a.UserRoleName From UserRole a, Employee b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 "
                        + " And a.UserRoleID = b.UserRoleID ";

        if (ddlDepartment.SelectedIndex != 0)
        {
            strSql = strSql + " And b.DeptCode = '" + ddlDepartment.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            strSql = strSql + " And ((b.EmpName Like '%" + txtSearch.Text + "%') Or (b.UserName Like '%" + txtSearch.Text + "%'))  ";
        }

        DataView dv = Conn.Select(string.Format(strSql));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
