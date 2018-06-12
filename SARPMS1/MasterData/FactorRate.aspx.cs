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

public partial class FactorRate : System.Web.UI.Page
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

            //àªç¤»Õ§º»ÃÐÁÒ³
            btc.ckBudgetYear(lblSearchYear, lblYear);

            getddlYear(0);
            btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "FactorRate", ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
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
        txtDetail.Attributes.Add("onkeyup", "Cktxt(0);");
        txtCriterion.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTranslation.Attributes.Add("onkeyup", "Cktxt(0);");
        txtMin.Attributes.Add("onkeyup", "Cktxt(0);");
        txtMax.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
            btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string StrSql = "Select FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax From FactorRate Where DelFlag = 0 ";
        if (ddlSearchYear.SelectedIndex != 0)
        {
            StrSql = StrSql + " And StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And ( TMin Like '%" + txtSearch.Text + "%' OR TMax Like '%" + txtSearch.Text + "%' ) ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By StudyYear, Criterion"));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select FactorRateID, StudyYear, Detail, Criterion, Translation, IsNull(TMin, 0) TMin, IsNull(TMax, 0) TMax From FactorRate Where DelFlag = 0 And FactorRateID = '" + id + "' "));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtCriterion.Text = dv[0]["Criterion"].ToString();
            txtTranslation.Text = dv[0]["Translation"].ToString();
            txtMin.Text = Convert.ToDouble(dv[0]["TMin"]).ToString("#,##0.00");
            txtMax.Text = Convert.ToDouble(dv[0]["TMax"]).ToString("#,##0.00");
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "FactorRate", "FactorRateID", id);
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
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "FactorRate", ddlSearchYear.SelectedValue);
        btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            Int32 i = Conn.AddNew("FactorRate", "FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlYearB.SelectedValue, txtDetail.Text, txtCriterion.Text, txtTranslation.Text, txtMin.Text, txtMax.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (CkAgain == "N")
            {
                Response.Redirect("FactorRate.aspx?ckmode=1&Cr=" + i);
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
            ddlYearB.Enabled = false;
            Int32 i = Conn.Update("FactorRate", "Where FactorRateID = '" + Request["id"] + "' ", "Detail, Criterion, Translation, TMin, TMax, UpdateUser, UpdateDate", txtDetail.Text, txtCriterion.Text, txtTranslation.Text, txtMin.Text, txtMax.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("FactorRate.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "FactorRateID", "Activity", "And DelFlag = 0"))
        {
            Response.Redirect("FactorRate.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("FactorRate", "Where FactorRateID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("FactorRate.aspx?ckmode=3&Cr=" + i); 
        }  
    }
    protected void btCopy_Click(object sender, EventArgs e)
    {
        if (btc.CkDataDuplicate(ddlSearchYear.SelectedValue, "FactorRate"))
        {
            Response.Redirect("FactorRate.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = " Select FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax From FactorRate Where DelFlag = 0 And StudyYear = '" + ddlOldYear.SelectedValue + "' Order By Criterion ";
        DataView dvFactor = Conn.Select(strSql);
        Int32 x = 0;
        if (dvFactor.Count != 0)
        {
            for (int i = 0; i < dvFactor.Count; i++)
            {
                string NewID = Guid.NewGuid().ToString();
                x += Conn.AddNew("FactorRate", "FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlSearchYear.SelectedValue, dvFactor[i]["Detail"].ToString(), dvFactor[i]["Criterion"].ToString(), dvFactor[i]["Translation"].ToString(), dvFactor[i]["TMin"].ToString(), dvFactor[i]["TMax"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            }
            Response.Redirect("FactorRate.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("FactorRate.aspx?ckmode=6&Cr=0"); 
        }
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
