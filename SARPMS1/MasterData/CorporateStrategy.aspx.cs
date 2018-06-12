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

public partial class CorporateStrategy : System.Web.UI.Page
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

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlStrategies(1, ddlYearB.SelectedValue);
                        btc.GenSort(txtSort, "CorporateStrategy", " And StrategiesCode = '" + ddlStrategies.SelectedValue + "' ");
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
                        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "CorporateStrategy", ddlSearchYear.SelectedValue);
                        break;
                }
            }
            else
            {
                getddlYear(0);
                getddlStrategies(0, ddlSearchYear.SelectedValue);
                btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "CorporateStrategy", ddlSearchYear.SelectedValue);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtCorporateStrategy.Attributes.Add("onkeyup", "Cktxt(0);");
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
    private void getddlStrategies(int mode, string StudyYear)
    {
        if (mode == 0)
        {
            btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));
            if (Cookie.GetValue2("CprStrategies") == null)
            {
                ddlSearch2.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddlSearch2.SelectedValue = Cookie.GetValue2("CprStrategies").ToString();
                }
                catch (Exception ex)
                {
                    ddlSearch2.SelectedIndex = 0;
                }
            }
        }

        if (mode == 1)
        {
            btc.getddlStrategies(1, ddlStrategies, StudyYear, null);
        }
    }

    public override void DataBind()
    {
        string StrSql = @" Select a.CorporateStrategyID, a.CorporateStrategyName, a.Sort 
                        From CorporateStrategy a 
                        Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
        if (ddlSearch2.SelectedIndex != 0)
        {
            StrSql += " And StrategiesCode = '" + ddlSearch2.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.CorporateStrategyName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From CorporateStrategy Where CorporateStrategyID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            getddlStrategies(1, ddlYearB.SelectedValue);
            ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            txtCorporateStrategy.Text = dv[0]["CorporateStrategyName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "CorporateStrategy", "CorporateStrategyID", id);
        }
    }
    private void ClearAll()
    {
        txtCorporateStrategy.Text = "";
        txtSearch.Text = "";
        txtDetail.Text = "";
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
            i = Conn.AddNew("CorporateStrategy", "CorporateStrategyID, StudyYear, StrategiesCode, CorporateStrategyName, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, ddlYearB.SelectedValue, ddlStrategies.SelectedValue, txtCorporateStrategy.Text, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("CorporateStrategy.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "CorporateStrategy", " And StrategiesCode = '" + ddlStrategies.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("CorporateStrategy", "Where CorporateStrategyID = '" + Request["id"] + "' ", "StudyYear, StrategiesCode, CorporateStrategyName, Detail, Sort, UpdateUser, UpdateDate", 
                ddlYearB.SelectedValue, ddlStrategies.SelectedValue, txtCorporateStrategy.Text, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("CorporateStrategy.aspx?ckmode=2&Cr=" + i);    
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
        if (btc.CkUseData(id, "CorporateStrategyID", "Projects", ""))
        {
            Response.Redirect("CorporateStrategy.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("CorporateStrategy", "Where CorporateStrategyID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("CorporateStrategy.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "CorporateStrategy", ddlSearchYear.SelectedValue);
        btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "CorporateStrategy", " And StrategiesCode = '" + ddlStrategies.SelectedValue + "'");
    }
    protected void btCopy_Click(object sender, EventArgs e)
    {
        if (btc.CkDataDuplicate(ddlSearchYear.SelectedValue, "CorporateStrategy"))
        {
            Response.Redirect("CorporateStrategy.aspx?ckmode=7&Cr=0");
        }
        string strSql = " Select CorporateStrategyID, StudyYear, CorporateStrategyName, Detail, Sort From CorporateStrategy Where DelFlag = 0 And StudyYear = '" + ddlOldYear.SelectedValue + "' Order By Sort ";
        DataView dvCorporateStrategy = Conn.Select(strSql);
        Int32 x = 0;
        if (dvCorporateStrategy.Count != 0)
        {
            for (int i = 0; i < dvCorporateStrategy.Count; i++)
            {
                string NewID = Guid.NewGuid().ToString();
                x += Conn.AddNew("CorporateStrategy", "CorporateStrategyID, StudyYear, CorporateStrategyName, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, ddlSearchYear.SelectedValue, dvCorporateStrategy[i]["CorporateStrategyName"].ToString(), dvCorporateStrategy[i]["Detail"].ToString(), dvCorporateStrategy[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            }
            Response.Redirect("CorporateStrategy.aspx?ckmode=1&Cr=" + x);
        }
        else
        {
            Response.Redirect("CorporateStrategy.aspx?ckmode=6&Cr=0");
        }
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
    protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
        DataBind();
    }
    protected void ddlStrategies_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "CorporateStrategy", " And StrategiesCode = '" + ddlStrategies.SelectedValue + "' ");
    }
}
