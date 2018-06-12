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

public partial class Indicators2Edit : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    
    public static DataView dv;
    public static string path = ConfigurationManager.AppSettings["FilePath"].ToString();

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
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);
            if (btc.ckIdentityName("ckBudgetYear"))
            {
                lblYear2.InnerText = "ปีการศึกษา : ";
            }

            string mode = Request.QueryString["mode"];
            string delmode = Request.QueryString["delmode"];
            int ij = string.IsNullOrEmpty(Request.QueryString["i"])? 0 : Convert.ToInt32(Request.QueryString["i"]);
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        GetData(Request.QueryString["id"]);
                        GetDataAttach(Request.QueryString["id"]);
                        EnableTxt(false);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "CkPercent(0);", true);
                        break;
                    case "3":
                        break;
                    case "4":
                        btc.Msg_Head(Img1, MsgHead, true, "2", ij);
                        break;
                }
            }
            else
            {
                getddlYear(0);
                //getddlStrategies(0, ddlSearchYear.SelectedValue);
                getddlProjects(0, ddlSearchYear.SelectedValue, "");
                getddlActivity(0, ddlSearch.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
                DataBind();
            }          
        }
        //ddlStrategies.Attributes.Add("onchange", "Cktxt(0);");
        ddlProjects.Attributes.Add("onchange", "Cktxt(0);");
        ddlActivity.Attributes.Add("onchange", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
        txtWeight.Attributes.Add("onchange", "CkWeight();");
        txtCan.Attributes.Add("onchange", "CkNum(); CkPercent(0);");
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    //private void getddlStrategies(int mode, string StudyYear)
    //{
    //    if (mode == 0)
    //    {
    //        btc.getddlStrategies(0, ddlSearch2, StudyYear, Cookie.GetValue2("ckStrategiesCode"));
    //    }

    //    if (mode == 1)
    //    {
    //        btc.getddlStrategies(1, ddlStrategies, StudyYear, null);
    //    }
    //}
    private void getddlProjects(int mode, string StudyYear, string StrategiesCode)
    {
        if (mode == 0)
        {
            btc.getddlProjects(0, ddlSearch, StudyYear, StrategiesCode, Cookie.GetValue2("ckProjectsCode"));
        }

        if (mode == 1)
        {
            btc.getddlProjects(1, ddlProjects, StudyYear, StrategiesCode, null);
        }
    }
    private void getddlActivity(int mode, string ProjectsCode)
    {
        if (mode == 0)
        {
            btc.getddlActivityIsApprove(0, ddlSearch1, ProjectsCode, Cookie.GetValue2("ckActivityCode"));
        }

        if (mode == 1)
        {
            btc.getddlActivityIsApprove(1, ddlActivity, ProjectsCode, null);
        }
    }
    private void getddlDepartment()
    {
        btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
    }
    private void getActivityDetail(string ActivityCode)
    {
        DataView dv = btc.getActivityDetail(ActivityCode);
        if (dv.Count != 0)
        {
            txtActivityDetail.Text = dv[0]["ActivityDetail"].ToString();
            lblType.Text = dv[0]["CostsType"].ToString();
            lblTerm.Text = dv[0]["Term"].ToString() + "/" + dv[0]["YearB"].ToString();
            lblBudgetYear.Text = dv[0]["BudgetYear"].ToString();
            txtTotalAmount.Text = Convert.ToDouble(dv[0]["TotalAmount"]).ToString("#,##0.00");
            lblDepartment.Text = dv[0]["DeptName"].ToString();
            lblEmpName.Text = dv[0]["EmpName"].ToString();
            txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString();
            txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString();
        }
        else
        {
            txtActivityDetail.Text = "";
            lblType.Text = "";
            lblTerm.Text = "";
            lblBudgetYear.Text = "";
            txtTotalAmount.Text = "0.00";
            lblDepartment.Text = "";
            lblEmpName.Text = "";
            txtSDay.Text = "";
            txtEDay.Text = "";
        }
    }
    public override void DataBind()
    {
        string StrSql = @"Select a.ProjectsName FullName, b.ActivityCode, b.ActivityName, 
        c.Indicators2Code, c.IndicatorsName2 IndicatorsName2, c.Weight, 
        WeightType = Case c.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, c.OffAll, c.OffThat, c.Sort 
        From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
        Inner Join Activity b On a.ProjectsCode = b.ProjectsCode
        Inner Join Indicators2 c On b.ActivityCode = c.ActivityCode
        Where c.DelFlag = 0 And a.StudyYear = '{0}' 
        And b.ApproveFlag = 1 And c.SchoolID = '{1}' ";
        if (ddlSearchDept.SelectedIndex != 0)
        {
            StrSql = @"Select a.ProjectsName FullName, b.ActivityCode, b.ActivityName, 
                    c.Indicators2Code, c.IndicatorsName2 IndicatorsName2, c.Weight, 
                    WeightType = Case c.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, c.OffAll, c.OffThat, c.Sort 
                    From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode
                    Inner Join Activity b On a.ProjectsCode = b.ProjectsCode
                    Inner Join Indicators2 c On b.ActivityCode = c.ActivityCode
                    Inner Join dtAcDept d On b.ActivityCode = d.ActivityCode
                    Where c.DelFlag = 0 And a.StudyYear = '{0}' And c.SchoolID = '{1}' 
                    And b.ApproveFlag = 1 And d.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlSearchEmp.SelectedIndex != 0)
        {
            if (ddlSearchDept.SelectedIndex == 0)
            {
                StrSql = @"Select a.ProjectsName FullName, b.ActivityCode, b.ActivityName, 
                       c.Indicators2Code, c.IndicatorsName2 IndicatorsName2, c.Weight, 
                       WeightType = Case c.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, c.OffAll, c.OffThat, c.Sort 
                       From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
                       Inner Join Activity b On a.ProjectsCode = b.ProjectsCode
                       Inner Join Indicators2 c On b.ActivityCode = c.ActivityCode
                       Inner Join dtAcEmp d On b.ActivityCode = d.ActivityCode
                       Where c.DelFlag = 0 And a.StudyYear = '{0}' And c.SchoolID = '{1}' 
                       And b.ApproveFlag = 1 And d.EmpCode = '" + ddlSearchEmp.SelectedValue + "'";
            }
            else
            {
                StrSql = @"Select a.ProjectsName FullName, b.ActivityCode, b.ActivityName, 
                         c.Indicators2Code, c.IndicatorsName2 IndicatorsName2, c.Weight, 
                         WeightType = Case c.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, c.OffAll, c.OffThat, c.Sort 
                         From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
                         Inner Join Activity b On a.ProjectsCode = b.ProjectsCode
                         Inner Join Indicators2 c On  b.ActivityCode = c.ActivityCode
                         Inner Join dtAcEmp d On b.ActivityCode = d.ActivityCode 
                         Inner Join dtAcDept e On b.ActivityCode = e.ActivityCode
                         Where c.DelFlag = 0 And a.StudyYear = '{0}' And c.SchoolID = '{1}' 
                         And b.ApproveFlag = 1 And d.EmpCode = '" + ddlSearchEmp.SelectedValue + "' And e.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
            }
        }
        //if (ddlSearch2.SelectedIndex != 0)
        //{
        //    StrSql = StrSql + " And S.StrategiesCode = '" + ddlSearch2.SelectedValue + "'";
        //}
        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ProjectsCode = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearch1.SelectedIndex != 0)
        {
            StrSql = StrSql + " And b.ActivityCode = '" + ddlSearch1.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And c.IndicatorsName2 Like '%" + txtSearch.Text + "%' ";
        }

        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort Desc, b.Sort Desc, c.Sort Desc", ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;

        string strSql = @"Select a.ProjectsCode, a.StudyYear, S.StrategiesCode, b.ActivityCode, b.Note, c.IndicatorsName2, 
        c.Weight, c.WeightType, c.OffAll, c.OffThat, c.APercent, c.CkCriterion, c.Sort 
        From Projects a Left Join dtStrategies S On a.ProjectsCode = S.ProjectsCode 
        Inner Join Activity b On  a.ProjectsCode = b.ProjectsCode
        Inner Join Indicators2 c On b.ActivityCode = c.ActivityCode
        Where c.Indicators2Code = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            //getddlStrategies(1, ddlYearB.SelectedValue);
            //ddlStrategies.SelectedValue = dv[0]["StrategiesCode"].ToString();
            getddlProjects(1, ddlYearB.SelectedValue, "");
            ddlProjects.SelectedValue = dv[0]["ProjectsCode"].ToString();
            getddlActivity(1, ddlProjects.SelectedValue);
            ddlActivity.SelectedValue = dv[0]["ActivityCode"].ToString();
            getActivityDetail(ddlActivity.SelectedValue);
            txtNote.Text = dv[0]["Note"].ToString();
            txtIndicators2Edit.Text = dv[0]["IndicatorsName2"].ToString();
            txtWeight.Text = Convert.ToInt32(dv[0]["Weight"]).ToString("#,##0");
            lblWeightType.Text = (Convert.ToInt32(dv[0]["WeightType"]) == 0) ? "%" : "";
            txtAll.Text = string.IsNullOrEmpty(dv[0]["OffAll"].ToString()) ? "0" : Convert.ToInt32(dv[0]["OffAll"]).ToString("#,##0");
            txtCan.Text = string.IsNullOrEmpty(dv[0]["OffThat"].ToString()) ? "0" : Convert.ToInt32(dv[0]["OffThat"]).ToString("#,##0");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "CkPercent(0);", true);
            txtSort.Text = dv[0]["Sort"].ToString();

            if (txtAll.Text == "5")
            {
                RateDetail.Visible = true;
            }
            //DataBind2();
        }
    }
    private void ClearAll()
    {
        txtIndicators2Edit.Text = "";
        txtWeight.Text = "50";
        txtSearch.Text = "";
        txtSort.Text = "";
        txtNote.Text = "";
    }
    private void EnableTxt(Boolean Enables)
    {
        ddlYearB.Enabled = Enables;
        //ddlStrategies.Enabled = Enables;
        ddlProjects.Enabled = Enables;
        ddlActivity.Enabled = Enables;
        txtSort.Enabled = Enables;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 CkCriterion = 1;
        if (Convert.ToDouble(txtPercent.Text) < 50)
        {
            CkCriterion = 0;
        }
        
        Int32 i = 0; 
        if (Request.QueryString["mode"] == "2")
        {
            Conn.Update("Activity", "Where ActivityCode = '" + Request.QueryString["acid"] + "' ", "Note", txtNote.Text);
            i = Conn.Update("Indicators2", "Where Indicators2Code = '" + Request.QueryString["id"] + "' ", "OffThat, APerCent, CkCriterion", Convert.ToDouble(txtCan.Text), Convert.ToDouble(txtPercent.Text), CkCriterion);
            Conn.Update("Evaluation", "Where Indicators2Code = '" + Request.QueryString["id"] + "' ", "OffAll, OffThat, APerCent, CkCriterion, UpdateUser, UpdateDate", Convert.ToDouble(txtAll.Text), Convert.ToDouble(txtCan.Text), Convert.ToDouble(txtPercent.Text), CkCriterion, CurrentUser.ID, DateTime.Now);

            //btc.ChangeDefault("Activity", "ActivityCode", ddlActivity.SelectedValue);
            //btc.Msg_Head(Img1, MsgHead, true, "2", i);
        }
        Response.Redirect("Indicators2Edit.aspx?ckmode=2&Cr=" + i);    
        //Response.Redirect("Indicators2Edit.aspx?mode=4&i="+ i);
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        //getddlStrategies(1, ddlYearB.SelectedValue);
        getddlProjects(1, ddlYearB.SelectedValue, "");
        getddlActivity(1, ddlProjects.SelectedValue);
        getActivityDetail(ddlActivity.SelectedValue);
    }
    //protected void ddlStrategies_OnSelectedChanged(object sender, EventArgs e)
    //{
    //    getddlProjects(1, ddlYearB.SelectedValue, "");
    //    getddlActivity(1, ddlProjects.SelectedValue);
    //    getActivityDetail(ddlActivity.SelectedValue);
    //}
    protected void ddlProjects_OnSelectedChanged(object sender, EventArgs e)
    {
        getddlActivity(1, ddlProjects.SelectedValue);
        getActivityDetail(ddlActivity.SelectedValue);
    }
    protected void ddlActivity_OnSelectedChanged(object sender, EventArgs e)
    {
        getActivityDetail(ddlActivity.SelectedValue);
        btc.GenSort(txtSort, "Indicators2", " And ActivityCode = '" + ddlActivity.SelectedValue + "'");
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        //getddlStrategies(0, ddlSearchYear.SelectedValue);
        getddlProjects(0, ddlSearchYear.SelectedValue, "");
        getddlActivity(0, ddlSearch.SelectedValue);
        DataBind();
    }
    //protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Cookie.SetValue2("ckStrategiesCode", ddlSearch2.SelectedValue);
    //    getddlProjects(0, ddlSearchYear.SelectedValue, ddlSearch2.SelectedValue);
    //    getddlActivity(0, ddlSearch.SelectedValue);
    //    DataBind();
    //}
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckProjectsCode", ddlSearch.SelectedValue);
        getddlActivity(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckActivityCode", ddlSearch1.SelectedValue);
        DataBind();
    }
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept.SelectedValue);
        btc.getddlEmpByDept(0, ddlSearchEmp, ddlSearchDept.SelectedValue, Cookie.GetValue2("ckEmpID"));
        DataBind();
    }
    protected void ddlSearchEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckEmpID", ddlSearchEmp.SelectedValue);
        DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "OffThat").ToString() != "0")
            {
                e.Row.ForeColor = System.Drawing.Color.Gray;
            }
            else
            {
                e.Row.Font.Bold = true;
            }

            if (!(e.Row.RowType == DataControlRowType.Header))
            {
                //e.Row.Attributes.Add("onclick", "javascript:window.location='Indicators2Edit.aspx?mode=2&id=" + DataBinder.Eval(e.Row.DataItem, "Indicators2Code") + "&acid=" + DataBinder.Eval(e.Row.DataItem, "ActivityCode") + "'");
            }
        }
    }
    protected string AttachShow(string id)
    {
        string strLink = "";
        DataView dv = Conn.Select("Select Count(ItemId) CountAtt From Multimedia Where ReferID = '" + id + "'");
        if (dv.Count != 0)
        {
            if (Convert.ToInt16(dv[0]["CountAtt"]) > 0)
            {
                strLink = "<a href=\"javascript:;\" onclick=\"AttachShow('" + id + "');\">"
                         + "<img style=\"border: 0; cursor: pointer;\" title=\"แสดงไฟล์แนบ\" src=\"../Image/AttachIcon.png\" /></a>";
            }
        }
        return strLink;
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
