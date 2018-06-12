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

public partial class Costs2Edit : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    decimal TotalMoney;

    protected override void OnInit(EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["opt"])) AjaxOption(Request.QueryString["opt"]);
        base.OnInit(e);
    }
    private void AjaxOption(string opt)
    {
        object data = "";
        switch (opt)
        {
            case "delete":
                break;
            case "delAtt":
                data = DeleteItems(Request.QueryString["attID"]);
                break;
        }

        Response.Write(data.ToString());
        Response.End();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //เช็คปีงบประมาณ
            btc.ckBudgetYear(null, lblYear);
            if (btc.ckIdentityName("ckBudgetYear"))
            {
                lblYear2.InnerText = "ปีการศึกษา : ";
            }

            getddlYear(1);
            btc.getddlDay(ddlSDay);
            btc.getddlMonth2(ddlSMonth);
            btc.getddlYear(ddlSYear, 4);
            btc.getddlDay(ddlEDay);
            btc.getddlMonth2(ddlEMonth);
            btc.getddlYear(ddlEYear, 4);

            string mode = Request.QueryString["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 0;
                        GetData(Request.QueryString["id"]);
                        GetDataAttach(Request.QueryString["id"]);
                        if (btc.CkActivitySuccess(Request.QueryString["id"]))
                        {
                            btSave.Visible = false;
                            if (CurrentUser.RoleLevel >= 98)
                            {
                                btUndo.Visible = true;
                            }
                        }
                        break;
                    case "3":
                        break;
                }
            }           
        }
        ddlSDay.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSMonth.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSYear.Attributes.Add("onchange", "ckddlDate(1);");
        ddlEDay.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEMonth.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEYear.Attributes.Add("onchange", "ckddlDate(2);");
    }
    private void getlblTarget()
    {
        string[] lblTarget = btc.getlblTarget().Split(',');
        lblTarget1.Text = lblTarget[0];
        lblTarget2.Text = lblTarget[1];
    }
    private void getddlYear(int mode)
    {
        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    //private void getddlStrategies(int mode, string StudyYear)
    //{
    //    if (mode == 1)
    //    {
    //        btc.getddlStrategies(1, ddlStrategies, StudyYear, null);
    //    }
    //}
    private void getddlProjects(int mode, string StudyYear, string StrategiesCode)
    {
        if (mode == 1)
        {
            btc.getddlProjects(1, ddlProjects, StudyYear, StrategiesCode, null);
        }
    }
    private void getddlActivity(int mode, string ProjectsCode)
    {
        if (mode == 1)
        {
            btc.getddlActivity(1, ddlActivity, ProjectsCode, null);
        }
    }
    private void getActivityDetail(string ActivityCode)
    {
        DataView dv = btc.getActivityDetail(ActivityCode);
        if (dv.Count != 0)
        {
            txtActivityDetail.Text = dv[0]["ActivityDetail"].ToString();
            txtTarget.Text = dv[0]["Target"].ToString();
            txtTarget2.Text = dv[0]["Target2"].ToString();
            lblTerm.Text = dv[0]["Term"].ToString() + "/" + dv[0]["YearB"].ToString();
            lblBudgetYear.Text = dv[0]["BudgetYear"].ToString();
            lblDepartment.Text = dv[0]["DeptName"].ToString();
            lblEmpName.Text = dv[0]["EmpName"].ToString();
            lblVolumeExpect.Text = string.IsNullOrEmpty(dv[0]["VolumeExpect"].ToString()) ? "0" : Convert.ToDecimal(dv[0]["VolumeExpect"]).ToString("#,##0");
            txtVolumeCan.Text = string.IsNullOrEmpty(dv[0]["VolumeCan"].ToString()) ? "0" : Convert.ToDecimal(dv[0]["VolumeCan"]).ToString("#,##0");
        }
        else
        {
            txtActivityDetail.Text = "";
            txtTarget.Text = "";
            txtTarget2.Text = "";
            lblTerm.Text = "";
            lblBudgetYear.Text = "";
            lblDepartment.Text = "";
            lblEmpName.Text = "";
            lblVolumeExpect.Text = "0";
            txtVolumeCan.Text = "0";
        }
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        string strSQL = @" Select S.StrategiesCode, p.ProjectsCode, a.ActivityCode, a.DeptCode, a.CostsType, a.TotalAmount, a.StudyYear, a.BudgetYear, 
                a.Term, a.YearB, a.SDate, a.EDate, a.CostsType2, a.SDate2, a.EDate2, IsNull(a.ckTime, 0) ckTime, a.Results 
                From Activity a Inner Join Projects p On a.ProjectsCode = p.ProjectsCode
                Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode  
                Where a.ActivityCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSQL, id));

        if (dv.Table.Rows.Count != 0)
        {
            getlblTarget();
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            //getddlStrategies(1, ddlYearB.SelectedValue);
            //ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            getddlProjects(1, ddlYearB.SelectedValue, "");
            ddlProjects.SelectedValue = dv[0]["ProjectsCode"].ToString();
            getddlActivity(1, ddlProjects.SelectedValue);
            ddlActivity.SelectedValue = dv[0]["ActivityCode"].ToString();
            getActivityDetail(ddlActivity.SelectedValue);
            txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToString("dd/MM/yyyy");
            txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToString("dd/MM/yyyy");
            txtSDay2.Text = (string.IsNullOrEmpty(dv[0]["SDate2"].ToString())) ? Convert.ToDateTime(dv[0]["SDate"]).ToString("dd/MM/yyyy") : Convert.ToDateTime(dv[0]["SDate2"]).ToString("dd/MM/yyyy");
            txtEDay2.Text = (string.IsNullOrEmpty(dv[0]["EDate2"].ToString())) ? Convert.ToDateTime(dv[0]["EDate"]).ToString("dd/MM/yyyy") : Convert.ToDateTime(dv[0]["EDate2"]).ToString("dd/MM/yyyy");

            ddlSDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate2"].ToString())) ? Convert.ToDateTime(dv[0]["SDate"]).Day.ToString("00") : Convert.ToDateTime(dv[0]["SDate2"]).Day.ToString("00");
            ddlSMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate2"].ToString())) ? Convert.ToDateTime(dv[0]["SDate"]).Month.ToString("00") : Convert.ToDateTime(dv[0]["SDate2"]).Month.ToString("00");
            ddlSYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate2"].ToString())) ? (Convert.ToDateTime(dv[0]["SDate"]).Year +543).ToString() : (Convert.ToDateTime(dv[0]["SDate2"]).Year + 543).ToString();

            ddlEDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate2"].ToString())) ? Convert.ToDateTime(dv[0]["EDate"]).Day.ToString("00") : Convert.ToDateTime(dv[0]["EDate2"]).Day.ToString("00");
            ddlEMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate2"].ToString())) ? Convert.ToDateTime(dv[0]["EDate"]).Month.ToString("00") : Convert.ToDateTime(dv[0]["EDate2"]).Month.ToString("00");
            ddlEYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate2"].ToString())) ? (Convert.ToDateTime(dv[0]["EDate"]).Year + 543).ToString() : (Convert.ToDateTime(dv[0]["EDate2"]).Year + 543).ToString();

            //ddlStrategies.Enabled = false;
            ddlProjects.Enabled = false;
            ddlActivity.Enabled = false;

            strSQL = "Select * From ActivityDetail Where ActivityCode = '" + id + "' And DelFlag = 0";
            DataView dvCkDt = Conn.Select(strSQL);

            strSQL = "Select IsNull(TotalAmount2,0) TotalAmount2 From Activity Where ActivityCode = '" + id + "'";
            DataView dvckTl = Conn.Select(strSQL);

            DataView dv1;
            if ((dvCkDt.Count == 0) || (Convert.ToDecimal(dvckTl[0]["TotalAmount2"]) != 0))
            {
                strSQL = " Select a.ActivityCode, a.ListName, a.ListName As EntryCostsCode, a.BudgetTypeCode, "
                + " a.TotalP, a.TotalD, a.TotalG, a.TotalMoney, a.TotalMoney2, a.ItemID, "
                + " BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, "
                + " a.ListName As EntryCostsName,  ValueT = Case IsNull(a.TotalMoney2,0) When 0 Then 0 Else a.TotalMoney2 End, '' As TotalMoney2Ag "
                    + " From CostsDetail a, BudgetType b "
                    + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
                dv1 = Conn.Select(string.Format(strSQL + " Order By a.ListNo, b.Sort ", id));
            }
            else
            {
                strSQL = " Select a.ActivityCode, a.ListName, a.ListName As EntryCostsCode, a.BudgetTypeCode, a.BudgetTypeOtherName, a.TotalP, a.TotalD, a.TotalG, "
                        + " a.TotalMoney, a.TotalMoney2, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, "
                        + " a.ListName As EntryCostsName, IsNull(Sum(e.TotalMoney),0) ValueT, '' As TotalMoney2Ag, b.Sort, a.ListNo, a.ItemID, e.ItemID As ItemID2 "
                        + " From CostsDetail a, BudgetType b, ActivityDetail d, ActivityCostsDetail e "
                        + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = d.ActivityCode "
                        + " And d.ActivityDetailCode = e.ActivityDetailCode And a.ItemID = e.ItemID "
                        + " And a.ActivityCode = '{0}'  "
                        + " Group By a.ActivityCode, a.BudgetTypeCode, a.BudgetTypeOtherName, "
                        + " a.TotalP, a.TotalD, a.TotalG, a.TotalMoney, a.TotalMoney2, BudgetTypeName, a.ListName, b.Sort, a.ListNo, a.ItemID, e.ItemID ";
                dv1 = Conn.Select(string.Format(strSQL + " Order By a.ListNo, b.Sort ", id));
            }
            if (dv1.Count != 0)
            {
                for (int j = 0; j < dv1.Count; j++)
                {
                   dv1[j]["TotalMoney2Ag"] = Convert.ToDecimal(dv1[j]["ValueT"]).ToString("#,##0.00"); //dv1[j]["TotalMoney2Ag"] = 0; 
                }
            }

            GridViewBudget.DataSource = dv1;
            GridViewBudget.DataBind();

            txtResults.Text = dv[0]["Results"].ToString();

            //txtOldTotal.Text = Convert.ToDouble(dv[0]["TotalAmount"]).ToString("#,##0");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal(); ckddlDate(1); ckddlDate(2);", true);
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {            

        }
        if (Request.QueryString["mode"] == "2")
        {
            int result = 0;
            StringBuilder strbSql = new StringBuilder();

            Int32 i = Conn.Update("Activity", "Where ActivityCode = '" + Request.QueryString["id"] + "' ", "TotalAmount2, VolumeCan, SDate2, Edate2, Results, UpdateUser, UpdateDate, SchoolID", Convert.ToDecimal(Request["txtTotalT2"]), Convert.ToDecimal(txtVolumeCan.Text), Convert.ToDateTime(txtSDay2.Text).ToString("s"), Convert.ToDateTime(txtEDay2.Text).ToString("s"), txtResults.Text, CurrentUser.ID, DateTime.Now, CurrentUser.SchoolID);
           
            //Conn.Delete("CostsDetail", "Where ActivityCode = '" + Request.QueryString["id"] + "'");
            for (int j = 0; j < GridViewBudget.Rows.Count; j++)
            {
                strbSql.AppendFormat("UPDATE CostsDetail SET TotalMoney2 = '{1}' Where ActivityCode = '{0}' And ItemID = '" + Request["txtItemID" + j + ""] + "';", Request.QueryString["id"], Convert.ToDecimal(Request["txtT" + j + ""]));

                //Conn.Update("CostsDetail", "Where ActivityCode = '" + Request.QueryString["id"] + "' And ListName = '" + Request.QueryString["txtEntry" + j + ""] + "'", "TotalMoney2", Convert.ToDecimal(Request.QueryString["txtT" + j + ""]));
            }

            //Update Status เป็นดำเนินการเสร็จแล้ว
            strbSql.AppendFormat("UPDATE Activity SET Status = '{1}', ActivityStatus = '{2}' Where ActivityCode = '{0}';", ddlActivity.SelectedValue, "3", "100");

            //Conn.Update("Activity", "Where ActivityCode = '" + ddlActivity.SelectedValue + "'", "Status, ActivityStatus", "3", "100");
            result = Conn.Execute(strbSql.ToString());
            Response.Redirect("CostsView2Edit.aspx?ckmode=5&Cr=" + i);         
        }
    }
    protected void btUndo_Click(object sender, EventArgs e)
    {
        int i = 0;
        //Update Status กลับไปยังไม่ปิดกิจกรรม
        i = Conn.Update("Activity", "Where ActivityCode = '" + ddlActivity.SelectedValue + "'", "Status", "0");
        btc.UpdateStatusActivity();
        Response.Redirect("CostsView2Edit.aspx?ckmode=5&Cr=" + i);    
    }
    public decimal GetTotalMoney(decimal Budget)
    {
        TotalMoney += Budget;
        return Budget;
    }
    public decimal GetSumTotalMoney()
    {
        return TotalMoney;
    }
    private int DeleteItems(string id)
    {
        int i = 0;
        i = Conn.Delete("Multimedia", string.Format("WHERE ItemID='{0}'", id));
        return i;
    }
    private void GetDataAttach(string refid)
    {
        object id;
        if (string.IsNullOrEmpty(refid)) id = DBNull.Value; else id = refid;

        DataView dv = Conn.Call("getAttachFile", "ReferID", id);
        rptAttach.DataSource = dv;
        rptAttach.DataBind();
    }
    protected void btnAttach_Click(object sender, EventArgs e)
    {
        if (fpAttach.HasFile)
        {
            if (btc.ckAttachFileGetExtensionError(fpAttach))
            {
                string NewID = Guid.NewGuid().ToString();
                int rowsEffect = Conn.AddNew("Multimedia", "ItemID,TypeID,Title,FileUrl,FileSize,FileType,ReferID,MediaYear,CreateUser,CreateDate,UpdateUser,UpdateDate,Source,Shared,Enabled,Flag",
                    NewID, cbDuo.Checked, fpAttach.FileName, "", fpAttach.PostedFile.ContentLength, fpAttach.PostedFile.ContentType, Request.QueryString["id"], DateTime.Now.Year, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, 1, 0, 1, 0);
                btc.UploadFileAttach(fpAttach, NewID, btc.getAttachType(fpAttach.PostedFile.ContentType, Convert.ToInt32(cbDuo.Checked)));

                if (cbDuo.Checked && fpAttach.FileName.ToString().Substring(fpAttach.FileName.ToString().IndexOf('.')).Contains(".zip"))
                {
                    UnZipFiles(fpAttach, NewID);
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "alert('ไม่รองรับไฟล์นี้');", true);
            }
            cbDuo.Checked = false;
            GetDataAttach(Request.QueryString["id"]);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
        }
    }
    protected string getImgAttatch(object ItemID, object title, object filetype, object TypeId)
    {
        string link = btc.getImageAttachFileType(btc.getAttachType(filetype.ToString(), Convert.ToInt32(TypeId)), ItemID, title);
        return string.Format(link);
    }
    private void UnZipFiles(FileUpload fpAttach, string NewID)
    {
        string path = ConfigurationManager.AppSettings["FilePath"].ToString();

        string UlFileName = "";
        string[] filetype = fpAttach.FileName.Split('.');

        ICSharpCode.SharpZipLib.Zip.FastZip myZip = new ICSharpCode.SharpZipLib.Zip.FastZip();

        UlFileName = path + NewID + "." + filetype[1].ToString();
        Page sv = new Page();
        myZip.ExtractZip(sv.Server.MapPath(UlFileName), sv.Server.MapPath("~/Temp/" + NewID), "");
    }
}
