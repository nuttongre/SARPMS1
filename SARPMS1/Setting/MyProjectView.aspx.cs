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

public partial class MyProject : System.Web.UI.Page
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
                        btc.GenSort(txtSort, "MyProject", "");
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
        txtMyProjectName.Attributes.Add("onkeyup", "Cktxt();");
        txtStartPage.Attributes.Add("onkeyup", "CkStartPage();");
        txtSort.Attributes.Add("onkeyup", "CkSort();");
    }
    public override void DataBind()
    {
        String StrSql = "Select * From MyProject Where DelFlag = 0 ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And MyProjectName Like '%" + txtSearch.Text + "%'";
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
        dv = Conn.Select(string.Format("Select * From MyProject Where DelFlag = 0 And MyProjectID = '" + id + "' "));

        if (dv.Table.Rows.Count != 0)
        {
            txtMyProjectName.Text = dv.Table.Rows[0]["MyProjectName"].ToString();
            txtStartPage.Text = dv.Table.Rows[0]["StartPage"].ToString();
            txtSort.Text = dv.Table.Rows[0]["Sort"].ToString();
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtMyProjectName.Text = "";
        txtStartPage.Text = "";
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
            Int32 i = Conn.AddNew("MyProject", "MyProjectID, MyProjectName, StartPage, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtMyProjectName.Text, txtStartPage.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("MyProject", "Where MyProjectID = '" + Request["id"] + "' ", "MyProjectName, StartPage, Sort, UpdateUser, UpdateDate", txtMyProjectName.Text, txtStartPage.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
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
        DataView dv = Conn.Select(string.Format("Select MyProjectID From MyMainMenu Where MyProjectID = '" + id + "' And DelFlag = '0' "));
        if (dv.Table.Rows.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("MyProject", "Where MyProjectID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        }
        ClearAll();
    }
}
