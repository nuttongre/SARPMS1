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

public partial class SubDepartment : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }
            btc.CkAdmission(GridView1, btAdd, null);
            getddlDepartment(0);
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlDepartment(1);
                        btc.GenSort(txtSort, "SubDepartment", " And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlDepartment(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                }
            }
            DataBind();
        }
        txtSubDeptName.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlDepartment.Attributes.Add("onchange", "CkDepartment(0);");
        txtSort.Attributes.Add("onkeyup", "CkSort(0);");
    }
    private void getddlDepartment(int mode)
    {
        DataView dv = btc.getddlDepartment();
        if (mode == 0)
        {
            ddlSearch.DataSource = dv;
            ddlSearch.DataTextField = "DeptName";
            ddlSearch.DataValueField = "DeptCode";
            ddlSearch.DataBind();
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            ddlSearch.SelectedIndex = 0;
        }

        if (mode == 1)
        {
            ddlDepartment.DataSource = dv;
            ddlDepartment.DataTextField = "DeptName";
            ddlDepartment.DataValueField = "DeptCode";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlDepartment.SelectedIndex = 0;
        }
    }
    public override void DataBind()
    {
        String StrSql = "Select a.DeptName, b.* From Department a, SubDepartment b Where b.DelFlag = 0 ";
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.SubDeptName Like '%" + txtSearch.Text + "%'";
        }
        if (ddlSearch.SelectedIndex != 0)
        { 
            StrSql = StrSql + " And a.DeptCode = '" + ddlSearch.SelectedValue + "' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " And a.DeptCode = b.DeptCode Order By a.Sort, b.Sort"));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From SubDepartment Where DelFlag = '0' And SubDeptCode = '" + id + "' "));

        if (dv.Count != 0)
        {
            txtSubDeptName.Text = dv[0]["SubDeptName"].ToString();
            ddlDepartment.SelectedValue = dv[0]["DeptCode"].ToString();
            txtSort.Text = dv.Table.Rows[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "SubDepartment", "SubDeptCode", id);
        }
    }
    private void ClearAll()
    {
        txtSubDeptName.Text = "";
        txtSort.Text = "";
        //ddlDepartment.SelectedIndex = 0;
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("SubDepartment", "SubDeptCode, SubDeptName, DeptCode, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtSubDeptName.Text, ddlDepartment.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            if (CkAgain == "N")
            {
                Response.Redirect("SubDepartment.aspx?ckmode=1&Cr=" + i);
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "SubDepartment", " And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("SubDepartment", "Where SubDeptCode = '" + Request["id"] + "' ", "SubDeptName, DeptCode, Sort, UpdateUser, UpdateDate", txtSubDeptName.Text, ddlDepartment.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SubDepartment.aspx?ckmode=2&Cr=" + i);
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save("N");
    }
    protected void btSaveAgain_Click(object sender, EventArgs e)
    {
        bt_Save("Y");
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        if (btc.CkUseData(id, "SubDeptCode", "dtAcSubDept", ""))
        {
            Response.Redirect("SubDepartment.aspx?ckmode=3&Cr=0");
        }
        else
        {
            Int32 i = Conn.Update("SubDepartment", "Where SubDeptCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SubDepartment.aspx?ckmode=3&Cr=" + i);
        }
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "SubDepartment", " And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
    }
}
