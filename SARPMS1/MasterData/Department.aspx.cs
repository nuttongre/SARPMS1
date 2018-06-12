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

public partial class Department : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
                        btc.GenSort(txtSort, "Department", " And MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        btc.btEnable(btSaveAgain, false);
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        break;
                }
            }
            else
            {
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("MainDept"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("MainSubDept"));
                DataBind();
            }
        }
        ddlMainDept.Attributes.Add("onchange", "Cktxt(0);");
        ddlMainSubDept.Attributes.Add("onchange", "Cktxt(0);");
        txtDepartment.Attributes.Add("onkeyup", "Cktxt(0);");
        txtDeptShortName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    public override void DataBind()
    {
        string strSql = @" Select D.DeptCode, D.DeptName, MD.MainDeptName, MSD.MainSubDeptName, MD.Sort As MainSort, MSD.Sort As MainSubSort, D.Sort, D.DeptShortName
        From Department D Inner Join MainSubDepartment MSD On D.MainSubDeptCode = Msd.MainSubDeptCode
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
        Where D.DelFlag = 0 ";

        if (string.IsNullOrEmpty(Request.QueryString["mode"]))
        {
            if (ddlSearchMainDept.SelectedIndex != 0)
            {
                strSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
            }
            if (ddlSearchMainSubDept.SelectedIndex != 0)
            {
                strSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
            }
            if (txtSearch.Text != "")
            {
                strSql += " And D.DeptName Like '%" + txtSearch.Text + "%' Or D.Sort Like '%" + txtSearch.Text + "%'  ";
            }
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By MD.Sort, MSD.Sort, D.Sort "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select D.*, MD.MainDeptCode From Department D 
        Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
        Where D.DeptCode = '{0}' "; 
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlMainDept.SelectedValue = dv[0]["MainDeptCode"].ToString();
            btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
            ddlMainSubDept.SelectedValue = dv[0]["MainSubDeptCode"].ToString();
            txtDepartment.Text = dv[0]["DeptName"].ToString();
            txtDeptShortName.Text = dv[0]["DeptShortName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Department", "DeptCode", id);
        }
    }
    private void ClearAll()
    {
        //ddlMainDept.SelectedIndex = 0;
        ddlMainSubDept.SelectedIndex = 0;
        txtDepartment.Text = "";
        txtDeptShortName.Text = "";
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Department", "DeptCode, DeptName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, MainSubDeptCode, DeptShortName", 
                NewID, txtDepartment.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, ddlMainSubDept.SelectedValue, txtDeptShortName.Text);

            if (CkAgain == "N")
            {
                Response.Redirect("Department.aspx?ckmode=1&Cr=" + i);
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Department", " And MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
            i = Conn.Update("Department", "Where DeptCode = '" + Request.QueryString["id"] + "' ", "DeptName, Sort, UpdateUser, UpdateDate, MainSubDeptCode, DeptShortName", 
                txtDepartment.Text, txtSort.Text, CurrentUser.ID, DateTime.Now, ddlMainSubDept.SelectedValue, txtDeptShortName.Text);
            Response.Redirect("Department.aspx?ckmode=2&Cr=" + i);
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
        if (btc.CkUseData(id, "DeptCode", "EmpDept", ""))
        {
            Response.Redirect("Department.aspx?ckmode=3&Cr=0");
        }
        else
        {
            Int32 i = Conn.Update("Department", "Where DeptCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Department.aspx?ckmode=3&Cr=" + i);
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Department", " And MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ");
    }
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("MainDept", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("MainSubDept"));
        DataBind();
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("MainSubDept", ddlSearchMainSubDept.SelectedValue);
        DataBind();
    }
    protected void ddlMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
        btc.GenSort(txtSort, "Department", " And MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ");
    }
    protected void ddlMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Department", " And MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ");
    }
}
