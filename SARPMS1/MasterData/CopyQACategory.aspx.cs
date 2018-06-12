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

public partial class CopyQACategory : System.Web.UI.Page
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

            getddlYear();
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        break;
                    case "3":
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
    }
    private void getddlYear()
    {
        string StudyYear = "0";
        StudyYear = btc.getdvDefault("StudyYear", "StudyYear");
        txtNextYear.Text =  Convert.ToInt32(StudyYear).ToString();
        getdllStudyYear(ddlYearB);
        ddlYearB.SelectedValue = (Convert.ToInt32(StudyYear) - 1).ToString();
    }
    public void getdllStudyYear(DropDownList ddl)
    {
        DataView dv = Conn.Select("Select Top 5 StudyYear, Df From StudyYear Where DelFlag = 0 And StudyYear < " + Convert.ToInt32(txtNextYear.Text) + " Order By StudyYear");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "StudyYear";
            ddl.DataValueField = "StudyYear";
            ddl.DataBind();
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.StudyYear, 'จำนวนหมวด ' + Cast(Count(Distinct(a.QACategoryID)) As nVarChar) + ' หมวด' QACategory, 
                        'จำนวนหัวข้อ ' + Cast(Count(Distinct(b.QACategorySubID)) As nVarChar) + ' หัวข้อ' QACategorySub
                        From QACategory a, QACategorySub b 
                        Where a.QACategoryID = b.QACategoryID
                        And a.DelFlag = 0 And b.DelFlag = 0
                        Group By a.StudyYear ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        DataView dvQACategory = Conn.Select("Select QACategoryID From QACategory Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvQACategory.Count != 0)
        {
            return true;
        }

        DataView dvQACategorySub = Conn.Select("Select QACategorySubID From QACategorySub Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvQACategorySub.Count != 0)
        {
            return true;
        }
        return false;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        int x = 0;
        if (CkDuplicate(txtNextYear.Text))
        {
            Response.Redirect("CopyQACategory.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = " Select QACategoryID, QACategoryName, Comment, Detail, Score, QAScoreGroupID, Sort From QACategory Where DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
        DataView dvQACategory = Conn.Select(strSql);

        if (dvQACategory.Count != 0)
        {
            for (int i = 0; i < dvQACategory.Count; i++)
            {
                string NewQACategoryID = Guid.NewGuid().ToString();
                x += Conn.AddNew("QACategory", "QACategoryID, StudyYear, QACategoryName, Comment, Detail, Score, QAScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewQACategoryID, txtNextYear.Text, dvQACategory[i]["QACategoryName"].ToString(), dvQACategory[i]["Comment"].ToString(), dvQACategory[i]["Detail"].ToString(), dvQACategory[i]["Score"].ToString(), dvQACategory[i]["QAScoreGroupID"].ToString(), dvQACategory[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                strSql = " Select QACategorySubID, QACategorySubName, Comment, Detail, Score, QAScoreGroupID, Sort From QACategorySub Where DelFlag = 0 And QACategoryID = '" + dvQACategory[i]["QACategoryID"].ToString() + "' And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
                DataView dvQACategorySub = Conn.Select(strSql);

                if (dvQACategorySub.Count != 0)
                {
                    for (int j = 0; j < dvQACategorySub.Count; j++)
                    {
                        string NewQACategorySub = Guid.NewGuid().ToString();
                        x += Conn.AddNew("QACategorySub", "QACategorySubID, QACategorySubName, QACategoryID, StudyYear, Comment, Detail, Score, QAScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewQACategorySub, dvQACategorySub[j]["QACategorySubName"].ToString(), NewQACategoryID, txtNextYear.Text, dvQACategorySub[j]["Comment"].ToString(), dvQACategorySub[j]["Detail"].ToString(), dvQACategorySub[j]["Score"].ToString(), dvQACategorySub[j]["QAScoreGroupID"].ToString(), dvQACategorySub[j]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
                    }
                }
            }
            Response.Redirect("CopyQACategory.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyQACategory.aspx?ckmode=6&Cr=0"); 
        }
    }
}
