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

public partial class FourthAssessmentIndicator : System.Web.UI.Page
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
            getddlFourthAssessmentSide(0, ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlFourthAssessmentSide(1, ddlYearB.SelectedValue);
                        btc.GenSort(txtSort, "FourthAssessmentIndicator", " And FourthAssessmentSideID = '" + ddlFourthAssessmentSide.SelectedValue + "' ");
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
        txtFourthAssessmentIndicator.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlFourthAssessmentSide.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlFourthAssessmentSide(int mode, string StudyYear)
    {
        DataView dv = Conn.Select("Select FourthAssessmentSideID, Cast(Sort as nvarchar) + ' - ' + FourthAssessmentSideName FullName, Sort From FourthAssessmentSide Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "FourthAssessmentSideID";
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
                ddlFourthAssessmentSide.DataSource = dv;
                ddlFourthAssessmentSide.DataTextField = "FullName";
                ddlFourthAssessmentSide.DataValueField = "FourthAssessmentSideID";
                ddlFourthAssessmentSide.DataBind();
                ddlFourthAssessmentSide.Enabled = true;
                ddlFourthAssessmentSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlFourthAssessmentSide.SelectedIndex = 0;
            }
            else
            {
                ddlFourthAssessmentSide.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlFourthAssessmentSide.SelectedIndex = 0;
                ddlFourthAssessmentSide.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select b.FourthAssessmentIndicatorID, b.FourthAssessmentIndicatorName, Cast(a.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) As Sort1 
                        From FourthAssessmentSide a Inner Join FourthAssessmentIndicator b On a.FourthAssessmentSideID = b.FourthAssessmentSideID
                        Where b.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And b.FourthAssessmentSideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (b.FourthAssessmentIndicatorName Like '%" + txtSearch.Text + "%' Or b.Sort Like '%" + txtSearch.Text + "%')  ";
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
        string strSql = @" Select b.*, a.StudyYear From FourthAssessmentSide a, FourthAssessmentIndicator b 
                Where b.FourthAssessmentIndicatorID = '{0}' And a.FourthAssessmentSideID = b.FourthAssessmentSideID ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlFourthAssessmentSide(1, ddlYearB.SelectedValue);          
            ddlFourthAssessmentSide.SelectedValue = dv[0]["FourthAssessmentSideID"].ToString();
            txtFourthAssessmentIndicator.Text = dv[0]["FourthAssessmentIndicatorName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "FourthAssessmentIndicator", "FourthAssessmentIndicatorID", id);
    }
    private void ClearAll()
    {
        txtFourthAssessmentIndicator.Text = "";
        ddlFourthAssessmentSide.SelectedIndex = 0;
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
            i = Conn.AddNew("FourthAssessmentIndicator", "FourthAssessmentIndicatorID, FourthAssessmentIndicatorName, FourthAssessmentSideID, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtFourthAssessmentIndicator.Text, ddlFourthAssessmentSide.SelectedValue, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("FourthAssessmentIndicator.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "FourthAssessmentIndicator", " And FourthAssessmentSideID = '" + ddlFourthAssessmentSide.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("FourthAssessmentIndicator", "Where FourthAssessmentIndicatorID = '" + Request["id"] + "' ", "FourthAssessmentIndicatorName, FourthAssessmentSideID, Detail, Sort, UpdateUser, UpdateDate", 
                txtFourthAssessmentIndicator.Text, ddlFourthAssessmentSide.SelectedValue, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("FourthAssessmentIndicator.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "FourthAssessmentIndicatorID", "dtFourthAssessment", ""))
        {
            Response.Redirect("FourthAssessmentIndicator.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("FourthAssessmentIndicator", "Where FourthAssessmentIndicatorID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("FourthAssessmentIndicator.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlFourthAssessmentSide(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlFourthAssessmentSide(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "FourthAssessmentIndicator", " And FourthAssessmentSideID = '" + ddlFourthAssessmentSide.SelectedValue + "'");
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
    protected void ddlFourthAssessmentSide_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "FourthAssessmentIndicator", " And FourthAssessmentSideID = '" + ddlFourthAssessmentSide.SelectedValue + "'");
    }
}
