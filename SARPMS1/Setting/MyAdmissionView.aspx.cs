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

public partial class MyAdmission : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            ClearAll();
            getMyProject();
            getMyMainMenu(ddlMyProject.SelectedValue);
            getMySubMenu(ddlMyMainMenu.SelectedValue);
            getUserRole();
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btnDelete.Visible = false;
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt();", true);
                        break;
                    case "2":
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        btnDelete.Visible = false;
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
        ddlMyProject.Attributes.Add("onchange", "Cktxt();");
        ddlMyMainMenu.Attributes.Add("onchange", "CkMyMainMenu();");
        ddlMySubMenu.Attributes.Add("onchange", "CkMySubMenu();");
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
    private void getMyMainMenu(string MyProjectID)
    {
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select MyMainMenuID, MyMainMenuName From MyMainMenu Where DelFlag = '0' And MyProjectID = '" + MyProjectID + "' Order By Sort "));
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
            ddlMySubMenu.SelectedIndex = 0;
            ddlMySubMenu.Enabled = false;
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
    private void getMySubMenu(string MyMainMenuID)
    {
        DataView dv;
        Connection Conn = new Connection();
        string strSql = "";
        if (string.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1" || Request["mode"] == "3")
        {
            strSql = "Select MySubMenuID, MySubMenuName From MySubMenu Where DelFlag = '0' And MyMainMenuID = '" + MyMainMenuID + "' And MySubMenuID Not In (Select MySubMenuID From MenuRole) Order By Sort";
        }
        if (Request["mode"] == "2")
        {
            strSql = "Select MySubMenuID, MySubMenuName From MySubMenu Where DelFlag = '0' And MyMainMenuID = '" + MyMainMenuID + "' Order By Sort";
        }
        dv = Conn.Select(string.Format(strSql));
        //And MySubMenuID Not In (Select MySubMenuID From MenuRole)

        if (ddlMyMainMenu.SelectedIndex != 0)
        {
            ddlMySubMenu.DataSource = dv;
            ddlMySubMenu.DataTextField = "MySubMenuName";
            ddlMySubMenu.DataValueField = "MySubMenuID";
            ddlMySubMenu.DataBind();
            ddlMySubMenu.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlMySubMenu.SelectedIndex = 0;
            ddlMySubMenu.Enabled = true;
        }
        else
        {
            ddlMySubMenu.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlMySubMenu.SelectedIndex = 0;
            ddlMySubMenu.Enabled = false;
        }          
    }
    private void getUserRole()
    {
        Connection Conn = new Connection();
        cblUserRole.DataSource = Conn.Select(string.Format("Select * From UserRole Where DelFlag = '0' Order By RoleLevel"));
        cblUserRole.DataTextField = "UserRoleName";
        cblUserRole.DataValueField = "UserRoleID";
        cblUserRole.DataBind();
    }
    public override void DataBind()
    {
        String StrSql = " Select d.MyProjectName, b.MySubMenuID, b.MySubMenuName, b.CreateDate, d.Sort, c.Sort, b.Sort From MenuRole a, MySubMenu b, MyMainMenu c, MyProject d "
                        + " Where a.MySubMenuID = b.MySubMenuID And d.MyProjectID = c.MyProjectID And c.MyMainMenuID = b.MyMainMenuID "
                        + " And b.DelFlag = '0'  ";
        //String StrSql = " Select a.MySubMenuName, b.*, c.UserRoleName From MySubMenu a, MenuRole b, UserRole c Where a.DelFlag = '0' ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.MySubMenuName Like '%" + txtSearch.Text + "%'";
        }
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And d.MyProjectID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearch1.SelectedIndex != 0)
        {
            StrSql = StrSql + " And c.MyMainMenuID = '" + ddlSearch1.SelectedValue + "' ";
        }
        DataView dv;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " Group By d.MyProjectName, b.MySubMenuID, MySubMenuName, b.CreateDate, d.Sort, c.Sort, b.Sort Order By d.Sort, c.Sort, b.Sort "));
        //dv = new ConnectDatabase().Read(string.Format(StrSql + " And a.MySubMenuID = b.MySubMenuID And b.UserRoleID = c.UserRoleID Order By a.MySubMenuSort "));

        DataTable dt = new DataTable();
        dt.Columns.Add("MyProjectName", typeof(string));
        dt.Columns.Add("MySubMenuID", typeof(string));
        dt.Columns.Add("MySubMenuName", typeof(string));
        dt.Columns.Add("MyUserRoleName", typeof(string));

        foreach (DataRowView dr in dv)
        {
            dt.Rows.Add(dr["MyProjectName"], dr["MySubMenuID"], dr["MySubMenuName"], "");
        }

        for (int i = 0; i <= dv.Count - 1; i++)
        {
            string UserRoleName = "";

            string sql1 = "Select a.*, b.UserRoleName FROM MenuRole a, UserRole b Where MySubMenuID = '" + dv[i]["MySubMenuID"].ToString() + "' And a.UserRoleID = b.UserRoleID ";
            DataView dv2 = Conn.Select(string.Format(sql1));

            for(int j = 0; j <= dv2.Count - 1; j++)
            {   
                string Ck = "";
                if(j == dv2.Count - 1)
                {
                 Ck = "";
                }
                else
                {
                 Ck = ", ";
                }
                UserRoleName = UserRoleName + dv2[j]["UserRoleName"].ToString() + Ck ;
            }
            dt.Rows[i]["MyUserRoleName"] = UserRoleName;
        }

        //for (Int32 i = 0; i <= dv.Count - 1; i++)
        //{
        //    string ckID = "";
         
        //    dr = dt.NewRow();
        //    dr["MySubMenuID"] = dv.Table.Rows[i]["MySubMenuID"];

        //    DataView dv2;
        //    dv.Table.Select("");
        //    dr["MySubMenuName"] = dv.Table.Rows[i]["MySubMenuName"];
        //    if (ckID == dv.Table.Rows[i]["MySubMenuID"].ToString())
        //    {
        //        string CkName = CkName + dv.Table.Rows[i]["MyUserRoleName"].ToString();
        //        dr["MyUserRoleName"] = CkName;
        //    }
        //    dt.Rows.Add(dr);
        //}

        GridView1.DataSource = dt;
        lblSearchTotal.InnerText = dt.Rows.Count.ToString();
        GridView1.CheckListDataField = "MySubMenuID";
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv;
        DataView dv1;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format("Select a.MyProjectID, a.MyMainMenuID, b.* From MyMainMenu a, MySubMenu b Where b.DelFlag = 0 And b.MySubMenuID = '" + id + "' And a.MyMainMenuID = b.MyMainMenuID"));
        dv1 = Conn.Select(string.Format("Select b.UserRoleID From MySubMenu a, MenuRole b Where a.MySubMenuID = b.MySubMenuID And a.DelFlag = 0 And a.MySubMenuID = '" + id + "' "));

        if (dv.Count != 0)
        {
            ddlMyProject.SelectedValue = dv[0]["MyProjectID"].ToString();
            getMyMainMenu(ddlMyProject.SelectedValue);
            ddlMyMainMenu.SelectedValue = dv[0]["MyMainMenuID"].ToString();
            getMySubMenu(ddlMyMainMenu.SelectedValue);
            ddlMySubMenu.SelectedValue = dv[0]["MySubMenuID"].ToString();
        }
        if (dv1.Count != 0)
        {
            for (int i = 0; i <= cblUserRole.Items.Count - 1; i++)
            {
                for (int j = 0; j <= dv1.Count - 1; j++)
                {
                    if (cblUserRole.Items[i].Value == dv1[j]["UserRoleID"].ToString())
                    {
                        cblUserRole.Items[i].Selected = true;
                        break;
                    }
                }
            }
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        ddlMyProject.SelectedIndex = 0;
        ddlMyMainMenu.SelectedIndex = 0;
        ddlMySubMenu.SelectedIndex = 0;
        txtSearch.Text = "";
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    private Boolean CkUserRole()
    {
        for (Int32 i = 0; i < cblUserRole.Items.Count; i++)
        {
            if (cblUserRole.Items[i].Selected == true)
            {
                lblErrorUserRole.Visible = false;
                return true;
            }
        }
        lblErrorUserRole.Visible = true;
        return false;
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
        if (!CkUserRole())
        {
            return;
        }
        Connection Conn = new Connection();
        BTC btc = new BTC();
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            Int32 i = 0;
            for (int j = 0; j <= cblUserRole.Items.Count - 1; j++)
            {
                if (cblUserRole.Items[j].Selected)
                {
                   i = Conn.AddNew("MenuRole", "MySubMenuID, UserRoleID", ddlMySubMenu.SelectedValue, cblUserRole.Items[j].Value);
                }
            }         
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        if (Request["mode"] == "2")
        {
            Int32 i = 0;
            DataView dv1 = Conn.Select(string.Format("Select MySubMenuID From MenuRole Where MySubMenuID = '" + Request["id"] + "' "));
            if (dv1.Count > 0)
            {
                Conn.Delete("MenuRole", "Where MySubMenuID = '" + Request["id"] + "' ");
            }
            
            for (int j = 0; j <= cblUserRole.Items.Count - 1; j++)
            {
                if (cblUserRole.Items[j].Selected)
                {
                   i = Conn.AddNew("MenuRole", "MySubMenuID, UserRoleID", Request["id"], cblUserRole.Items[j].Value);
                }
            }
            btc.Msg_Head(Img1, MsgHead, true, "2", i);
        }
        ClearAll();
        DataBind();
        if (GridView1.Rows.Count != 0)
        {
            btnDelete.Visible = true;
        }
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ClearAll();
        DataBind();
        if (GridView1.Rows.Count != 0)
        {
            btnDelete.Visible = true;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (GridView1.SelectedItems.Length == 0) return;
        string query = "DELETE MenuRole WHERE MySubMenuID IN('";
        query += String.Join("', '", GridView1.SelectedItems);
        query += "')";
        Connection Conn = new Connection();
        BTC btc = new BTC();
        try
        {
            Conn.Execute(query);
            //Response.Redirect(Request.RawUrl);
            btc.Msg_Head(Img1, MsgHead, true, "3", 1);
            DataBind();
        }
        catch (Exception ex)
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
            DataBind();
            //lblMessage.Text = "<img src=\"../Shared/images/no.png\" alt=\"เกิดข้อผิดพลาด\" />เกิดข้อผิดพลาดระหว่างดำเนินการ " + ex.Message;
        }
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Connection Conn = new Connection();
        BTC btc = new BTC();
        //DataView dv = Conn.Select(string.Format("Select BudgetID From Employee Where BudgetID = " + id));
        //if (dv.Table.Rows.Count > 0)
        //{
        //    Msg_Head(true, "3", 0);
        //}
        //else
        //{
        Int32 i = Conn.Delete("MenuRole", "Where MySubMenuID = '" + id + "' ");
            btc.Msg_Head(Img1, MsgHead, true, "3", i);
        //}
        ClearAll();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void cbCkAll_CheckedChanged(object sender, EventArgs e)
    {
        if (cbCkAll.Checked == true)
        {
            for (int i = 0; i <= cblUserRole.Items.Count - 1; i++)
            {
                cblUserRole.Items[i].Selected = true;
            }
        }
        if (cbCkAll.Checked == false)
        {
            for (int i = 0; i <= cblUserRole.Items.Count - 1; i++)
            {
                cblUserRole.Items[i].Selected = false;
            }
        }
    }
    protected void ddlMyProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        getMyMainMenu(ddlMyProject.SelectedValue);
    }
    protected void ddlMyMainMenu_SelectedIndexChanged(object sender, EventArgs e)
    {  
        getMySubMenu(ddlMyMainMenu.SelectedValue);
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getMyMainMenu(ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
