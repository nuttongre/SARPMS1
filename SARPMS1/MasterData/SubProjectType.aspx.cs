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

public partial class SubProjectType : System.Web.UI.Page
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

            getddlProjectType(0);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlProjectType(1);
                        btc.GenSort(txtSort, "SubProjectType", " And ProjectTypeID = '" + ddlProjectType.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        btc.btEnable(btSaveAgain, false);
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
        txtSubProjectType.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlProjectType.Attributes.Add("onchange", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getddlProjectType(int mode)
    {
        DataView dv = Conn.Select("Select ProjectTypeID, Cast(Sort as nvarchar) + ' - ' + ProjectTypeName FullName, Sort From ProjectType Where DelFlag = 0 Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "ProjectTypeID";
                ddlSearch.DataBind();
                ddlSearch.Enabled = true;
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearch.SelectedIndex = 0;
            }
            else
            {
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearch.SelectedIndex = 0;
                ddlSearch.Enabled = false;
            }
        }

        if (mode == 1)
        {
            if (dv.Count != 0)
            {
                ddlProjectType.DataSource = dv;
                ddlProjectType.DataTextField = "FullName";
                ddlProjectType.DataValueField = "ProjectTypeID";
                ddlProjectType.DataBind();
                ddlProjectType.Enabled = true;
                ddlProjectType.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlProjectType.SelectedIndex = 0;
            }
            else
            {
                ddlProjectType.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlProjectType.SelectedIndex = 0;
                ddlProjectType.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.SubProjectTypeID, a.SubProjectTypeName, Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1 
                        From SubProjectType a Inner Join ProjectType b On a.ProjectTypeID = b.ProjectTypeID
                        Where a.DelFlag = 0 ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ProjectTypeID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.SubProjectTypeName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From SubProjectType Where SubProjectTypeID = '" + id + "'"));

        if (dv.Count != 0)
        {
            getddlProjectType(1);          
            ddlProjectType.SelectedValue = dv[0]["ProjectTypeID"].ToString();
            txtSubProjectType.Text = dv[0]["SubProjectTypeName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "SubProjectType", "SubProjectTypeID", id);
    }
    private void ClearAll()
    {
        txtSubProjectType.Text = "";
        ddlProjectType.SelectedIndex = 0;
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("SubProjectType", "SubProjectTypeID, SubProjectTypeName, ProjectTypeID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtSubProjectType.Text, ddlProjectType.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("SubProjectType.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "SubProjectType", " And ProjectTypeID = '" + ddlProjectType.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("SubProjectType", "Where SubProjectTypeID = '" + Request["id"] + "' ", "SubProjectTypeName, ProjectTypeID, Sort, UpdateUser, UpdateDate", 
                txtSubProjectType.Text, ddlProjectType.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SubProjectType.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "SubProjectTypeID", "Projects", "And DelFlag = 0"))
        {
            Response.Redirect("SubProjectType.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("SubProjectType", "Where SubProjectTypeID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SubProjectType.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProjectType(0);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlProjectType(1);
       btc.GenSort(txtSort, "SubProjectType", " And ProjectTypeID = '" + ddlProjectType.SelectedValue + "'");
    }
    protected string checkedit(string id, string strName)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
    }
    protected void ddlProjectType_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "SubProjectType", " And ProjectTypeID = '" + ddlProjectType.SelectedValue + "'");
    }
}
