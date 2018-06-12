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

public partial class WorldClassStandard : System.Web.UI.Page
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
            getddlWorldClassSide(0, ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlWorldClassSide(1, ddlYearB.SelectedValue);
                        getddlScoreGroup();
                        btc.GenSort(txtSort, "WorldClassStandard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And WorldClassSideID = '" + ddlWorldClassSide.SelectedValue + "' ");
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
        txtWorldClassStandard.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlWorldClassSide.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlWorldClassSide(int mode, string StudyYear)
    {
        DataView dv = Conn.Select("Select WorldClassSideID, Cast(Sort as nvarchar) + ' - ' + WorldClassSideName FullName, Sort From WorldClassSide Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By MsSideSort, Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "WorldClassSideID";
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
                ddlWorldClassSide.DataSource = dv;
                ddlWorldClassSide.DataTextField = "FullName";
                ddlWorldClassSide.DataValueField = "WorldClassSideID";
                ddlWorldClassSide.DataBind();
                ddlWorldClassSide.Enabled = true;
                ddlWorldClassSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlWorldClassSide.SelectedIndex = 0;
            }
            else
            {
                ddlWorldClassSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlWorldClassSide.SelectedIndex = 0;
                ddlWorldClassSide.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        //string StrSql = " Select a.WorldClassStandardID, a.WorldClassStandardName, a.Sort, IsNull(b.WeightScore, 0) WeightScore "
        //            + " From WorldClassStandard a Left Join ScoreGroup b On a.ScoreGroupID = b.ScoreGroupID "
        //            + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        string StrSql = @" Select a.WorldClassStandardID, a.WorldClassStandardName, Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1, IsNull(a.Score, 0) WeightScore 
                        From WorldClassStandard a Inner Join WorldClassSide b On a.WorldClassSideID = b.WorldClassSideID
                        Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.WorldClassSideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.WorldClassStandardName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.MsSideSort, b.Sort, a.Sort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From WorldClassStandard Where WorldClassStandardID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlWorldClassSide(1, ddlYearB.SelectedValue);          
            ddlWorldClassSide.SelectedValue = dv[0]["WorldClassSideID"].ToString();
            txtWorldClassStandard.Text = dv[0]["WorldClassStandardName"].ToString();
            txtComment.Text = dv[0]["Comment"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtScore.Text = dv[0]["Score"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "WorldClassStandard", "WorldClassStandardID", id);
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
        txtWorldClassStandard.Text = "";
        ddlWorldClassSide.SelectedIndex = 0;
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
            i = Conn.AddNew("WorldClassStandard", "WorldClassStandardID, WorldClassStandardName, WorldClassSideID, StudyYear, Comment, Detail, Score, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtWorldClassStandard.Text, ddlWorldClassSide.SelectedValue, ddlYearB.SelectedValue, txtComment.Text, txtDetail.Text, txtScore.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("WorldClassStandard.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "WorldClassStandard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And WorldClassSideID = '" + ddlWorldClassSide.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("WorldClassStandard", "Where WorldClassStandardID = '" + Request["id"] + "' ", "WorldClassStandardName, WorldClassSideID, StudyYear, Comment, Detail, Score, Sort, UpdateUser, UpdateDate", txtWorldClassStandard.Text, ddlWorldClassSide.SelectedValue, ddlYearB.SelectedValue, txtComment.Text, txtDetail.Text, txtScore.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("WorldClassStandard.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "WorldClassStandardID", "dtWorldClass", "And DelFlag = 0"))
        {
            Response.Redirect("WorldClassStandard.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("WorldClassStandard", "Where WorldClassStandardID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("WorldClassStandard.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlWorldClassSide(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlWorldClassSide(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "WorldClassStandard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And WorldClassSideID = '" + ddlWorldClassSide.SelectedValue + "'");
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
    protected void ddlWorldClassSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "WorldClassStandard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And WorldClassSideID = '" + ddlWorldClassSide.SelectedValue + "'");
    }
}
