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

public partial class Indicators : System.Web.UI.Page
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

            lblSideSearch.Text = "มาตรฐาน";
            lblSide.Text = "มาตรฐาน";
            lblTitle1.Text = "ประเด็นการประเมิน";
            lblTitle2.Text = "ประเด็นการประเมิน";
            lblStandardSearch.Text = "ตัวบ่งชี้";
            lblIndicatorNo.Text = "ประเด็นการประเมินที่";
            lblStandard.Text = "ตัวบ่งชี้";
            lblIndicator.Text = "ประเด็นการประเมิน";
            //GridView1.Columns[0].HeaderText = "ประเด็นการประเมินที่";
            //GridView1.Columns[1].HeaderText = "ชื่อประเด็นการประเมิน";
            //GridView2.Columns[0].HeaderText = "ประเด็นการประเมินที่";
            //GridView2.Columns[1].HeaderText = "ชื่อประเด็นการประเมิน";
            btAdd.Text = "       สร้างประเด็นการประเมินใหม่";
            btAdd.ToolTip = "สร้างประเด็นการประเมินใหม่";
            btSave.ToolTip = "บันทึกประเด็นการประเมินนี้";
            btSaveAgain.Text = "       บันทึกและสร้างประเด็นการประเมินใหม่";
            btSaveAgain.ToolTip = "บันทึกประเด็นการประเมินนี้และสร้างประเด็นการประเมินใหม่";

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlSide(1);
                        getddlStandard(1, ddlSide.SelectedValue);
                        //getddlScoreGroup();
                        btc.GenSort(txtSort, "Indicators", " And StandardCode = '" + ddlStandard.SelectedValue + "'");
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
                getddlSide(0);
                getddlStandard(0, ddlSearchSide.SelectedValue);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        ddlStandard.Attributes.Add("onchange", "Cktxt(0);");
        txtIndicators.Attributes.Add("onkeyup", "Cktxt(0);");
        //txtWeightScore.Attributes.Add("onkeyup", "Cktxt(0);");
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
    private void getddlSide(int mode)
    {
        if (mode == 0)
        {
            btc.getddlSide(0, ddlSearchSide, ddlSearchYear.SelectedValue, Cookie.GetValue2("ckSideCode"));
        }

        if (mode == 1)
        {
            btc.getddlSide(1, ddlSide, ddlYearB.SelectedValue, null);
        }
    }
    private void getddlStandard(int mode, string SideCode)
    {
        if (mode == 0)
        {
            btc.getddlStandard(0, ddlSearch, ddlSearchYear.SelectedValue, SideCode, Cookie.GetValue2("ckStandard"));
        }

        if (mode == 1)
        {
            btc.getddlStandard(1, ddlStandard, ddlYearB.SelectedValue, ddlSide.SelectedValue, null);
        }
    }
    public override void DataBind()
    {
        string StrSql = @"Select Cast(a.Sort As nVarChar) + ' - ' + a.StandardName FullName, b.IndicatorsCode, 
            Cast(S.Sort As nVarChar) + '.' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName IndicatorsName
            From Indicators b Left Join Standard a On a.StandardCode = b.StandardCode
            Left Join Side S On S.SideCode = a.SideCode
            Where a.DelFlag = 0 And b.DelFlag = 0 And S.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        if (ddlSearchSide.SelectedIndex != 0)
        {
            StrSql += " And S.SideCode = '" + ddlSearchSide.SelectedValue + "'";
        }
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql += " And a.StandardCode = '" + ddlSearch.SelectedValue + "'";
        }
        if (txtSearch.Text != "")
        {
            StrSql += " And b.IndicatorsName Like '%" + txtSearch.Text + "%' Or b.Sort Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By S.Sort, a.Sort, b.Sort " ));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        if (Request.QueryString["mode"] == "1")
        {
            StrSql = @"Select Cast(a.Sort As nVarChar) + ' - ' + a.StandardName FullName, b.IndicatorsCode, 
            Cast(S.Sort As nVarChar) + '.' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName IndicatorsName 
            From Indicators b Left Join Standard a On a.StandardCode = b.StandardCode
            Left Join Side S On S.SideCode = a.SideCode
            Where a.DelFlag = 0 And b.DelFlag = 0 And S.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' ";

            DataView dv1 = Conn.Select(string.Format(StrSql + " Order By S.Sort, a.Sort, b.Sort "));
            GridView2.DataSource = dv1;
            GridView2.DataBind();
        }
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        string strSql = @"Select a.StandardCode, a.StudyYear, b.IndicatorsCode, b.ScoreGroupID, b.IndicatorsName, b.Detail, b.DevelopIssues, b.Sort, a.SideCode 
            From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode 
            Where b.IndicatorsCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Table.Rows.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlSide(1);
            ddlSide.SelectedValue = dv[0]["SideCode"].ToString();
            getddlStandard(1, ddlSide.SelectedValue);
            ddlStandard.SelectedValue = dv[0]["StandardCode"].ToString();
            txtIndicators.Text = dv[0]["IndicatorsName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            //txtDevelopIssues.Text = dv[0]["DevelopIssues"].ToString();
            //cbQualityFlag.Checked = Convert.ToBoolean(dv[0]["QualityFlag"]);
            //txtDataSource1.Text = dv[0]["DataSource1"].ToString();
            //txtDataSource2.Text = dv[0]["DataSource2"].ToString(); ;
            //txtWeightScore.Text = dv[0]["WeightScore"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            //ddlScoreGroup.SelectedValue = dv[0]["ScoreGroupID"].ToString();
            //getCriteria();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Indicators", "IndicatorsCode", id);
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
        ddlSide.SelectedIndex = 0;
        ddlStandard.SelectedIndex = 0;
        txtIndicators.Text = "";
        txtDetail.Text = "";
        //txtDevelopIssues.Text = "";
        //txtDataSource1.Text = "";
        //txtDataSource2.Text = "";
        //txtWeightScore.Text = "";
        //cbQualityFlag.Checked = false;
        txtSearch.Text = "";
        //ddlScoreGroup.SelectedIndex = 0;
        //dgCriteria.DataSource = null;
        //dgCriteria.DataBind();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    } 
    protected void ddlSearchSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckSideCode", ddlSearchSide.SelectedValue);
        getddlStandard(0, ddlSearchSide.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckStandard", ddlSearch.SelectedValue);
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Indicators", "IndicatorsCode, IndicatorsName, StandardCode, Detail, DevelopIssues, WeightScore, QualityFlag, DataSource1, DataSource2, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate",
                NewID, txtIndicators.Text, ddlStandard.SelectedValue, txtDetail.Text, txtDevelopIssues.Text, txtWeightScore.Text, cbQualityFlag.Checked, txtDataSource1.Text, txtDataSource2.Text, ddlScoreGroup.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (CkAgain == "N")
            {
                Response.Redirect("Indicators.aspx?ckmode=1&Cr=" + i);  
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Indicators", " And StandardCode = '" + ddlStandard.SelectedValue + "'");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Indicators", "Where IndicatorsCode = '" + Request["id"] + "' ", "IndicatorsName, StandardCode, Detail, DevelopIssues, WeightScore, QualityFlag, DataSource1, DataSource2, ScoreGroupID, Sort, UpdateUser, UpdateDate", 
                txtIndicators.Text, ddlStandard.SelectedValue, txtDetail.Text, txtDevelopIssues.Text, txtWeightScore.Text, cbQualityFlag.Checked, txtDataSource1.Text, txtDataSource2.Text, ddlScoreGroup.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Indicators.aspx?ckmode=2&Cr=" + i);  
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
        if (btc.CkUseData(id, "IndicatorsCode", "Evaluation", "And DelFlag = 0"))
        {
            Response.Redirect("Indicators.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("Indicators", "Where IndicatorsCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Indicators.aspx?ckmode=3&Cr=" + i);    
        }  
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSide(0);
        getddlStandard(0, ddlSearchSide.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSide(1);
        getddlStandard(1, ddlSide.SelectedValue);
        btc.GenSort(txtSort, "Indicators", " And StandardCode = '" + ddlStandard.SelectedValue + "'");
    }
    protected void ddlSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlStandard(1, ddlSide.SelectedValue);
        btc.GenSort(txtSort, "Indicators", " And StandardCode = '" + ddlStandard.SelectedValue + "'");
    }
    protected void ddlStandard_OnSelectedChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Indicators", " And StandardCode = '" + ddlStandard.SelectedValue + "'");
    }
    protected void EnableMode(string id, bool status)
    {
        int result = Conn.Update("Indicators", "WHERE IndicatorsCode='" + id + "'", "QualityFlag", (status ? 0 : 1));
    }
    protected void ddlScoreGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        getCriteria();
        txtWeightScore.Text = btc.getWeightScoreGroup(ddlScoreGroup.SelectedValue).ToString();
    }
    protected string checkedit(string id, string strName)
    {
        if (CurrentUser.RoleLevel >= 98)
        {
            return String.Format("<a href=\"javascript:;\" title=\"{1}\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
    }
}
