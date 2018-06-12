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

public partial class CopySuffice : System.Web.UI.Page
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
        string StrSql = @" Select a.StudyYear, 'จำนวนด้าน ' + Cast(Count(Distinct(a.SufficeSideID)) As nVarChar) + ' ด้าน' SufficeSide, 
            'จำนวนองค์ประกอบ ' + Cast(Count(Distinct(b.SufficeStandardID)) As nVarChar) + ' องค์ประกอบ' SufficeStandard, 
            'จำนวนตัวบ่งชี้ ' + Cast(Count(Distinct(c.SufficeIndicatorID)) As nVarChar) + ' ตัวบ่งชี้' SufficeIndicator
            From SufficeSide a, SufficeStandard b, SufficeIndicator c
            Where a.SufficeSideID = b.SufficeSideID And b.SufficeStandardID = c.SufficeStandardID
            And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0
            Group By a.StudyYear ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        string strSql = @" Select SufficeSideID From SufficeSide Where DelFlag = 0 And StudyYear = '{0}' ";
        DataView dvSufficeSide = Conn.Select(string.Format(strSql, StudyYearNext));
        if(dvSufficeSide.Count != 0)
        {
            return true;
        }

        strSql = @" Select b.SufficeStandardID 
            From SufficeSide a, SufficeStandard b 
            Where b.DelFlag = 0 And a.StudyYear = '{0}' And a.SufficeSideID = b.SufficeSideID ";
        DataView dvSufficeStandard = Conn.Select(string.Format(strSql, StudyYearNext));
        if (dvSufficeStandard.Count != 0)
        {
            return true;
        }

        strSql = @" Select c.SufficeIndicatorID 
            From SufficeSide a, SufficeStandard b, SufficeIndicator c 
            Where c.DelFlag = 0 And a.StudyYear = '{0}' And a.SufficeSideID = b.SufficeSideID And b.SufficeStandardID = c.SufficeStandardID ";
        DataView dvSufficeIndicator = Conn.Select(string.Format(strSql, StudyYearNext));
        if (dvSufficeIndicator.Count != 0)
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
            Response.Redirect("CopySuffice.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = @" Select SufficeSideID, SufficeSideName, Detail, Sort 
                From SufficeSide Where DelFlag = 0 And StudyYear = '{0}' Order By Sort ";
        DataView dvSufficeSide = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select b.SufficeStandardID, b.SufficeStandardName, b.SufficeSideID, b.Detail, b.Sort 
                From SufficeSide a, SufficeStandard b 
                Where b.DelFlag = 0 And a.StudyYear = '{0}' And a.SufficeSideID = b.SufficeSideID Order By b.Sort ";
        DataView dvSufficeStandard = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select c.SufficeIndicatorID, c.SufficeIndicatorName, c.SufficeStandardID, c.Detail, c.Sort 
                From SufficeSide a, SufficeStandard b, SufficeIndicator c 
                Where c.DelFlag = 0 And a.StudyYear = '{0}' And a.SufficeSideID = b.SufficeSideID And b.SufficeStandardID = c.SufficeStandardID Order By c.Sort ";
        DataView dvSufficeIndicator = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        if (dvSufficeSide.Count != 0)
        {
            for (int i = 0; i < dvSufficeSide.Count; i++)
            {
                string NewSufficeSideID = Guid.NewGuid().ToString();
                strbSql.AppendFormat("INSERT INTO SufficeSide (SufficeSideID, StudyYear, SufficeSideName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}',{1},N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                    NewSufficeSideID, txtNextYear.Text, dvSufficeSide[i]["SufficeSideName"].ToString(), dvSufficeSide[i]["Detail"].ToString(), Convert.ToInt32(dvSufficeSide[i]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);

                dvSufficeStandard.RowFilter = " SufficeSideID = '" + dvSufficeSide[i]["SufficeSideID"].ToString() + "' ";

                if (dvSufficeStandard.Count != 0)
                {
                    for (int j = 0; j < dvSufficeStandard.Count; j++)
                    {
                        string NewSufficeStandard = Guid.NewGuid().ToString();
                        strbSql.AppendFormat("INSERT INTO SufficeStandard (SufficeStandardID, SufficeSideID, SufficeStandardName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                            NewSufficeStandard, NewSufficeSideID, dvSufficeStandard[j]["SufficeStandardName"].ToString(), dvSufficeStandard[j]["Detail"].ToString(), Convert.ToInt32(dvSufficeStandard[j]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);

                        dvSufficeIndicator.RowFilter = " SufficeStandardID = '" + dvSufficeStandard[j]["SufficeStandardID"].ToString() + "' ";

                        if (dvSufficeIndicator.Count != 0)
                        {
                            for (int k = 0; k < dvSufficeIndicator.Count; k++)
                            {
                                string NewSufficeIndicator = Guid.NewGuid().ToString();
                                strbSql.AppendFormat("INSERT INTO SufficeIndicator (SufficeIndicatorID, SufficeStandardID, SufficeIndicatorName, Detail, Sort, DelFlag, CreateDate, CreateUser, UpdateDate, UpdateUser)VALUES('{0}','{1}',N'{2}',N'{3}',{4},{5},'{6}','{7}','{8}','{9}');",
                                    NewSufficeIndicator, NewSufficeStandard, dvSufficeIndicator[k]["SufficeIndicatorName"].ToString(), dvSufficeIndicator[k]["Detail"].ToString(), Convert.ToInt32(dvSufficeIndicator[k]["Sort"]), 0, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.ID);
                            }
                        }
                    }
                }
            }
            x = Conn.Execute(strbSql.ToString());
            Response.Redirect("CopySuffice.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopySuffice.aspx?ckmode=6&Cr=0"); 
        }
    }
}
