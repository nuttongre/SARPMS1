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

public partial class CopyStandard : System.Web.UI.Page
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
                getddlYear();
                ckNewStandard();
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
        DataView dv = Conn.Select("Select Top 5 StudyYear, Df From StudyYear Where DelFlag = 0 And StudyYear < " + Convert.ToInt32(txtNextYear.Text) + " Order By StudyYear Desc");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "StudyYear";
            ddl.DataValueField = "StudyYear";
            ddl.DataBind();
        }
    }
    private void ckNewStandard()
    {
        if (!CkDuplicate(txtNextYear.Text))
        {
            if (!CkNewDataDuplicate())
            {
                btNewSave.Visible = true;
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = " Select a.StudyYear, 'จำนวนมาตรฐาน ' + Cast(Count(Distinct(a.SideCode)) As nVarChar) + ' มาตรฐาน' SideC, "
                + " 'จำนวนตัวบ่งชี้ ' + Cast(Count(Distinct(b.StandardCode)) As nVarChar) + ' ตัวบ่งชี้' StandardC, "
                + " 'จำนวนประเด็นการประเมิน ' + Cast(Count(Distinct(c.IndicatorsCode)) As nVarChar) + ' ประเด็น' IndicatorsC "
                + " From Side a, Standard b, Indicators c "
                + " Where a.SideCode = b.SideCode And b.StandardCode = c.StandardCode "
                + " And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 ";

        DataView dv = Conn.Select(string.Format(StrSql + " Group By a.StudyYear "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        DataView dvSide = Conn.Select("Select SideCode From Side Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvSide.Count != 0)
        {
            return true;
        }

        DataView dvStandard = Conn.Select("Select StandardCode From Standard Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvStandard.Count != 0)
        {
            return true;
        }

        DataView dvIndicators = Conn.Select("Select b.IndicatorsCode From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And a.StudyYear = '" + StudyYearNext + "'");
        if(dvIndicators.Count != 0)
        {
            return true;
        }
        return false;
    }
    private Boolean CkNewDataDuplicate()
    {
        DataView dvSide = Conn.Select("Select SideCode From Side Where SideCode = 'B530DE97-A199-4592-B164-A9BC8FE6F55A'");
        if (dvSide.Count != 0)
        {
            return true;
        }

        DataView dvStandard = Conn.Select("Select StandardCode From Standard Where StandardCode = 'A71DC241-C269-44C5-B69C-CEFA99F73C73'");
        if (dvStandard.Count != 0)
        {
            return true;
        }

        DataView dvIndicators = Conn.Select("Select IndicatorsCode From Indicators Where IndicatorsCode = '764B9A9B-6F56-41AB-B91D-7677D0F326B3'");
        if (dvIndicators.Count != 0)
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
            Response.Redirect("CopyStandard.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = " Select SideCode, SideName, ScoreGroupID, Sort From Side Where DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
        DataView dvSide = Conn.Select(strSql);

        if (dvSide.Count != 0)
        {
            for (int i = 0; i < dvSide.Count; i++)
            {
                string NewSideID = Guid.NewGuid().ToString();
                x += Conn.AddNew("Side", "SideCode, StudyYear, SideName, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewSideID, txtNextYear.Text, dvSide[i]["SideName"].ToString(), dvSide[i]["ScoreGroupID"].ToString(), dvSide[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                strSql = " Select StandardCode, StandardName, Note, ScoreGroupID, Sort From Standard Where DelFlag = 0 And SideCode = '" + dvSide[i]["SideCode"].ToString() + "' And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
                DataView dvStandard = Conn.Select(strSql);

                if (dvStandard.Count != 0)
                {
                    for (int j = 0; j < dvStandard.Count; j++)
                    {
                        string NewStandardID = Guid.NewGuid().ToString();
                        x += Conn.AddNew("Standard", "StandardCode, StandardName, SideCode, StudyYear, Note, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewStandardID, dvStandard[j]["StandardName"].ToString(), NewSideID, txtNextYear.Text, dvStandard[j]["Note"].ToString(), dvStandard[j]["ScoreGroupID"].ToString(), dvStandard[j]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                        strSql = " Select IndicatorsName, Detail, DevelopIssues, WeightScore, DataSource1, DataSource2, ScoreGroupID, Sort, QualityFlag From Indicators Where DelFlag = 0 And StandardCode = '" + dvStandard[j]["StandardCode"].ToString() + "' Order By Sort ";
                        DataView dvIndicators = Conn.Select(strSql);

                        if (dvIndicators.Count != 0)
                        {
                            for (int k = 0; k < dvIndicators.Count; k++)
                            {
                                string NewIndicatorsID = Guid.NewGuid().ToString();
                                x += Conn.AddNew("Indicators", "IndicatorsCode, IndicatorsName, StandardCode, Detail, DevelopIssues, WeightScore, DataSource1, DataSource2, ScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, QualityFlag", NewIndicatorsID, dvIndicators[k]["IndicatorsName"].ToString(), NewStandardID, dvIndicators[k]["Detail"].ToString(), dvIndicators[k]["DevelopIssues"].ToString(), dvIndicators[k]["WeightScore"].ToString(), dvIndicators[k]["DataSource1"].ToString(), dvIndicators[k]["DataSource2"].ToString(), dvIndicators[k]["ScoreGroupID"].ToString(), dvIndicators[k]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, Convert.ToInt32(dvIndicators[k]["QualityFlag"]));
                            }
                        }
                    }
                }
            }
            Response.Redirect("CopyStandard.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyStandard.aspx?ckmode=6&Cr=0"); 
        }
    }
    protected void btNewSave_Click(object sender, EventArgs e)
    {
        Conn.Execute("GenNewDataStandard59", "StudyYear", Convert.ToInt32(txtNextYear.Text));
        DataBind();
    }
}
