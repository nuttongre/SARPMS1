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

public partial class Education21Indicator : System.Web.UI.Page
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
            getddlEvaluateType(0);
            getddlEducation21Side(0, ddlSearchYear.SelectedValue);
            getddlEducation21Standard(0, ddlSearchStandard.SelectedValue);
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
                        getddlEvaluateType(1);
                        getddlCriterionSort();
                        getddlEducation21Side(1, ddlYearB.SelectedValue);
                        getddlEducation21Standard(1, ddlEducation21Standard.SelectedValue);
                        btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        ClearAll();
                        getddlYear(1);
                        getddlEvaluateType(1);
                        getddlCriterionSort();
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
        txtEducation21Indicator.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlEducation21Side.Attributes.Add("onchange", "Cktxt(0);");
        ddlEducation21Standard.Attributes.Add("onchange", "Cktxt(0);");
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
    private void getddlEvaluateType(int mode)
    {
        if (mode == 0)
        {
            ddlSearchEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
            ddlSearchEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
            ddlSearchEvaluateType.DataBind();
            //ddlSearchEvaluateType.SelectedIndex = 0;

            if (Cookie.GetValue2("EvaluateType") == null)
            {
                ddlSearchEvaluateType.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddlSearchEvaluateType.SelectedValue = Cookie.GetValue2("EvaluateType").ToString();
                }
                catch (Exception ex)
                {
                    ddlSearchEvaluateType.SelectedIndex = 0;
                }
            }
        }

        if (mode == 1)
        {
            ddlEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
            ddlEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
            ddlEvaluateType.DataBind();
            ddlEvaluateType.SelectedIndex = 0;
        }
    }
    private void getddlEducation21Side(int mode, string StudyYear)
    {
        string strSql = @"Select Education21SideID, Cast(Sort as nvarchar) + ' - ' + Education21SideName FullName, Sort 
            From Education21Side Where DelFlag = 0 And StudyYear = '{0}' And EvaluateType = '{1}' Order By Sort";

        if (mode == 0)
        {
            DataView dv = Conn.Select(string.Format(strSql, StudyYear, ddlSearchEvaluateType.SelectedValue));
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "Education21SideID";
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
            DataView dv = Conn.Select(string.Format(strSql, StudyYear, ddlEvaluateType.SelectedValue));
            if (dv.Count != 0)
            {
                ddlEducation21Side.DataSource = dv;
                ddlEducation21Side.DataTextField = "FullName";
                ddlEducation21Side.DataValueField = "Education21SideID";
                ddlEducation21Side.DataBind();
                ddlEducation21Side.Enabled = true;
                ddlEducation21Side.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Side.SelectedIndex = 0;
            }
            else
            {
                ddlEducation21Side.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Side.SelectedIndex = 0;
                ddlEducation21Side.Enabled = false;
            }
        }
    }
    private void getddlEducation21Standard(int mode, string Education21SideID)
    {
        DataView dv = Conn.Select("Select Education21StandardID, Cast(Sort as nvarchar) + ' - ' + Education21StandardName FullName, Sort From Education21Standard Where DelFlag = 0 And Education21SideID = '" + Education21SideID + "' Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearchStandard.DataSource = dv;
                ddlSearchStandard.DataTextField = "FullName";
                ddlSearchStandard.DataValueField = "Education21StandardID";
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
                ddlEducation21Standard.DataSource = dv;
                ddlEducation21Standard.DataTextField = "FullName";
                ddlEducation21Standard.DataValueField = "Education21StandardID";
                ddlEducation21Standard.DataBind();
                ddlEducation21Standard.Enabled = true;
                ddlEducation21Standard.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Standard.SelectedIndex = 0;
            }
            else
            {
                ddlEducation21Standard.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Standard.SelectedIndex = 0;
                ddlEducation21Standard.Enabled = false;
            }
        }
    }
    private void getddlCriterionSort()
    {
        ddlCriterionSort.Items.Insert(0, new ListItem("1", "1"));
        ddlCriterionSort.Items.Insert(1, new ListItem("2", "2"));
        ddlCriterionSort.Items.Insert(2, new ListItem("3", "3"));
        ddlCriterionSort.DataBind();
        ddlCriterionSort.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.Education21IndicatorID, a.Education21IndicatorName, Cast(c.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1
                        From Education21Indicator a, Education21Standard b, Education21Side c  
                        Where a.DelFlag = 0 And c.Education21SideID = b.Education21SideID And b.Education21StandardID = a.Education21StandardID
                        And c.StudyYear = '" + ddlSearchYear.SelectedValue + "' And c.EvaluateType = '" + ddlSearchEvaluateType.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And c.Education21SideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearchStandard.SelectedIndex != 0)
        {
            StrSql = StrSql + " And b.Education21StandardID = '" + ddlSearchStandard.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.Education21IndicatorName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
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
        string strSql = @"Select SI.*, S.StudyYear, S.EvaluateType, SD.Education21SideID From Education21Side S, Education21Standard SD, Education21Indicator SI
                Where SI.Education21IndicatorID = '{0}' And S.Education21SideID = SD.Education21SideID And SD.Education21StandardID = SI.Education21StandardID ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlEvaluateType.SelectedValue = dv[0]["EvaluateType"].ToString();
            getddlEducation21Side(1, ddlYearB.SelectedValue);          
            ddlEducation21Side.SelectedValue = dv[0]["Education21SideID"].ToString();
            getddlEducation21Standard(1, ddlEducation21Side.SelectedValue);
            ddlEducation21Standard.SelectedValue = dv[0]["Education21StandardID"].ToString();
            txtEducation21Indicator.Text = dv[0]["Education21IndicatorName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();

            strSql = " Select RecNum As id, Education21CriterionID, Sort, Detail, Score "
                + " From Education21Criterion "
                + " Where Education21IndicatorID = '{0}' ";
            dvCriterion = Conn.Select(string.Format(strSql + " Order By Sort ", id));

            if (dvCriterion.Count != 0)
            {
                btDelCriterion.Visible = true;
                if (Session["Criterion"] == null)
                {
                    DataTable dt1 = new DataTable();
                    dt1.Columns.Add("id");
                    dt1.Columns.Add("Education21CriterionID");
                    dt1.Columns.Add("Sort");
                    dt1.Columns.Add("Detail");
                    dt1.Columns.Add("Score");

                    DataRow dr;
                    for (int i = 0; i < dvCriterion.Count; i++)
                    {
                        dr = dt1.NewRow();
                        dr["id"] = dvCriterion[i]["id"].ToString();
                        dr["Education21CriterionID"] = dvCriterion[i]["Education21CriterionID"].ToString();
                        dr["Sort"] = dvCriterion[i]["Sort"].ToString();
                        dr["Detail"] = dvCriterion[i]["Detail"].ToString();
                        dr["Score"] = dvCriterion[i]["Score"].ToString();
                        dt1.Rows.Add(dr);
                    }
                    dvCriterion = dt1.DefaultView;
                    Session["Criterion"] = dt1;
                }
                GridViewCriterion.Visible = true;
                GridViewCriterion.DataSource = dvCriterion;
                GridViewCriterion.CheckListDataField = "id";
                GridViewCriterion.DataBind();
            }
            else
            {
                btDelCriterion.Visible = false;
                GridViewCriterion.Visible = false;
            }
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Education21Indicator", "Education21IndicatorID", id);
    }
    private void ClearAll()
    {
        Session.Remove("Criterion");
        txtEducation21Indicator.Text = "";
        //ddlEducation21Side.SelectedIndex = 0;
        //ddlEducation21Standard.SelectedIndex = 0;
        txtDetail.Text = "";
        txtSearch.Text = "";

        GridViewCriterion.DataSource = null;
        GridViewCriterion.DataBind();
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
            i = Conn.AddNew("Education21Indicator", "Education21IndicatorID, Education21IndicatorName, Education21StandardID, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", 
                NewID, txtEducation21Indicator.Text, ddlEducation21Standard.SelectedValue, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

            //Criterion
            if (Session["Criterion"] != null)
            {
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["Criterion"];
                dvCriterion = dt1.DefaultView;
                for (int j = 0; j < dvCriterion.Count; j++)
                {
                    strbSql.AppendFormat("INSERT INTO Education21Criterion (Education21CriterionID, Education21IndicatorID, Detail, Score, Sort, RecNum, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',{3},{4},{5},'{6}','{7}');",
                        Guid.NewGuid().ToString(), NewID, dvCriterion[j]["Detail"].ToString().Trim(), dvCriterion[j]["Score"].ToString(), dvCriterion[j]["Sort"].ToString(), dvCriterion[j]["id"].ToString(), DateTime.Now.ToString("s"), CurrentUser.ID);
                }
            }
            result = Conn.Execute(strbSql.ToString());
            if (CkAgain == "N")
            {
                Response.Redirect("Education21Indicator.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Education21Indicator", "Where Education21IndicatorID = '" + Request["id"] + "' ", "Education21IndicatorName, Education21StandardID, Detail, Sort, UpdateUser, UpdateDate",
                txtEducation21Indicator.Text, ddlEducation21Standard.SelectedValue, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);

            //Criterion
            if (Session["Criterion"] != null)
            {
                strbSql.AppendFormat("Delete Education21Criterion Where Education21IndicatorID = '{0}';", Request["id"]);
                DataTable dt1 = new DataTable();
                dt1 = (DataTable)Session["Criterion"];
                dvCriterion = dt1.DefaultView;
                for (int j = 0; j < dvCriterion.Count; j++)
                {
                    strbSql.AppendFormat("INSERT INTO Education21Criterion (Education21CriterionID, Education21IndicatorID, Detail, Score, Sort, RecNum, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',{3},{4},{5},'{6}','{7}');",
                        Guid.NewGuid().ToString(), Request["id"], dvCriterion[j]["Detail"].ToString().Trim(), dvCriterion[j]["Score"].ToString(), dvCriterion[j]["Sort"].ToString(), dvCriterion[j]["id"].ToString(), DateTime.Now.ToString("s"), CurrentUser.ID);
                }
            }
            result = Conn.Execute(strbSql.ToString());

            Response.Redirect("Education21Indicator.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "Education21IndicatorID", "Education21Evaluate", ""))
        {
            Response.Redirect("Education21Indicator.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("Education21Indicator", "Where Education21IndicatorID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Education21Indicator.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("EvaluateType", ddlSearchEvaluateType.SelectedValue);
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchStandard_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlEducation21Side(1, ddlYearB.SelectedValue);
       getddlEducation21Standard(1, ddlEducation21Side.SelectedValue);
       btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
    }
    protected void ddlEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Side(1, ddlYearB.SelectedValue);
        getddlEducation21Standard(1, ddlEducation21Side.SelectedValue);
        btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
    }
    protected void ddlEducation21Side_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Standard(1, ddlEducation21Side.SelectedValue);
        btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
    }
    protected void ddlEducation21Standard_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Education21Indicator", " And Education21StandardID = '" + ddlEducation21Standard.SelectedValue + "' ");
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
    protected void btaddCriterion_Click(object sender, EventArgs e)
    {
        if (Session["Criterion"] == null)
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("id");
            dt1.Columns.Add("Education21CriterionID");
            dt1.Columns.Add("Sort");
            dt1.Columns.Add("Detail");
            dt1.Columns.Add("Score");

            DataRow dr;
            dr = dt1.NewRow();
            dr["id"] = dr.Table.Rows.Count;
            dr["Education21CriterionID"] = Guid.NewGuid().ToString();
            dr["Sort"] = ddlCriterionSort.SelectedValue;
            dr["Detail"] = txtcDetail.Text;
            dr["Score"] = txtcScore.Text;
            dt1.Rows.Add(dr);

            dvCriterion = dt1.DefaultView;
            Session["Criterion"] = dt1;
        }
        else
        {
            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["Criterion"];

            if (txtid.Text == "")
            {
                DataView ckdv = ((DataTable)Session["Criterion"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int i = 0; i < ckdv.Count; i++)
                    {
                        if (ckdv[i]["Sort"].ToString() == ddlCriterionSort.SelectedValue)
                        {
                            lblckCritetion.Visible = true;
                            return;
                        }
                    }
                }
                DataRow dr;
                dr = dt1.NewRow();
                dr["id"] = dr.Table.Rows.Count;
                dr["Education21CriterionID"] = Guid.NewGuid().ToString();
                dr["Sort"] = ddlCriterionSort.SelectedValue;
                dr["Detail"] = txtcDetail.Text;
                dr["Score"] = txtcScore.Text;
                dt1.Rows.Add(dr);
            }
            else
            {
                DataView ckdv = ((DataTable)Session["Criterion"]).DefaultView;
                if (ckdv.Count != 0)
                {
                    for (int i = 0; i < ckdv.Count; i++)
                    {
                        if ((ckdv[i]["id"].ToString() != txtid.Text) && (ckdv[i]["Sort"].ToString() == ddlCriterionSort.SelectedValue))
                        {
                            lblckCritetion.Visible = true;
                            return;
                        }
                    }
                }
                Int32 j = Convert.ToInt32(txtid.Text);
                dt1.Rows[j]["Education21CriterionID"] = hdfEducation21CriterionID.Value;
                dt1.Rows[j]["Sort"] = ddlCriterionSort.SelectedValue;
                dt1.Rows[j]["Detail"] = txtcDetail.Text;
                dt1.Rows[j]["Score"] = txtcScore.Text;
            }
            lblckCritetion.Visible = false;
            dvCriterion = dt1.DefaultView;
            Session["Criterion"] = dt1;
        }
        dvCriterion.Sort = "Sort";
        ClearCriterion();
        GridViewCriterion.DataSource = dvCriterion;
        GridViewCriterion.CheckListDataField = "id";
        GridViewCriterion.DataBind();
        if (dvCriterion.Count > 0)
        {
            btDelCriterion.Visible = true;
            GridViewCriterion.Visible = true;
        }
    }
    private void ClearCriterion()
    {
        txtid.Text = "";
        hdfEducation21CriterionID.Value = "";
        ddlCriterionSort.SelectedIndex = 0;
        txtcDetail.Text = "";
        txtcScore.Text = "";
    }
    protected void btDelCriterion_Click(object sender, EventArgs e)
    {
        if (GridViewCriterion.SelectedItems.Length == 0) return;
        DataTable dt1 = new DataTable();
        dt1 = (DataTable)Session["Criterion"];
        DataRow[] dra = dt1.Select("id in (" + string.Join(",", GridViewCriterion.SelectedItems) + ")");
        foreach (DataRow dr in dra)
            dr.Delete();
        dt1.AcceptChanges();
        dvCriterion = dt1.DefaultView;
        Session["Criterion"] = dt1;
        GridViewCriterion.DataSource = dvCriterion;
        GridViewCriterion.DataBind();
        if (dvCriterion.Count == 0)
        {
            btDelCriterion.Visible = false;
        }
    }
}
