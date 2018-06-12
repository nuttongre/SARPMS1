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

public partial class Side : System.Web.UI.Page
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

            lblTitle1.Text = "มาตรฐาน";
            lblTitle2.Text = "มาตรฐาน";
            lblSideNo.Text = "มาตรฐานที่";
            lblSide.Text = "มาตรฐาน";
            GridView1.Columns[0].HeaderText = "มาตรฐานที่";
            GridView1.Columns[1].HeaderText = "ชื่อมาตรฐาน";
            GridView2.Columns[0].HeaderText = "มาตรฐานที่";
            GridView2.Columns[1].HeaderText = "ชื่อมาตรฐาน";
            btAdd.Text = "       สร้างมาตรฐานใหม่";
            btAdd.ToolTip = "สร้างมาตรฐานใหม่";
            btSave.ToolTip = "บันทึกมาตรฐานนี้";
            btSaveAgain.Text = "       บันทึกและสร้างมาตรฐานใหม่";
            btSaveAgain.ToolTip = "บันทึกมาตรฐานนี้และสร้างมาตรฐานใหม่";


            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        //getddlScoreGroup();
                        btc.GenSort(txtSort, "Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        //getddlScoreGroup();
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
                getddlYear(0);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtSide.Attributes.Add("onkeyup", "Cktxt(0);");
        //ddlScoreGroup.Attributes.Add("onchange", "Cktxt(0);");
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
        DataView dv = btc.getScoreGroup();
        ddlScoreGroup.DataSource = dv;
        ddlScoreGroup.DataTextField = "ScoreGroupName";
        ddlScoreGroup.DataValueField = "ScoreGroupID";
        ddlScoreGroup.DataBind();
        ddlScoreGroup.Items.Insert(0, new ListItem("-เลือก-", ""));
        ddlScoreGroup.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        string StrSql = " Select a.SideCode, a.SideName, a.Sort, IsNull(b.WeightScore, 0) WeightScore "
                    + " From Side a Left Join ScoreGroup b On a.ScoreGroupID = b.ScoreGroupID "
                    + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (txtSearch.Text != "")
        {
            StrSql +=  " And (a.SideName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        if (Request.QueryString["mode"] == "1")
        {
            StrSql = " Select a.SideCode, a.SideName, a.Sort "
                   + " From Side a Where a.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' ";

            DataView dv1 = Conn.Select(string.Format(StrSql + " Order By a.Sort "));

            GridView2.DataSource = dv1;
            GridView2.DataBind();
        }
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From Side Where SideCode = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            txtSide.Text = dv[0]["SideName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Side", "SideCode", id);
        }
    }
    private void getCriteria()
    {
        string StrSql = "Select TcriteriaID, ScoreGroupID, Tcriteria, Detail, Criterion, Translation, TMin, TMax From TCriteria Where DelFlag = 0 ";   
            StrSql = StrSql + " And ScoreGroupID = '" + ddlScoreGroup.SelectedValue + "' ";
        
        DataView dv = Conn.Select(string.Format(StrSql + " Order By Tcriteria, Criterion"));
        dgCriteria.DataSource = dv;
        dgCriteria.DataBind();
    }
    private void ClearAll()
    {
        txtSide.Text = "";
        txtSearch.Text = "";
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
            i = Conn.AddNew("Side", "SideCode, StudyYear, SideName, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlYearB.SelectedValue, txtSide.Text, ddlScoreGroup.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("Side.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Side", "Where SideCode = '" + Request["id"] + "' ", "StudyYear, SideName, ScoreGroupID, Sort, UpdateUser, UpdateDate", ddlYearB.SelectedValue, txtSide.Text, ddlScoreGroup.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Side.aspx?ckmode=2&Cr=" + i);    
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
        if (btc.CkUseData(id, "SideCode", "Standard", "And DelFlag = 0"))
        {
            Response.Redirect("Side.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("Side", "Where SideCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Side.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Side", " And StudyYear = '" + ddlYearB.SelectedValue + "'");
    }
    protected void ddlScoreGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        getCriteria();
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
