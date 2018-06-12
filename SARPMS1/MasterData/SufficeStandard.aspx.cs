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

public partial class SufficeStandard : System.Web.UI.Page
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
            getddlSufficeSide(0, ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlSufficeSide(1, ddlYearB.SelectedValue);
                        btc.GenSort(txtSort, "SufficeStandard", " And SufficeSideID = '" + ddlSufficeSide.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
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
        txtSufficeStandard.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlSufficeSide.Attributes.Add("onchange", "Cktxt(0);");
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
    public override void DataBind()
    {
        string StrSql = @" Select a.SufficeStandardID, a.SufficeStandardName, Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1
                        From SufficeStandard a Inner Join SufficeSide b On a.SufficeSideID = b.SufficeSideID
                        Where a.DelFlag = 0 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.SufficeSideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.SufficeStandardName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
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
        string strSql = @"Select SD.*, S.StudyYear From SufficeSide S, SufficeStandard SD 
                Where SD.SufficeStandardID = '{0}' And S.SufficeSideID = SD.SufficeSideID ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlSufficeSide(1, ddlYearB.SelectedValue);          
            ddlSufficeSide.SelectedValue = dv[0]["SufficeSideID"].ToString();
            txtSufficeStandard.Text = dv[0]["SufficeStandardName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "SufficeStandard", "SufficeStandardID", id);
    }
    private void ClearAll()
    {
        txtSufficeStandard.Text = "";
        ddlSufficeSide.SelectedIndex = 0;
        txtDetail.Text = "";
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
            i = Conn.AddNew("SufficeStandard", "SufficeStandardID, SufficeStandardName, SufficeSideID, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtSufficeStandard.Text, ddlSufficeSide.SelectedValue, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("SufficeStandard.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "SufficeStandard", " And SufficeSideID = '" + ddlSufficeSide.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("SufficeStandard", "Where SufficeStandardID = '" + Request["id"] + "' ", "SufficeStandardName, SufficeSideID, Detail, Sort, UpdateUser, UpdateDate", 
                txtSufficeStandard.Text, ddlSufficeSide.SelectedValue, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SufficeStandard.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "SufficeStandardID", "SufficeIndicator", "And DelFlag = 0"))
        {
            Response.Redirect("SufficeStandard.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("SufficeStandard", "Where SufficeStandardID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("SufficeStandard.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlSufficeSide(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlSufficeSide(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "SufficeStandard", " And SufficeSideID = '" + ddlSufficeSide.SelectedValue + "'");
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
    protected void ddlSufficeSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "SufficeStandard", " And SufficeSideID = '" + ddlSufficeSide.SelectedValue + "'");
    }
}
