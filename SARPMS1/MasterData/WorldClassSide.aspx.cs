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

public partial class WorldClassSide : System.Web.UI.Page
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

            getddlYear(0);
            getddlType(0, ddlSearchType);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlType(1, ddlType);
                        getddlScoreGroup();
                        btc.GenSort(txtSort, "WorldClassSide", " And StudyYear = '" + ddlYearB.SelectedValue + "' And MsSideSort = '" + ddlType.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlType(1, ddlType);
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
        txtWorldClassSide.Attributes.Add("onkeyup", "Cktxt(0);");
        txtScore.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlType.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlType(int mode, DropDownList ddlType)
    {
        if (mode == 0)
        {
            ddlType.Items.Insert(0, new ListItem("- ทั้งหมด -", "0"));
        }
        if (mode == 1)
        {
            ddlType.Items.Insert(0, new ListItem("- เลือก -", "0"));
        }
        ddlType.Items.Insert(1, new ListItem("คุณลักษณะผู้เรียน", "1"));
        ddlType.Items.Insert(2, new ListItem("การจัดการเรียนการสอนเทียบเคียงมาตรฐานสากล", "2"));
        ddlType.Items.Insert(3, new ListItem("บริหารจัดการด้วยระบบคุณภาพ", "3"));
        ddlType.DataBind();
        ddlType.SelectedIndex = 0;
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
    public override void DataBind()
    {
        //string StrSql = " Select a.WorldClassSideID, a.WorldClassSideName, a.Sort, IsNull(b.WeightScore, 0) WeightScore "
        //            + " From WorldClassSide a Left Join ScoreGroup b On a.ScoreGroupID = b.ScoreGroupID "
        //            + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        string StrSql = @" Select a.WorldClassSideID, a.WorldClassSideName, a.Sort, IsNull(a.Score, 0) WeightScore 
                        From WorldClassSide a 
                        Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        if (ddlSearchType.SelectedIndex != 0)
        {
            StrSql += " And MsSideSort = '" + ddlSearchType.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.WorldClassSideName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.MsSideSort, a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From WorldClassSide Where WorldClassSideID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlType.SelectedValue = dv[0]["MsSideSort"].ToString();
            txtWorldClassSide.Text = dv[0]["WorldClassSideName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtScore.Text = dv[0]["Score"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "WorldClassSide", "WorldClassSideID", id);
        }
    }
    private void getCriteria()
    {
        //string StrSql = "Select TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax From TCriteria Where DelFlag = 0 ";   
        //    StrSql = StrSql + " And ScoreGroupID = '" + ddlScoreGroup.SelectedValue + "' ";
        
        //DataView dv = Conn.Select(string.Format(StrSql + " Order By Tcriteria, Criterion"));
        //dgCriteria.DataSource = dv;
        //dgCriteria.DataBind();
    }
    private void ClearAll()
    {
        txtWorldClassSide.Text = "";
        txtSearch.Text = "";
        txtDetail.Text = "";
        txtScore.Text = "";
        //ddlScoreGroup.SelectedIndex = 0;
        //dgCriteria.DataSource = null;
        //dgCriteria.DataBind();
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
            i = Conn.AddNew("WorldClassSide", "WorldClassSideID, StudyYear, WorldClassSideName, Detail, Score, Sort, MsSideSort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlYearB.SelectedValue, txtWorldClassSide.Text, txtDetail.Text, txtScore.Text, txtSort.Text, ddlType.SelectedValue, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("WorldClassSide.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "WorldClassSide", " And StudyYear = '" + ddlYearB.SelectedValue + "' And MsSideSort = '" + ddlType.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("WorldClassSide", "Where WorldClassSideID = '" + Request["id"] + "' ", "StudyYear, WorldClassSideName, Detail, Score, Sort, MsSideSort, UpdateUser, UpdateDate", ddlYearB.SelectedValue, txtWorldClassSide.Text, txtDetail.Text, txtScore.Text, txtSort.Text, ddlType.SelectedValue, CurrentUser.ID, DateTime.Now);
            Response.Redirect("WorldClassSide.aspx?ckmode=2&Cr=" + i);    
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
        if (btc.CkUseData(id, "WorldClassSideID", "WorldClassStandard", "And DelFlag = 0"))
        {
            Response.Redirect("WorldClassSide.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("WorldClassSide", "Where WorldClassSideID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("WorldClassSide.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "WorldClassSide", " And StudyYear = '" + ddlYearB.SelectedValue + "' And MsSideSort = '" + ddlType.SelectedValue + "' ");
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
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "WorldClassSide", " And StudyYear = '" + ddlYearB.SelectedValue + "' And MsSideSort = '" + ddlType.SelectedValue + "' ");
    }
    protected void ddlSearchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
