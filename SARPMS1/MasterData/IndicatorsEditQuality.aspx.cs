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
using System.IO;

public partial class IndicatorsEditQuality : System.Web.UI.Page
{
    public static DataView dv;
    public static string path = ConfigurationManager.AppSettings["FilePath"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        if (!IsPostBack)
        {
            ClearAll();
            getddlYear(0);
            getddlStandardQuality(0, ddlSearchYear.SelectedValue);
            getddlCan();
            string mode = Request["mode"];
            string delmode = Request.QueryString["delmode"];
            int ij = string.IsNullOrEmpty(Request.QueryString["i"])? 0 : Convert.ToInt32(Request.QueryString["i"]);
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        getddlYear(1);
                        btc.txtEnable(table1, TableSearch, GridView1, true);
                        GetData(Request["id"]);
                        break;
                    case "3":                       
                        break;
                    case "4" :
                        btc.Msg_Head(Img1, MsgHead, true, "2", ij);
                        break;
                }
            }
            if (!String.IsNullOrEmpty(delmode))
            {
                DeleteItems();
            }
            DataBind();
            DataBind2();
        }
    }
    private void getddlYear(int mode)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
    }
    private void getddlStandardQuality(int mode, string StudyYear)
    {
        BTC btc = new BTC();
        if (mode == 0)
        {
            btc.getddlStandardQuality(0, ddlSearch, StudyYear);
        }
    }
    private void getddlCan()
    {
        for (int i = 0; i < 5; i++)
        {
            ddlCan.Items.Insert(i, new ListItem((i + 1).ToString(), (i + 1).ToString()));
        }
        ddlCan.DataBind();
        getScore(ddlCan.SelectedValue);
    }
    private void getScore(string Criterion)
    {
        Connection Conn = new Connection();
        string strSql = " Select TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax " 
                        + " From Tcriteria Where DelFlag = 0 And TCriteria = '" + lblWeightScore.Text + "' "
                        + " And Criterion = '" + Convert.ToInt32(Criterion) + "' ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            lblScore.Text = dv[0]["TMax"].ToString();
        }
    }
    public override void DataBind()
    {
        string StrSql = " Select b.IndicatorsCode, Cast(a.Sort AS nVarChar) + '. - ' + a.StandardName stdFullName, "
                + " Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName intFullName, "
                + " b.WeightScore, a.StudyYear, 0 As Quality, 0.0 As Score "
                + " From Standard a, Indicators b "
                + " Where a.StandardCode = b.StandardCode And a.DelFlag = 0 And b.DelFlag = 0 "
                + " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.QualityFlag = 1 ";
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.StandardCode = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And b.IndicatorsName Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv,dv1;
        Connection Conn = new Connection();
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort" ));

        for (int i = 0; i < dv.Count; i++)
        {
            dv1 = Conn.Select("Select Quality, Score From IndicatorsQuality Where IndicatorsCode = '" + dv[i]["IndicatorsCode"] + "'");
            if (dv1.Count != 0)
            {
                dv[i]["Quality"] = Convert.ToInt32(dv1[0]["Quality"]);
                dv[i]["Score"] = Convert.ToDecimal(dv1[0]["Score"]);
            }

        }


        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv, dv1;
        Connection Conn = new Connection();
        string strSql = "Select Cast(a.Sort AS nVarChar) + '. - ' + a.StandardName stdFullName, "
                + " b.IndicatorsCode, Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName intFullName, "
                + " b.WeightScore, a.StudyYear, 0 As Evaluation, b.Detail, b.DevelopIssues, c.Quality, c.Score, c.Note "
                + " From Standard a, Indicators b, IndicatorsQuality c "
                + " Where a.StandardCode = b.StandardCode And b.IndicatorsCode = c.IndicatorsCode And a.DelFlag = 0 And b.DelFlag = 0 "
                + " And b.QualityFlag = 1 And b.IndicatorsCode = '" + id + "'";
        dv1 = Conn.Select(strSql);
        if (dv1.Count != 0)
        {
            lblStudyYear.Text = dv1[0]["StudyYear"].ToString();
            lblStandard.Text = dv1[0]["stdFullName"].ToString();
            lblIndicators.Text = dv1[0]["intFullName"].ToString();
            txtDetail.Text = dv1[0]["Detail"].ToString();
            txtDevelopIssues.Text = dv1[0]["DevelopIssues"].ToString();
            lblWeightScore.Text = Convert.ToDecimal(dv1[0]["WeightScore"]).ToString("#,##0.00");
            ddlCan.SelectedValue = dv1[0]["Quality"].ToString();
            getScore(ddlCan.SelectedValue);
            txtNote.Text = dv1[0]["Note"].ToString();
        }
        else
        {
            strSql = " Select Cast(a.Sort AS nVarChar) + '. - ' + a.StandardName stdFullName, "
                    + " b.IndicatorsCode, Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' - ' + b.IndicatorsName intFullName, "
                    + " b.WeightScore, a.StudyYear, 0 As Evaluation, b.Detail, b.DevelopIssues "
                    + " From Standard a, Indicators b "
                    + " Where a.StandardCode = b.StandardCode And a.DelFlag = 0 And b.DelFlag = 0 "
                    + " And b.QualityFlag = 1 And b.IndicatorsCode = '" + id + "'";
            dv = Conn.Select(string.Format(strSql));

            if (dv.Count != 0)
            {
                lblStudyYear.Text = dv[0]["StudyYear"].ToString();
                lblStandard.Text = dv[0]["stdFullName"].ToString();
                lblIndicators.Text = dv[0]["intFullName"].ToString();
                txtDetail.Text = dv[0]["Detail"].ToString();
                txtDevelopIssues.Text = dv[0]["DevelopIssues"].ToString();
                lblWeightScore.Text = Convert.ToDecimal(dv[0]["WeightScore"]).ToString("#,##0.00");
                getScore(ddlCan.SelectedValue);
                //txtCan.Text = dv[0]["OffThat"].ToString()) ? "0" : Convert.ToInt32(dv[0]["OffThat"]).ToString("#,##0");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "CkPercent(0);", true);
            }     
        }
    }
    private void ClearAll()
    {
        BTC btc = new BTC();
        lblStudyYear.Text = "";
        lblStandard.Text = "";
        lblIndicators.Text = "";
        txtDetail.Text = "";
        txtDevelopIssues.Text = "";
        lblWeightScore.Text = "";
        txtSearch.Text = "";
        btc.txtEnable(table1, TableSearch, GridView1, false);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Connection Conn = new Connection();
        BTC btc = new BTC();
        Int32 i = 0;
        if (Request["mode"] == "2")
        {
            DataView dv = Conn.Select("Select * From IndicatorsQuality Where IndicatorsCode = '" + Request["id"] + "' And StudyYear = '" + lblStudyYear.Text + "'");
            if (dv.Count != 0)
            {
                i = Conn.Update("IndicatorsQuality", "Where IndicatorsCode = '" + Request["id"] + "' And StudyYear = '" + lblStudyYear.Text + "'", "Quality, Score, Note, UpdateUser, UpdateDate", Convert.ToDecimal(ddlCan.SelectedValue), Convert.ToDecimal(lblScore.Text), txtNote.Text, CurrentUser.ID, DateTime.Now);
            }
            else
            {
                string NewID = Guid.NewGuid().ToString();
                i = Conn.AddNew("IndicatorsQuality", "IndicatorsQualityCode, IndicatorsCode, StudyYear, Quality, Score, Note, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, Request["id"], Convert.ToInt32(lblStudyYear.Text), Convert.ToDecimal(ddlCan.SelectedValue), Convert.ToDecimal(lblScore.Text), txtNote.Text, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            }
            btc.Msg_Head(Img1, MsgHead, true, "1", i);
        }
        //ClearAll();
        //DataBind();
        Response.Redirect("IndicatorsEditQuality.aspx?mode=4&i=" + i);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("IndicatorsEditQuality.aspx");
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlStandardQuality(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    public void DataBind2()
    {
        Connection Conn = new Connection();
        DataView dv = new DataView();
        string strSql = "Select AttachID, IndicatorsCode, SubString(FileName,38,len(FileName)) FileName, ContentType, DelFlag From AttachFile2 Where DelFlag = 0 AND IndicatorsCode='{0}'";
        dv = Conn.Select(string.Format(strSql, Request.QueryString["id"]));
        rptFile.DataSource = dv;
        rptFile.DataBind();
    }
    private void DeleteItems()
    {
        Connection Conn = new Connection();
        Conn.Update("AttachFile", string.Format("WHERE AttachId='{0}'", Request.QueryString["did"]), "DelFlag", 1);
        //EditForm();
    }
    protected void btnAttach_Click(object sender, EventArgs e)
    {
        Connection Conn = new Connection();
        if (fpAttach.HasFile)
        {
            string NewID = Guid.NewGuid().ToString();
            int rowsEffect = Conn.AddNew("AttachFile2", "AttachId,IndicatorsCode,FileName,ContentType,DelFlag", NewID, Request.QueryString["id"], NewID + "_" + fpAttach.FileName, fpAttach.PostedFile.ContentType, 0);
            //DataRow[] drSub = dv.Table.Select(string.Format("JobId='{0}'", Request.QueryString["i"]));
            //DataRow[] drMain = dv.Table.Select(string.Format("JobId='{0}'", drSub[0]["ParentId"].ToString()));
            fpAttach.SaveAs(Server.MapPath(path + NewID + "_" + Path.GetFileName(fpAttach.PostedFile.FileName)));
            DataBind2();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "Quality").ToString() != "0")
            {
                e.Row.ForeColor = System.Drawing.Color.Gray;
            }
            else
            {
                e.Row.Font.Bold = true;
            }

            if (!(e.Row.RowType == DataControlRowType.Header))
            {
                e.Row.Attributes.Add("onclick", "javascript:window.location='IndicatorsEditQuality.aspx?mode=2&id=" + DataBinder.Eval(e.Row.DataItem, "IndicatorsCode") + "&yearid=" + DataBinder.Eval(e.Row.DataItem, "StudyYear") + "'");
            }
        }
    }
    protected void ddlCan_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        getScore(ddlCan.SelectedValue);
    }
}
