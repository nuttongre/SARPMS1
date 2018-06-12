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

public partial class CopyRoyalAward : System.Web.UI.Page
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
        string StrSql = @" Select a.StudyYear, 'จำนวนด้าน ' + Cast(Count(Distinct(a.RoyalAwardSideID)) As nVarChar) + ' ด้าน' RoyalAwardSide, 
                        'จำนวนตัวชี้วัด ' + Cast(Count(Distinct(b.RoyalAwardIndicatorID)) As nVarChar) + ' ตัวชี้วัด' RoyalAwardIndicator
                        From RoyalAwardSide a, RoyalAwardIndicator b 
                        Where a.RoyalAwardSideID = b.RoyalAwardSideID
                        And a.DelFlag = 0 And b.DelFlag = 0
                        Group By a.StudyYear ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        DataView dvRoyalAwardSide = Conn.Select("Select RoyalAwardSideID From RoyalAwardSide Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvRoyalAwardSide.Count != 0)
        {
            return true;
        }

        DataView dvRoyalAwardIndicator = Conn.Select("Select RoyalAwardIndicatorID From RoyalAwardIndicator Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if (dvRoyalAwardIndicator.Count != 0)
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
            Response.Redirect("CopyRoyalAward.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = " Select RoyalAwardSideID, RoyalAwardSideName, Comment, Detail, Score, QAScoreGroupID, Sort From RoyalAwardSide Where DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
        DataView dvRoyalAwardSide = Conn.Select(strSql);

        if (dvRoyalAwardSide.Count != 0)
        {
            for (int i = 0; i < dvRoyalAwardSide.Count; i++)
            {
                string NewRoyalAwardSideID = Guid.NewGuid().ToString();
                x += Conn.AddNew("RoyalAwardSide", "RoyalAwardSideID, StudyYear, RoyalAwardSideName, Comment, Detail, Score, QAScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewRoyalAwardSideID, txtNextYear.Text, dvRoyalAwardSide[i]["RoyalAwardSideName"].ToString(), dvRoyalAwardSide[i]["Comment"].ToString(), dvRoyalAwardSide[i]["Detail"].ToString(), dvRoyalAwardSide[i]["Score"].ToString(), dvRoyalAwardSide[i]["QAScoreGroupID"].ToString(), dvRoyalAwardSide[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                strSql = " Select RoyalAwardIndicatorID, RoyalAwardIndicatorName, Comment, Detail, Score, QAScoreGroupID, Sort From RoyalAwardIndicator Where DelFlag = 0 And RoyalAwardSideID = '" + dvRoyalAwardSide[i]["RoyalAwardSideID"].ToString() + "' And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
                DataView dvRoyalAwardIndicator = Conn.Select(strSql);

                if (dvRoyalAwardIndicator.Count != 0)
                {
                    for (int j = 0; j < dvRoyalAwardIndicator.Count; j++)
                    {
                        string NewRoyalAwardIndicator = Guid.NewGuid().ToString();
                        x += Conn.AddNew("RoyalAwardIndicator", "RoyalAwardIndicatorID, RoyalAwardIndicatorName, RoyalAwardSideID, StudyYear, Comment, Detail, Score, QAScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewRoyalAwardIndicator, dvRoyalAwardIndicator[j]["RoyalAwardIndicatorName"].ToString(), NewRoyalAwardSideID, txtNextYear.Text, dvRoyalAwardIndicator[j]["Comment"].ToString(), dvRoyalAwardIndicator[j]["Detail"].ToString(), dvRoyalAwardIndicator[j]["Score"].ToString(), dvRoyalAwardIndicator[j]["QAScoreGroupID"].ToString(), dvRoyalAwardIndicator[j]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
                    }
                }
            }
            Response.Redirect("CopyRoyalAward.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyRoyalAward.aspx?ckmode=6&Cr=0"); 
        }
    }
}
