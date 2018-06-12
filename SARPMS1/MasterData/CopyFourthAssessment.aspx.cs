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

public partial class CopyFourthAssessment : System.Web.UI.Page
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
        string StrSql = @" Select a.StudyYear, 'จำนวนด้าน ' + Cast(Count(Distinct(a.FourthAssessmentSideID)) As nVarChar) + ' ด้าน' FourthAssessmentSide, 
                        'จำนวนตัวบ่งชี้ ' + Cast(Count(Distinct(b.FourthAssessmentIndicatorID)) As nVarChar) + ' ตัวบ่งชี้' FourthAssessmentIndicator
                        From FourthAssessmentSide a, FourthAssessmentIndicator b 
                        Where a.FourthAssessmentSideID = b.FourthAssessmentSideID
                        And a.DelFlag = 0 And b.DelFlag = 0
                        Group By a.StudyYear ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        string strSql = @" Select FourthAssessmentSideID From FourthAssessmentSide Where DelFlag = 0 And StudyYear = '{0}' ";
        DataView dvFourthAssessmentSide = Conn.Select(string.Format(strSql, StudyYearNext));
        if(dvFourthAssessmentSide.Count != 0)
        {
            return true;
        }

        strSql = @" Select b.FourthAssessmentIndicatorID 
            From FourthAssessmentSide a, FourthAssessmentIndicator b 
            Where b.DelFlag = 0 And a.StudyYear = '{0}' And a.FourthAssessmentSideID = b.FourthAssessmentSideID ";
        DataView dvFourthAssessmentIndicator = Conn.Select(string.Format(strSql, StudyYearNext));
        if (dvFourthAssessmentIndicator.Count != 0)
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
            Response.Redirect("CopyFourthAssessment.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = @" Select FourthAssessmentSideID, FourthAssessmentSideName, Detail, Sort 
                From FourthAssessmentSide Where DelFlag = 0 And StudyYear = '{0}' Order By Sort ";
        DataView dvFourthAssessmentSide = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select b.FourthAssessmentIndicatorID, b.FourthAssessmentIndicatorName, b.FourthAssessmentSideID, b.Detail, b.Sort 
                From FourthAssessmentSide a, FourthAssessmentIndicator b 
                Where b.DelFlag = 0 And a.StudyYear = '{0}' And a.FourthAssessmentSideID = b.FourthAssessmentSideID Order By b.Sort ";
        DataView dvFourthAssessmentIndicator = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        if (dvFourthAssessmentSide.Count != 0)
        {
            for (int i = 0; i < dvFourthAssessmentSide.Count; i++)
            {
                string NewFourthAssessmentSideID = Guid.NewGuid().ToString();
                strbSql.AppendFormat("INSERT INTO FourthAssessmentSide (FourthAssessmentSideID, StudyYear, FourthAssessmentSideName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}',{1},N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                    NewFourthAssessmentSideID, txtNextYear.Text, dvFourthAssessmentSide[i]["FourthAssessmentSideName"].ToString(), dvFourthAssessmentSide[i]["Detail"].ToString(), Convert.ToInt32(dvFourthAssessmentSide[i]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);

                dvFourthAssessmentIndicator.RowFilter = " FourthAssessmentSideID = '" + dvFourthAssessmentSide[i]["FourthAssessmentSideID"].ToString() + "' ";

                if (dvFourthAssessmentIndicator.Count != 0)
                {
                    for (int j = 0; j < dvFourthAssessmentIndicator.Count; j++)
                    {
                        string NewFourthAssessmentIndicator = Guid.NewGuid().ToString();
                        strbSql.AppendFormat("INSERT INTO FourthAssessmentIndicator (FourthAssessmentIndicatorID, FourthAssessmentSideID, FourthAssessmentIndicatorName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                            NewFourthAssessmentIndicator, NewFourthAssessmentSideID, dvFourthAssessmentIndicator[j]["FourthAssessmentIndicatorName"].ToString(), dvFourthAssessmentIndicator[j]["Detail"].ToString(), Convert.ToInt32(dvFourthAssessmentIndicator[j]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);
                    }
                }
            }
            x = Conn.Execute(strbSql.ToString());
            Response.Redirect("CopyFourthAssessment.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyFourthAssessment.aspx?ckmode=6&Cr=0"); 
        }
    }
}
