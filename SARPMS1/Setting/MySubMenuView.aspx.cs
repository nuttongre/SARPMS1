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
using System.IO;

public partial class MySubMenu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (Request["mode"] == "enable")
        {
            if (!string.IsNullOrEmpty(Request["id"]) && !string.IsNullOrEmpty(Request["enable"]))
                EnableMode(Request["id"], Convert.ToBoolean(Request["enable"]), Request["yearcode"]);

            string url = Request.Url.ToString();
            Response.Redirect(url.Substring(0, url.IndexOf("?")));
        }
        if (!IsPostBack)
        {
            ClearAll();
            getMyProject();
            getMyMainMenu(ddlMyProject.SelectedValue);
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "MySubMenu", " And MyMainMenuID = '" + ddlMyMainMenu.SelectedValue + "'");
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
        txtMySubMenuName.Attributes.Add("onkeyup", "Cktxt();");
        ddlMyProject.Attributes.Add("onchange", "CkMyProject();");
        ddlMyMainMenu.Attributes.Add("onchange", "CkMyMainMenu();");
        txtLinkName.Attributes.Add("onkeyup", "CkLinkName();");
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
    private void getMyMainMenu(string ProjectID)
    {
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select MyMainMenuID, MyMainMenuName From MyMainMenu Where DelFlag = '0' And MyProjectID = '" + ProjectID + "' Order By Sort "));
        if (ddlMyProject.SelectedIndex != 0)
        {
            ddlMyMainMenu.DataSource = dv;
            ddlMyMainMenu.DataTextField = "MyMainMenuName";
            ddlMyMainMenu.DataValueField = "MyMainMenuID";
            ddlMyMainMenu.DataBind();
            ddlMyMainMenu.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlMyMainMenu.SelectedIndex = 0;
            ddlMyMainMenu.Enabled = true;
        }
        else
        {
            ddlMyMainMenu.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlMyMainMenu.SelectedIndex = 0;
            ddlMyMainMenu.Enabled = false;
        }

        if (ddlSearch.SelectedIndex != 0)
        {
            ddlSearch1.DataSource = dv;
            ddlSearch1.DataTextField = "MyMainMenuName";
            ddlSearch1.DataValueField = "MyMainMenuID";
            ddlSearch1.DataBind();
            ddlSearch1.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlSearch1.SelectedIndex = 0;
            ddlSearch1.Enabled = true;
        }
        else
        {
            ddlSearch1.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlSearch1.SelectedIndex = 0;
            ddlSearch1.Enabled = false;
        }          
    }
    public override void DataBind()
    {
        String StrSql = "Select  b.MyMainMenuName, c.MySubMenuID, c.MySubMenuName, c.Status, c.Sort From MyProject a, MyMainMenu b, MySubMenu c Where c.DelFlag = '0' ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And c.MySubMenuName Like '%" + txtSearch.Text + "%'";
        }
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.MyProjectID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearch1.SelectedIndex != 0)
        { 
            StrSql = StrSql + " And b.MyMainMenuID = '" + ddlSearch1.SelectedValue + "' ";
        }
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " And a.MyProjectID = b.MyProjectID And b.MyMainMenuID = c.MyMainMenuID Order By a.Sort, b.Sort, c.Sort"));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        DataView dv1;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select a.MyMainMenuID, a.MyProjectID, b.* From MyMainMenu a, MySubMenu b Where b.DelFlag = '0' And b.MySubMenuID = '" + id + "' And a.MyMainMenuID = b.MyMainMenuID"));

        if (dv.Table.Rows.Count != 0)
        {
            txtMySubMenuName.Text = dv.Table.Rows[0]["MySubMenuName"].ToString();
            txtLinkName.Text = dv.Table.Rows[0]["LinkName"].ToString();
            txtSort.Text = dv.Table.Rows[0]["Sort"].ToString();
            ddlMyProject.SelectedValue = dv.Table.Rows[0]["MyProjectID"].ToString();
            getMyMainMenu(ddlMyProject.SelectedValue);
            ddlMyMainMenu.SelectedValue = dv.Table.Rows[0]["MyMainMenuID"].ToString();
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtMySubMenuName.Text = "";
        txtSort.Text = "";
        ddlMyProject.SelectedIndex = 0;
        ddlMyMainMenu.SelectedIndex = 0;
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
            Int32 i = Conn.AddNew("MySubMenu", "MySubMenuID, MySubMenuName, MyMainMenuID, LinkName, ImgName, Sort, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtMySubMenuName.Text, ddlMyMainMenu.SelectedValue, txtLinkName.Text, "S0.png", txtSort.Text, 0, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);        
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("MySubMenu", "Where MySubMenuID = '" + Request["id"] + "' ", "MySubMenuName, MyMainMenuID, LinkName, Sort, UpdateUser, UpdateDate", txtMySubMenuName.Text, ddlMyMainMenu.SelectedValue, txtLinkName.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
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
        DataView dv = Conn.Select(string.Format("Select MySubMenuID From MenuRole Where MySubMenuID = '" + id + "' "));
        if (dv.Table.Rows.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("MySubMenu", "Where MySubMenuID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        }
        ClearAll();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlMyProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        getMyMainMenu(ddlMyProject.SelectedValue);  
    }
    protected void ddlMyMainMenu_SelectedIndexChanged(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.GenSort(txtSort, "MySubMenu", " And MyMainMenuID = '" + ddlMyMainMenu.SelectedValue + "'");
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getMyMainMenu(ddlSearch.SelectedValue);
        DataBind();
    }
    protected void EnableMode(string id, bool status, string yearcode)
    {
        {
            Connection Conn = new Connection();
            int result = Conn.Update("MySubMenu", "WHERE MySubMenuID='" + id + "' And DelFlag = '0' ", "Status", (status ? 0 : 1));
        }
    }
}
