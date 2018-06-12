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

public partial class MyMainMenu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            ClearAll();
            getMyProject();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "MyMainMenu", " And MyProjectID = '" + ddlMyProject.SelectedValue + "' ");
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
        txtMyMainMenuName.Attributes.Add("onkeyup", "Cktxt();");
        ddlMyProject.Attributes.Add("onchange", "CkMyProject();");
        txtSort.Attributes.Add("onkeyup", "CkSort();");
    }
    private void getMyProject()
    {
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select MyProjectID, MyProjectName From MyProject Where DelFlag = '0' Order By Sort "));
        
        ddlMyProject.DataSource = dv;
        ddlMyProject.DataTextField = "MyProjectName";
        ddlMyProject.DataValueField = "MyProjectID";
        ddlMyProject.DataBind();
        ddlMyProject.Items.Insert(0, new ListItem("-เลือก-", ""));
        ddlMyProject.SelectedIndex = 0;

        ddlSearch.DataSource = dv;
        ddlSearch.DataTextField = "MyProjectName";
        ddlSearch.DataValueField = "MyProjectID";
        ddlSearch.DataBind();
        ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlSearch.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        String StrSql = "Select a.MyProjectName, b.* From MyProject a, MyMainMenu b Where b.DelFlag = '0' ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.MyMainMenuName Like '%" + txtSearch.Text + "%'";
        }
        if (ddlSearch.SelectedIndex != 0)
        { 
            StrSql = StrSql + " And a.MyProjectID = '" + ddlSearch.SelectedValue + "' ";
        }
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " And a.MyProjectID = b.MyProjectID Order By a.Sort, b.Sort"));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select * From MyMainMenu Where DelFlag = '0' And MyMainMenuID = '" + id + "' "));

        if (dv.Table.Rows.Count != 0)
        {
            txtMyMainMenuName.Text = dv.Table.Rows[0]["MyMainMenuName"].ToString();
            ddlMyProject.SelectedValue = dv.Table.Rows[0]["MyProjectID"].ToString();
            txtSort.Text = dv.Table.Rows[0]["Sort"].ToString();
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtMyMainMenuName.Text = "";
        txtSort.Text = "";
        ddlMyProject.SelectedIndex = 0;
        txtSearch.Text = "";
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
        Connection Conn = new Connection();
        BTC btc = new BTC();
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {            
            string NewID = Guid.NewGuid().ToString();
            Int32 i = Conn.AddNew("MyMainMenu", "MyMainMenuID, MyMainMenuName, MyProjectID, ImgName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtMyMainMenuName.Text, ddlMyProject.SelectedValue, "M3.png", txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("MyMainMenu", "Where MyMainMenuID = '" + Request["id"] + "' ", "MyMainMenuName, MyProjectID, Sort, UpdateUser, UpdateDate", txtMyMainMenuName.Text, ddlMyProject.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
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
        DataView dv = Conn.Select(string.Format("Select MyMainMenuID From MySubMenu Where MyMainMenuID = '" + id + "' And DelFlag = '0' "));
        if (dv.Table.Rows.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("MyMainMenu", "Where MyMainMenuID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        }
        ClearAll();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    } 
    protected void ddlMyProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.GenSort(txtSort, "MyMainMenu", " And MyProjectID = '" + ddlMyProject.SelectedValue + "' ");
    }
}
