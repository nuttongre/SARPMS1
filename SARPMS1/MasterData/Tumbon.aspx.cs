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

public partial class Tumbon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            getddlProvince();
            getddlAmphur(ddlSearch.SelectedValue);
            ClearAll();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "Tumbon", " And AmphurID = '" + ddlAmphur.SelectedValue + "' ");
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
        ddlAmphur.Attributes.Add("onchange", "CkAmphur();");
        txtTumbon.Attributes.Add("onchange", "Cktxt();");
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
    private void getddlAmphur(string id)
    {
        DataView dv = new BTC().getddlAmphur(id);
        if (dv.Count != 0)
        {                              
            ddlAmphur.DataSource = dv;
            ddlAmphur.DataTextField = "AmphurName";
            ddlAmphur.DataValueField = "AmphurID";
            ddlAmphur.DataBind();
            ddlAmphur.Items.Insert(0, new ListItem("-เลือก-", "0"));
            ddlAmphur.SelectedIndex = 0;
            ddlAmphur.Enabled = true;

            ddlSearch1.DataSource = dv;
            ddlSearch1.DataTextField = "AmphurName";
            ddlSearch1.DataValueField = "AmphurID";
            ddlSearch1.DataBind();
            ddlSearch1.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch1.SelectedIndex = 0;
            ddlSearch1.Enabled = true;
        }
        else
        {
            ddlAmphur.Items.Insert(0, new ListItem("-เลือก-", "0"));
            ddlAmphur.SelectedIndex = 0;
            ddlAmphur.Enabled = false;

            ddlSearch1.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch1.SelectedIndex = 0;
            ddlSearch1.Enabled = false;
        }        
    }
    public override void DataBind()
    {
        string strSql = " Select a.ProvinceName, b.AmphurName, c.TumbonID, c.TumbonName, c.Sort "
                    + " From Province a, Amphur b, Tumbon c Where a.ProvinceID = b.ProvinceID And b.AmphurID = c.AmphurID And c.DelFlag = 0 ";
        if (ddlSearch.SelectedIndex != 0)
        {
            strSql = strSql + " And a.ProvinceID = '" + ddlSearch.SelectedValue + "'";
        }
        if (ddlSearch1.SelectedIndex != 0)
        {
            strSql = strSql + " And b.AmphurID = '" + ddlSearch1.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            strSql = strSql + " And c.TumbonName Like '%" + txtSearch.Text + "%'";
        }
        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(strSql + " Order By a.Sort Desc, b.Sort Desc, c.Sort Desc"));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString("#,##0");
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Connection Conn = new Connection();
        string strSql = " Select a.ProvinceID, b.AmphurID, c.TumbonID, c.TumbonName, c.Sort "
                    + " From Province a, Amphur b, Tumbon c "
                    + " Where a.ProvinceID = b.ProvinceID And b.AmphurID = c.AmphurID And c.TumbonID = '" + id + "' ";
        DataView dv = Conn.Select(string.Format(strSql));

        if (dv.Count != 0)
        {
            ddlProvince.SelectedValue = dv[0]["ProvinceID"].ToString();
            getddlAmphur(ddlProvince.SelectedValue);
            ddlAmphur.SelectedValue = dv[0]["AmphurID"].ToString();
            txtTumbon.Text = dv[0]["TumbonName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtTumbon.Text = "";
        txtSearch.Text = "";
        ddlProvince.SelectedIndex = 0;
        ddlAmphur.SelectedIndex = 0;
        ddlSearch.SelectedIndex = 0;
        ddlSearch1.SelectedIndex = 0;
        txtSort.Text = "";
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlAmphur(ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlAmphur(ddlProvince.SelectedValue);
    }
    protected void ddlAmphur_SelectedIndexChanged(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.GenSort(txtSort, "Tumbon", " And AmphurID = '" + ddlAmphur.SelectedValue + "' ");
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
            Int32 i = Conn.AddNew("Tumbon", "TumbonID, TumbonName, AmphurID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtTumbon.Text, ddlAmphur.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("Tumbon", "Where TumbonID = '" + Request["id"] + "' ", "TumbonName, AmphurID, Sort, UpdateUser, UpdateDate", txtTumbon.Text, ddlAmphur.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
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

        //DataView dv = Conn.Select(string.Format("Select DevelopCode From Three_Projects Where DevelopCode = '" + id + "' And DelFlag = '0' "));
        //if (dv.Table.Rows.Count > 0)
        //{
        //    Msg_Head(true, "3", 0);
        //}
        //else
        //{
            Int32 i = Conn.Update("Tumbon", "Where TumbonID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        //} 
        ClearAll();
    }
}
