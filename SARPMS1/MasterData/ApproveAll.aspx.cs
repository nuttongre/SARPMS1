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
using Star.Security.Cryptography;

public partial class ApproveAll : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }
            getddlYear(1);
            DataBind();
        }
    }
    private void getddlYear(int mode)
    {
        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, IsNull(b.ApproveFlag, 0) ApproveFlag, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, 0 As ConnectInd, 0 As ConnectEva "
                    + " From Projects a, Activity b "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " And a.StudyYear = '" + ddlYearB.SelectedValue + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.CreateDate Desc "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
            dv[j]["ConnectInd"] = btc.getAcIndicators2(dv[j]["ActivityCode"].ToString());
            dv[j]["ConnectEva"] = btc.getAcEvaluation(dv[j]["ActivityCode"].ToString());
        }
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    protected string GenConnection(int ConnectInd, int ConnectEva)
    {
        Int32 ckConnect = 0;
        string Detail = "";
        if (ConnectInd > 0)
        {
            ckConnect += 1;
            Detail = "กำหนดตัวชี้วัดแล้ว";
        }
        else
        {
            Detail = "ยังไม่ได้กำหนดตัวชี้วัด";
        }
        if (ConnectEva > 0)
        {
            ckConnect += 1;
            if (Detail == "")
            {
                Detail = "เชื่อมโยงตัวบ่งชี้แล้ว";
            }
            else
            {
                Detail += ", เชื่อมโยงตัวบ่งชี้แล้ว";
            }
        }
        else
        {
            if (Detail == "")
            {
                Detail = "ยังไม่เชื่อมโยงตัวบ่งชี้";
            }
            else
            {
                Detail += ", ยังไม่เชื่อมโยงตัวบ่งชี้";
            }
        }

        if (ckConnect == 2)
        {
            return "<img style=\"border: none; \" title=\"กำหนดตัวชี้วัดและเชื่อมโยงตัวบ่งชี้สมบูรณ์แล้ว\" src='../Image/Connect.png' />";
        }
        else
        {
            return "<img style=\"border: none; \" title=\"" + Detail + "\" src='../Image/UnConnect.png' />";
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 i = Conn.Update("Activity", "Where StudyYear = '" + ddlYearB.SelectedValue + "'", "ApproveFlag", 1);
        Response.Redirect("ApproveAll.aspx?ckmode=5&Cr=" + i);  
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Int32 i = Conn.Update("Activity", "Where StudyYear = '" + ddlYearB.SelectedValue + "'", "ApproveFlag", Convert.DBNull);
        Response.Redirect("ApproveAll.aspx?ckmode=5&Cr=" + i);  
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}
