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

public partial class EntryCosts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            getddlOperations();
            ClearAll();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btc.GenSort(txtSort, "EntryCosts", " And OperationsCode = '" + ddlOperations.SelectedValue + "'");
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
        ddlOperations.Attributes.Add("onchange", "Ckddl();");
        txtEntryCosts.Attributes.Add("onchange", "Cktxt();");
        txtSort.Attributes.Add("onchange", "CkSort();");
    }
    private void getddlOperations()
    {
        DataView dv;
        dv = new BTC().getddlOperations();
        ddlOperations.DataSource = dv;
        ddlOperations.DataTextField = "OperationsName";
        ddlOperations.DataValueField = "OperationsCode";
        ddlOperations.DataBind();
        ddlOperations.Items.Insert(0, new ListItem("-เลือก-", ""));

        ddlSearch.DataSource = dv;
        ddlSearch.DataTextField = "OperationsName";
        ddlSearch.DataValueField = "OperationsCode";
        ddlSearch.DataBind();
        ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
    }
    public override void DataBind()
    {
        string StrSql = "Select a.OperationsName, b.EntryCostsCode, b.EntryCostsName EntryCostsName, BudgetType = Case b.BudgetType When 0 Then 'งบดำเนินงาน' When 1 Then 'งบบุคคลากร' When 2 Then 'งบลงทุน' End From Operations a, EntryCosts b Where b.DelFlag = '0' And a.OperationsCode = b.OperationsCode ";
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.OperationsCode = '" + ddlSearch.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.EntryCostsName Like '%" + txtSearch.Text + "%'";
        }
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort " ));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select a.OperationsCode, b.EntryCostsCode, b.EntryCostsName, b.BudgetType, b.Sort From Operations a, EntryCosts b Where a.OperationsCode = b.OperationsCode And b.EntryCostsCode = '" + id + "' "));

        if (dv.Table.Rows.Count != 0)
        {
            ddlOperations.SelectedValue = dv.Table.Rows[0]["OperationsCode"].ToString();
            txtEntryCosts.Text = dv.Table.Rows[0]["EntryCostsName"].ToString();
            txtSort.Text = dv.Table.Rows[0]["Sort"].ToString();

            switch (Convert.ToInt32(dv.Table.Rows[0]["BudgetType"]))
            {
                case 0:
                    rbtStatement.Checked = true;
                    break;
                case 1:
                    rbtPersonnel.Checked = true;
                    break;
                case 2:
                    rbtFinance.Checked = true;
                    break;
            }
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        txtEntryCosts.Text = "";
        txtSearch.Text = "";
        txtSort.Text = "";
        ddlOperations.SelectedIndex = 0;
        ddlSearch.SelectedIndex = 0;
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    private int CkRbt()
    {
        int ckrbt = 0;
        if (rbtStatement.Checked)
        {
            ckrbt = 0;
        }
        if (rbtPersonnel.Checked)
        {
            ckrbt = 1;
        }
        if (rbtFinance.Checked)
        {
            ckrbt = 2;
        }
        return ckrbt;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
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
            Int32 i = Conn.AddNew("EntryCosts", "EntryCostsCode, EntryCostsName, OperationsCode, BudgetType, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtEntryCosts.Text, ddlOperations.SelectedValue, CkRbt(), txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = Conn.Update("EntryCosts", "Where EntryCostsCode = '" + Request["id"] + "' ", "EntryCostsName, OperationsCode, BudgetType, Sort, UpdateUser, UpdateDate", txtEntryCosts.Text, ddlOperations.SelectedValue, CkRbt(), txtSort.Text, CurrentUser.ID, DateTime.Now);
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
        DataView dv = Conn.Select(string.Format("Select EntryCostsCode From DevelopLevel Where EntryCostsCode = '" + id + "' And DelFlag = '0' "));
        if (dv.Table.Rows.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = Conn.Update("EntryCosts", "Where EntryCostsCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        }  
        ClearAll();
    }
    protected void ddlOperations_OnSelectedChanged(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        btc.GenSort(txtSort, "EntryCosts", " And OperationsCode = '" + ddlOperations.SelectedValue + "'");
    }
}
