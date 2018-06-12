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

public partial class UserRole : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            ClearAll();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "UserRole", "");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt();", true);
                        break;
                    case "2":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        btc.txtEnable(table1, TableSearch, GridView1, false);
                        Delete(Request["id"]);
                        break;
                }
            }
            DataBind();
        }
        txtUserRole.Attributes.Add("onkeyup", "Cktxt();");
        txtSort.Attributes.Add("onkeyup", "CkSort();");
    }
    public override void DataBind()
    {
        String StrSql = "Select * From UserRole Where DelFlag = '0' ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And UserRoleName Like '%" + txtSearch.Text + "%'";
        }
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " Order By Sort "));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select * From UserRole Where DelFlag = 0 And UserRoleID = '" + id + "' "));

        if (dv.Count != 0)
        {
            txtUserRole.Text = dv[0]["UserRoleName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            cbAdmin.Checked = Convert.ToBoolean(dv[0]["IsAdmin"]);
            cbAllDept.Checked = Convert.ToBoolean(dv[0]["IsAllDept"]);
            cbDept.Checked = Convert.ToBoolean(dv[0]["IsDept"]);
            cbManager.Checked = Convert.ToBoolean(dv[0]["IsManager"]);
            cbHeadDept.Checked = Convert.ToBoolean(dv[0]["IsHeadDept"]); ;      
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtUserRole.Text = "";
        txtSearch.Text = "";
        cbAdmin.Checked = false;
        cbAllDept.Checked = false;
        cbDept.Checked = false;
        cbManager.Checked = false;
        cbHeadDept.Checked = false;
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.txtEnable(table1, TableSearch, GridView1, true);
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        Connection Conn = new Connection();
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {          
            string NewID = Guid.NewGuid().ToString();
            Int32 i = Conn.AddNew("UserRole", "UserRoleID, UserRoleName, IsAdmin, IsAllDept, IsDept, IsManager, IsHeadDept, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtUserRole.Text, cbAdmin.Checked, cbAllDept.Checked, cbDept.Checked, cbManager.Checked, cbHeadDept.Checked, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("UserRole", "Where UserRoleID = '" + Request["id"] + "' ", "UserRoleName, IsAdmin, IsAllDept, IsDept, IsManager, IsHeadDept, Sort, UpdateUser, UpdateDate", txtUserRole.Text, cbAdmin.Checked, cbAllDept.Checked, cbDept.Checked, cbManager.Checked, cbHeadDept.Checked, txtSort.Text, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "2", i);
        }
        ClearAll();
        DataBind();
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ClearAll();
        DataBind();
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Connection Conn = new Connection();
        BTC btc = new BTC();
        DataView dv = Conn.Select(string.Format("Select UserRoleID From Employee Where UserRoleID = '" + id + "' And DelFlag = '0' "));
        if (dv.Table.Rows.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("UserRole", "Where UserRoleID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        }
        ClearAll();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
