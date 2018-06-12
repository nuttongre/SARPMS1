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

public partial class Education21Evaluate : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    DataView dvEvaluate = null;
        
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

            //btc.LinkReport(linkReport);

            getddlYear(0);
            getddlEvaluateType(0);
            getddlEducation21Side(0, ddlSearchYear.SelectedValue);
            getddlEducation21Standard(0, ddlSearch.SelectedValue);
            //btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request["id"], Request.QueryString["lv"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
        ddlEducation21Criterion.Attributes.Add("onchange", "ckDivCriterion(); Cktxt(0);");
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
    }
    private void getddlEvaluateType(int mode)
    {
        if (mode == 0)
        {
            ddlSearchEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
            ddlSearchEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
            ddlSearchEvaluateType.DataBind();
            //ddlSearchEvaluateType.SelectedIndex = 0;

            if (Cookie.GetValue2("EvaluateType") == null)
            {
                ddlSearchEvaluateType.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddlSearchEvaluateType.SelectedValue = Cookie.GetValue2("EvaluateType").ToString();
                }
                catch (Exception ex)
                {
                    ddlSearchEvaluateType.SelectedIndex = 0;
                }
            }
        }

        if (mode == 1)
        {
        }
    }
    private void getddlEducation21Side(int mode, string StudyYear)
    {
        string strSql = @"Select Education21SideID, Cast(Sort as nvarchar) + ' - ' + Education21SideName FullName, Sort 
            From Education21Side Where DelFlag = 0 And StudyYear = '{0}' And EvaluateType = '{1}' Order By Sort";

        if (mode == 0)
        {
            DataView dv = Conn.Select(string.Format(strSql, StudyYear, ddlSearchEvaluateType.SelectedValue));
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "Education21SideID";
                ddlSearch.DataBind();
                ddlSearch.Enabled = true;
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                //ddlSearch.SelectedIndex = 0;

                if (Cookie.GetValue2("Education21Side") == null)
                {
                    ddlSearch.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddlSearch.SelectedValue = Cookie.GetValue2("Education21Side").ToString();
                    }
                    catch (Exception ex)
                    {
                        ddlSearch.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearch.SelectedIndex = 0;
                ddlSearch.Enabled = false;
            }
        }
    }
    private void getddlEducation21Standard(int mode, string Education21SideID)
    {
        DataView dv = Conn.Select("Select Education21StandardID, Cast(Sort as nvarchar) + ' - ' + Education21StandardName FullName, Sort From Education21Standard Where DelFlag = 0 And Education21SideID = '" + Education21SideID + "' Order By Sort");

        if (mode == 0)
        {
            if (dv.Count != 0)
            {
                ddlSearchStandard.DataSource = dv;
                ddlSearchStandard.DataTextField = "FullName";
                ddlSearchStandard.DataValueField = "Education21StandardID";
                ddlSearchStandard.DataBind();
                ddlSearchStandard.Enabled = true;
                ddlSearchStandard.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                //ddlSearchStandard.SelectedIndex = 0;

                if (Cookie.GetValue2("Education21Standard") == null)
                {
                    ddlSearchStandard.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddlSearchStandard.SelectedValue = Cookie.GetValue2("Education21Standard").ToString();
                    }
                    catch (Exception ex)
                    {
                        ddlSearchStandard.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddlSearchStandard.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearchStandard.SelectedIndex = 0;
                ddlSearchStandard.Enabled = false;
            }
        }
    }
    private void getddlEducation21Criterion(string Education21IndicatorID)
    {
        string strSql = @" Select Education21CriterionID, Detail, Score, Sort, 'ระดับคุณภาพที่ ' + Cast(Sort As nVarchar) As cSort 
            From Education21Criterion Where Education21IndicatorID = '{0}' Order By Sort ";
        if (Request.QueryString["lv"] == "A")
        { 
        
        }
        DataView dvCriterion = Conn.Select(string.Format(strSql, Education21IndicatorID));

        if (dvCriterion.Count != 0)
        {
            ddlEducation21Criterion.DataSource = dvCriterion;
            ddlEducation21Criterion.DataTextField = "cSort";
            ddlEducation21Criterion.DataValueField = "Sort";
            ddlEducation21Criterion.DataBind();
            ddlEducation21Criterion.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlEducation21Criterion.SelectedIndex = 0;
        }
        else
        {
            ddlEducation21Criterion.Items.Insert(0, new ListItem("-เลือก-", ""));
            ddlEducation21Criterion.SelectedIndex = 0;
            ddlEducation21Criterion.Enabled = false;
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select EE.Education21EvaluateID, EE.Education21IndicatorID, EE.Education21StandardID, EE.Sort, EC.Score 
            From Education21Evaluate EE, Education21Side ES, Education21Standard ED, Education21Indicator EI, Education21Criterion EC
            Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0 And EI.DelFlag = 0
            And ES.Education21SideID = ED.Education21SideID And ED.Education21StandardID = EI.Education21StandardID 
            And EI.Education21IndicatorID = EC.Education21IndicatorID
            And (EI.Education21IndicatorID = EE.Education21IndicatorID 
			OR ED.Education21StandardID = EE.Education21StandardID)
            And EC.Sort = EE.Sort ";
        dvEvaluate = Conn.Select(string.Format(StrSql, ddlSearchYear.SelectedValue));

        StrSql = @" Select * From(
            Select b.Education21StandardID As eID, b.Education21StandardID As StandardID, b.Education21StandardName As StandardName, '' As IndicatorName, c.Education21SideID,
            Cast(c.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) As eSort, 'A' As lv,
            c.StudyYear, c.EvaluateType
            From Education21Standard b, Education21Side c  
            Where b.DelFlag = 0 And b.ckEvaluate = 1 And c.Education21SideID = b.Education21SideID
            Union
            Select a.Education21IndicatorID As eID, b.Education21StandardID As StandardID, b.Education21StandardName As StandardName, a.Education21IndicatorName As IndicatorName, c.Education21SideID,
            Cast(c.Sort As nVarChar(3)) + '.' + Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As eSort, 'B' As lv,
            c.StudyYear, c.EvaluateType
            From Education21Indicator a, Education21Standard b, Education21Side c  
            Where a.DelFlag = 0 And b.ckEvaluate = 0 And c.Education21SideID = b.Education21SideID And b.Education21StandardID = a.Education21StandardID)tb
            Where StudyYear = '" + ddlSearchYear.SelectedValue + "' And EvaluateType = '" + ddlSearchEvaluateType.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And Education21SideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearchStandard.SelectedIndex != 0)
        {
            StrSql = StrSql + " And StandardID = '" + ddlSearchStandard.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (StandardName Like '%" + txtSearch.Text + "%' Or IDName Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By lv, eSort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private void GetData(string id, string lv)
    {
        string ckEducation21IndicatorID = "";
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select Cast(S.Sort As nVarchar) + '. ' + S.Education21SideName As Education21SideName, EvaluateType = Case S.EvaluateType When 0 Then 'ประเมินวิธีการ' When 1 Then 'ประเมินผลงาน' End,
                Cast(S.Sort As nVarchar) + '.' + Cast(SD.Sort As nVarchar) + ' ' + SD.Education21StandardName As Education21StandardName,
                Cast(S.Sort As nVarchar) + '.' + Cast(SD.Sort As nVarchar) + '.' + Cast(SI.Sort As nVarchar) + ' ' + SI.Education21IndicatorName As Education21IndicatorName,
                SI.Detail As SIDetail, SD.Detail AS SDDetail, S.StudyYear, SD.Education21SideID, SI.Education21IndicatorID  
                From Education21Side S, Education21Standard SD, Education21Indicator SI
                Where S.DelFlag = 0 And SD.DelFlag = 0 And SI.DelFlag = 0
                And S.Education21SideID = SD.Education21SideID And SD.Education21StandardID = SI.Education21StandardID ";

        if (lv == "A") // ประเมินมาตรฐาน
        {
            strSql += " And SI.Education21StandardID = '{0}' ";
        }

        if (lv == "B") // ประเมินตัวชี้วัด
        {
            strSql += " And SI.Education21IndicatorID = '{0}' ";
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By S.Sort, SD.Sort, SI.Sort ", id));

        if (dv.Count != 0)
        {
            divStudyYear.InnerHtml = dv[0]["StudyYear"].ToString();
            divEvaluateType.InnerHtml = dv[0]["EvaluateType"].ToString();
            divEducation21Side.InnerHtml = dv[0]["Education21SideName"].ToString();
            divEducation21Standard.InnerHtml = dv[0]["Education21StandardName"].ToString();

            if (lv == "A") // ประเมินมาตรฐาน
            {
                ckEducation21IndicatorID = dv[0]["Education21IndicatorID"].ToString(); 
                string Education21IndicatorName = "";
                for (int i = 0; i < dv.Count; i++)
                {
                    Education21IndicatorName += dv[i]["Education21IndicatorName"].ToString();
                    if ((i + 1) != dv.Count)
                    {
                        Education21IndicatorName += "<BR />";
                    }
                }
                divEducation21Indicator.InnerHtml = Education21IndicatorName;
                divDetail.InnerHtml = dv[0]["SDDetail"].ToString();
            }
            if (lv == "B") // ประเมินตัวชี้วัด
            {
                ckEducation21IndicatorID = Request.QueryString["id"];
                divEducation21Indicator.InnerHtml = dv[0]["Education21IndicatorName"].ToString();
                divDetail.InnerHtml = dv[0]["SIDetail"].ToString();
            }
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Education21Indicator", "Education21IndicatorID", id);

        if (!string.IsNullOrEmpty(ckEducation21IndicatorID))
        {
            //ddl ระดับคุณภาพ
            getddlEducation21Criterion(ckEducation21IndicatorID);

            //คำอธิบายระดับคุณภาพ
            strSql = @" Select Education21CriterionID, Detail, Score, Sort, 'ระดับคุณภาพที่ ' + Cast(Sort As nVarchar) As cSort 
            From Education21Criterion Where Education21IndicatorID = '{0}' Order By Sort ";
            DataView dvCriterion = Conn.Select(string.Format(strSql, ckEducation21IndicatorID));
            if (dvCriterion.Count != 0)
            {
                rptCriterion.DataSource = dvCriterion;
                rptCriterion.DataBind();
            }

            //ระดับคุณภาพ
            if (lv == "A") // ประเมินมาตรฐาน
            {
                strSql = @"Select * from Education21Evaluate Where Education21StandardID = '{0}'";
            }
            if (lv == "B") // ประเมินตัวชี้วัด
            {
                strSql = @"Select * from Education21Evaluate Where Education21IndicatorID = '{0}'";
            }
            
            DataView dv2 = Conn.Select(string.Format(strSql, id));
            if (dv2.Count != 0)
            {
                ddlEducation21Criterion.SelectedValue = dv2[0]["Sort"].ToString();
                Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "ckDivCriterion();", true);
            }
        }
        GetDataAttach(id);
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Education21Side", ddlSearch.SelectedValue);
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchStandard_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Education21Standard", ddlSearchStandard.SelectedValue);
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        StringBuilder strbSql = new StringBuilder();
        string strSql = "";
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
        }
        if (Request["mode"] == "2")
        {
            if (Request.QueryString["lv"] == "A") // ประเมินมาตรฐาน
            {
                strSql = @"Select * from Education21Evaluate Where Education21StandardID = '{0}'";
            }
            if (Request.QueryString["lv"] == "B") // ประเมินตัวชี้วัด
            {
                strSql = @"Select * from Education21Evaluate Where Education21IndicatorID = '{0}'";
            }
            DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["id"]));
            if (dv.Count != 0)
            {
                if (Request.QueryString["lv"] == "A") // ประเมินมาตรฐาน
                {
                    i = Conn.Update("Education21Evaluate", "Where Education21StandardID = '" + Request.QueryString["id"] + "'", "Sort, UpdateDate, UpdateUser",
                    ddlEducation21Criterion.SelectedValue, DateTime.Now.ToString("s"), CurrentUser.ID);
                }
                if (Request.QueryString["lv"] == "B") // ประเมินตัวชี้วัด
                {
                    i = Conn.Update("Education21Evaluate", "Where Education21IndicatorID = '" + Request.QueryString["id"] + "'", "Sort, UpdateDate, UpdateUser",
                    ddlEducation21Criterion.SelectedValue, DateTime.Now.ToString("s"), CurrentUser.ID);
                }
            }
            else
            {
                if (Request.QueryString["lv"] == "A") // ประเมินมาตรฐาน
                {
                    i = Conn.AddNew("Education21Evaluate", "Education21EvaluateID, Education21StandardID, Sort, CreateUser, CreateDate, UpdateUser, UpdateDate",
                    Guid.NewGuid().ToString(), Request.QueryString["id"], ddlEducation21Criterion.SelectedValue, CurrentUser.ID, DateTime.Now.ToString("s"), CurrentUser.ID, DateTime.Now.ToString("s"));
                }
                if (Request.QueryString["lv"] == "B") // ประเมินตัวชี้วัด
                {
                    i = Conn.AddNew("Education21Evaluate", "Education21EvaluateID, Education21IndicatorID, Sort, CreateUser, CreateDate, UpdateUser, UpdateDate",
                    Guid.NewGuid().ToString(), Request.QueryString["id"], ddlEducation21Criterion.SelectedValue, CurrentUser.ID, DateTime.Now.ToString("s"), CurrentUser.ID, DateTime.Now.ToString("s"));
                }
            }
            Response.Redirect("Education21Evaluate.aspx?ckmode=2&Cr=" + i); 
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save("N");
    }
    protected void btSaveAgain_Click(object sender, EventArgs e)
    {
        bt_Save("Y");
    }
    private void Delete(string id)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(id)) return;
        //if (btc.CkUseData(id, "Education21IndicatorID", "Education21Criterion", ""))
        //{
        //    Response.Redirect("Education21Evaluate.aspx?ckmode=3&Cr=0");    
        //}
        //else
        //{

        if (Request.QueryString["lv"] == "A") // ประเมินมาตรฐาน
        {
            i = Conn.Delete("Education21Evaluate", "Where Education21StandardID = '" + id + "' ");
        }
        if (Request.QueryString["lv"] == "B") // ประเมินตัวชี้วัด
        {
            i = Conn.Delete("Education21Evaluate", "Where Education21IndicatorID = '" + id + "' ");
        }
        Response.Redirect("Education21Evaluate.aspx?ckmode=3&Cr=" + i);
        //}
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearchEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("EvaluateType", ddlSearchEvaluateType.SelectedValue);
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        getddlEducation21Standard(0, ddlSearch.SelectedValue);
        DataBind();
    }
    protected string checkedit(string id, string strName, string lv)
    {
        string StyleColor = "style=\"color:gray !important;\"";

        if (lv == "A") // ประเมินมาตรฐาน
        {
            dvEvaluate.RowFilter = "Education21StandardID = '" + id + "'";
        }
        if (lv == "B") // ประเมินตัวชี้วัด
        {
            dvEvaluate.RowFilter = "Education21IndicatorID = '" + id + "'";
        }

        if (dvEvaluate.Count != 0)
        {
            if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 1)
            {
                StyleColor = "style=\"color:red !important;\"";
            }
            //if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 2)
            //{
            //    StyleColor = "style=\"color:#aeb000 !important;\"";
            //}
            //if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 3)
            else
            {
                StyleColor = "style=\"color:green !important;\"";
            }
        }
        return String.Format("<a href=\"javascript:;\" " + StyleColor + " onclick=\"EditItem('{0}','{2}');\">{1}</a>", id, strName, lv);
        //if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
        //{
        //    return String.Format("<a href=\"javascript:;\" style=\"color:red !important;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        //}
        //else
        //{
        //    return strName;
        //}
    }
    protected string checkEvaluate(string Education21IndicatorID, string lv)
    {
        string StyleColor = "style=\"color:gray !important; font-weight:bold;\"";
        string Link = "<a href=\"javascript:;\" onclick=\"EditItem('" + Education21IndicatorID + "');\"><img alt=\"\" style=\"border: 0; cursor: pointer;\" title=\"ประเมิน\" src=\"../Image/reporticon.gif\" /></a>";

        if (lv == "A") // ประเมินมาตรฐาน
        {
            dvEvaluate.RowFilter = "Education21StandardID = '" + Education21IndicatorID + "'";
        }
        if (lv == "B") // ประเมินตัวชี้วัด
        {
            dvEvaluate.RowFilter = "Education21IndicatorID = '" + Education21IndicatorID + "'";
        }

        if(dvEvaluate.Count != 0)
        {
            if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 1)
            {
                StyleColor = "style=\"color:red !important; font-weight:bold;\"";
            }
            //if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 2)
            //{
            //    StyleColor = "style=\"color:#aeb000 !important; font-weight:bold;\"";
            //}
            //if (Convert.ToInt32(dvEvaluate[0]["Sort"]) == 3)
            else
            {
                StyleColor = "style=\"color:green !important; font-weight:bold;\"";
            }
            Link = "<a href=\"javascript:;\" " + StyleColor + " onclick=\"EditItem('" + Education21IndicatorID + "','" + lv + "');\">" + dvEvaluate[0]["Score"].ToString() + "</a>";
        }
        return Link;
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
                    NewID, cbDuo.Checked, fpAttach.FileName, "", fpAttach.PostedFile.ContentLength, fpAttach.PostedFile.ContentType, Request["id"], DateTime.Now.Year, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, 1, 0, 1, 0);
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
            GetDataAttach(Request["id"]);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "ckDivCriterion();", true);
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
