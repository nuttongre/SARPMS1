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

public partial class IndicatorSMS : System.Web.UI.Page
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
            btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "IndicatorSMS", ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        btc.GenSort(txtSort, "IndicatorSMS", " And StudyYear = '" + ddlYearB.SelectedValue + "' ");
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
                        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "IndicatorSMS", ddlSearchYear.SelectedValue);
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
        txtIndicatorSMS.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
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
        string StrSql = " Select IndicatorSMSCode, IndicatorSMSName, Sort "
                    + " From IndicatorSMS "
                    + " Where DelFlag = 0 And StudyYear = '" + ddlSearchYear.SelectedValue + "' ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And IndicatorSMSName Like '%" + txtSearch.Text + "%' Or Sort Like '%" + txtSearch.Text + "%'  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By Sort Asc "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From IndicatorSMS Where IndicatorSMSCode = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            txtIndicatorSMS.Text = dv[0]["IndicatorSMSName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "IndicatorSMS", "IndicatorSMSCode", id);
    }
    private void ClearAll()
    {
        txtIndicatorSMS.Text = "";
        txtSearch.Text = "";
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
            i = Conn.AddNew("IndicatorSMS", "IndicatorSMSCode, StudyYear, IndicatorSMSName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlYearB.SelectedValue, txtIndicatorSMS.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            if (CkAgain == "N")
            {
                Response.Redirect("IndicatorSMS.aspx?ckmode=1&Cr=" + i);
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "IndicatorSMS", " And StudyYear = '" + ddlYearB.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("IndicatorSMS", "Where IndicatorSMSCode = '" + Request["id"] + "' ", "StudyYear, IndicatorSMSName, Sort, UpdateUser, UpdateDate", ddlYearB.SelectedValue, txtIndicatorSMS.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("IndicatorSMS.aspx?ckmode=2&Cr=" + i);
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
        if (btc.CkUseData(id, "IndicatorSMSCode", "dtIndicatorSMS", ""))
        {
            Response.Redirect("IndicatorSMS.aspx?ckmode=3&Cr=0");
        }
        else
        {
            Int32 i = Conn.Update("IndicatorSMS", "Where IndicatorSMSCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("IndicatorSMS.aspx?ckmode=3&Cr=" + i);
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "IndicatorSMS", ddlSearchYear.SelectedValue);
        btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "IndicatorSMS", " And StudyYear = '" + ddlYearB.SelectedValue + "'");
    }
    protected void btCopy_Click(object sender, EventArgs e)
    {
        if (btc.CkDataDuplicate(ddlSearchYear.SelectedValue, "IndicatorSMS"))
        {
            Response.Redirect("IndicatorSMS.aspx?ckmode=7&Cr=0");
        }
        string strSql = " Select IndicatorSMSCode, StudyYear, IndicatorSMSName, Sort From IndicatorSMS Where DelFlag = 0 And StudyYear = '" + ddlOldYear.SelectedValue + "' Order By Sort ";
        DataView dvIndicatorSMS = Conn.Select(strSql);
        Int32 x = 0;
        if (dvIndicatorSMS.Count != 0)
        {
            for (int i = 0; i < dvIndicatorSMS.Count; i++)
            {
                string NewID = Guid.NewGuid().ToString();
                x += Conn.AddNew("IndicatorSMS", "IndicatorSMSCode, StudyYear, IndicatorSMSName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlSearchYear.SelectedValue, dvIndicatorSMS[i]["IndicatorSMSName"].ToString(), dvIndicatorSMS[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            }
            Response.Redirect("IndicatorSMS.aspx?ckmode=1&Cr=" + x);
        }
        else
        {
            Response.Redirect("IndicatorSMS.aspx?ckmode=6&Cr=0");
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
