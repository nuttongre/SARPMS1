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

public partial class Expenses : System.Web.UI.Page
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
            getddlYear(0);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
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
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string StrSql = " Select *, (Subsidies + Revenue + Free + Other) As TotalAmount From Expenses "
                    + " Where DelFlag = 0 And StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And ( Subsidies Like '%" + txtSearch.Text + "%' Or Revenue Like '%" + txtSearch.Text + "%' Or Free Like '%" + txtSearch.Text + "%' Or Other Like '%" + txtSearch.Text + "%' )  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By StudyYear Asc "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From Expenses Where ExpensesCode = '" + id + "'"));
        if (dv.Count != 0)
        {
            lblExpensesCode.Text = dv[0]["ExpensesCode"].ToString();
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlYearB.Enabled = false;
            txtSubsidies.Text = Convert.ToDecimal(dv[0]["Subsidies"]).ToString("#,##0");
            txtRevenue.Text = Convert.ToDecimal(dv[0]["Revenue"]).ToString("#,##0");
            txtFree.Text = Convert.ToDecimal(dv[0]["Free"]).ToString("#,##0");
            txtOther.Text = Convert.ToDecimal(dv[0]["Other"]).ToString("#,##0");
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Expenses", "ExpensesCode", id);
        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 i = 0;
        if ((btc.CkUseData(ddlYearB.SelectedValue, "StudyYear", "Expenses", "And DelFlag = 0")) && Request["mode"] != "2")
        {
            btc.Msg_Head(Img1, MsgHead, true, "7", 0);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
            return;
        }
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {           
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Expenses", "ExpensesCode, StudyYear, Subsidies, Revenue, Free, Other, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlYearB.SelectedValue, Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtOther.Text), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Expenses.aspx?ckmode=1&Cr=" + i);   
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Expenses", "Where ExpensesCode = '" + Request["id"] + "' ", "Subsidies, Revenue, Free, Other, UpdateUser, UpdateDate", Convert.ToDecimal(txtSubsidies.Text), Convert.ToDecimal(txtRevenue.Text), Convert.ToDecimal(txtFree.Text), Convert.ToDecimal(txtOther.Text), CurrentUser.ID, DateTime.Now);
            Response.Redirect("Expenses.aspx?ckmode=2&Cr=" + i);   
        }
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 i = Conn.Update("Expenses", "Where ExpensesCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
        Response.Redirect("Expenses.aspx?ckmode=3&Cr=" + i); 
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
