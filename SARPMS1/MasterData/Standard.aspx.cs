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

public partial class Standard : System.Web.UI.Page
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

            lblTitle1.Text = "ตัวบ่งชี้";
            lblTitle2.Text = "ตัวบ่งชี้";
            lblSideSearch.Text = "มาตรฐาน";
            lblStandardNo.Text = "ตัวบ่งชี้ที่";
            lblSide.Text = "มาตรฐาน";
            lblStandard.Text = "ตัวบ่งชี้";
            GridView1.Columns[0].HeaderText = "ตัวบ่งชี้ที่";
            GridView1.Columns[1].HeaderText = "ชื่อตัวบ่งชี้";
            GridView2.Columns[0].HeaderText = "ตัวบ่งชี้ที่";
            GridView2.Columns[1].HeaderText = "ชื่อตัวบ่งชี้";
            btAdd.Text = "       สร้างตัวบ่งชี้ใหม่";
            btAdd.ToolTip = "สร้างตัวบ่งชี้ใหม่";
            btSave.ToolTip = "บันทึกตัวบ่งชี้นี้";
            btSaveAgain.Text = "       บันทึกและสร้างตัวบ่งชี้ใหม่";
            btSaveAgain.ToolTip = "บันทึกตัวบ่งชี้นี้และสร้างตัวบ่งชี้ใหม่";

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            btc.LinkReport(linkReport);

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlSide(1, ddlYearB.SelectedValue);
                        //getddlScoreGroup();
                        btc.GenSort(txtSort, "Standard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And SideCode = '" + ddlSide.SelectedValue + "'");
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
                getddlSide(0, ddlSearchYear.SelectedValue);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtStandard.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlSide.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlSide(int mode, string StudyYear)
    {
        if (mode == 0)
        {
            btc.getddlSide(0, ddlSearch, StudyYear, Cookie.GetValue2("ckSideCode"));
        }

        if (mode == 1)
        {
            btc.getddlSide(1, ddlSide, StudyYear, null);
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.StandardCode, a.StandardName, Cast(S.Sort As nVarChar) + '.' + Cast(a.Sort As nVarChar) As Sort 
                    From Standard a  
                    Left Join Side S On a.SideCode = S.SideCode
                    Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.SideCode = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.StandardName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By S.Sort, a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        if (Request.QueryString["mode"] == "1")
        {
            StrSql = @" Select a.StandardCode, a.StandardName, Cast(S.Sort As nVarChar) + '.' + Cast(a.Sort As nVarChar) As Sort 
                    From Standard a  
                    Left Join Side S On a.SideCode = S.SideCode
                    Where a.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' ";

            DataView dv1 = Conn.Select(string.Format(StrSql + " Order By S.Sort, a.Sort "));
            GridView2.DataSource = dv1;
            GridView2.DataBind();
        }
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From Standard Where StandardCode = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlSide(1, ddlYearB.SelectedValue);          
            ddlSide.SelectedValue = dv[0]["SideCode"].ToString();
            txtStandard.Text = dv[0]["StandardName"].ToString();
            txtNote.Text = dv[0]["Note"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Standard", "StandardCode", id);
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
        txtStandard.Text = "";
        //ddlSide.SelectedIndex = 0;
        txtNote.Text = "";
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
        Cookie.SetValue2("ckSideCode", ddlSearch.SelectedValue);
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Standard", "StandardCode, StandardName, SideCode, StudyYear, Note, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtStandard.Text, ddlSide.SelectedValue, ddlYearB.SelectedValue, txtNote.Text, ddlScoreGroup.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("Standard.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Standard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And SideCode = '" + ddlSide.SelectedValue + "'");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Standard", "Where StandardCode = '" + Request["id"] + "' ", "StandardName, SideCode, StudyYear, Note, ScoreGroupID, Sort, UpdateUser, UpdateDate", txtStandard.Text, ddlSide.SelectedValue, ddlYearB.SelectedValue, txtNote.Text, ddlScoreGroup.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Standard.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "StandardCode", "Indicators", "And DelFlag = 0"))
        {
            Response.Redirect("Standard.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("Standard", "Where StandardCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Standard.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSide(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlSide(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "Standard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And SideCode = '" + ddlSide.SelectedValue + "'");
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
    protected void ddlSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Standard", " And StudyYear = '" + ddlYearB.SelectedValue + "' And SideCode = '" + ddlSide.SelectedValue + "'");
    }
}
