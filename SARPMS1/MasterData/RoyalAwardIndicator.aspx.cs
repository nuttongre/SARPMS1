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

public partial class RoyalAwardIndicator : System.Web.UI.Page
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

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            //btc.LinkReport(linkReport);

            getddlYear(0);
            getddlRoyalAwardSide(0, ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlRoyalAwardSide(1, ddlYearB.SelectedValue);
                        getddlScoreGroup();
                        btc.GenSort(txtSort, "RoyalAwardIndicator", " And StudyYear = '" + ddlYearB.SelectedValue + "' And RoyalAwardSideID = '" + ddlRoyalAwardSide.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlScoreGroup();
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
        txtRoyalAwardIndicator.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlRoyalAwardSide.Attributes.Add("onchange", "Cktxt(0);");
        txtScore.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
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
    private void getddlScoreGroup()
    {
        //DataView dv = btc.getScoreGroup();
        //ddlScoreGroup.DataSource = dv;
        //ddlScoreGroup.DataTextField = "ScoreGroupName";
        //ddlScoreGroup.DataValueField = "ScoreGroupID";
        //ddlScoreGroup.DataBind();
        //ddlScoreGroup.Items.Insert(0, new ListItem("-เลือก-", ""));
        //ddlScoreGroup.SelectedIndex = 0;
    }
    private void getddlRoyalAwardSide(int mode, string StudyYear)
    {
        DataView dv = Conn.Select("Select RoyalAwardSideID, Cast(Sort as nvarchar) + ' - ' + RoyalAwardSideName FullName, Sort From RoyalAwardSide Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "RoyalAwardSideID";
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
                ddlRoyalAwardSide.DataSource = dv;
                ddlRoyalAwardSide.DataTextField = "FullName";
                ddlRoyalAwardSide.DataValueField = "RoyalAwardSideID";
                ddlRoyalAwardSide.DataBind();
                ddlRoyalAwardSide.Enabled = true;
                ddlRoyalAwardSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlRoyalAwardSide.SelectedIndex = 0;
            }
            else
            {
                ddlRoyalAwardSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlRoyalAwardSide.SelectedIndex = 0;
                ddlRoyalAwardSide.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        //string StrSql = " Select a.RoyalAwardIndicatorID, a.RoyalAwardIndicatorName, a.Sort, IsNull(b.WeightScore, 0) WeightScore "
        //            + " From RoyalAwardIndicator a Left Join ScoreGroup b On a.ScoreGroupID = b.ScoreGroupID "
        //            + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        string StrSql = @" Select b.RoyalAwardIndicatorID, b.RoyalAwardIndicatorName, Cast(a.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) As Sort1, IsNull(b.Score, 0) WeightScore 
                        From RoyalAwardSide a Inner Join RoyalAwardIndicator b On a.RoyalAwardSideID = b.RoyalAwardSideID
                        Where b.DelFlag = 0 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And b.RoyalAwardSideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (b.RoyalAwardIndicatorName Like '%" + txtSearch.Text + "%' Or b.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From RoyalAwardIndicator Where RoyalAwardIndicatorID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlRoyalAwardSide(1, ddlYearB.SelectedValue);          
            ddlRoyalAwardSide.SelectedValue = dv[0]["RoyalAwardSideID"].ToString();
            txtRoyalAwardIndicator.Text = dv[0]["RoyalAwardIndicatorName"].ToString();
            txtComment.Text = dv[0]["Comment"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtScore.Text = dv[0]["Score"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "RoyalAwardIndicator", "RoyalAwardIndicatorID", id);
    }
    private void getCriteria()
    {
        //string StrSql = "Select TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax From TCriteria Where DelFlag = 0 ";
        //StrSql = StrSql + " And ScoreGroupID = '" + ddlScoreGroup.SelectedValue + "' ";

        //DataView dv = Conn.Select(string.Format(StrSql + " Order By Tcriteria, Criterion"));
        //dgCriteria.DataSource = dv;
        //dgCriteria.DataBind();
    }
    private void ClearAll()
    {
        txtRoyalAwardIndicator.Text = "";
        ddlRoyalAwardSide.SelectedIndex = 0;
        txtComment.Text = "";
        txtDetail.Text = "";
        txtScore.Text = "";
        txtSearch.Text = "";
        //ddlScoreGroup.SelectedIndex = 0;
        //dgCriteria.DataSource = null;
        //dgCriteria.DataBind();
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
            i = Conn.AddNew("RoyalAwardIndicator", "RoyalAwardIndicatorID, RoyalAwardIndicatorName, RoyalAwardSideID, StudyYear, Comment, Detail, Score, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtRoyalAwardIndicator.Text, ddlRoyalAwardSide.SelectedValue, ddlYearB.SelectedValue, txtComment.Text, txtDetail.Text, txtScore.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("RoyalAwardIndicator.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "RoyalAwardIndicator", " And StudyYear = '" + ddlYearB.SelectedValue + "' And RoyalAwardSideID = '" + ddlRoyalAwardSide.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("RoyalAwardIndicator", "Where RoyalAwardIndicatorID = '" + Request["id"] + "' ", "RoyalAwardIndicatorName, RoyalAwardSideID, StudyYear, Comment, Detail, Score, Sort, UpdateUser, UpdateDate", txtRoyalAwardIndicator.Text, ddlRoyalAwardSide.SelectedValue, ddlYearB.SelectedValue, txtComment.Text, txtDetail.Text, txtScore.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("RoyalAwardIndicator.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "RoyalAwardIndicatorID", "dtRoyalAward", "And DelFlag = 0"))
        {
            Response.Redirect("RoyalAwardIndicator.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("RoyalAwardIndicator", "Where RoyalAwardIndicatorID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("RoyalAwardIndicator.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlRoyalAwardSide(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlRoyalAwardSide(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "RoyalAwardIndicator", " And StudyYear = '" + ddlYearB.SelectedValue + "' And RoyalAwardSideID = '" + ddlRoyalAwardSide.SelectedValue + "'");
    }
    protected void ddlScoreGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        getCriteria();
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
    protected void ddlRoyalAwardSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "RoyalAwardIndicator", " And StudyYear = '" + ddlYearB.SelectedValue + "' And RoyalAwardSideID = '" + ddlRoyalAwardSide.SelectedValue + "'");
    }
}
