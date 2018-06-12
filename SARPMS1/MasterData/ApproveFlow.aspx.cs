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

public partial class ApproveFlow : System.Web.UI.Page
{
    Connection Conn = new Connection();
    BTC btc = new BTC();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }

            ClearAll();
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
                        btc.GenSort(txtSort, "ApproveFlow", "");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
        txtApproveFlow.Attributes.Add("onkeyup", "Cktxt(0);");
        txtCk.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    public override void DataBind()
    {
        string StrSql = "Select * From ApproveFlow Where DelFlag = 0 ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And ApproveFlowName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By Sort "));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select AF.*, MD.MainDeptCode From ApproveFlow AF Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
            Inner Join MainDepartment MD On MD.MainDeptCode = MSD.MainDeptCode
            Where AF.ApproveFlowID = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            txtApproveFlow.Text = dv[0]["ApproveFlowName"].ToString();
            ddlMainDept.SelectedValue = dv[0]["MainDeptCode"].ToString();
            btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
            ddlMainSubDept.SelectedValue = dv[0]["MainSubDeptCode"].ToString();
            txtCk.Text = dv[0]["ckType"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
    }
    private void ClearAll()
    {
        txtApproveFlow.Text = "";
        ddlMainSubDept.SelectedIndex = 0;
        ddlMainDept.SelectedIndex = 0;
        txtCk.Text = "";
        txtSort.Text = "";
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save()
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("ApproveFlow", "ApproveFlowID, ApproveFlowName, ckType, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtApproveFlow.Text, txtCk.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ApproveFlow.aspx?ckmode=1&Cr=" + i);
        }

        if (Request["mode"] == "2")
        {
            i = Conn.Update("ApproveFlow", "Where ApproveFlowID = '" + Request["id"] + "' ", "ApproveFlowName, ckType, Sort, UpdateUser, UpdateDate", 
                txtApproveFlow.Text, txtCk.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ApproveFlow.aspx?ckmode=2&Cr=" + i);
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save();
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        //DataView dv = Conn.Select(string.Format("Select ApproveFlowID From Indicators Where ApproveFlowID = '" + id + "' And DelFlag = '0' "));
        //if (dv.Count > 0)
        //{
        //    Response.Redirect("ApproveFlow.aspx?ckmode=3&Cr=0");
        //}
        //else
        //{
            Int32 i = Conn.Update("ApproveFlow", "Where ApproveFlowID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ApproveFlow.aspx?ckmode=3&Cr=" + i);
        //}
    }
    protected void ddlMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
    }
}
