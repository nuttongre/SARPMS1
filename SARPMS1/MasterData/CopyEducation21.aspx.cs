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

public partial class CopyEducation21 : System.Web.UI.Page
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
        DataView dv = Conn.Select("Select Top 5 StudyYear, Df From StudyYear Where DelFlag = 0 And StudyYear < " + Convert.ToInt32(txtNextYear.Text) + " Order By StudyYear Desc");
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
        string StrSql = @" Select a.StudyYear, 'จำนวนด้าน ' + Cast(Count(Distinct(a.Education21SideID)) As nVarChar) + ' ด้าน' SideC, 
                'จำนวนมาตรฐาน ' + Cast(Count(Distinct(b.Education21StandardID)) As nVarChar) + ' มาตรฐาน' StandardC, 
                'จำนวนตัวชี้วัด ' + Cast(Count(Distinct(c.Education21IndicatorID)) As nVarChar) + ' ตัวชี้วัด' IndicatorsC 
                From Education21Side a, Education21Standard b, Education21Indicator c 
                Where a.Education21SideID = b.Education21SideID And b.Education21StandardID = c.Education21StandardID 
                And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 ";

        DataView dv = Conn.Select(string.Format(StrSql + " Group By a.StudyYear "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        string strSql = @" Select Education21SideID From Education21Side Where DelFlag = 0 And StudyYear = '{0}' ";
        DataView dvSide = Conn.Select(string.Format(strSql, StudyYearNext));
        if(dvSide.Count != 0)
        {
            return true;
        }

        strSql = @" Select ED.Education21StandardID 
            From Education21Side ES, Education21Standard ED
            Where ED.DelFlag = 0 And ES.StudyYear = '{0}' And ES.Education21SideID = ED.Education21SideID ";
        DataView dvStandard = Conn.Select(string.Format(strSql, StudyYearNext));
        if(dvStandard.Count != 0)
        {
            return true;
        }

        strSql = @" Select EI.Education21IndicatorID 
            From Education21Side ES, Education21Standard ED, Education21Indicator EI
            Where EI.DelFlag = 0 And ES.StudyYear = '{0}' 
            And ES.Education21SideID = ED.Education21SideID
            And EI.Education21StandardID = ED.Education21StandardID ";
        DataView dvIndicators = Conn.Select(string.Format(strSql, StudyYearNext));
        if(dvIndicators.Count != 0)
        {
            return true;
        }
        return false;
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        StringBuilder strbSql = new StringBuilder();
        int x = 0;
        if (CkDuplicate(txtNextYear.Text))
        {
            Response.Redirect("CopyEducation21.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = @" Select Education21SideID, Education21SideName, Detail, Sort, EvaluateType 
                From Education21Side Where DelFlag = 0 And StudyYear = '{0}' Order By Sort ";
        DataView dvSide = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select ED.Education21SideID, ED.Education21StandardID, ED.Education21StandardName, ED.Detail, ED.Sort, ED.ckEvaluate
                From Education21Side ES, Education21Standard ED
                Where ED.DelFlag = 0 And ES.StudyYear = '{0}' And ES.Education21SideID = ED.Education21SideID Order By ES.Sort, ED.Sort ";
        DataView dvStandard = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select EI.Education21StandardID, EI.Education21IndicatorID, EI.Education21IndicatorName, EI.Detail, EI.Sort 
                From Education21Side ES, Education21Standard ED, Education21Indicator EI
                Where EI.DelFlag = 0 And ES.StudyYear = '{0}' 
                And ES.Education21SideID = ED.Education21SideID
                And EI.Education21StandardID = ED.Education21StandardID Order By ES.Sort, ED.Sort, EI.Sort ";
        DataView dvIndicators = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select EC.Education21IndicatorID, EC.Detail, EC.Score, EC.Sort, EC.RecNum
                From Education21Side ES, Education21Standard ED, Education21Indicator EI, Education21Criterion EC
                Where ES.StudyYear = '{0}' 
                And ES.Education21SideID = ED.Education21SideID
                And EI.Education21StandardID = ED.Education21StandardID 
                And EI.Education21IndicatorID = EC.Education21IndicatorID Order By ES.Sort, ED.Sort, EI.Sort, EC.RecNum ";
        DataView dvCriterion = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue)); 

        if (dvSide.Count != 0)
        {
            for (int i = 0; i < dvSide.Count; i++)
            {
                string NewSideID = Guid.NewGuid().ToString();
                strbSql.AppendFormat("INSERT INTO Education21Side (Education21SideID, StudyYear, Education21SideName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser, EvaluateType)VALUES('{0}',{1},N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}',{10});",
                    NewSideID, txtNextYear.Text, dvSide[i]["Education21SideName"].ToString(), dvSide[i]["Detail"].ToString(), Convert.ToInt32(dvSide[i]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID, Convert.ToInt32(dvSide[i]["EvaluateType"]));

                dvStandard.RowFilter = " Education21SideID = '" + dvSide[i]["Education21SideID"].ToString() + "' ";

                if (dvStandard.Count != 0)
                {
                    for (int j = 0; j < dvStandard.Count; j++)
                    {
                        string NewStandardID = Guid.NewGuid().ToString();
                        strbSql.AppendFormat("INSERT INTO Education21Standard (Education21StandardID, Education21SideID, Education21StandardName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser, ckEvaluate)VALUES('{0}','{1}',N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}',{10});",
                           NewStandardID, NewSideID, dvStandard[j]["Education21StandardName"].ToString(), dvStandard[j]["Detail"].ToString(), Convert.ToInt32(dvStandard[j]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID, Convert.ToInt32(dvStandard[j]["ckEvaluate"]));

                        dvIndicators.RowFilter = " Education21StandardID = '" + dvStandard[j]["Education21StandardID"].ToString() + "'";

                        if (dvIndicators.Count != 0)
                        {
                            for (int k = 0; k < dvIndicators.Count; k++)
                            {
                                string NewIndicatorsID = Guid.NewGuid().ToString();
                                strbSql.AppendFormat("INSERT INTO Education21Indicator (Education21IndicatorID, Education21StandardID, Education21IndicatorName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                                   NewIndicatorsID, NewStandardID, dvIndicators[k]["Education21IndicatorName"].ToString(), dvIndicators[k]["Detail"].ToString(), Convert.ToInt32(dvIndicators[k]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);

                                dvCriterion.RowFilter = "Education21IndicatorID = '" + dvIndicators[k]["Education21IndicatorID"].ToString() + "'";

                                if (dvCriterion.Count != 0)
                                {
                                    for (int m = 0; m < dvCriterion.Count; m++)
                                    {
                                        string NewCriterionID = Guid.NewGuid().ToString();
                                        strbSql.AppendFormat("INSERT INTO Education21Criterion (Education21CriterionID, Education21IndicatorID, Detail, Score, Sort, UpdateDate, UpdateUser, RecNum)VALUES('{0}','{1}',N'{2}',{3},{4},'{5}','{6}',{7});",
                                            NewCriterionID, NewIndicatorsID, dvCriterion[m]["Detail"].ToString(), Convert.ToInt32(dvCriterion[m]["Score"]), Convert.ToInt32(dvCriterion[m]["Sort"]), DateTime.Now, CurrentUser.ID, Convert.ToInt32(dvCriterion[m]["RecNum"]));
                                    }
                                }
                            }
                        }
                    }
                }
            }
            x = Conn.Execute(strbSql.ToString());
            Response.Redirect("CopyEducation21.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyEducation21.aspx?ckmode=6&Cr=0"); 
        }
    }
}
