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

public partial class IdentityName : System.Web.UI.Page
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
            
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        btc.GenSort(txtSort, "IdentityName", "");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        btc.btEnable(btSaveAgain, false);
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
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtIdentityName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    public override void DataBind()
    {
        string StrSql = " Select IdentityNameCode, IdentityName, Sort "
                    + " From IdentityName "
                    + " Where DelFlag = 0 ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And IdentityName Like '%" + txtSearch.Text + "%' Or Sort Like '%" + txtSearch.Text + "%'  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By Sort Asc "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From IdentityName Where IdentityNameCode = '" + id + "'"));

        if (dv.Count != 0)
        {
            txtIdentityName.Text = dv[0]["IdentityName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "IdentityName", "IdentityNameCode", id);
    }
    private void ClearAll()
    {
        txtIdentityName.Text = "";
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
            i = Conn.AddNew("IdentityName", "IdentityNameCode, IdentityName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtIdentityName.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("IdentityName.aspx?ckmode=1&Cr=" + i); 
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "IdentityName", "");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
            i = Conn.Update("IdentityName", "Where IdentityNameCode = '" + Request.QueryString["id"] + "' ", "IdentityName, Sort, UpdateUser, UpdateDate", 
                txtIdentityName.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("IdentityName.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "IdentityNameCode", "dtIdentityName", ""))
        {
            Response.Redirect("IdentityName.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("IdentityName", "Where IdentityNameCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("IdentityName.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected string checkedit(string id, string strName)
    {
        if (CurrentUser.RoleLevel >= 98)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
    }
}
