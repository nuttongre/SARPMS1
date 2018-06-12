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

public partial class CopyWorldClass : System.Web.UI.Page
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
        string StrSql = @" Select a.StudyYear, 'จำนวนด้าน ' + Cast(Count(Distinct(a.WorldClassSideID)) As nVarChar) + ' ด้าน' WorldClassSide, 
                        'จำนวนมาตรฐาน ' + Cast(Count(Distinct(b.WorldClassStandardID)) As nVarChar) + ' มาตรฐาน' WorldClassStandard
                        From WorldClassSide a, WorldClassStandard b 
                        Where a.WorldClassSideID = b.WorldClassSideID
                        And a.DelFlag = 0 And b.DelFlag = 0
                        Group By a.StudyYear ";

        DataView dv = Conn.Select(string.Format(StrSql));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private Boolean CkDuplicate(string StudyYearNext)
    {
        DataView dvWorldClassSide = Conn.Select("Select WorldClassSideID From WorldClassSide Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvWorldClassSide.Count != 0)
        {
            return true;
        }

        DataView dvWorldClassStandard = Conn.Select("Select WorldClassStandardID From WorldClassStandard Where DelFlag = 0 And StudyYear = '" + StudyYearNext + "'");
        if(dvWorldClassStandard.Count != 0)
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
            Response.Redirect("CopyWorldClass.aspx?ckmode=7&Cr=0"); 
        }
        string strSql = " Select WorldClassSideID, WorldClassSideName, Comment, Detail, Score, QAScoreGroupID, Sort, MsSideSort From WorldClassSide Where DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
        DataView dvWorldClassSide = Conn.Select(strSql);

        if (dvWorldClassSide.Count != 0)
        {
            for (int i = 0; i < dvWorldClassSide.Count; i++)
            {
                string NewWorldClassSideID = Guid.NewGuid().ToString();
                x += Conn.AddNew("WorldClassSide", "WorldClassSideID, StudyYear, WorldClassSideName, Comment, Detail, Score, QAScoreGroupID, Sort, MsSideSort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewWorldClassSideID, txtNextYear.Text, dvWorldClassSide[i]["WorldClassSideName"].ToString(), dvWorldClassSide[i]["Comment"].ToString(), dvWorldClassSide[i]["Detail"].ToString(), dvWorldClassSide[i]["Score"].ToString(), dvWorldClassSide[i]["QAScoreGroupID"].ToString(), dvWorldClassSide[i]["Sort"].ToString(), dvWorldClassSide[i]["MsSideSort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);

                strSql = " Select WorldClassStandardID, WorldClassStandardName, Comment, Detail, Score, QAScoreGroupID, Sort From WorldClassStandard Where DelFlag = 0 And WorldClassSideID = '" + dvWorldClassSide[i]["WorldClassSideID"].ToString() + "' And StudyYear = '" + ddlYearB.SelectedValue + "' Order By Sort ";
                DataView dvWorldClassStandard = Conn.Select(strSql);

                if (dvWorldClassStandard.Count != 0)
                {
                    for (int j = 0; j < dvWorldClassStandard.Count; j++)
                    {
                        string NewWorldClassStandard = Guid.NewGuid().ToString();
                        x += Conn.AddNew("WorldClassStandard", "WorldClassStandardID, WorldClassStandardName, WorldClassSideID, StudyYear, Comment, Detail, Score, QAScoreGroupID, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewWorldClassStandard, dvWorldClassStandard[j]["WorldClassStandardName"].ToString(), NewWorldClassSideID, txtNextYear.Text, dvWorldClassStandard[j]["Comment"].ToString(), dvWorldClassStandard[j]["Detail"].ToString(), dvWorldClassStandard[j]["Score"].ToString(), dvWorldClassStandard[j]["QAScoreGroupID"].ToString(), dvWorldClassStandard[j]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
                    }
                }
            }
            Response.Redirect("CopyWorldClass.aspx?ckmode=1&Cr=" + x); 
        }
        else
        {
            Response.Redirect("CopyWorldClass.aspx?ckmode=6&Cr=0"); 
        }
    }
}
