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
using System.Text;

public partial class SufficeIndicator : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    DataView dvCriterion;
        
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
            getddlSufficeSide(0, ddlSearchYear.SelectedValue);
            getddlSufficeStandard(0, ddlSearchStandard.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        getddlSufficeSide(1, ddlYearB.SelectedValue);
                        getddlSufficeStandard(1, ddlSufficeStandard.SelectedValue);
                        btc.GenSort(txtSort, "SufficeIndicator", " And SufficeStandardID = '" + ddlSufficeStandard.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
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
        txtSufficeIndicator.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlSufficeSide.Attributes.Add("onchange", "Cktxt(0);");
        ddlSufficeStandard.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlSufficeSide(int mode, string StudyYear)
    {
        string strSql = @"Select SufficeSideID, Cast(Sort as nvarchar) + ' - ' + SufficeSideName FullName, Sort 
            From SufficeSide Where DelFlag = 0 And StudyYear = '{0}' Order By Sort";

        if (mode == 0)
        {
            DataView dv = Conn.Select(string.Format(strSql, StudyYear));
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "SufficeSideID";
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
            DataView dv = Conn.Select(string.Format(strSql, StudyYear));
            if (dv.Count != 0)
            {
                ddlSufficeSide.DataSource = dv;
                ddlSufficeSide.DataTextField = "FullName";
                ddlSufficeSide.DataValueField = "SufficeSideID";
                ddlSufficeSide.DataBind();
                ddlSufficeSide.Enabled = true;
                ddlSufficeSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlSufficeSide.SelectedIndex = 0;
            }
            else
            {
                ddlSufficeSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlSufficeSide.SelectedIndex = 0;
                ddlSufficeSide.Enabled = false;
            }
        }
    }
    private void getddlSufficeStandard(int mode, string SufficeSideID)
    {
        DataView dv = Conn.Select("Select SufficeStandardID, Cast(Sort as nvarchar) + ' - ' + SufficeStandardName FullName, Sort From SufficeStandard Where DelFlag = 0 And SufficeSideID = '" + SufficeSideID + "' Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearchStandard.DataSource = dv;
                ddlSearchStandard.DataTextField = "FullName";
                ddlSearchStandard.DataValueField = "SufficeStandardID";
                ddlSearchStandard.DataBind();
                ddlSearchStandard.Enabled = true;
                ddlSearchStandard.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearchStandard.SelectedIndex = 0;
            }
            else
            {
                ddlSearchStandard.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearchStandard.SelectedIndex = 0;
                ddlSearchStandard.Enabled = false;
            }
        }

        if (mode == 1)
        {
            if (dv.Count != 0)
            {
                ddlSufficeStandard.DataSource = dv;
                ddlSufficeStandard.DataTextField = "FullName";
                ddlSufficeStandard.DataValueField = "SufficeStandardID";
                ddlSufficeStandard.DataBind();
                ddlSufficeStandard.Enabled = true;
                ddlSufficeStandard.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlSufficeStandard.SelectedIndex = 0;
            }
            else
            {
                ddlSufficeStandard.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlSufficeStandard.SelectedIndex = 0;
                ddlSufficeStandard.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.SufficeIndicatorID, a.SufficeIndicatorName, Cast(c.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1
                        From SufficeIndicator a, SufficeStandard b, SufficeSide c  
                        Where a.DelFlag = 0 And c.SufficeSideID = b.SufficeSideID And b.SufficeStandardID = a.SufficeStandardID
                        And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And c.SufficeSideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearchStandard.SelectedIndex != 0)
        {
            StrSql = StrSql + " And b.SufficeStandardID = '" + ddlSearchStandard.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.SufficeIndicatorName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By c.Sort, b.Sort, a.Sort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select SI.*, S.StudyYear, SD.SufficeSideID From SufficeSide S, SufficeStandard SD, SufficeIndicator SI
                Where SI.SufficeIndicatorID = '{0}' And S.SufficeSideID = SD.SufficeSideID And SD.SufficeStandardID = SI.SufficeStandardID ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlSufficeSide(1, ddlYearB.SelectedValue);          
            ddlSufficeSide.SelectedValue = dv[0]["SufficeSideID"].ToString();
            getddlSufficeStandard(1, ddlSufficeSide.SelectedValue);
            ddlSufficeStandard.SelectedValue = dv[0]["SufficeStandardID"].ToString();
            txtSufficeIndicator.Text = dv[0]["SufficeIndicatorName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();         
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "SufficeIndicator", "SufficeIndicatorID", id);
    }
    private void ClearAll()
    {
        txtSufficeIndicator.Text = "";
        //ddlSufficeSide.SelectedIndex = 0;
        //ddlSufficeStandard.SelectedIndex = 0;
        txtDetail.Text = "";
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        int result = 0;
        StringBuilder strbSql = new StringBuilder();
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("SufficeIndicator", "SufficeIndicatorID, SufficeIndicatorName, SufficeStandardID, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtSufficeIndicator.Text, ddlSufficeStandard.SelectedValue, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (CkAgain == "N")
            {
                Response.Redirect("SufficeIndicator.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "SufficeIndicator", " And SufficeStandardID = '" + ddlSufficeStandard.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("SufficeIndicator", "Where SufficeIndicatorID = '" + Request["id"] + "' ", "SufficeIndicatorName, SufficeStandardID, Detail, Sort, UpdateUser, UpdateDate",
                txtSufficeIndicator.Text, ddlSufficeStandard.SelectedValue, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);

            Response.Redirect("SufficeIndicator.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "SufficeIndicatorID", "dtSuffice", ""))
        {
            Response.Redirect("SufficeIndicator.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("SufficeIndicator", "Where SufficeIndicatorID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SufficeIndicator.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSufficeSide(0, ddlSearchYear.SelectedValue);
        getddlSufficeStandard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSufficeStandard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchStandard_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlSufficeSide(1, ddlYearB.SelectedValue);
       getddlSufficeStandard(1, ddlSufficeSide.SelectedValue);
       btc.GenSort(txtSort, "SufficeIndicator", " And SufficeStandardID = '" + ddlSufficeStandard.SelectedValue + "' ");
    }
    protected void ddlSufficeSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSufficeStandard(1, ddlSufficeSide.SelectedValue);
        btc.GenSort(txtSort, "SufficeIndicator", " And SufficeStandardID = '" + ddlSufficeStandard.SelectedValue + "' ");
    }
    protected void ddlSufficeStandard_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "SufficeIndicator", " And SufficeStandardID = '" + ddlSufficeStandard.SelectedValue + "' ");
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
}
