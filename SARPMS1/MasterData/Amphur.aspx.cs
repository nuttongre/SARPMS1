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

public partial class Amphur : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            getddlProvince();
            ClearAll();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "Amphur", " And ProvinceID = '" + ddlProvince.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Ckddl();", true);
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
        ddlProvince.Attributes.Add("onchange", "Ckddl();");
        txtAmphur.Attributes.Add("onchange", "Cktxt();");
        txtSort.Attributes.Add("onchange", "CkSort();");
    }

    private void getddlProvince()
    {
        DataView dv = new BTC().getddlProvince();
        ddlProvince.DataSource = dv;
        ddlProvince.DataTextField = "ProvinceName";
        ddlProvince.DataValueField = "ProvinceID";
        ddlProvince.DataBind();
        ddlProvince.Items.Insert(0, new ListItem("-เลือก-", ""));

        ddlSearch.DataSource = dv;
        ddlSearch.DataTextField = "ProvinceName";
        ddlSearch.DataValueField = "ProvinceID";
        ddlSearch.DataBind();
        ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
    }
    public override void DataBind()
    {
        string StrSql = "Select a.ProvinceName, b.AmphurID, b.AmphurName, b.Sort From Province a, Amphur b Where a.ProvinceID = b.ProvinceID And b.DelFlag = '0' ";
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ProvinceID = '" + ddlSearch.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.AmphurName Like '%" + txtSearch.Text + "%'";
        }
        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort Desc, b.Sort Desc"));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString("#,##0");
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format("Select a.ProvinceID, b.AmphurID, b.AmphurName, b.Sort From Province a, Amphur b Where a.ProvinceID = b.ProvinceID And b.AmphurID = '" + id + "' "));

        if (dv.Count != 0)
        {
            ddlProvince.SelectedValue = dv[0]["ProvinceID"].ToString();
            txtAmphur.Text = dv[0]["AmphurName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtAmphur.Text = "";
        txtSearch.Text = "";
        ddlProvince.SelectedIndex = 0;
        ddlSearch.SelectedIndex = 0;
        txtSort.Text = "";
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlProvince_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.GenSort(txtSort, "Amphur", " And ProvinceID = '" + ddlProvince.SelectedValue + "' ");
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
            Int32 i = Conn.AddNew("Amphur", "AmphurID, AmphurName, ProvinceID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtAmphur.Text, ddlProvince.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("Amphur", "Where AmphurID = '" + Request["id"] + "' ", "AmphurName, ProvinceID, Sort, UpdateUser, UpdateDate", txtAmphur.Text, ddlProvince.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
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
        BTC btc = new BTC();
        if (String.IsNullOrEmpty(id)) return;
        Connection Conn = new Connection();

        DataView dv = Conn.Select(string.Format("Select AmphurID From Tumbon Where AmphurID = '" + id + "' And DelFlag = 0 "));
        if (dv.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("Amphur", "Where AmphurID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        } 
        ClearAll();
    }
}
