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

public partial class Tcriteria : System.Web.UI.Page
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

            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlScoreGroup(1);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlScoreGroup(1);
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
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                getddlScoreGroup(0);
                DataBind();
            }
        }
        ddlScoreGroup.Attributes.Add("onchange", "Cktxt(0);");
        txtDetail.Attributes.Add("onkeyup", "Cktxt(0);");
        txtCriterion.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTranslation.Attributes.Add("onkeyup", "Cktxt(0);");
        txtMin.Attributes.Add("onkeyup", "Cktxt(0);");
        txtMax.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getddlScoreGroup(int mode)
    {
        DataView dv = btc.getScoreGroup();
        if (mode == 0)
        {
            ddlSearch.DataSource = dv;
            ddlSearch.DataTextField = "ScoreGroupName";
            ddlSearch.DataValueField = "ScoreGroupID";
            ddlSearch.DataBind();
            ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));

            if (Session["sCriteria"] == null)
            {
                ddlSearch.SelectedIndex = 1;
            }
            else
            {
                try
                {
                    ddlSearch.SelectedValue = Session["sCriteria"].ToString();
                }
                catch (Exception ex)
                {
                    ddlSearch.SelectedIndex = 1;
                }
            }
        }
        if (mode == 1)
        {
            ddlScoreGroup.DataSource = dv;
            ddlScoreGroup.DataTextField = "ScoreGroupName";
            ddlScoreGroup.DataValueField = "ScoreGroupID";
            ddlScoreGroup.DataBind();
            ddlScoreGroup.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlScoreGroup.SelectedIndex = 0;
        }
    }
    public override void DataBind()
    {
        string StrSql = "Select TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, CreateUser From TCriteria Where DelFlag = 0 ";
        if (Request["mode"] == "1")
        {
            if (ddlScoreGroup.SelectedIndex != 0)
            {
                StrSql = StrSql + " And ScoreGroupID = '" + ddlScoreGroup.SelectedValue + "' ";
            }
        }
        else
        {
            if (ddlSearch.SelectedIndex != 0)
            {
                StrSql = StrSql + " And ScoreGroupID = '" + ddlSearch.SelectedValue + "' ";
            }
            if (txtSearch.Text != "")
            {
                StrSql = StrSql + " And ( TMin Like '%" + txtSearch.Text + "%' OR TMax Like '%" + txtSearch.Text + "%' ) ";
            }
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By Tcriteria, Criterion"));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, IsNull(TMin, 0) TMin, IsNull(TMax, 0) TMax From TCriteria Where DelFlag = 0 And TcriteriaID = '" + id + "' "));
        if (dv.Count != 0)
        {
            ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            lblTcriteria.Text = dv[0]["Tcriteria"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtCriterion.Text = dv[0]["Criterion"].ToString();
            txtTranslation.Text = dv[0]["Translation"].ToString();
            txtMin.Text = Convert.ToDouble(dv[0]["TMin"]).ToString("#,##0.00");
            txtMax.Text = Convert.ToDouble(dv[0]["TMax"]).ToString("#,##0.00");
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "TCriteria", "TcriteriaID", id);
    }
    private void ClearAll()
    {
        txtDetail.Text = "";
        txtCriterion.Text = "";
        txtTranslation.Text = "";
        txtMin.Text = "";
        txtMax.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["sCriteria"] = ddlSearch.SelectedValue;
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("TCriteria", "TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlScoreGroup.SelectedValue, lblTcriteria.Text, txtDetail.Text, txtCriterion.Text, txtTranslation.Text, txtMin.Text, txtMax.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (CkAgain == "N")
            {
                Response.Redirect("TCriteria.aspx?ckmode=1&Cr=" + i);
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("TCriteria", "Where TcriteriaID = '" + Request["id"] + "' ", "ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, UpdateUser, UpdateDate", ddlScoreGroup.SelectedValue, lblTcriteria.Text, txtDetail.Text, txtCriterion.Text, txtTranslation.Text, txtMin.Text, txtMax.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("TCriteria.aspx?ckmode=2&Cr=" + i);
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
        //DataView dv = Conn.Select(string.Format("Select TCriteriaID From Develop Where CriterionCode = '" + id + "' And DelFlag = '0' "));
        //if (dv.Count > 0)
        //{
        //    btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        //}
        //else
        //{
            Int32 i = Conn.Update("TCriteria", "Where TCriteriaID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("TCriteria.aspx?ckmode=3&Cr=" + i); 
        //}  
    }
    protected void ddlScoreGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strSql = "Select WeightScore From ScoreGroup Where ScoreGroupID = '" + ddlScoreGroup.SelectedValue + "'";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            lblTcriteria.Text = dv[0]["WeightScore"].ToString();
        }
        else
        {
            lblTcriteria.Text = "0";
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
    protected string checkdel(string createuser, string id)
    {
        if (createuser != "9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A")
        {
            return "<a href=\"javascript:deleteItem('" + id + "');\">"
                   + "<img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>";
        }
        else
        {
            return "";
        }
    }
}
