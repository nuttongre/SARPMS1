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
using System.Globalization;

public partial class Strategies : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    DataView dvIndicators;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }

            //àªç¤»Õ§º»ÃÐÁÒ³
            btc.ckBudgetYear(lblSearchYear, lblYear);

            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        btc.GenSort(txtSort, "Strategies", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        break;
                }
            }
            else
            {
                getddlYear(0);
                btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "Strategies", ddlSearchYear.SelectedValue);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtStrategies.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
        txtIndicators2.Attributes.Add("onkeyup", "ckAddIndicators();");
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
            btc.getdllStudyYear(ddlYearS);
            btc.getDefault(ddlYearS, "StudyYear", "StudyYear");
        }
    } 
    private void ckAdmission(Star.Web.UI.Controls.DataGridView GridView1, Button btAdd)
    {
        DataView dv = btc.getAdmission(CurrentUser.UserRoleID);
        if (dv.Count != 0)
        {
            if (Convert.ToInt32(dv[0]["IsAdmin"]) == 1)
            {
            }
            else
            {
                if (btAdd != null)
                {
                    btAdd.Visible = false;
                }
                if (GridView1 != null)
                {
                    GridView1.Columns[GridView1.Columns.Count - 2].Visible = false;
                    GridView1.Columns[GridView1.Columns.Count - 3].Visible = false;
                }
            }

        }
    }
    public override void DataBind()
    {
        string StrSql = " Select a.StrategiesCode, a.StudyYear, a.StrategiesName, a.Df, a.Sort "
                + " From Strategies a Left Join Projects b On a.StrategiesCode = b.StrategiesCode And b.DelFlag = 0 "
                + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
                + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And a.StrategiesName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort"));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From Strategies Where StrategiesCode = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearS.SelectedValue = dv[0]["StudyYear"].ToString();
            txtStrategies.Text = dv[0]["StrategiesName"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Strategies", "StrategiesCode", id);

            string strSql = " Select CorporateStrategyID, Sort As id, CorporateStrategyName "
                + " From CorporateStrategy "
                + " Where StrategiesCode = '{0}' ";
            dvIndicators = Conn.Select(string.Format(strSql + " Order By Sort ", id));

            if (dvIndicators.Count != 0)
            {
                btDelIndicators.Visible = true;
                if (Session["IndicatorsSuccess"] == null)
                {
                    DataTable dt1 = new DataTable();
                    dt1.Columns.Add("id");
                    dt1.Columns.Add("IndicatorsName");

                    DataRow dr;
                    for (int i = 0; i < dvIndicators.Count; i++)
                    {
                        dr = dt1.NewRow();
                        dr["id"] = dvIndicators[i]["id"].ToString();
                        dr["IndicatorsName"] = dvIndicators[i]["CorporateStrategyName"].ToString();
                        dt1.Rows.Add(dr);
                    }
                    dvIndicators = dt1.DefaultView;
                    Session["IndicatorsSuccess"] = dt1;
                }
                GridViewIndicators.Visible = true;
                GridViewIndicators.DataSource = dvIndicators;
                GridViewIndicators.CheckListDataField = "id";
                GridViewIndicators.DataBind();
            }
            else
            {
                btDelIndicators.Visible = false;
                GridViewIndicators.Visible = false;
            }
        }
    }
    private void ClearAll()
    {
        Session.Remove("IndicatorsSuccess");

        txtStrategies.Text = "";
        txtSearch.Text = "";
        GridViewIndicators.DataSource = null;
        GridViewIndicators.DataBind();
        btDelIndicators.Visible = false;
        GridViewIndicators.Visible = false;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        int result = 0;
        StringBuilder strbSql = new StringBuilder();
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            strbSql.AppendFormat("INSERT INTO Strategies (StrategiesCode, StudyYear, StrategiesName, Sort, Df, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate)VALUES('{0}','{1}','{2}',{3},{4},{5},'{6}','{7}','{8}','{9}','{10}');",
                NewID, ddlYearS.SelectedValue, txtStrategies.Text, txtSort.Text, 1, 0, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");


            //IndicatorsSuccess
            if (Session["IndicatorsSuccess"] != null)
            {
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["IndicatorsSuccess"];
                dvIndicators = dt1.DefaultView;
                for (int j = 0; j < dvIndicators.Count; j++)
                {
                    strbSql.AppendFormat("INSERT INTO CorporateStrategy (CorporateStrategyID, StudyYear, CorporateStrategyName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, StrategiesCode)VALUES('{0}','{1}','{2}',{3},{4},'{5}','{6}','{7}','{8}','{9}');",
                        Guid.NewGuid().ToString(), ddlYearS.SelectedValue, dvIndicators[j]["IndicatorsName"].ToString(), Convert.ToDecimal(dvIndicators[j]["id"]), 0, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", NewID);
                }
            }
            result = Conn.Execute(strbSql.ToString());
            if (CkAgain == "N")
            {
                btc.Msg_Head(Img1, MsgHead, true, "1", result);
                Response.Redirect("Strategies.aspx?ckmode=1&Cr=" + result);  
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", result);
                ClearAll();
                btc.GenSort(txtSort, "Strategies", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
                GridView2.Visible = true;
                DataBind();
            }         
        }
        if (Request.QueryString["mode"] == "2")
        {
            Int32 i = 0;
            i = Conn.Update("Strategies", "Where StrategiesCode = '" + Request.QueryString["id"] + "' ", "StudyYear, StrategiesName, Sort, SchoolID, UpdateUser, UpdateDate", ddlYearS.SelectedValue, txtStrategies.Text, txtSort.Text, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now);
            //IndicatorsSuccess
            if (Session["IndicatorsSuccess"] != null)
            {
                Conn.Delete("CorporateStrategy", "Where StrategiesCode = '" + Request.QueryString["id"] + "'");
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["IndicatorsSuccess"];
                dvIndicators = dt1.DefaultView;
                for (int j = 0; j < dvIndicators.Count; j++)
                {
                    strbSql.AppendFormat("INSERT INTO CorporateStrategy (CorporateStrategyID, StudyYear, CorporateStrategyName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, StrategiesCode)VALUES('{0}',{1},'{2}',{3},{4},'{5}','{6}','{7}','{8}','{9}');",
                    Guid.NewGuid().ToString(), ddlYearS.SelectedValue, dvIndicators[j]["IndicatorsName"].ToString(), Convert.ToDecimal(dvIndicators[j]["id"]), 0, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", Request.QueryString["id"]);
                }
                result = Conn.Execute(strbSql.ToString());
            }
            Response.Redirect("Strategies.aspx?ckmode=2&Cr=" + i); 
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
        Int32 i = 0;
        if (String.IsNullOrEmpty(id)) return;
        if (btc.CkUseData(id, "StrategiesCode", "Projects", "And DelFlag = 0"))
        {
            Response.Redirect("Strategies.aspx?ckmode=3&Cr=0");
        }
        else
        {
            i = Conn.Update("Strategies", "Where StrategiesCode = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Conn.Delete("StrategiesIndicators", "Where StrategiesCode = '" + Request.QueryString["id"] + "'");
            Response.Redirect("Strategies.aspx?ckmode=3&Cr=" + i);  
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "Strategies", ddlSearchYear.SelectedValue);
        btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearS_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Strategies", " And StudyYear = '" + ddlYearS.SelectedValue + "' And SchoolID = '" + CurrentUser.SchoolID + "' ");
    }
    protected void btaddIndicators_Click(object sender, EventArgs e)
    {
        if (Session["IndicatorsSuccess"] == null)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("id");
            dt1.Columns.Add("IndicatorsName");

            DataRow dr;
            dr = dt1.NewRow();
            dr["id"] = dr.Table.Rows.Count;
            dr["IndicatorsName"] = txtIndicators2.Text;
            dt1.Rows.Add(dr);

            dvIndicators = dt1.DefaultView;
            Session["IndicatorsSuccess"] = dt1;
        }
        else
        {
            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["IndicatorsSuccess"];

            if (txtid.Text == "")
            {
                DataView ckdv = ((DataTable)Session["IndicatorsSuccess"]).DefaultView;
                DataRow dr;
                dr = dt1.NewRow();
                dr["id"] = dr.Table.Rows.Count;
                dr["IndicatorsName"] = txtIndicators2.Text;
                dt1.Rows.Add(dr);
            }
            else
            {
                Int32 i = Convert.ToInt32(txtid.Text);
                dt1.Rows[i]["IndicatorsName"] = txtIndicators2.Text;
            }

            dvIndicators = dt1.DefaultView;
            Session["IndicatorsSuccess"] = dt1;
        }
        //dvBudget.Sort = "YearE DESC";
        ClearIndicators();
        GridViewIndicators.DataSource = dvIndicators;
        GridViewIndicators.CheckListDataField = "id";
        GridViewIndicators.DataBind();
        if (dvIndicators.Count > 0)
        {
            btDelIndicators.Visible = true;
            GridViewIndicators.Visible = true;
        }
    }
    private void ClearIndicators()
    {
        txtid.Text = "";
        txtIndicators2.Text = "";
    }
    protected void btDelIndicators_Click(object sender, EventArgs e)
    {
        if (GridViewIndicators.SelectedItems.Length == 0) return;
        DataTable dt1 = new DataTable();
        dt1 = (DataTable)Session["IndicatorsSuccess"];
        DataRow[] dra = dt1.Select("id in (" + string.Join(",", GridViewIndicators.SelectedItems) + ")");
        foreach (DataRow dr in dra)
            dr.Delete();
        dt1.AcceptChanges();
        dvIndicators = dt1.DefaultView;
        Session["IndicatorsSuccess"] = dt1;
        GridViewIndicators.DataSource = dvIndicators;
        GridViewIndicators.DataBind();
        if (dvIndicators.Count == 0)
        {
            btDelIndicators.Visible = false;
        }
    }
    protected void btCopy_Click(object sender, EventArgs e)
    {
        StringBuilder strbSql = new StringBuilder();
        int result = 0;

        if (btc.CkDataDuplicate(ddlSearchYear.SelectedValue, "Strategies"))
        {
            btc.Msg_Head(Img1, MsgHead, true, "7", 0);
            return;
        }
        string strSql = " Select StrategiesCode, StudyYear, StrategiesName, Sort From Strategies Where DelFlag = 0 And StudyYear = '" + ddlOldYear.SelectedValue + "' Order By Sort ";
        DataView dvStrategies = Conn.Select(strSql);

        if (dvStrategies.Count != 0)
        {
            for (int i = 0; i < dvStrategies.Count; i++)
            {
                string NewID = Guid.NewGuid().ToString();
                Int32 x = Conn.AddNew("Strategies", "StrategiesCode, StudyYear, StrategiesName, Sort, Df, DelFlag, SchoolID, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                    NewID, ddlSearchYear.SelectedValue, dvStrategies[i]["StrategiesName"].ToString(), dvStrategies[i]["Sort"].ToString(), 0, 0, CurrentUser.SchoolID, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                strSql = "Select * From StrategiesIndicators Where StrategiesCode = '" + dvStrategies[i]["StrategiesCode"].ToString() + "'";
                DataView dvStrategiesIndicators = Conn.Select(strSql);

                if (dvStrategiesIndicators.Count != 0)
                {
                    for (int j = 0; j < dvStrategiesIndicators.Count; j++)
                    {
                        strbSql.AppendFormat("INSERT INTO StrategiesIndicators (StrategiesCode, RecNum, IndicatorsName) VALUES ('{0}',{1},'{2}');",
                            NewID, Convert.ToDecimal(dvStrategiesIndicators[j]["RecNum"]), dvStrategiesIndicators[j]["IndicatorsName"].ToString());
                    }
                }

                strSql = "Select * From CorporateStrategy Where DelFlag = 0 And StrategiesCode = '" + dvStrategies[i]["StrategiesCode"].ToString() + "'";
                DataView dvCorporateStrategy = Conn.Select(strSql);

                if (dvCorporateStrategy.Count != 0)
                {
                    for (int j = 0; j < dvCorporateStrategy.Count; j++)
                    {
                        strbSql.AppendFormat("INSERT INTO CorporateStrategy (CorporateStrategyID, StudyYear, CorporateStrategyName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, StrategiesCode)VALUES('{0}',{1},'{2}',{3},{4},'{5}','{6}','{7}','{8}','{9}');",
                            Guid.NewGuid().ToString(), Convert.ToInt32(ddlSearchYear.SelectedValue), dvCorporateStrategy[j]["CorporateStrategyName"].ToString(), Convert.ToDecimal(dvCorporateStrategy[j]["Sort"]), 0, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000", NewID);
                    }
                }
            }
            result = Conn.Execute(strbSql.ToString());
            btc.Msg_Head(Img1, MsgHead, true, "1", 1);
            btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "Strategies", ddlSearchYear.SelectedValue);
            DataBind();
        }
        else
        {
            btc.Msg_Head(Img1, MsgHead, true, "6", 0);
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
}
