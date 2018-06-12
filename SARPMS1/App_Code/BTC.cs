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
using System.Net.Mail;
using System.IO;
using System.Text;
using System.Globalization;

public class BTC
{
    Connection Conn = new Connection();

    public static string ProductID
    {
        get
        {
            return "27";
        }
    }
    public static void DisplayInValidLicense(System.Web.UI.Page page)
    {
        string inValidLicenseMessage = "Your Software License is invalid or expired. Please contact your Products Vender.";
        page.Title = inValidLicenseMessage;
        page.ClientScript.RegisterStartupScript(page.GetType(), "LicenseControl", "alert(\"" + inValidLicenseMessage + "\");", true);
    }

    public static string GetSize(long size)
    {
        double s = size;
        string[] format = new string[] { "{0} ไบต์", "{0} กิโลไบต์", "{0} เมกกะไบต์", "{0} จิกะไบต์", "{0} เทระไบต์", "{0} เพตะไบต์", "{0} เอกซะไบต์" };
        int i = 0;
        while (i < format.Length && s >= 1024)
        {
            s = (int)(100 * s / 1024) / 100.0;
            i++;
        }
        return string.Format(format[i], s);
    }
    public BTC()
    {
        
    }
    //-------------------------Master-------------------------//
    public Int32 fontView1 = Convert.ToInt32(ConfigurationManager.AppSettings["fontView1"]); //20;
    public Int32 fontView2 = Convert.ToInt32(ConfigurationManager.AppSettings["fontView2"]); //18;
    public Int32 strCut1 = Convert.ToInt32(ConfigurationManager.AppSettings["strCut1"]); //70;
    public Int32 strCut2 = Convert.ToInt32(ConfigurationManager.AppSettings["strCut2"]); //50;
    public Int32 strCut3 = Convert.ToInt32(ConfigurationManager.AppSettings["strCut3"]); //60;
    public Int32 strCut4 = Convert.ToInt32(ConfigurationManager.AppSettings["strCut4"]); //45;

    public DataView getMasterSchool()
    {
        DataView dv = Conn.Select("Select * From Mr_School Where SchoolID = '" + CurrentUser.SchoolID + "' And DelFlag = 0");
        return dv;
    }
    public string SchoolFieldName(string FieldName, string SchoolID)
    {
        string fieldname = "";
        string strSql = "Select SchoolName, ManagerName, LogoPath, ProvinceID, IsCon, ConUser, UpdateLink, LogSarLink, MailTo, "
                + " ManagerSaraGroupName, ManagerPlanName, PositionPlanName, ManagerSuppliesName, PositionSuppliesName, "
                + " ManagerMoneyName, PositionMoneyName, UnderBudgetName, PositionManagerBudgetName, PositionResponsible, PositionHeadGroupSara, PositionHeadGroup, "
                + " UnderManagerName, PositionUnderManagerName "
                + " From Mr_School Where DelFlag = 0 ";
        if (!string.IsNullOrEmpty(SchoolID))
        {
            strSql += " And SchoolID = '" + SchoolID + "' ";
        }
        DataView dv = Conn.Select(strSql);
        switch (FieldName)
        {
            case "SchoolName":
                fieldname = dv[0]["SchoolName"].ToString();
                break;
            case "UpdateLink":
                fieldname = dv[0]["UpdateLink"].ToString();
                break;
            case "LogSarLink":
                fieldname = dv[0]["LogSarLink"].ToString();
                break;
            case "MailTo":
                fieldname = dv[0]["MailTo"].ToString();
                break;
            case "ManagerSaraGroupName":
                fieldname = dv[0]["ManagerSaraGroupName"].ToString();
                break;
            case "ManagerPlanName":
                fieldname = dv[0]["ManagerPlanName"].ToString() + ":" + dv[0]["PositionPlanName"].ToString();
                break;
            case "ManagerSuppliesName":
                fieldname = dv[0]["ManagerSuppliesName"].ToString() + ":" + dv[0]["PositionSuppliesName"].ToString();
                break;
            case "ManagerMoneyName":
                fieldname = dv[0]["ManagerMoneyName"].ToString() + ":" + dv[0]["PositionMoneyName"].ToString();
                break;
            case "UnderBudgetName":
                fieldname = dv[0]["UnderBudgetName"].ToString() + ":" + dv[0]["PositionManagerBudgetName"].ToString();
                break;
            case "UnderManagerName":
                fieldname = dv[0]["UnderManagerName"].ToString() + ":" + dv[0]["PositionUnderManagerName"].ToString();
                break;
            case "Responsible":
                fieldname = "" + ":" + dv[0]["PositionResponsible"].ToString();
                break;
            case "HeadGroupSara":
                fieldname = "" + ":" + dv[0]["PositionHeadGroupSara"].ToString();
                break;
            case "HeadGroup":
                fieldname = "" + ":" + dv[0]["PositionHeadGroup"].ToString();
                break;

        }
        return fieldname;
    }
    public DataView getddlProvince()
    {
        DataView dv = Conn.Select("Select ProvinceID, ProvinceName From Province Where DelFlag = 0 Order By ProvinceName ");
        return dv;
    }
    public string getProvinceName(string id)
    {
        string strProvinceName = "";
        
        DataView dv = Conn.Select("Select ProvinceName From Province Where DelFlag = 0 And ProvinceID = '" + id + "'");
        if (dv.Count != 0)
        {
            strProvinceName = dv[0]["ProvinceName"].ToString();
        }
        return strProvinceName;
    }
    public DataView getddlAmphur(string id)
    {   
        DataView dv = Conn.Select("Select b.AmphurID, b.AmphurName  From Province a, Amphur b Where a.ProvinceID = b.ProvinceID And b.DelFlag = 0 And a.ProvinceID = '" + id + "' Order By a.Sort, b.Sort ");
        return dv;
    }
    public DataView getddlTumbon(string id)
    { 
        DataView dv = Conn.Select("Select b.TumbonID, b.TumbonName From Amphur a, Tumbon b Where a.AmphurID = b.AmphurID And b.DelFlag = 0 And a.AmphurID = '" + id + "' Order By a.Sort, b.Sort");
        return dv;
    }
    public DataView getddlIndicatorsNotIn(string id, Int32 ck, string yearB)
    {        
        string strSql = "Select b.IndicatorsCode, Cast(a.Sort as nvarchar) + '.' + Cast(b.Sort as nvarchar) + ' - ' + b.IndicatorsName FullName, b.Sort From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And a.StandardCode = '" + id + "' ";
        if (ck == 1)
        {
            strSql = strSql + " And b.IndicatorsCode Not In (Select IndicatorsCode From DevelopLevelExpect Where StudyYear = '" + yearB + "' And SchoolID = '" + CurrentUser.SchoolID + "' ) ";
        }
        DataView dv = Conn.Select(strSql + " Order By a.Sort, b.Sort ");
        return dv;
    }
    public DataView getddlProjectsEva(string id, string stid)
    {      
        DataView dv = Conn.Select("Select ProjectsCode, ProjectsName FullName, Sort From Projects Where DelFlag = 0 And StudyYear = '" + id + "' And StrategiesCode = '" + stid + "' And ProjectsCode In (Select ProjectsCode From Evaluation Where DelFlag = '0' And StudyYear = '" + id + "' And StrategiesCode = '" + stid + "') And SchoolID = '" + CurrentUser.SchoolID + "' Order By Sort ");
        return dv;
    }
    public DataView getddlActivity()
    {      
        DataView dv = Conn.Select("Select ActivityCode, ActivityName FullName, Sort From Activity Where DelFlag = 0 Order By Sort ");
        return dv;
    }
    public DataView getddlDevelopLevel(string id)
    {       
        DataView dv = Conn.Select("Select b.DevelopLevelCode, '  ' + Cast(b.LevelScore as nvarchar) + ' - ' + b.LevelDetail FullName, b.LevelScore, b.LevelDetail, b.Sort From Indicators a, DevelopLevel b Where a.IndicatorsCode = b.IndicatorsCode And b.DelFlag = '0' And a.IndicatorsCode = '" + id + "' Order By a.Sort, b.Sort ");
        return dv;
    }
    public DataView getDevelopLevelDetail(string id)
    {      
        DataView dv = Conn.Select("Select DevelopLevelCode, Cast(LevelScore as nvarchar) + ' - ' + LevelDetail FullName, LevelScore, LevelDetail, Sort From DevelopLevel Where DelFlag = '0' And DevelopLevelCode = '" + id + "' Order By Sort ");
        return dv;
    }
    public DataView getddlOperations()
    {     
        DataView dv = Conn.Select("Select OperationsCode, OperationsName From Operations Where DelFlag = '0' Order By Sort");
        return dv;
    }

    //-------------------------admission---------------------//
    public DataView getAdmission(string id)
    {    
        DataView dv = Conn.Select("Select UserRoleID From UserRole Where DelFlag = 0 And UserRoleID = '" + id + "' ");
        return dv;
    }
    public Int32 ckGetAdmission(string UserRoleID)
    {       
        DataView dv = Conn.Select("Select UserRoleID, RoleLevel From UserRole Where DelFlag = 0 And UserRoleID = '" + UserRoleID + "' ");
        if (dv.Count != 0)
        {
            return Convert.ToInt32(dv[0]["RoleLevel"]);
        }
        else
        {
            return 0;
        }
    }
    public DataView getDept(string id)
    {      
        DataView dv = Conn.Select("Select DeptCode From Department Where DelFlag = 0 And DeptCode = '" + id + "' ");
        return dv;
    }
    public string getDeptIDInActivityByUserId(string EmpID, string ActivityCode)
    {
        string DeptCode = "";
        string strSql = " Select DeptCode From EmpDept Where EmpID = '" + EmpID + "' "
                + " And DeptCode In (Select DeptCode From dtAcDept Where ActivityCode = '" + ActivityCode + "') ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            DeptCode = dv[0]["DeptCode"].ToString();
        }
        return DeptCode;
    }
    //--------------------------Setting------------------------//
    public string getEmpName(string EmpCode)
    {       
        DataView dv = Conn.Select("Select EmpName From Employee Where DelFlag = 0 And EmpID = '" + EmpCode + "' ");
        if (dv.Count != 0)
        {
            return dv[0]["EmpName"].ToString();
        }
        else
        {
            return "";
        }
    }
    public string getDeptName(string DeptCode)
    {       
        DataView dv = Conn.Select("Select DeptName From Department Where DelFlag = 0 And DeptCode = '" + DeptCode + "' ");
        if (dv.Count != 0)
        {
            return dv[0]["DeptName"].ToString();
        }
        else
        {
            return "";
        }
    }
    public string getEntryCostsName(string EntryCostsCode)
    {      
        DataView dv = Conn.Select(" Select EntryCostsName From EntryCosts Where EntryCostsCode = '" + EntryCostsCode + "' ");
        if (dv.Count != 0)
        {
            return dv[0]["EntryCostsName"].ToString();
        }
        else
        {
            return "";
        }
    }
    public string getCostsCenterName(string CostsCode)
    {       
        DataView dv = Conn.Select(" Select CostsName From CostsCenter Where CostsCode = '" + CostsCode + "' ");
        if (dv.Count != 0)
        {
            return dv[0]["CostsName"].ToString();
        }
        else
        {
            return "";
        }
    }
    public string getCostsSubCenterName(string CostsSubCode)
    {     
        DataView dv = Conn.Select(" Select CostsSubName From CostsSubCenter Where CostsSubCode = '" + CostsSubCode + "' ");
        if (dv.Count != 0)
        {
            return dv[0]["CostsSubName"].ToString();
        }
        else
        {
            return "";
        }
    }
    public DataView getddlEmployee()
    {
        string strSql = @" Select a.EmpID, a.EmpName, b.DeptCode 
        From Employee a Inner Join EmpDept b On a.EmpID = b.EmpID
		Inner Join Department D On b.DeptCode = D.DeptCode
		Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
        Where MD.MainDeptCode = '{0}' 
		And a.DelFlag = 0 And D.DelFlag = 0 And MD.DelFlag = 0 And MSD.DelFlag = 0 And a.HideFlag = 0 
		Order By a.EmpName ";
            
            //"Select a.EmpID, a.EmpName, b.DeptCode "
            //        + " From Employee a, EmpDept b "
            //        + " Where a.EmpID = b.EmpID And a.DelFlag = 0 And a.HideFlag = 0 Order By a.EmpName";
        DataView dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID));
        return dv;
    }
    public void getddlSubDept(int mode, DropDownList ddl, string DeptCode)
    {
        string strSql = " Select SubDeptCode, DeptCode, SubDeptName From SubDepartment Where DelFlag = 0 And DeptCode = '" + DeptCode + "' ";
        DataView dv = Conn.Select(strSql + " Order By Sort");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "SubDeptName";
            ddl.DataValueField = "SubDeptCode";
            ddl.DataBind();
            ddl.Enabled = true;

            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public DataView getddlSchool()
    {       
        DataView dv = Conn.Select("SELECT SchoolID, SchoolName FROM MR_School Where DelFlag = 0 Order By Sort ");
        return dv;
    }
    public DataView getddlDepartment()
    {
        string strSql = @" Select D.DeptCode, D.DeptName 
        From Department D Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
        Where D.DelFlag = 0 And MD.DelFlag = 0 And MSD.DelFlag = 0 
        And MD.MainDeptCode = '{0}'
		Order By MD.Sort, MSD.Sort, D.Sort ";

        //SELECT DeptCode, DeptName FROM Department Where DelFlag = 0 Order By Sort
        DataView dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID));
        return dv;
    }
    public DataView getddlSubDept()
    {      
        DataView dv = Conn.Select("SELECT SubDeptCode, SubDeptName, DeptCode FROM SubDepartment Where DelFlag = 0 Order By SubDeptName ");
        return dv;
    }
    public DataView getddlPosition()
    {      
        DataView dv = Conn.Select("Select PositionCode, PositionName From Position Where DelFlag = '0' Order By Sort ");
        return dv;
    }

    //----------------------------------------------------------
    public void Msg_Head(Image Img1, Label MsgHead, Boolean Enables, String mode, Int32 i)
    {
        if (i > 0)
        {
            switch (mode)
            {
                case "1":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>เพิ่มข้อมูลใหม่เรียบร้อยแล้ว</small>";
                    break;
                case "2":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>แก้ไขข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "3":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>ลบข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "4":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>ทำการส่งข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "5":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>ยืนยันข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "8":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>ฟื้นฟูข้อมูลเสร็จสมบูรณ์</small>";
                    break;
                case "9":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>สำรองข้อมูลเสร็จสมบูรณ์</small>";
                    break;
                case "10":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>ระบบได้ส่งการแจ้งปัญหาการใช้งานไปยังผู้เกี่ยวข้องแล้ว</small>";
                    break;
                case "11":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>ระบบได้ปรับปรุงเกณฑ์คะแนนใหม่เรียบร้อยแล้ว</small>";
                    break;
                case "12":
                    MsgHead.Text = "สำเร็จ ! <BR> <small>บันทึกผลการอนุมัติเรียบร้อยแล้ว</small>";
                    break;
            }
            Img1.ImageUrl = "~/Image/msg_check.gif";
            MsgHead.CssClass = "headMsg";
        }
        else
        {
            switch (mode)
            {
                case "1":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถเพิ่มข้อมูลใหม่ได้</small>";
                    break;
                case "2":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถแก้ไขข้อมูลได้</small>";
                    break;
                case "3":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถลบข้อมูลได้  เนื่องจากข้อมูลถูกใช้อยู่</small>";
                    break;
                case "4":
                    MsgHead.Text = "";
                    break;
                case "5":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถยืนยันข้อมูลได้</small>";
                    break;
                case "6":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถเพิ่มข้อมูลใหม่ได้  เนื่องจากไม่มีข้อมูลในปีที่เลือก</small>";
                    break;
                case "7":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถเพิ่มหรือแก้ไขข้อมูลได้  เนื่องจากข้อมูลนี้มีอยู่แล้ว</small>";
                    break;
                case "8":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ฟื้นฟูข้อมูลไม่สมบูรณ์</small>";
                    break;
                case "9":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>สำรองข้อมูลไม่สมบูรณ์</small>";
                    break;
                case "11":
                    MsgHead.Text = "ไม่สำเร็จ ! <BR> <small>ระบบไม่สามารถปรับปรุงเกณฑ์คะแนนใหม่ได้</small>";
                    break;
                case "12":
                    MsgHead.Text = "ไม่สำเร็จ ! <BR> <small>ไม่สามารถบันทึกผลการอนุมัติได้</small>";
                    break;
            }
            Img1.ImageUrl = "~/Image/msg_error.gif";
            MsgHead.CssClass = "headMsgError";
        }
        Img1.Visible = Enables;
        MsgHead.Visible = Enables;
    }
    public void ckBudgetYear(HtmlGenericControl lblSearchYear, HtmlGenericControl lblYear)
    {
        if (ckIdentityName("ckBudgetYear"))
        {
            if(lblSearchYear != null)
            lblSearchYear.InnerHtml = "ปีงบประมาณ : ";

            if(lblYear != null)
            lblYear.InnerHtml = "ปีงบประมาณ : ";
        }
    }
    public void CkAllDept(DropDownList ddlDept)
    {
        DataView dv;
        dv = getAdmission(CurrentUser.UserRoleID);

        if (dv.Count != 0)
        {
            if (Convert.ToInt32(dv[0]["IsAllDept"]) == 1)
            {
                if (ddlDept != null)
                {
                    //ddlDept.Enabled = true;
                    ddlDept.SelectedIndex = 0;
                }
            }
            else
            {
                if (ddlDept != null)
                {
                    //ddlDept.Enabled = false;
                    ddlDept.SelectedValue = CurrentUser.DeptID;
                }
            }
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
    }
    public void CkAdmission(Star.Web.UI.Controls.DataGridView GridView1, Button btAdd, LinkButton btDel)
    {
        if (!string.IsNullOrEmpty(CurrentUser.RoleLevel.ToString()))
        {
            if ((CurrentUser.RoleLevel > 1) && (CurrentUser.RoleLevel < 98))
            {
                if (btAdd != null)
                {
                    btAdd.Visible = false;
                }
                if (btDel != null)
                {
                    btDel.Enabled = false;
                }
                if (GridView1 != null)
                {
                    GridView1.Columns[GridView1.Columns.Count - 1].Visible = false;
                    GridView1.Columns[GridView1.Columns.Count - 2].Visible = false;
                    GridView1.Columns[GridView1.Columns.Count - 3].Visible = false;
                }
            }
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
    }
    public void CkAdmissionForAdmin(Star.Web.UI.Controls.DataGridView GridView1, Button btAdd, LinkButton btDel)
    {
        if (!string.IsNullOrEmpty(CurrentUser.RoleLevel.ToString()))
        {
            if (CurrentUser.RoleLevel < 98)
            {
                if (btAdd != null)
                {
                    btAdd.Visible = false;
                }
                if (btDel != null)
                {
                    btDel.Enabled = false;
                }
                if (GridView1 != null)
                {
                    GridView1.Columns[GridView1.Columns.Count - 1].Visible = false;
                    GridView1.Columns[GridView1.Columns.Count - 2].Visible = false;
                }
            }
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
    }
    public string getDeptShortName(string DeptCode)
    {
        string DeptShortName = "";
        string strSql = @" Select DeptShortName From Department Where DeptCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, DeptCode));
        if (dv.Count > 0)
        {
            DeptShortName = dv[0]["DeptShortName"].ToString();
        }
        return DeptShortName;
    }
    public void txtEnable(HtmlTable table1, HtmlTable TableSearch, Star.Web.UI.Controls.DataGridView GridView1, Boolean Enabales)
    {
        table1.Visible = Enabales;
        TableSearch.Visible = !Enabales;
        GridView1.Visible = !Enabales;
    }
    public void CopyEnable(Label lbl, DropDownList ddl, Button bt, string TableName, string StudyYear)
    {       
        DataView dv = Conn.Select("Select * From " + TableName + " Where StudyYear = '" + StudyYear + "' And DelFlag = 0");
        if (dv.Count != 0)
        {
            lbl.Visible = false;
            ddl.Visible = false;
            bt.Visible = false;
        }
        else
        {
            if (CurrentUser.RoleLevel < 98)
            {
                lbl.Visible = false;
                ddl.Visible = false;
                bt.Visible = false;
            }
            else
            {
                lbl.Visible = true;
                ddl.Visible = true;
                bt.Visible = true;
            }
        }     
    }
    public void IdentityNameEnable(Label lbl, TextBox txt, string FieldName, string FieldNameCk, HtmlGenericControl Div)
    {   
        string strSql = "";
        if (!string.IsNullOrEmpty(FieldName))
        {
            strSql = "Select " + FieldName + ", " + FieldNameCk + " From MR_School Where " + FieldNameCk + " = 1 And SchoolID = '" + CurrentUser.SchoolID + "'";
        }
        else
        {
            strSql = "Select " + FieldNameCk + " From MR_School Where " + FieldNameCk + " = 1 And SchoolID = '" + CurrentUser.SchoolID + "'";
        }
        DataView dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            Div.Visible = true;
            lbl.Visible = true;
            if (txt != null)
            {
                txt.Visible = true;
                if (!string.IsNullOrEmpty(FieldName))
                {
                    txt.Text = dv[0]["" + FieldName + ""].ToString();
                }
            }
        }
        else
        {
            Div.Visible = false;
            lbl.Visible = false;
            if (txt != null)
            {
                txt.Visible = false;
                txt.Text = "";
            }
        }     
    }
    public void IdentityNameCblEnable(Label lbl, CheckBoxList cbl, string FieldName, string FieldNameCk, HtmlGenericControl Div)
    {      
        string strSql = "";
        if (!string.IsNullOrEmpty(FieldName))
        {
            strSql = "Select " + FieldName + ", " + FieldNameCk + " From MR_School Where " + FieldNameCk + " = 1 And SchoolID = '" + CurrentUser.SchoolID + "'";
        }
        else
        {
            strSql = "Select " + FieldNameCk + " From MR_School Where " + FieldNameCk + " = 1 And SchoolID = '" + CurrentUser.SchoolID + "'";
        }
        DataView dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            Div.Visible = true;
            lbl.Visible = true;
            if (cbl != null)
            {
                cbl.Visible = true;
            }
        }
        else
        {
            Div.Visible = false;
            lbl.Visible = false;
            if (cbl != null)
            {
                cbl.Visible = false;
            }
        }
    }
    public Boolean ckIdentityName(string FieldName)
    {    
        DataView dv = Conn.Select("Select " + FieldName + " From MR_School Where " + FieldName + " = 1 And SchoolID = '" + CurrentUser.SchoolID + "'");

        if (dv.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public void GenSort(TextBox txtSort, string tableName, string criteria)
    {
        DataView dv;      
        dv = Conn.Select(string.Format("Select IsNull(Max(Sort),0) Sort From " + tableName + " Where DelFlag = 0 " + criteria));
        txtSort.Text = (Convert.ToInt32(dv[0]["Sort"]) + 1).ToString();
    }
    public Int32 GenListNo(string tableName, string criteria)
    {
        DataView dv;
        dv = Conn.Select(string.Format("Select IsNull(Max(ListNo),0) + 1 As GenListNo From " + tableName + criteria));
        return Convert.ToInt32(dv[0]["GenListNo"]);
    }
    public void ckbtAdd(HtmlGenericControl divBt)
    {
        if ((CurrentUser.RoleLevel != 1) && (CurrentUser.RoleLevel != 98))
        {
            divBt.Visible = false;
        }
    }
    public void btEnable(Button bt, Boolean Enables)
    {
        bt.Visible = Enables;
    }
    public double getQuality(string IndicatorsCode, double hScore)
    {      
        string strSql = " Select IndicatorsCode, StudyYear, Quality, Score, Note From IndicatorsQuality Where IndicatorsCode = '" + IndicatorsCode + "' ";
        DataView dvQuality = Conn.Select(strSql);
        if (dvQuality.Count != 0)
        {
            return Convert.ToDouble(dvQuality[0]["Score"]);
        }
        else
        {
            return hScore;
        }
    }
    public DataView getScoreGroup()
    {
        string strSql = "";
        DataView dv = Conn.Select("Select ckRate From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'");
        if (dv.Count != 0)
        {
            if (Convert.ToInt32(dv[0]["ckRate"]) == 0)
            {
                strSql = @"Select * From ScoreGroup Where ScoreGroupID 
                    Not In ('25E2142B-3F11-48DF-8D66-681E6FDDC5E7', '7211D888-9FDA-4691-AA80-13D38710AA45', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35', 
                    'E82BB47C-6C65-409F-818E-6ADE319CA8A1', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96', '4BD33310-AE51-4E69-9D84-A4A8173D81F0') 
                    Order By WeightScore, ScoreGroupName ";
            }
            if (Convert.ToInt32(dv[0]["ckRate"]) == 1)
            {
                strSql = @"Select * From ScoreGroup Where ScoreGroupID 
                     Not In ('D7A04A29-300F-4E0F-B100-8026FF7D66D6', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96', '4BD33310-AE51-4E69-9D84-A4A8173D81F0') 
                     Order By WeightScore, ScoreGroupName ";
            }
            if (Convert.ToInt32(dv[0]["ckRate"]) == 2)
            {
                strSql = @" Select * From ScoreGroup Where ScoreGroupID 
                     Not In ('E2EF2D9F-7052-418E-8CE4-8E93525D5C35', '1c167bba-813c-43ce-a37f-9c634610d960', '921aae33-10ee-4c06-9818-361c88f75dbd',
                     'c68263a8-5339-41f6-a19a-9e02167577b4', '4996ad20-57fc-4dbc-a01d-698393d7affb', '950E2A3C-5B5B-4A51-8613-4EC393A1F495', 'fe43801a-1fa1-4cc1-8789-385df50aa650') 
                     Order By WeightScore, ScoreGroupName ";
            }
            if (Convert.ToInt32(dv[0]["ckRate"]) == 3)
            {
                strSql = @"Select * From ScoreGroup Where ScoreGroupID 
                    Not In ('25E2142B-3F11-48DF-8D66-681E6FDDC5E7', '7211D888-9FDA-4691-AA80-13D38710AA45', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35', '1c167bba-813c-43ce-a37f-9c634610d960',
                    'E82BB47C-6C65-409F-818E-6ADE319CA8A1', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96', '4BD33310-AE51-4E69-9D84-A4A8173D81F0',
                    '921aae33-10ee-4c06-9818-361c88f75dbd', 'c68263a8-5339-41f6-a19a-9e02167577b4', 'fe43801a-1fa1-4cc1-8789-385df50aa650') 
                    Order By WeightScore, ScoreGroupName ";
            }
        }
        DataView dv1 = Conn.Select(strSql);
        return dv1;
    }
    public decimal getWeightScoreGroup(string ScoreGroupID)
    {      
        string strSql = " Select WeightScore From ScoreGroup Where ScoreGroupID = '" + ScoreGroupID + "'";

        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            return Convert.ToDecimal(dv[0]["WeightScore"]);
        }
        else
        {
            return 0;
        }
    }
    public string ckTCriteria(string Criteria, double Score)
    {      
        string strSql = " Select TCriteriaID, TCriteria, Criterion, Translation, TMin, TMax "
            + " From TCriteria "
            + " Where DelFlag = 0 And ScoreGroupID = '{0}' And (round({1},2) Between TMin And TMax) ";

        DataView dv = Conn.Select(string.Format(strSql, Criteria, Score));

        if (dv.Count != 0)
        {
            return dv[0]["Criterion"].ToString() + " : " + dv[0]["Translation"].ToString();
        }
        else
        {
            return "0:0";
        }
    }
    public string getColorMaster(double hScore, double rate)
    {     
        string strColor = "";
        string strSql = " Select Criterion, Translation, TMin, TMax From TCriteria Where TCriteria = " + rate + " Order By Criterion ";
        DataView dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            if (hScore < Convert.ToDouble(dv[1]["TMin"]))
            {
                strColor = "Red";
            }
            else
            {
                strColor = "#0B610B";
            }
        }
        return strColor;
    }
    public void DefaultStrategies(DropDownList ddl)
    {     
        DataView dv = Conn.Select("Select StrategiesCode From Strategies Where DelFlag = 0 And Df = 1");
        if (dv.Count != 0)
        {
            ddl.SelectedValue = dv[0]["StrategiesCode"].ToString();
        }
    }
    public void getddlTerm(int mode, DropDownList ddl)
    {
        ddl.Items.Clear();
        ddl.Items.Insert(0, new ListItem("1", "1"));
        ddl.Items.Insert(1, new ListItem("2", "2"));
        //if (mode == 0)
        //{
        //    ddl.Items.Insert(2, new ListItem("1-2", "1-2"));
        //}
        //if (mode == 1)
        //{
        //    ddl.Items.Insert(2, new ListItem("2-1", "2-1"));
        //}
        ddl.SelectedIndex = 0;
    }
    public void getddlActivityStatus(DropDownList ddl)
    {
        int j = 0;
        for (int i = 0; i <= 100; i++)
        {
            ddl.Items.Insert(j, new ListItem(i.ToString() + " %", i.ToString()));
            j = j + 1;
            i = i + 4;
        }
    }
    public void getddlMainActivity(string mode, DropDownList ddl, string studyyear)
    {
        string strSql = @"Select MainActivityID, MainActivityName From MainActivity Where DelFlag = 0 And StudyYear = '{0}' Order By Sort";
        DataView dv = Conn.Select(string.Format(strSql, studyyear));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "MainActivityName";
            ddl.DataValueField = "MainActivityID";
            ddl.DataBind();
        }
        if (mode == "0")
        {
            ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        }
        else
        {
            ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
        }
        ddl.SelectedIndex = 0;
    }
    public string getSpanColorStatus(Boolean ckActivityStatus, string ActivityStatus)
    {
        Int32 AcStatus = 0;
        string link = "<span style=\"color:green;font-weight:bold;\">" + ActivityStatus + " %</span>";
        try
        {
            if (ckActivityStatus)
            {
                AcStatus = Convert.ToInt32(ActivityStatus);
                if (AcStatus == 0)
                {
                    link = "<span style=\"color:gray;font-weight:bold;\">" + ActivityStatus + " %</span>";
                }
                else
                {
                    if (AcStatus < 10)
                    {
                        link = "<span style=\"color:red;font-weight:bold;\">" + ActivityStatus + " %</span>";
                    }
                    else
                    {
                        if (AcStatus < 30)
                        {
                            link = "<span style=\"color:orange;font-weight:bold;\">" + ActivityStatus + " %</span>";
                        }
                        else
                        {
                            if (AcStatus < 50)
                            {
                                link = "<span style=\"color:#c5c713;font-weight:bold;\">" + ActivityStatus + " %</span>";
                            }
                            else
                            {
                                if (AcStatus < 80)
                                {
                                    link = "<span style=\"color:#37b8d5;font-weight:bold;\">" + ActivityStatus + " %</span>";
                                }
                                else
                                {
                                    if (AcStatus < 100)
                                    {
                                        link = "<span style=\"color:#4fdc3f;font-weight:bold;\">" + ActivityStatus + " %</span>";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                link = "<img src=\"../Image/History2.png\" />";
            }
        }
        catch (Exception ex)
        {

        }
        return link;
    }

    public void getrbtlType(RadioButtonList rbtl)
    {
        rbtl.Items.Clear();
        rbtl.Items.Insert(0, new ListItem(" กิจกรรมใหม่", "0"));
        rbtl.Items.Insert(1, new ListItem(" กิจกรรมต่อเนื่อง", "2"));
        rbtl.Items.Insert(2, new ListItem(" งานประจำ", "1"));
        rbtl.SelectedIndex = 0;
    }
    public string getlblTarget()
    {      
        DataView dv = Conn.Select("Select txtTarget1, txtTarget2 From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'");
        if (dv.Count != 0)
        {
            return dv[0]["txtTarget1"].ToString() + "," + dv[0]["txtTarget2"].ToString();
        }
        else
        {
            return "เชิงปริมาณ" + "," + "เชิงคุณภาพ";
        }
    }
    public string getKeyWordResponsibleActivity()
    {
        DataView dv = Conn.Select("Select KeyWordResponsibleActivity, KeyWordProposeActivity, KeyWordApprovalActivity, KeyWordApproval2Activity From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'");
        if (dv.Count != 0)
        {
            return dv[0]["KeyWordResponsibleActivity"].ToString() + "," + dv[0]["KeyWordProposeActivity"].ToString() + "," + dv[0]["KeyWordApprovalActivity"].ToString() + "," + dv[0]["KeyWordApproval2Activity"].ToString();
        }
        else
        {
            return "ผู้รับผิดชอบกิจกรรม,ผู้เสนอกิจกรรม,ผู้เห็นชอบกิจกรรม,ผู้เห็นชอบกิจกรรมที่ 2";
        }
    }
    public string getlblResponsibleName()
    {
        DataView dv = Conn.Select("Select spnResponsibleName, spnProposeName, spnApprovalName, spnApprovalName2 From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'");
        if (dv.Count != 0)
        {
            return dv[0]["spnResponsibleName"].ToString() + "," + dv[0]["spnProposeName"].ToString() + "," + dv[0]["spnApprovalName"].ToString() + "," + dv[0]["spnApprovalName2"].ToString();
        }
        else
        {
            return "ผู้รับผิดชอบโครงการ : " + "," + "ผู้เสนอโครงการ : " + "," + "ผู้เห็นชอบโครงการ : " + "," + "ผู้เห็นชอบโครงการที่ 2 : ";
        }
    }
    public DataView getddlEntryCosts()
    {       
        DataView dv = Conn.Select("Select * From EntryCosts Where DelFlag = 0 Order By Sort");
        return dv;
    }
    public DataView getddlBudgetType()
    {     
        DataView dv = Conn.Select("Select * From BudgetType Where DelFlag = 0 Order By Sort");
        return dv;
    }
    public void getddlMonth(DropDownList ddl)
    {
        ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", "0"));
        ddl.Items.Insert(1, new ListItem("มกราคม", "1"));
        ddl.Items.Insert(2, new ListItem("กุมภาพันธ์", "2"));
        ddl.Items.Insert(3, new ListItem("มีนาคม", "3"));
        ddl.Items.Insert(4, new ListItem("เมษายน", "4"));
        ddl.Items.Insert(5, new ListItem("พฤษภาคม", "5"));
        ddl.Items.Insert(6, new ListItem("มิถุนายน", "6"));
        ddl.Items.Insert(7, new ListItem("กรกฎาคม", "7"));
        ddl.Items.Insert(8, new ListItem("สิงหาคม", "8"));
        ddl.Items.Insert(9, new ListItem("กันยายน", "9"));
        ddl.Items.Insert(10, new ListItem("ตุลาคม", "10"));
        ddl.Items.Insert(11, new ListItem("พฤศจิกายน", "11"));
        ddl.Items.Insert(12, new ListItem("ธันวาคม", "12"));
        //ddl.SelectedValue = DateTime.Now.Month.ToString();
        ddl.SelectedIndex = 0;
    }
    public void getddlDay(DropDownList ddl)
    {
        for (int i = 0; i < 31; i++)
        {
            ddl.Items.Insert(i, new ListItem((i + 1).ToString(), (i + 1).ToString("00")));
        }
        ddl.SelectedValue = DateTime.Now.Day.ToString("00");
    }
    public void getddlMonth2(DropDownList ddl)
    {
        ddl.Items.Insert(0, new ListItem("มกราคม", "01"));
        ddl.Items.Insert(1, new ListItem("กุมภาพันธ์", "02"));
        ddl.Items.Insert(2, new ListItem("มีนาคม", "03"));
        ddl.Items.Insert(3, new ListItem("เมษายน", "04"));
        ddl.Items.Insert(4, new ListItem("พฤษภาคม", "05"));
        ddl.Items.Insert(5, new ListItem("มิถุนายน", "06"));
        ddl.Items.Insert(6, new ListItem("กรกฏาคม", "07"));
        ddl.Items.Insert(7, new ListItem("สิงหาคม", "08"));
        ddl.Items.Insert(8, new ListItem("กันยายน", "09"));
        ddl.Items.Insert(9, new ListItem("ตุลาคม", "10"));
        ddl.Items.Insert(10, new ListItem("พฤศจิกายน", "11"));
        ddl.Items.Insert(11, new ListItem("ธันวาคม", "12"));
        ddl.SelectedValue = DateTime.Now.Month.ToString("00");
    }
    public void getddlQuarter(DropDownList ddl)
    {
        ddl.Items.Insert(0, new ListItem("ไตรมาสที่ 1 (1 ต.ค. - 31 ธ.ค.)", "1"));
        ddl.Items.Insert(1, new ListItem("ไตรมาสที่ 2 (1 ม.ค. – 31 มี.ค.)", "2"));
        ddl.Items.Insert(2, new ListItem("ไตรมาสที่ 3 (1 เม.ย. – 30 มิ.ย. 57)", "3"));
        ddl.Items.Insert(3, new ListItem("ไตรมาสที่ 4 (1 ก.ค. – 30 ก.ย. 57)", "4"));
    }
    public void getddlQuarter2(DropDownList ddl)
    {
        ddl.Items.Insert(0, new ListItem("ไตรมาสที่ 1 (1 พ.ค. – 31 ก.ค.)", "1"));
        ddl.Items.Insert(1, new ListItem("ไตรมาสที่ 2 (1 ส.ค. – 31 ต.ค.)", "2"));
        ddl.Items.Insert(2, new ListItem("ไตรมาสที่ 3 (1 พ.ย. – 31 ม.ค.)", "3"));
        ddl.Items.Insert(3, new ListItem("ไตรมาสที่ 4 (1 ก.พ. - 30 เม.ย.)", "4"));
    }
    public string getMonthOfMonth(string ckMonth, string SearchYear)
    {
        string strSql = "";
        Int32 searchyear = DateTime.Now.Year;
        if (!string.IsNullOrEmpty(SearchYear))
        {
            searchyear = Convert.ToInt32(SearchYear) - 543;
        }
        if (!string.IsNullOrEmpty(ckMonth))
        {
            switch (ckMonth)
            {
                case "01":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) = 1 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
                case "02":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) Between 1 And 2 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
                case "03":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) Between 1 And 3 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
                case "04":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) Between 1 And 4 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
                case "05":
                    strSql += " And Month(P.SDate) = 5 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "06":
                    strSql += " And Month(P.SDate) Between 5 And 6 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "07":
                    strSql += " And Month(P.SDate) Between 5 And 7 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "08":
                    strSql += " And Month(P.SDate) Between 5 And 8 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "09":
                    strSql += " And Month(P.SDate) Between 5 And 9 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "10":
                    strSql += " And Month(P.SDate) Between 5 And 10 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "11":
                    strSql += " And Month(P.SDate) Between 5 And 11 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "12":
                    strSql += " And Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
            }
        }
        return strSql;
    }
    public string getMonthOfQuarter(string Quarter, string SearchYear)
    {
        string strSql = "";
        Int32 searchyear = DateTime.Now.Year;
        if (!string.IsNullOrEmpty(SearchYear))
        {
            searchyear = Convert.ToInt32(SearchYear) - 543;
        }
        if (!string.IsNullOrEmpty(Quarter))
        {
            switch (Quarter)
            {
                case "1":
                    strSql += " And Month(P.SDate) Between 5 And 7 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "2":
                    strSql += " And Month(P.SDate) Between 5 And 10 And Year(P.SDate) = '" + searchyear + "' ";
                    break;
                case "3":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) = 1 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
                case "4":
                    strSql += " And ((Month(P.SDate) Between 5 And 12 And Year(P.SDate) = '" + searchyear + "') OR (Month(P.SDate) Between 2 And 4 And Year(P.SDate) = '" + (searchyear + 1) + "')) ";
                    break;
            }
        }
        return strSql;
    }

    public void getCreateUpdateUser(Label lblCreate, Label lblUpdate, string tblName, string fieldName, string id)
    {        
        DataView dv;
        string strSql = "";
        lblCreate.Text = "";
        lblUpdate.Text = "";

        strSql = " Select b.CreateUser, a.EmpName,  b.CreateDate From Employee a, " + tblName + " b Where a.EmpID = b.CreateUser And b." + fieldName + " = '" + id + "'";
        dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            lblCreate.Text = "ผู้สร้าง : " + dv[0]["EmpName"].ToString() + " - " + Convert.ToDateTime(dv[0]["CreateDate"]).ToShortDateString();
        }

        strSql = " Select b.UpdateUser, a.EmpName,  b.UpdateDate From Employee a, " + tblName + " b Where a.EmpID = b.UpdateUser And b." + fieldName + " = '" + id + "'";
        dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            lblUpdate.Text = "ผู้แก้ไข : " + dv[0]["EmpName"].ToString() + " - " + Convert.ToDateTime(dv[0]["UpdateDate"]).ToShortDateString();
        }
    }
    public void getddlSide(int mode, DropDownList ddl, string StudyYear, object SideCode)
    {      
        DataView dv = Conn.Select("Select SideCode, Cast(Sort as nvarchar) + ' - ' + SideName FullName, Sort From Side Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "SideCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (SideCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = SideCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public DataView getddlSide()
    {     
        DataView dv = Conn.Select("Select SideCode, Cast(Sort as nvarchar) + ' - ' + SideName FullName, Sort From Side Where DelFlag = 0 Order By Sort ");
        return dv;
    }
    public void getddlStandard(int mode, DropDownList ddl, string StudyYear, string SideCode, object StandardCode)
    {
        string strSql = @" Select Sd.StandardCode, Cast(S.Sort as nvarchar) + '.' + Cast(Sd.Sort as nvarchar) + ' - ' + Sd.StandardName FullName, Sd.Sort 
            From Standard Sd Left Join Side S On Sd.SideCode = S.SideCode Where Sd.DelFlag = 0 And Sd.StudyYear = '{0}' And Sd.SideCode = '" + SideCode + "' ";
        //if(!string.IsNullOrEmpty(SideCode))
        //{
        //    strSql += " And SideCode = '" + SideCode + "' ";
        //}
        DataView dv = Conn.Select(string.Format(strSql + " Order By S.Sort, Sd.Sort" , StudyYear));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "StandardCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (StandardCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = StandardCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlStandardNotInEvaluation(int mode, DropDownList ddl, string StudyYear, string SideCode, object StandardCode, string Indicators2Code)
    {
        string strSql = @" Select Sd.StandardCode, Cast(S.Sort as nvarchar) + '.' + Cast(Sd.Sort as nvarchar) + ' - ' + Sd.StandardName FullName, Sd.Sort 
            From Standard Sd Left Join Side S On Sd.SideCode = S.SideCode Where Sd.DelFlag = 0 And Sd.StudyYear = '{0}' And Sd.SideCode = '" + SideCode + "' ";
        strSql += " And Sd.StandardCode Not In (Select StandardCode From Evaluation Where DelFlag = 0 And Indicators2Code = '" + Indicators2Code + "' And SchoolID = '" + CurrentUser.SchoolID + "' ) ";

        DataView dv = Conn.Select(string.Format(strSql + " Order By S.Sort, Sd.Sort", StudyYear));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "StandardCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (StandardCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = StandardCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlStandardQuality(int mode, DropDownList ddl, string StudyYear)
    {       
        string strSql = " Select a.StandardCode, Cast(a.Sort as nvarchar) + ' - ' + a.StandardName FullName, a.StudyYear, a.Sort "
                + " From Standard a, Indicators b "
                + " Where a.StandardCode = b.StandardCode And a.DelFlag = 0 And b.DelFlag = 0 "
                + " And a.StudyYear = '" + StudyYear + "' And b.QualityFlag = 1 "
                + " Group By a.StandardCode, a.StandardName, a.Sort, a.StudyYear Order By a.Sort ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "StandardCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlIndicatorsNotInEvaluation(int mode, DropDownList ddl, string StandardCode, string Indicators2Code)
    {      
        string strSql = "Select b.IndicatorsCode, Cast(a.Sort as nvarchar) + '.' + Cast(b.Sort as nvarchar) + ' - ' + b.IndicatorsName FullName, b.Sort "
              + " From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And a.StandardCode = '" + StandardCode + "' "
              + " And b.QualityFlag = 0 "
              + " And b.IndicatorsCode Not In (Select IndicatorsCode From Evaluation Where DelFlag = 0 And Indicators2Code = '" + Indicators2Code + "' And SchoolID = '" + CurrentUser.SchoolID + "' ) ";

        DataView dv = Conn.Select(strSql + " Order By a.Sort, b.Sort ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "IndicatorsCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
                if (dv.Count == 1)
                {
                    ddl.SelectedIndex = 1;
                }
            }
        }
        else
        {
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public DataView getddlIndicatorsNotInEvaluation(string stid, string int2id)
    {     
        string strSql = "Select b.IndicatorsCode, Cast(a.Sort as nvarchar) + '.' + Cast(b.Sort as nvarchar) + ' - ' + b.IndicatorsName FullName, b.Sort "
                      + " From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And a.StandardCode = '" + stid + "' "
                      + " And b.QualityFlag = 0 "
                      + " And b.IndicatorsCode Not In (Select IndicatorsCode From Evaluation Where Indicators2Code = '" + int2id + "' And SchoolID = '" + CurrentUser.SchoolID + "' ) ";

        DataView dv = Conn.Select(strSql + " Order By a.Sort, b.Sort ");
        return dv;
    }
    public void getddlIndicators(int mode, DropDownList ddl, string StandardCode)
    {      
        string strSql = "Select b.IndicatorsCode, Cast(a.Sort as nvarchar) + '.' + Cast(b.Sort as nvarchar) + ' - ' + b.IndicatorsName FullName, "
                    + " b.Sort From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And b.QualityFlag = 0 "
                    + " And a.StandardCode = '" + StandardCode + "' Order By a.Sort, b.Sort ";
        DataView dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "IndicatorsCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public DataView getddlIndicators(string id)
    {     
        string strSql = "Select b.IndicatorsCode, Cast(a.Sort as nvarchar) + '.' + Cast(b.Sort as nvarchar) + ' - ' + b.IndicatorsName FullName, "
                    + " b.Sort From Standard a, Indicators b Where a.StandardCode = b.StandardCode And b.DelFlag = 0 And b.QualityFlag = 0 "
                    + " And a.StandardCode = '" + id + "' Order By a.Sort, b.Sort ";
        DataView dv = Conn.Select(strSql);
        return dv;
    }
    public void getdllStudyYear(DropDownList ddl)
    {      
        DataView dv = Conn.Select("Select Top 10 StudyYear, Df From StudyYear Where DelFlag = 0 Order By StudyYear");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "StudyYear";
            ddl.DataValueField = "StudyYear";
            ddl.DataBind();
        }
    }
    public void getdllStudyYearForCopy(DropDownList ddl, string StudyYear)
    {     
        DataView dv = Conn.Select("Select Top 10 StudyYear, Df From StudyYear Where DelFlag = 0 And StudyYear < '" + StudyYear + "' Order By StudyYear");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "StudyYear";
            ddl.DataValueField = "StudyYear";
            ddl.DataBind();
            ddl.SelectedValue = (Convert.ToInt32(StudyYear) - 1).ToString();
            ddl.Enabled = true;
        }
        else
        {
            ddl.DataSource = dv;
            ddl.DataBind();
            ddl.Enabled = false;
        }
    }
    public void getrbtlProjectType(RadioButtonList rbtl)
    {
        DataView dv = Conn.Select("Select ProjectTypeID, ' ' + ProjectTypeName As ProjectTypeName From ProjectType Where DelFlag = 0 Order By Sort");
        if (dv.Count != 0)
        {
            rbtl.DataSource = dv;
            rbtl.DataTextField = "ProjectTypeName";
            rbtl.DataValueField = "ProjectTypeID";
            rbtl.DataBind();
            rbtl.Enabled = true;
            rbtl.SelectedIndex = 0;
        }
        else
        {
            rbtl.Items.Clear();
            rbtl.Enabled = false;
        }
    }
    public void getrbtlSubProjectType(RadioButtonList rbtl, string ProjectTypeID)
    {
        DataView dv = Conn.Select("Select SubProjectTypeID, ' ' + SubProjectTypeName As SubProjectTypeName From SubProjectType Where DelFlag = 0 And ProjectTypeID = '" + ProjectTypeID + "' Order By Sort");
        if (dv.Count != 0)
        {
            rbtl.DataSource = dv;
            rbtl.DataTextField = "SubProjectTypeName";
            rbtl.DataValueField = "SubProjectTypeID";
            rbtl.DataBind();
            rbtl.Visible = true;
            rbtl.SelectedIndex = 0;
        }
        else
        {
            rbtl.Items.Clear();
            rbtl.Visible = false;
        }
    }
    public void getcblStrategicPlan(CheckBoxList cbl, string StudyYear, string DeptCode)
    {
        string strSql = @"Select StrategicPlanID, ' ' + StrategicPlanName StrategicPlanName 
        From StrategicPlan Where DelFlag = 0 And StudyYear = '{0}' And DeptCode = '{1}' ";
      
        DataView dv = Conn.Select(string.Format(strSql + " Order By Sort ", StudyYear, DeptCode));
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategicPlanName";
            cbl.DataValueField = "StrategicPlanID";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblCorporateStrategy(HtmlGenericControl Div, CheckBoxList cbl, string StudyYear, CheckBoxList cblStrategies)
    {
        if (ckIdentityName("ckCorporateStrategy"))
        {
            string strSql = @" Select CR.CorporateStrategyID, ' ' + Cast(S.Sort As nVarChar) + '.' + Cast(CR.Sort As nVarChar) + ' ' + CR.CorporateStrategyName CorporateStrategyName 
        From CorporateStrategy CR Inner Join Strategies S On CR.StrategiesCode = S.StrategiesCode 
        Where CR.DelFlag = 0 And CR.StudyYear = '{0}' ";

            string StrategiesCode = "";
            if (!string.IsNullOrEmpty(cblStrategies.SelectedValue))
            {
                for (int j = 0; j <= cblStrategies.Items.Count - 1; j++)
                {
                    if (cblStrategies.Items[j].Selected)
                    {
                        StrategiesCode += "'" + cblStrategies.Items[j].Value + "',";
                    }
                }
                StrategiesCode = StrategiesCode.Substring(0, StrategiesCode.Length - 1);
                strSql += " And CR.StrategiesCode In (" + StrategiesCode + ") ";
            }
            DataView dv = Conn.Select(string.Format(strSql + " Order By S.Sort, CR.Sort ", StudyYear));
            if (dv.Count != 0)
            {
                cbl.DataSource = dv;
                cbl.DataTextField = "CorporateStrategyName";
                cbl.DataValueField = "CorporateStrategyID";
                cbl.DataBind();
                cbl.Enabled = true;
            }
            else
            {
                cbl.Items.Clear();
                cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
                cbl.Enabled = false;
            }
            Div.Visible = true;
        }
        else
        {
            Div.Visible = false;
        }
    }
    public void getcblStandardNation(CheckBoxList cbl, string StudyYear)
    {
        
        DataView dv = Conn.Select("Select StandardNationCode, ' มาตรฐานที่ ' + Cast(Sort As nVarChar) + '. ' + StandardNationName As StandardNationName From StandardNation Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StandardNationName";
            cbl.DataValueField = "StandardNationCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStandardMinistry(CheckBoxList cbl, string StudyYear)
    {
        
        DataView dv = Conn.Select("Select StandardMinistryCode, ' มาตรฐานที่ ' + Cast(Sort As nVarChar) + '. ' + StandardMinistryName As StandardMinistryName From StandardMinistry Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StandardMinistryName";
            cbl.DataValueField = "StandardMinistryCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblNewStandard(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select StandardCode, ' มาตรฐานที่ ' + Cast(Sort As nVarChar) + '. ' + StandardName As StandardName From NewStandard Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StandardName";
            cbl.DataValueField = "StandardCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStrategicObjectives(CheckBoxList cbl, string StudyYear)
    {
        string strSql = @" Select StrategicObjectivesCode, ' วัตถุประสงค์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategicObjectivesName As StrategicObjectivesName 
            From StrategicObjectives 
            Where DelFlag = 0 And StudyYear = '{0}' Order By Sort ";
        DataView dv = Conn.Select(string.Format(strSql, StudyYear));
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategicObjectivesName";
            cbl.DataValueField = "StrategicObjectivesCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStrategySPT(CheckBoxList cbl, string StudyYear)
    {    
        DataView dv = Conn.Select("Select StrategySPTCode, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategySPTName As StrategySPTName From StrategySPT Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategySPTName";
            cbl.DataValueField = "StrategySPTCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStrategySPM(CheckBoxList cbl, string StudyYear)
    {   
        DataView dv = Conn.Select("Select StrategySPMCode, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategySPMName As StrategySPMName From StrategySPM Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategySPMName";
            cbl.DataValueField = "StrategySPMCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStandardSPM(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select StandardSPMCode, ' มาตรฐานที่ ' + Cast(Sort As nVarChar) + '. ' + StandardSPMName As StandardSPMName From StandardSPM Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StandardSPMName";
            cbl.DataValueField = "StandardSPMCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblIndicatorSMS(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select IndicatorSMSCode, ' ตัวบ่งชี้ที่ ' + Cast(Sort As nVarChar) + '. ' + IndicatorSMSName As IndicatorSMSName From IndicatorSMS Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "IndicatorSMSName";
            cbl.DataValueField = "IndicatorSMSCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblPopularity(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select PopularityID, ' ประการที่ ' + Cast(Sort As nVarChar) + '. ' + PopularityName As PopularityName From Popularity Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "PopularityName";
            cbl.DataValueField = "PopularityID";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblPrimePolicy(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select PrimePolicyID, ' นโยบายที่ ' + Cast(Sort As nVarChar) + '. ' + PrimePolicyName As PrimePolicyName From PrimePolicy Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "PrimePolicyName";
            cbl.DataValueField = "PrimePolicyID";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblPoliciesMinister(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select PoliciesMinisterID, ' นโยบายที่ ' + Cast(Sort As nVarChar) + '. ' + PoliciesMinisterName As PoliciesMinisterName From PoliciesMinister Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "PoliciesMinisterName";
            cbl.DataValueField = "PoliciesMinisterID";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblPolicyKSN(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select PolicyKSNID, ' นโยบายที่ ' + Cast(Sort As nVarChar) + '. ' + PolicyKSNName As PolicyKSNName From PolicyKSN Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "PolicyKSNName";
            cbl.DataValueField = "PolicyKSNID";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStrategies(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select StrategiesCode, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategiesName As StrategiesName From Strategies Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategiesName";
            cbl.DataValueField = "StrategiesCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getddlCorporateStrategy(HtmlGenericControl Div, DropDownList ddl, string StudyYear)
    {
        if (ckIdentityName("ckCorporateStrategy"))
        {
            DataView dv = Conn.Select("Select CorporateStrategyID, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + CorporateStrategyName As CorporateStrategyName From CorporateStrategy Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
            if (dv.Count != 0)
            {
                ddl.DataSource = dv;
                ddl.DataTextField = "CorporateStrategyName";
                ddl.DataValueField = "CorporateStrategyID";
                ddl.DataBind();
                ddl.Enabled = true;
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddl.SelectedIndex = 0;
            }
            else
            {
                ddl.Items.Clear();
                ddl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
                ddl.Enabled = false;
            }
            Div.Visible = true;
        }
        else
        {
            Div.Visible = false;
        }
    }
    public void getcblStrategies(HtmlGenericControl Div, CheckBoxList cbl, string StudyYear)
    {
        if (ckIdentityName("ckStrategies"))
        {
            string strSql = @" Select StrategiesCode, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategiesName As StrategiesName From Strategies Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort ";
            DataView dv = Conn.Select(string.Format(strSql));
            if (dv.Count != 0)
            {
                cbl.DataSource = dv;
                cbl.DataTextField = "StrategiesName";
                cbl.DataValueField = "StrategiesCode";
                cbl.DataBind();
            }
            else
            {
                cbl.Items.Clear();
                cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
                cbl.Enabled = false;
            }
            Div.Visible = true;
        }
        else
        {
            Div.Visible = false;
        }
    }
    public void getddlStrategicPlan(HtmlGenericControl Div, DropDownList ddl, string StudyYear)
    {
        if (ckIdentityName("ckStrategicPlan"))
        {
            DataView dv = Conn.Select("Select StrategicPlanID, ' กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '. ' + StrategicPlanName As StrategicPlanName From StrategicPlan Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
            if (dv.Count != 0)
            {
                ddl.DataSource = dv;
                ddl.DataTextField = "StrategicPlanName";
                ddl.DataValueField = "StrategicPlanID";
                ddl.DataBind();
                ddl.Enabled = true;
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddl.SelectedIndex = 0;
            }
            else
            {
                ddl.Items.Clear();
                ddl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
                ddl.Enabled = false;
            }
            Div.Visible = true;
        }
        else
        {
            Div.Visible = false;
        }
    }
    public void getcblResponseProblems(CheckBoxList cbl, string StudyYear)
    {
        DataView dv = Conn.Select("Select ResponseProblemsCode, ' ' + ResponseProblemsName AS ResponseProblemsName From ResponseProblems Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "ResponseProblemsName";
            cbl.DataValueField = "ResponseProblemsCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblStrategic(CheckBoxList cbl, string StudyYear)
    {      
        DataView dv = Conn.Select("Select StrategicCode, ' ยุทธศาสตร์ด้านที่ ' + Cast(Sort As nVarChar) + '. ' + StrategicName As StrategicName From Strategic Where DelFlag = 0 And StudyYear = '" + StudyYear + "' Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "StrategicName";
            cbl.DataValueField = "StrategicCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getcblIdentityName2(CheckBoxList cbl)
    {

        DataView dv = Conn.Select("Select IdentityNameCode, ' ' + IdentityName As IdentityName From IdentityName Where DelFlag = 0 Order By Sort");
        if (dv.Count != 0)
        {
            cbl.DataSource = dv;
            cbl.DataTextField = "IdentityName";
            cbl.DataValueField = "IdentityNameCode";
            cbl.DataBind();
            cbl.Enabled = true;
        }
        else
        {
            cbl.Items.Clear();
            cbl.Items.Insert(0, new ListItem("-ไม่พบข้อมูล-", ""));
            cbl.Enabled = false;
        }
    }
    public void getddlStrategies(int mode, DropDownList ddl, string StudyYear, object StrategiesCode)
    {
        string strSql = @" Select StrategiesCode, 'กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '.  ' + StrategiesName FullName, Sort 
        From Strategies Where DelFlag = 0 And StudyYear = '{0}' And SchoolID = '{1}' Order By Sort ";
        DataView dv = Conn.Select(string.Format(strSql, StudyYear, CurrentUser.SchoolID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "StrategiesCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (StrategiesCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = StrategiesCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlProjects(int mode, DropDownList ddl, string StudyYear, string StrategiesCode, object ProjectsCode)
    {
//        string strSql = @"Select ProjectsCode, ProjectsName FullName, Sort 
//                    From Projects Where DelFlag = 0 
//                    And StudyYear = '{0}' And SchoolID = '{1}' ";

//        if (!string.IsNullOrEmpty(StrategiesCode))
//        {
            string strSql = @" Select a.ProjectsCode, a.ProjectsName FullName, a.Sort  
            From Projects a Left Join dtStrategies b On a.ProjectsCode = b.ProjectsCode
            Where a.DelFlag = 0 And a.StudyYear = '{0}' And a.SchoolID = '{1}' ";
            if (!string.IsNullOrEmpty(StrategiesCode))
            {
                strSql += " And b.StrategiesCode = '" + StrategiesCode + "'";
            }
            if (CurrentUser.RoleLevel <= 65)
            {
                strSql += " And a.DeptCode = '" + CurrentUser.DeptID + "' ";
            }
        //}

            DataView dv = Conn.Select(string.Format(strSql + " Group By a.ProjectsCode, a.ProjectsName, a.Sort Order By a.Sort ", StudyYear, CurrentUser.SchoolID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "ProjectsCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (ProjectsCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = ProjectsCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            //ddl.Enabled = false;
        }
    }
    public void getddlProjectsForAddActivity(int mode, DropDownList ddl, string StudyYear, string StrategiesCode, object ProjectsCode)
    {
        //        string strSql = @"Select ProjectsCode, ProjectsName FullName, Sort 
        //                    From Projects Where DelFlag = 0 
        //                    And StudyYear = '{0}' And SchoolID = '{1}' ";

        //        if (!string.IsNullOrEmpty(StrategiesCode))
        //        {
        string strSql = @" Select a.ProjectsCode, a.ProjectsName FullName, a.Sort  
            From Projects a Left Join dtStrategies b On a.ProjectsCode = b.ProjectsCode
            Where a.DelFlag = 0 And a.StudyYear = '{0}' And a.SchoolID = '{1}' And a.ckSend Is Null ";
        if (!string.IsNullOrEmpty(StrategiesCode))
        {
            strSql += " And b.StrategiesCode = '" + StrategiesCode + "'";
        }
        if (CurrentUser.RoleLevel <= 65)
        {
            strSql += " And a.DeptCode = '" + CurrentUser.DeptID + "' ";
        }
        //}

        DataView dv = Conn.Select(string.Format(strSql + " Group By a.ProjectsCode, a.ProjectsName, a.Sort Order By a.Sort ", StudyYear, CurrentUser.SchoolID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "ProjectsCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (ProjectsCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = ProjectsCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            //ddl.Enabled = false;
        }
    }
    public DataView getddlProjects(string StudyYear, string StrategiesCode)
    {
        
        DataView dv = Conn.Select("Select ProjectsCode, ProjectsName FullName, Sort From Projects Where DelFlag = 0 And StrategiesCode = '" + StrategiesCode + "' And StudyYear = '" + StudyYear + "' And SchoolID = '" + CurrentUser.SchoolID + "' Order By Sort ");
        return dv;
    }
    public DataView getddlProjectsNotStrategies(string StudyYear, int mode)
    {
        
        string strSql = "Select ProjectsCode, ProjectsName FullName, Sort From Projects "
                + " Where DelFlag = 0  And SchoolID = '" + CurrentUser.SchoolID + "' ";
        //if (mode == 0)
        //{
            strSql += " And StudyYear = '" + StudyYear + "' ";
        //}
       //else
        //{
            //strSql += " And BudgetYear = '" + StudyYear + "' ";
        //}
        DataView dv = Conn.Select(strSql + " Order By Sort ");
        return dv;
    }
    public string getMissionName(string MissionCode)
    {
        
        DataView dv = Conn.Select("Select MissionName From Mission Where DelFlag = 0 And MissionCode = '" + MissionCode + "'");
        if (dv.Count != 0)
        {
            return dv[0]["MissionName"].ToString();
        }
        else
        {
            return "-";
        }
    }
    public string getdtMissionName(string ProjectsCode)
    {
        string MissionName = "";
        DataView dv = Conn.Select("Select M.MissionName From Mission M, dtMission dtM Where M.DelFlag = 0 And M.MissionCode = dtM.MissionCode And dtM.ProjectsCode = '" + ProjectsCode + "' ");
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ",";
            }
            MissionName = MissionName + dv[j]["MissionName"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(MissionName)) ? "-" : MissionName;
    }
    public string getGoalsName(string GoalsCode)
    {
        
        DataView dv = Conn.Select("Select GoalsName From Goals Where DelFlag = 0 And GoalsCode = '" + GoalsCode + "'");
        if (dv.Count != 0)
        {
            return dv[0]["GoalsName"].ToString();
        }
        else
        {
            return "-";
        }
    }
    public string getdtGoalsName(string ProjectsCode)
    {
        string GoalsName = "";
        DataView dv = Conn.Select("Select G.GoalsName From Goals G, dtGoals dtG Where G.DelFlag = 0 And G.GoalsCode = dtG.GoalsCode And dtG.ProjectsCode = '" + ProjectsCode + "' ");
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ",";
            }
            GoalsName = GoalsName + dv[j]["GoalsName"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(GoalsName)) ? "-" : GoalsName;
    }
    public string getSideName(Boolean FullText, string ActivityCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select c.Sort As SideName FROM Evaluation a, Standard b, Side c Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.StandardCode = b.StandardCode And b.SideCode = c.SideCode Group By c.Sort, b.Sort ";
        }
        else
        {
            strSql = "Select Cast(c.Sort As nVarChar) + '. ' + c.SideName As SideName FROM Evaluation a, Standard b, Side c Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.StandardCode = b.StandardCode And b.SideCode = c.SideCode Group By c.Sort, b.Sort, c.SideName ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string Side = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Side = Side + dv[j]["SideName"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Side)) ? "-" : "ด้านที่ " + Side;
    }
    public string getSideNameOfActivity(Boolean FullText, string ActivityCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select s.Sort As SideName 
            FROM Evaluation a, Standard b, Side s 
            Where a.DelFlag = 0 And a.ActivityCode = '{0}' 
            And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort ";
        }
        else
        {
            strSql = @"Select Cast(s.Sort As nVarChar) + ' ' + s.SideName SideName 
            FROM Evaluation a, Standard b, Side s 
            Where a.DelFlag = 0 And a.ActivityCode = '{0}' 
            And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, s.SideName ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ActivityCode));
        string Side = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Side = Side + dv[j]["SideName"].ToString() + Ck;
        }
        string txtSideName = "มาตรฐานที่ ";
        return (string.IsNullOrEmpty(Side)) ? "-" : txtSideName + Side;
    }

    public string getStandardName(Boolean FullText, string ActivityCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) As StandardName FROM Evaluation a, Standard b, Side s Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, b.Sort Order By s.Sort, b.Sort ";
        }
        else
        {
            strSql = "Select Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.StandardName As StandardName FROM Evaluation a, Standard b, Side s Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, b.Sort, b.StandardName Order By s.Sort, b.Sort";
        }   
        DataView dv = Conn.Select(string.Format(strSql));

        string Standard = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Standard = Standard + dv[j]["StandardName"].ToString() + Ck;
        }
        string txtStandardName = "ตัวบ่งชี้ที่ ";
        return (string.IsNullOrEmpty(Standard)) ? "-" : txtStandardName + Standard;
    }
    public string getIndicatorsName(Boolean FullText, string ActivityCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) As IndicatorsName FROM Evaluation a, Standard b, Indicators c Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.IndicatorsCode = c.IndicatorsCode And a.StandardCode = b.StandardCode Group By b.Sort, c.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) + ' ' + c.IndicatorsName As IndicatorsName FROM Evaluation a, Standard b, Indicators c Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.IndicatorsCode = c.IndicatorsCode And a.StandardCode = b.StandardCode Group By b.Sort, c.Sort, c.IndicatorsName ";
        }   
        DataView dv = Conn.Select(string.Format(strSql));

        string Indicators = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Indicators = Indicators + dv[j]["IndicatorsName"].ToString() + Ck;
        }
        string txtIndicatorsName = "ตัวบ่งชี้ที่ ";
        if (ckIdentityName("ckStandardNew"))
        {
            txtIndicatorsName = "ประเด็นการพิจารณาย่อยที่ ";
        }
        return (string.IsNullOrEmpty(Indicators)) ? "-" : txtIndicatorsName + Indicators;
    }
    public string getSideNameOfProjects(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select s.Sort As SideName 
            FROM Evaluation a, Standard b, Side s 
            Where a.DelFlag = 0 And a.ProjectsCode = '{0}' 
            And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort ";
        }
        else
        {
            strSql = @"Select Cast(s.Sort As nVarChar) + '. ' + s.SideName SideName 
            FROM Evaluation a, Standard b, Side s 
            Where a.DelFlag = 0 And a.ProjectsCode = '{0}' 
            And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, s.SideName ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));
        string Side = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Side = Side + dv[j]["SideName"].ToString() + Ck;
        }
        string txtSideName = "มาตรฐานที่ ";
        return (string.IsNullOrEmpty(Side)) ? "-" : txtSideName + Side;
    }
    public string getStandardNameOfProjects(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) As StandardName FROM Evaluation a, Standard b, Side s Where a.DelFlag = 0 And a.ProjectsCode = '" + ProjectsCode + "' And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, b.Sort ";
        }
        else
        {
            strSql = "Select Cast(s.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.StandardName StandardName FROM Evaluation a, Standard b, Side s Where a.DelFlag = 0 And a.ProjectsCode = '" + ProjectsCode + "' And a.StandardCode = b.StandardCode And b.SideCode = s.SideCode Group By s.Sort, b.Sort, b.StandardName ";
        }
        DataView dv = Conn.Select(string.Format(strSql));
        string Standard = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Standard = Standard + dv[j]["StandardName"].ToString() + Ck;
        }
        string txtStandardName = "ตัวบ่งชี้ที่ ";
        return (string.IsNullOrEmpty(Standard)) ? "-" : txtStandardName + Standard;
    }
    public string getIndicatorsNameOfProjects(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) As IndicatorsName FROM Evaluation a, Standard b, Indicators c Where a.DelFlag = 0 And a.ProjectsCode = '" + ProjectsCode + "' And a.IndicatorsCode = c.IndicatorsCode And a.StandardCode = b.StandardCode Group By b.Sort, c.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '.' + Cast(c.Sort As nVarChar) + ' ' + c.IndicatorsName As IndicatorsName FROM Evaluation a, Standard b, Indicators c Where a.DelFlag = 0 And a.ProjectsCode = '" + ProjectsCode + "' And a.IndicatorsCode = c.IndicatorsCode And a.StandardCode = b.StandardCode Group By b.Sort, c.Sort, c.IndicatorsName ";
        }
        DataView dv = Conn.Select(string.Format(strSql));
        string Indicators = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Indicators = Indicators + dv[j]["IndicatorsName"].ToString() + Ck;
        }
        string txtIndicatorsName = "ประเด็นการประเมินที่ ";
        return (string.IsNullOrEmpty(Indicators)) ? "-" : txtIndicatorsName + Indicators;
    }
    public string getPolicyName(string ProjectsCode)
    {
        
        string strSql = "Select a.*, b.Sort As Policy, b.PolicyName FROM dtPolicy a, Policy b Where a.ProjectsCode = '" + ProjectsCode + "' And a.PolicyCode = b.PolicyCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        string Policy = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Policy = Policy + dv[j]["Policy"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Policy)) ? "" : "นโยบายที่ " + Policy;
    }
    public string getNewStandard(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As NewStandard FROM dtNewStandard a, NewStandard b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardCode = b.StandardCode Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.StandardName As NewStandard FROM dtNewStandard a, NewStandard b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardCode = b.StandardCode Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string StandardName = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            StandardName = StandardName + dv[j]["NewStandard"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(StandardName)) ? "" : "มาตรฐานที่ " + StandardName;
    }
    public string getStandardNationName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As StandardNation FROM dtStandardNation a, StandardNation b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardNationCode = b.StandardNationCode Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.StandardNationName As StandardNation FROM dtStandardNation a, StandardNation b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardNationCode = b.StandardNationCode Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string StandardNation = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            StandardNation = StandardNation + dv[j]["StandardNation"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(StandardNation)) ? "" : "มาตรฐานที่ " + StandardNation;
    }
    public string getStandardMinistryName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As StandardMinistry FROM dtStandardMinistry a, StandardMinistry b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardMinistryCode = b.StandardMinistryCode Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.StandardMinistryName As StandardMinistry FROM dtStandardMinistry a, StandardMinistry b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardMinistryCode = b.StandardMinistryCode Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string StandardMinistry = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            StandardMinistry = StandardMinistry + dv[j]["StandardMinistry"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(StandardMinistry)) ? "" : "มาตรฐานที่ " + StandardMinistry;
    }
    public string getStrategySPTName(string ProjectsCode)
    {
        
        string strSql = "Select a.*, b.Sort As StrategySPT FROM dtStrategySPT a, StrategySPT b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategySPTCode = b.StrategySPTCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        string StrategySPT = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                string Ck = "";
                if (j == dv.Count - 1)
                {
                    Ck = "";
                }
                else
                {
                    Ck = ", ";
                }
                StrategySPT = StrategySPT + dv[j]["StrategySPT"].ToString() + Ck;
            }
        }
        return (string.IsNullOrEmpty(StrategySPT)) ? "-" : "กลยุทธ์ที่ " + StrategySPT;
    }
    public string getStrategiesName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As Strategies FROM dtStrategies a, Strategies b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategiesCode = b.StrategiesCode Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As Strategies FROM dtStrategies a, Strategies b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategiesCode = b.StrategiesCode Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string Strategies = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Strategies = Strategies + dv[j]["Strategies"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Strategies)) ? "" : "กลยุทธ์ที่ " + Strategies;
    }
    public string getStrategicName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As Strategic FROM dtStrategic a, Strategic b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategicCode = b.StrategicCode Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.StrategicName As Strategic FROM dtStrategic a, Strategic b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategicCode = b.StrategicCode Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string Strategic = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Strategic = Strategic + dv[j]["Strategic"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Strategic)) ? "" : "ยุทธศาสตร์ที่ " + Strategic;
    }
    public string getPopularityName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = "Select b.Sort As Popularity FROM dtPopularity a, Popularity b Where a.ProjectsCode = '" + ProjectsCode + "' And a.PopularityID = b.PopularityID Order By b.Sort ";
        }
        else
        {
            strSql = "Select Cast(b.Sort As nVarChar) + '. ' + b.PopularityName As Popularity FROM dtPopularity a, Popularity b Where a.ProjectsCode = '" + ProjectsCode + "' And a.PopularityID = b.PopularityID Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql));

        string Popularity = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            Popularity = Popularity + dv[j]["Popularity"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Popularity)) ? "" : "ประการที่ " + Popularity;
    }
    public string getWorldClassSideName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select b.WorldClassSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) As WorldClassSide, b.MsSideSort
                FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
                Where a.ProjectsCode = '{0}' 
                And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
                Group By b.Sort, b.MsSideSort, b.WorldClassSideID
                Order By b.MsSideSort, b.Sort ";
        }
        else
        {
            strSql = @"Select b.WorldClassSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) + ' ' + b.WorldClassSideName As WorldClassSide, b.MsSideSort 
				FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
                Where a.ProjectsCode = '{0}' 
				And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
				Group By b.Sort, b.MsSideSort, b.WorldClassSideName, b.WorldClassSideID
                Order By b.MsSideSort, b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        //if (!FullText)
        //{
        strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As WorldClassStandard, b.WorldClassSideID 
                FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
                Where a.ProjectsCode = '{0}' 
                And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
                Order By b.MsSideSort, b.Sort, c.Sort ";
        //}
        //else
        //{
        //    strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.WorldClassStandardName As WorldClassStandard, b.WorldClassSideID 
        //      FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
        //      Where a.ProjectsCode = '{0}' 
        //      And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
        //      Order By b.Sort ";
        //}
        DataView dv1 = Conn.Select(string.Format(strSql, ProjectsCode));

        string WorldClassSideName = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {            
                dv1.RowFilter = " WorldClassSideID = '" + dv[j]["WorldClassSideID"].ToString() + "'";
                if (dv1.Count != 0)
                {
                    string WorldClassStandardName = "";
                    for (int k = 0; k < dv1.Count; k++)
                    {
                        string Ck = "";
                        if (k == dv1.Count - 1)
                        {
                            Ck = "";
                        }
                        else
                        {
                            Ck = ", ";
                        }
                        WorldClassStandardName = WorldClassStandardName + dv1[k]["WorldClassStandard"].ToString() + Ck;
                    }

                    string Ck1 = "";
                    if (j == dv.Count - 1)
                    {
                        Ck1 = "";
                    }
                    else
                    {
                        Ck1 = "|";
                    }
                    WorldClassSideName = WorldClassSideName + dv[j]["WorldClassSide"].ToString() + "  ตัวชี้วัดที่ " + WorldClassStandardName + Ck1;
                }
            }
        }
        return (string.IsNullOrEmpty(WorldClassSideName)) ? "" : WorldClassSideName;
    }
    public string getWorldClassStandardName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As WorldClassStandard FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
                Where a.ProjectsCode = '{0}' And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
                Order By b.Sort ";
        }
        else
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.WorldClassStandardName As WorldClassStandard 
				FROM dtWorldClass a, WorldClassSide b, WorldClassStandard c 
                Where a.ProjectsCode = '{0}' 
				And a.WorldClassStandardID = c.WorldClassStandardID And b.WorldClassSideID = c.WorldClassSideID
                Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        string WorldClassStandardName = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            WorldClassStandardName = WorldClassStandardName + dv[j]["WorldClassStandard"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(WorldClassStandardName)) ? "" : "มาตรฐานที่ " + WorldClassStandardName;
    }
    public string getRoyalAwardSideName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select b.RoyalAwardSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) As RoyalAwardSide 
                FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
                Where a.ProjectsCode = '{0}' 
                And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID
                Group By b.RoyalAwardSideID, b.Sort
                Order By b.Sort ";
        }
        else
        {
            strSql = @"Select b.RoyalAwardSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) + ' ' + b.RoyalAwardSideName As RoyalAwardSide 
				FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
                Where a.ProjectsCode = '{0}' 
				And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID
				Group By b.RoyalAwardSideID, b.Sort, b.RoyalAwardSideName
                Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        //if (!FullText)
        //  {
        strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As RoyalAwardIndicator, b.RoyalAwardSideID 
                FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
                Where a.ProjectsCode = '{0}' 
                And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID 
                Order By b.Sort ";
        //  }
        //  else
        //  {
        //      strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.RoyalAwardIndicatorName As RoyalAwardIndicator, b.RoyalAwardSideID  
        //          FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
        //          Where a.ProjectsCode = '{0}' 
        //          And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID
        //          Order By b.Sort ";
        //}
        DataView dv1 = Conn.Select(string.Format(strSql, ProjectsCode));

        string RoyalAwardSideName = "";

        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                dv1.RowFilter = " RoyalAwardSideID = '" + dv[j]["RoyalAwardSideID"].ToString() + "'";
                if (dv1.Count != 0)
                {
                    string RoyalAwardIndicatorName = "";
                    for (int k = 0; k < dv1.Count; k++)
                    {
                        string Ck = "";
                        if (k == dv1.Count - 1)
                        {
                            Ck = "";
                        }
                        else
                        {
                            Ck = ", ";
                        }
                        RoyalAwardIndicatorName = RoyalAwardIndicatorName + dv1[k]["RoyalAwardIndicator"].ToString() + Ck;
                    }
                    string Ck1 = "";
                    if (j == dv.Count - 1)
                    {
                        Ck1 = "";
                    }
                    else
                    {
                        Ck1 = "|";
                    }
                    RoyalAwardSideName = RoyalAwardSideName + dv[j]["RoyalAwardSide"].ToString() + "  ตัวชี้วัดที่ " + RoyalAwardIndicatorName + Ck1;
                }               
            }
        }
        return (string.IsNullOrEmpty(RoyalAwardSideName)) ? "" : RoyalAwardSideName;
    }
    public string getRoyalAwardIndicatorName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As RoyalAwardIndicator FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
                Where a.ProjectsCode = '{0}' And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID
                Order By b.Sort ";
        }
        else
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.RoyalAwardIndicatorName As RoyalAwardIndicator 
				FROM dtRoyalAward a, RoyalAwardSide b, RoyalAwardIndicator c 
                Where a.ProjectsCode = '{0}' 
				And a.RoyalAwardIndicatorID = c.RoyalAwardIndicatorID And b.RoyalAwardSideID = c.RoyalAwardSideID
                Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        string RoyalAwardIndicatorName = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            RoyalAwardIndicatorName = RoyalAwardIndicatorName + dv[j]["RoyalAwardIndicator"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(RoyalAwardIndicatorName)) ? "" : "ตัวชี้วัดที่ " + RoyalAwardIndicatorName;
    }
    public string getFourthAssessmentSideName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        //if (!FullText)
        //{
            strSql = @"Select b.FourthAssessmentSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) As FourthAssessmentSide 
                        FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
                        Where a.ProjectsCode = '{0}' And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID
                        Group By b.FourthAssessmentSideID, b.Sort
                        Order By b.Sort ";
//        }
//        else
//        {
//            strSql = @"Select b.FourthAssessmentSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) + ' ' + b.FourthAssessmentSideName As FourthAssessmentSide 
//				FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
//                Where a.ProjectsCode = '{0}' 
//				And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID
//				Group By b.FourthAssessmentSideID, b.Sort, b.FourthAssessmentSideName
//                Order By b.Sort ";
//        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        //if (!FullText)
        //{
        strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As FourthAssessmentIndicator, b.FourthAssessmentSideID 
                    FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
                    Where a.ProjectsCode = '{0}'
                    And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID
                    Order By b.Sort ";
        //   }
        //   else
        //   {
        //       strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.FourthAssessmentIndicatorName As FourthAssessmentIndicator, b.FourthAssessmentSideID 
        //          FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
        //          Where a.ProjectsCode = '{0}' 
        //          And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID And b.FourthAssessmentSideID = '{1}'
        //          Order By b.Sort ";
        //}
        DataView dv1 = Conn.Select(string.Format(strSql, ProjectsCode));

        string FourthAssessmentSideName = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                dv1.RowFilter = " FourthAssessmentSideID = '" + dv[j]["FourthAssessmentSideID"].ToString() + "'";
                if (dv1.Count != 0)
                {
                    string FourthAssessmentIndicatorName = "";
                    for (int k = 0; k < dv1.Count; k++)
                    {
                        string Ck = "";
                        if (k == dv1.Count - 1)
                        {
                            Ck = "";
                        }
                        else
                        {
                            Ck = ", ";
                        }
                        FourthAssessmentIndicatorName = FourthAssessmentIndicatorName + dv1[k]["FourthAssessmentIndicator"].ToString() + Ck;
                    }
                    string Ck1 = "";
                    if (j == dv.Count - 1)
                    {
                        Ck1 = "";
                    }
                    else
                    {
                        Ck1 = "|";
                    }
                    FourthAssessmentSideName = FourthAssessmentSideName + dv[j]["FourthAssessmentSide"].ToString() + "  ตัวบ่งชี้ที่ " + FourthAssessmentIndicatorName + Ck1;
                }
            }
        }
        return (string.IsNullOrEmpty(FourthAssessmentSideName)) ? "" : FourthAssessmentSideName;
    }
    public string getFourthAssessmentIndicatorName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        if (!FullText)
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As FourthAssessmentIndicator FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
                Where a.ProjectsCode = '{0}' And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID
                Order By b.Sort ";
        }
        else
        {
            strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.FourthAssessmentIndicatorName As FourthAssessmentIndicator 
				FROM dtFourthAssessment a, FourthAssessmentSide b, FourthAssessmentIndicator c 
                Where a.ProjectsCode = '{0}' 
				And a.FourthAssessmentIndicatorID = c.FourthAssessmentIndicatorID And b.FourthAssessmentSideID = c.FourthAssessmentSideID
                Order By b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        string FourthAssessmentIndicatorName = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ", ";
            }
            FourthAssessmentIndicatorName = FourthAssessmentIndicatorName + dv[j]["FourthAssessmentIndicator"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(FourthAssessmentIndicatorName)) ? "" : "ตัวบ่งชี้ที่ " + FourthAssessmentIndicatorName;
    }
    public string getSufficeSideName(Boolean FullText, string ProjectsCode)
    {
        string strSql;
        string SufficeStandardName = "";
        string SufficeIndicatorName = "";
        //if (!FullText)
        //{
            strSql = @" Select b.SufficeSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) As SufficeSide 
                        FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d 
                        Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID 
                        And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
                        Group By b.SufficeSideID, b.Sort
                        Order By b.Sort ";
//        }
//        else
//        {
//            strSql = @"Select b.SufficeSideID, N'ด้านที่ ' + Cast(b.Sort As nVarChar) + ' ' + b.SufficeSideName As SufficeSide 
//				FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d 
//                Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID
//				And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
//				Group By b.SufficeSideID, b.Sort, b.SufficeSideName
//                Order By b.Sort ";
//        }
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));

        //if (!FullText)
        //{
        strSql = @"Select c.SufficeStandardID, Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) As SufficeStandard, c.SufficeSideID 
                       FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d
                       Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID
                       And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
                       Order By b.Sort, c.Sort, d.Sort ";
        //}
        //else
        //{
        //  strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + ' ' + c.SufficeStandardName As SufficeStandard, c.SufficeSideID 
        //			    FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d
        //              Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID
        //              And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
        //              Order By b.Sort, c.Sort, d.Sort ";
        //}
        DataView dv1 = Conn.Select(string.Format(strSql, ProjectsCode));

        //if (!FullText)
        //{
        strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + '.' + Cast(d.Sort As nVarchar) As SufficeIndicator, c.SufficeSideID, d.SufficeStandardID 
                                FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d
                                Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID
                                And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
                                Order By b.Sort, c.Sort, d.Sort ";
        //}
        //else
        //{
        //  strSql = @"Select Cast(b.Sort As nVarchar) + '.' + Cast(c.Sort As nVarchar) + '.' + Cast(d.Sort As nVarchar) + ' ' + d.SufficeIndicatorName As SufficeIndicator, c.SufficeSideID, d.SufficeStandardID 
        //				FROM dtSuffice a, SufficeSide b, SufficeStandard c, SufficeIndicator d
        //              Where a.ProjectsCode = '{0}' And a.SufficeIndicatorID = d.SufficeIndicatorID
        //              And d.SufficeStandardID = c.SufficeStandardID And c.SufficeSideID = b.SufficeSideID
        //              Order By b.Sort, c.Sort, d.Sort ";
        //}
        DataView dv2 = Conn.Select(string.Format(strSql, ProjectsCode));

        string SufficeSideName = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                dv1.RowFilter = " SufficeSideID = '" + dv[j]["SufficeSideID"].ToString() + "'";
                if (dv1.Count != 0)
                {
                    SufficeStandardName = "";
                    for (int k = 0; k < dv1.Count; k++)
                    {
                        string Ck = "";
                        if (k == dv1.Count - 1)
                        {
                            Ck = "";
                        }
                        else
                        {
                            Ck = ", ";
                        }
                        SufficeStandardName = SufficeStandardName + dv1[k]["SufficeStandard"].ToString() + Ck;
                    }

                    for (int t = 0; t <= dv1.Count - 1; t++)
                    {
                        dv2.RowFilter = " SufficeSideID = '" + dv[j]["SufficeSideID"].ToString() + "' And SufficeStandardID = '" + dv1[t]["SufficeStandardID"].ToString() + "'";
                        if (dv2.Count != 0)
                        {
                            SufficeIndicatorName = "";
                            for (int k = 0; k < dv2.Count; k++)
                            {
                                string Ck = "";
                                if (k == dv2.Count - 1)
                                {
                                    Ck = "";
                                }
                                else
                                {
                                    Ck = ", ";
                                }
                                SufficeIndicatorName = SufficeIndicatorName + dv2[k]["SufficeIndicator"].ToString() + Ck;
                            }
                        }
                    }
                }
                string Ck1 = "";
                if (j == dv.Count - 1)
                {
                    Ck1 = "";
                }
                else
                {
                    Ck1 = "|";
                }
                SufficeSideName = SufficeSideName + dv[j]["SufficeSide"].ToString() + "  องค์ประกอบที่ " + SufficeStandardName + "  ตัวบ่งชี้ที่ " + SufficeIndicatorName + Ck1;
            }
        }
        return (string.IsNullOrEmpty(SufficeSideName)) ? "" : SufficeSideName;
    }
    public string getStrategySPMPName()
    {
        string Name = "กลยุทธ์ สพม.";
        if (ckIdentityName("ckAnuban"))
        {
            Name = "กลยุทธ์ สพป.";
        }
        return Name;
    }
    public string getStrategySPMName(string ProjectsCode)
    {
        
        string strSql = "Select a.*, b.Sort As StrategySPM FROM dtStrategySPM a, StrategySPM b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StrategySPMCode = b.StrategySPMCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        string StrategySPM = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                string Ck = "";
                if (j == dv.Count - 1)
                {
                    Ck = "";
                }
                else
                {
                    Ck = ", ";
                }
                StrategySPM = StrategySPM + dv[j]["StrategySPM"].ToString() + Ck;
            }
        }
        return (string.IsNullOrEmpty(StrategySPM)) ? "-" : "กลยุทธ์ที่ " + StrategySPM;
    }
    public string getStandardSPMName(string ProjectsCode)
    {
        
        string strSql = "Select a.*, b.Sort As StandardSPM FROM dtStandardSPM a, StandardSPM b Where a.ProjectsCode = '" + ProjectsCode + "' And a.StandardSPMCode = b.StandardSPMCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        string StandardSPM = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                string Ck = "";
                if (j == dv.Count - 1)
                {
                    Ck = "";
                }
                else
                {
                    Ck = ", ";
                }
                StandardSPM = StandardSPM + dv[j]["StandardSPM"].ToString() + Ck;
            }
        }
        return (string.IsNullOrEmpty(StandardSPM)) ? "-" : "มาตรฐานที่ " + StandardSPM;
    }
    public string getIndicatorSMSName(string ProjectsCode)
    {

        string strSql = "Select a.*, b.Sort As IndicatorSMS FROM dtIndicatorSMS a, IndicatorSMS b Where a.ProjectsCode = '" + ProjectsCode + "' And a.IndicatorSMSCode = b.IndicatorSMSCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        string IndicatorSMS = "";
        if (dv.Count != 0)
        {
            for (int j = 0; j <= dv.Count - 1; j++)
            {
                string Ck = "";
                if (j == dv.Count - 1)
                {
                    Ck = "";
                }
                else
                {
                    Ck = ", ";
                }
                IndicatorSMS = IndicatorSMS + dv[j]["IndicatorSMS"].ToString() + Ck;
            }
        }
        return (string.IsNullOrEmpty(IndicatorSMS)) ? "-" : "ตัวบ่งชี้ที่ " + IndicatorSMS;
    }
    public string getFactorName(string ActivityCode)
    {
        
        string strSql = "Select a.FactorName FROM Factor a, dtFactor b Where a.DelFlag = 0 And a.FactorCode = b.FactorCode And b.ActivityCode = '" + ActivityCode + "' ";
        DataView dv = Conn.Select(string.Format(strSql));

        string Factor = "";
        for (int j = 0; j <= dv.Count - 1; j++)
        {
            string Ck = "";
            if (j == dv.Count - 1)
            {
                Ck = "";
            }
            else
            {
                Ck = ",  ";
            }
            Factor = Factor + dv[j]["FactorName"].ToString() + Ck;
        }
        return (string.IsNullOrEmpty(Factor)) ? "-" : Factor;
    }
    public string getResourceName(string ActivityCode)
    {
        string Resource = "";
        DataView dv = Conn.Select("Select ReSource From Activity Where ActivityCode = '" + ActivityCode + "'");
        if (dv.Count != 0)
        {
            Resource = dv[0]["Resource"].ToString();
        }

        if (ckIdentityName("ckResource"))
        {
            return Resource;
        }
        else
        {
            return "";
        }
    }
    public void getddlActivity(int mode, DropDownList ddl, string ProjectsCode, object ckActivityCode)
    {        
        string strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort From Activity a"
                    + " Where a.DelFlag = 0 And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //if (btc.ckGetAdmission(CurrentUser.UserRoleID) > 2)
        //{
        //    if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 3)
        //    {
        //        strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort "
        //                + " From Activity a, dtAcDept b "
        //                + " Where a.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And b.DeptCode = '" + CurrentUser.DeptID + "' ";
        //    }
        //    if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 4)
        //    {
        //        strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort "
        //                + " From Activity a, dtAcEmp b "
        //                + " Where a.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And b.EmpCode = '" + CurrentUser.ID + "' ";
        //    }
        //}

        DataView dv = Conn.Select(strSql + " Order By a.Sort ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "ActivityCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (ckActivityCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = ckActivityCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlActivityIsApprove(int mode, DropDownList ddl, string ProjectsCode, object ckActivityCode)
    {       
        string strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort From Activity a"
                    + " Where a.DelFlag = 0 And a.ApproveFlag = 1 And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //if (btc.ckGetAdmission(CurrentUser.UserRoleID) > 2)
        //{
        //    if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 3)
        //    {
        //        strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort "
        //                + " From Activity a, dtAcDept b "
        //                + " Where a.DelFlag = 0 And a.ApproveFlag = 1 And a.ActivityCode = b.ActivityCode And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And b.DeptCode = '" + CurrentUser.DeptID + "' ";
        //    }
        //    if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 4)
        //    {
        //        strSql = " Select a.ActivityCode, a.ActivityName FullName, a.Sort "
        //                + " From Activity a, dtAcEmp b "
        //                + " Where a.DelFlag = 0 And a.ApproveFlag = 1 And a.ActivityCode = b.ActivityCode And a.ProjectsCode = '" + ProjectsCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //                + " And b.EmpCode = '" + CurrentUser.ID + "' ";
        //    }
        //}

        DataView dv = Conn.Select(strSql + " Order By a.Sort ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "ActivityCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (ckActivityCode == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        ddl.SelectedValue = ckActivityCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public string getStrategiesCodeOfProj(string ProjectsID)
    {
        
        string strSql = " Select StrategiesCode From Projects Where DelFlag = 0 And ProjectsCode = '" + ProjectsID + "'";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            return dv[0]["StrategiesCode"].ToString();
        }
        else
        {
            return "";
        }
    }
    public DataView getddlActivity(string id)
    {
        
        DataView dv = Conn.Select("Select ActivityCode, ActivityName FullName, Sort From Activity Where DelFlag = 0 And ProjectsCode = '" + id + "' And SchoolID = '" + CurrentUser.SchoolID + "' Order By Sort ");
        return dv;
    }
    public DataView getActivityDetail(string ActivityCode)
    {
        
        DataView dv = Conn.Select("Select a.ActivityCode, a.ActivityName FullName, a.DeptCode, '' DeptName, a.Target, a.Target2, a.ActivityDetail, a.Note, CostsType = Case a.CostsType When 0 Then 'งานกิจกรรม' When 1 Then 'งานประจำ' End, IsNull(a.TotalAmount, 0) TotalAmount, IsNull(a.TotalStatement, 0) TotalStatement, IsNull(a.TotalPersonnel, 0) TotalPersonnel, IsNull(a.TotalFinance, 0) TotalFinance, a.StudyYear, a.BudgetYear, a.Term, a.YearB, a.SDate, a.EDate, a.Sort, '' EmpName, a.VolumeExpect, a.VolumeCan From Activity a Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' Order By a.Sort ");

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = getAcDeptName(dv[j]["ActivityCode"].ToString());
            dv[j]["EmpName"] = getAcEmpName(dv[j]["ActivityCode"].ToString());
        }

        return dv;
    }
    public DataView getActivityDetailFinished(string ActivityCode)
    {
        
        DataView dv = Conn.Select("Select a.ActivityCode, a.ActivityName FullName, a.DeptCode, '' DeptName, a.ActivityDetail, a.Place, a.Note, CostsType = Case IsNull(a.CostsType2, a.CostsType) When 0 Then 'งานกิจกรรม' When 1 Then 'งานประจำ' End, IsNull(a.TotalAmount, 0) TotalAmount, a.StudyYear, a.BudgetYear, a.Term, a.YearB, a.SDate, a.EDate, IsNull(a.SDate2, a.SDate) As SDate2, IsNull(a.EDate2, a.EDate) As EDate2, a.Sort, '' EmpName From Activity a Where a.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' Order By a.Sort ");

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = getAcDeptName(dv[j]["ActivityCode"].ToString());
            dv[j]["EmpName"] = getAcEmpName(dv[j]["ActivityCode"].ToString());
        }

        return dv;
    }
    public void getddlIndicators2(int mode, DropDownList ddl, string ActivityCode, object ckIndicators2)
    {
        
        DataView dv = Conn.Select("Select b.Indicators2Code, b.IndicatorsName2 FullName, b.Weight, b.Sort From Activity a, Indicators2 b Where a.ActivityCode = b.ActivityCode And b.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' Order By a.Sort, b.Sort");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "Indicators2Code";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                if (ckIndicators2 == null)
                {
                    ddl.SelectedIndex = 0;
                }
                else
                {
                    try
                    {
                        if (!string.IsNullOrEmpty(ckIndicators2.ToString()))
                        {
                            ddl.SelectedValue = Cookie.GetValue2("ckIndicators2").ToString();
                        }
                        else
                        {
                            ddl.SelectedIndex = 0;
                        }
                    }
                    catch (Exception ex)
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public enum DDl
    {
        QACategory = 20,
        QACategorySub = 21,
    }
    public void getddlQACategory(int mode, DDl type, DropDownList ddl, string studyYear, string RefID, string Indicators2Code)
    {
        string strSql = "";
        if (type == DDl.QACategory)
        {
            strSql = @"Select QACategoryID As ID, Cast(Sort AS nVarchar(3)) + '. ' + QACategoryName As FullName 
                        From QACategory Where DelFlag = '0' And StudyYear = '{0}' Order By Sort ";
        }
        if (type == DDl.QACategorySub)
        {
            strSql = @"Select b.QACategorySubID As ID, Cast(a.Sort AS nVarchar(3)) + '.' + Cast(b.Sort AS nVarchar(3)) + ' ' + b.QACategorySubName As FullName 
                        From QACategory a, QACategorySub b Where A.QACategoryID = b.QACategoryID And b.DelFlag = '0' 
                        And a.StudyYear = '{0}' And b.QACategoryID = '{1}' 
                        And b.QACategorySubID Not In (Select QACategorySubID From QALink Where Indicators2Code = '{2}' And SchoolID = '{3}' )
                        Order By a.Sort, b.Sort ";
        }
        DataView dv = Conn.Select(string.Format(strSql, studyYear, RefID, Indicators2Code, CurrentUser.SchoolID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "FullName";
            ddl.DataValueField = "ID";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public DataView getddlIndicators2(string ActivityCode)
    {
        
        DataView dv = Conn.Select("Select b.Indicators2Code, b.IndicatorsName2 FullName, b.Weight, b.Sort From Activity a, Indicators2 b Where a.ActivityCode = b.ActivityCode And b.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' Order By a.Sort, b.Sort ");
        return dv;
    }
    public DataView getWeight(string Indicators2Code)
    {
        
        DataView dv = Conn.Select("Select Weight, WeightType, OffAll, OffThat, APercent, CkCriterion From Indicators2 Where DelFlag = 0 And Indicators2Code = '" + Indicators2Code + "' ");
        return dv;
    }
    public void getddlUserRole(int mode, DropDownList ddl, object ckRole)
    {
        string strSql = @" Select UserRoleID, UserRoleName From UserRole Where DelFlag = 0 ";
        DataView dv = Conn.Select(strSql + " Order By RoleLevel ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "UserRoleName";
            ddl.DataValueField = "UserRoleID";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }

        if (mode == 0)
        {
            if (ckRole == null)
            {
                ddl.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    if (!string.IsNullOrEmpty(ckRole.ToString()))
                    {
                        ddl.SelectedValue = ckRole.ToString();
                    }
                    else
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
    }

    public void getddlPosition(int mode, DropDownList ddl, string UserRoleID, object ckPosition)
    {
        string strSql = @" Select ApprovePositionID, ApprovePositionName From ApprovePosition Where ApprovePositionID Is Not Null ";
        if (!string.IsNullOrEmpty(UserRoleID))
        {
            strSql += " And UserRoleID = '" + UserRoleID + "' ";
        }
        DataView dv = Conn.Select(strSql + " Order By ApprovePositionID ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "ApprovePositionName";
            ddl.DataValueField = "ApprovePositionID";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }

        if (mode == 0)
        {
            if (ckPosition == null)
            {
                ddl.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    if (!string.IsNullOrEmpty(ckPosition.ToString()))
                    {
                        ddl.SelectedValue = ckPosition.ToString();
                    }
                    else
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
    }
    public void getddlApproveUser(int mode, DropDownList ddl, string UserRoleID, string PositionID, object ckApproveUser)
    {
        string strSql = @" Select EmpID, EmpName From Employee Where DelFlag = 0 And HideFlag = 0 ";
        if (!string.IsNullOrEmpty(UserRoleID))
        {
            strSql += " And UserRoleID = '" + UserRoleID + "' ";
        }
        if (!string.IsNullOrEmpty(PositionID))
        {
            strSql += " And ApprovePositionID = '" + PositionID + "' ";
        }
        DataView dv = Conn.Select(strSql + " Order By EmpName ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "EmpName";
            ddl.DataValueField = "EmpID";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }

        if (mode == 0)
        {
            if (ckApproveUser == null)
            {
                ddl.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    if (!string.IsNullOrEmpty(ckApproveUser.ToString()))
                    {
                        ddl.SelectedValue = ckApproveUser.ToString();
                    }
                    else
                    {
                        ddl.SelectedIndex = 0;
                    }
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
    }

    public void getddlMainDepartment(int mode, DropDownList ddl, object ckMainDept)
    {
        string strSql = @" Select MainDeptCode, MainDeptName From MainDepartment 
        Where DelFlag = 0 And MainDeptCode = '{0}' Order By Sort ";
        DataView dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "MainDeptName";
            ddl.DataValueField = "MainDeptCode";
            ddl.DataBind();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedValue = CurrentUser.MainDeptID;
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
        }
        ddl.Enabled = false;
    }
    public void getddlMainSubDepartment(int mode, DropDownList ddl, string MainDeptCode, object ckMainSubDept)
    {
        string strSql = @" Select MainSubDeptCode, MainSubDeptName From MainSubDepartment Where DelFlag = 0 ";
        if (!string.IsNullOrEmpty(MainDeptCode))
        {
            strSql += " And MainDeptCode = '" + MainDeptCode + "' ";
        }
        DataView dv = Conn.Select(strSql + " Order By Sort ");
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "MainSubDeptName";
            ddl.DataValueField = "MainSubDeptCode";
            ddl.DataBind();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }

            if (ckMainSubDept == null)
            {
                if (CurrentUser.RoleLevel > 65)
                {
                    ddl.SelectedIndex = 0;
                    ddl.Enabled = true;
                }
                else
                {
                    ddl.SelectedValue = CurrentUser.MainSubDeptID;
                    ddl.Enabled = false;
                }
            }
            else
            {
                try
                {
                    if (CurrentUser.RoleLevel > 65)
                    {
                        if (!string.IsNullOrEmpty(ckMainSubDept.ToString()))
                        {
                            ddl.SelectedValue = ckMainSubDept.ToString();
                        }
                        else
                        {
                            ddl.SelectedIndex = 0;
                        }
                        ddl.Enabled = true;
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(ckMainSubDept.ToString()))
                        {
                            ddl.SelectedValue = ckMainSubDept.ToString();
                        }
                        else
                        {
                            ddl.SelectedValue = CurrentUser.MainSubDeptID;
                        }
                        ddl.Enabled = false;
                    }
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }       
    }
    public void getddlDepartment(int mode, DropDownList ddl, string MainSubDeptCode, object ckDept, CheckBoxList cbl)
    {
        string strSql = @" Select D.DeptCode, D.DeptName 
        From Department D Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
        Where D.DelFlag = 0 And MD.DelFlag = 0 And MSD.DelFlag = 0 
        And MD.MainDeptCode = '{0}' ";
        if (mode == 0)
        {
            //if (!string.IsNullOrEmpty(MainSubDeptCode))
            //{
            strSql += " And MSD.MainSubDeptCode = '" + MainSubDeptCode + "' ";
            //}
        }
        else
        {
            if (!string.IsNullOrEmpty(MainSubDeptCode))
            {
                strSql += " And MSD.MainSubDeptCode = '" + MainSubDeptCode + "' ";
            }
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By MD.Sort, MSD.Sort, D.Sort ", CurrentUser.MainDeptID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "DeptName";
            ddl.DataValueField = "DeptCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }

            if (ckDept == null)
            {
                if (CurrentUser.RoleLevel > 65)
                {
                    ddl.SelectedIndex = 0;
                    ddl.Enabled = true;
                }
                else
                {
                    ddl.SelectedValue = CurrentUser.DeptID;
                    ddl.Enabled = false;
                }
            }
            else
            {
                try
                {
                    if (CurrentUser.RoleLevel > 65)
                    {
                        if (!string.IsNullOrEmpty(ckDept.ToString()))
                        {
                            ddl.SelectedValue = ckDept.ToString();
                        }
                        else
                        {
                            ddl.SelectedIndex = 0;
                        }
                        ddl.Enabled = true;
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(ckDept.ToString()))
                        {
                            ddl.SelectedValue = ckDept.ToString();
                        }
                        else
                        {
                            ddl.SelectedValue = CurrentUser.DeptID;
                        }
                        ddl.Enabled = false;
                    }
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }

            if (cbl != null)
            {
                cbl.DataSource = dv;
                cbl.DataTextField = "DeptName";
                cbl.DataValueField = "DeptCode";
                cbl.DataBind();
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlDepartmentJoin(int mode, DropDownList ddl, string MainSubDeptCode, string DeptCodeNotSelect)
    {
        string strSql = @" Select D.DeptCode, D.DeptName 
        From Department D Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
        Where D.DelFlag = 0 And MD.DelFlag = 0 And MSD.DelFlag = 0 
        And MD.MainDeptCode = '{0}' ";
        if (!string.IsNullOrEmpty(MainSubDeptCode))
        {
            strSql += " And MSD.MainSubDeptCode = '" + MainSubDeptCode + "' ";
        }

        if (!string.IsNullOrEmpty(DeptCodeNotSelect))
        {
            strSql += " And D.DeptCode Not IN ('" + DeptCodeNotSelect + "') ";
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By MD.Sort, MSD.Sort, D.Sort ", CurrentUser.MainDeptID));
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "DeptName";
            ddl.DataValueField = "DeptCode";
            ddl.DataBind();
            ddl.Enabled = true;
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
        }
        else
        {
            ddl.Items.Clear();
            if (mode == 0)
            {
                ddl.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddl.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void getddlEmpByDept(int mode, DropDownList ddlEmp, string DeptCode, object ckEmp)
    {
        string strSql = " Select a.EmpID, a.EmpName From Employee a, EmpDept b Where a.EmpID = b.EmpID And a.DelFlag = 0 And a.HideFlag = 0 ";
        //if (DeptCode != "")
        //{
            strSql = strSql + " And b.DeptCode = '" + DeptCode + "' ";
        //}
        if (CurrentUser.RoleLevel == 1)
        {
            strSql = strSql + " And a.EmpID = '" + CurrentUser.ID + "' ";
        }
        DataView dv = Conn.Select(strSql + " Group By a.EmpID, a.EmpName Order By a.EmpName");
        if (dv.Count != 0)
        {
            ddlEmp.DataSource = dv;
            ddlEmp.DataTextField = "EmpName";
            ddlEmp.DataValueField = "EmpID";
            ddlEmp.DataBind();
            ddlEmp.Enabled = true;
            if (CurrentUser.RoleLevel == 1)
            {
                ddlEmp.Enabled = false;
                ddlEmp.SelectedValue = CurrentUser.ID;
            }
            if (mode == 0)
            {
                ddlEmp.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddlEmp.Items.Insert(0, new ListItem("-เลือก-", ""));
            }

            if (ckEmp == null)
            {
                if (CurrentUser.RoleLevel != 1)
                {
                    ddlEmp.SelectedIndex = 0;
                    ddlEmp.Enabled = true;
                }
                else
                {
                    ddlEmp.SelectedValue = CurrentUser.ID;
                    ddlEmp.Enabled = false;
                }
            }
            else
            {
                try
                {
                    if (CurrentUser.RoleLevel != 1)
                    {
                        if (!string.IsNullOrEmpty(ckEmp.ToString()))
                        {
                            ddlEmp.SelectedValue = ckEmp.ToString();
                        }
                        else
                        {
                            ddlEmp.SelectedIndex = 0;
                        }
                        ddlEmp.Enabled = true;
                    }
                    else
                    {
                        //if (!string.IsNullOrEmpty(ckEmp.ToString()))
                        //{
                        //    ddlEmp.SelectedValue = ckEmp.ToString();
                        //}
                        //else
                        //{
                            ddlEmp.SelectedValue = CurrentUser.ID;
                        //}
                        ddlEmp.Enabled = false;
                    }
                }
                catch (Exception ex)
                {
                    ddlEmp.SelectedIndex = 0;
                }
            }
        }
        else
        {
            if (mode == 0)
            {
                ddlEmp.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
            }
            else
            {
                ddlEmp.Items.Insert(0, new ListItem("-เลือก-", ""));
            }
            ddlEmp.SelectedIndex = 0;
            ddlEmp.Enabled = false;
        }
    }

    public void getddlDepartment(DropDownList ddl)
    {
        BTC btc = new BTC();
        
        string strSql = "";
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) < 3)
        {
            strSql = "SELECT DeptCode, DeptName FROM Department Where DelFlag = 0 Order By Sort";
        }
        else
        {
            strSql = "SELECT a.DeptCode, a.DeptName FROM Department a, EmpDept b "
                    + " Where a.DeptCode = b.DeptCode And a.DelFlag = 0 And b.EmpID = '" + CurrentUser.ID + "' Order By Sort";
        }
       
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "DeptName";
            ddl.DataValueField = "DeptCode";
            ddl.DataBind();
            ddl.Enabled = true;
        }
        else
        {
            ddl.SelectedIndex = 0;
            ddl.Enabled = false;
        }
    }
    public void SetLableColor(Label lbl)
    {
        decimal ckNumber = 0;
        if (!string.IsNullOrEmpty(lbl.Text))
        {
            ckNumber = Convert.ToDecimal(lbl.Text);
        }
        if (ckNumber > 0)
        {
            lbl.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            if (ckNumber == 0)
            {
                lbl.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lbl.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    public Int32 getProjectsApproveDetail(string ProjectsCode, string MainSubDeptCode, string ApproveUser, bool IsApprove, string Comment, string EmpApproveID)
    {
        StringBuilder strbSql = new StringBuilder();
        StringBuilder strbSql2 = new StringBuilder();
        Int32 result = 0;
        if (IsApprove)
        {
            strbSql2.AppendFormat("Update Projects Set IsWait = NULL, ckSend = 1 Where ProjectsCode = '{0}';", ProjectsCode);

            strbSql2.AppendFormat("Update ProjectsApproveDetail Set IsApprove = '{2}', CreateDate = '{3}', Comment = N'{4}' Where ProjectsCode = '{0}' And EmpID = '{1}' And StepNo = (Select Max(StepNo) From ProjectsApproveDetail Where ProjectsCode = '{0}') ;",
               ProjectsCode, ApproveUser, IsApprove, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), Comment);

           //Conn.Update("Projects", "Where ProjectsCode = '" + ProjectsCode + "'", "IsWait", DBNull.Value);
           //result = Conn.Update("ProjectsApproveDetail", "Where ProjectsCode = '" + ProjectsCode + "' And EmpID = '" + ApproveUser + "' And StepNo = (Select Max(StepNo) From ProjectsApproveDetail Where ProjectsCode = '" + ProjectsCode + "')", "IsApprove, CreateDate, Comment", IsApprove, DateTime.Now.ToString("s"), Comment);

            Conn.Execute(strbSql2.ToString());

            string strSql = @" Select MSD.MainSubDeptCode, MSD.MainSubDeptName, AFD.ApproveFlowDetailID,
        AFD.UserRoleID, UR.UserRoleName, AFD.ApprovePositionID, AP.ApprovePositionName, AFD.ApproveStepID, APS.ApproveStepName,
        AFD.BudgetLimit, AFD.ckStatus, AFD.Sort As StepNo, E.EmpID, E.EmpName, UR.RoleLevel, ED.DeptCode
        From ApproveFlow AF Inner Join ApproveFlowDetail AFD On AF.MainSubDeptCode = AFD.ApproveFlowID
        Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
        Inner Join ApproveStep APS On AFD.ApproveStepID = APS.ApproveStepID
        Inner Join UserRole UR On AFD.UserRoleID = UR.UserRoleID 
        Inner Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
		Inner Join Employee E On E.UserRoleID = UR.UserRoleID
		Inner Join EmpDept ED On E.EmpID = ED.EmpID
        Where AF.MainSubDeptCode = '{1}' 
		And AFD.Sort = (Select IsNull(Max(StepNo) + 1, 0) StepNo From ProjectsApproveDetail Where ProjectsCode = '{0}')
		And E.HideFlag = 0
        Order By AFD.Sort ";
            DataView dv = Conn.Select(string.Format(strSql, ProjectsCode, MainSubDeptCode));
            Int32 stepNo = 1;
            if (dv.Count > 0)
            {
                string strApproveUser = dv[0]["EmpID"].ToString();
                string strApproveFlowDetailID = dv[0]["ApproveFlowDetailID"].ToString();
                stepNo = Convert.ToInt32(dv[0]["StepNo"]);
                if (Convert.ToInt32(dv[0]["RoleLevel"]) < 70)
                {
                    if (dv[0]["ApprovePositionID"].ToString() == "3") //เช็คผู้บริหารที่เกี่ยวข้อง
                    {
                        strApproveUser = getHeadCenterNameDeptJoin(ProjectsCode);
                        if (string.IsNullOrEmpty(strApproveUser))
                        {
                            strSql = @" Select MSD.MainSubDeptCode, MSD.MainSubDeptName, AFD.ApproveFlowDetailID,
                                    AFD.UserRoleID, UR.UserRoleName, AFD.ApprovePositionID, AP.ApprovePositionName, AFD.ApproveStepID, APS.ApproveStepName,
                                    AFD.BudgetLimit, AFD.ckStatus, AFD.Sort As StepNo, E.EmpID, E.EmpName, UR.RoleLevel, ED.DeptCode
                                    From ApproveFlow AF Inner Join ApproveFlowDetail AFD On AF.MainSubDeptCode = AFD.ApproveFlowID
                                    Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
                                    Inner Join ApproveStep APS On AFD.ApproveStepID = APS.ApproveStepID
                                    Inner Join UserRole UR On AFD.UserRoleID = UR.UserRoleID 
                                    Inner Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
		                            Inner Join Employee E On E.UserRoleID = UR.UserRoleID
		                            Inner Join EmpDept ED On E.EmpID = ED.EmpID
                                    Where AF.MainSubDeptCode = '{1}' 
		                            And AFD.Sort = (Select IsNull(Max(StepNo) + 2, 0) StepNo From ProjectsApproveDetail Where ProjectsCode = '{0}')
		                            And E.HideFlag = 0
                                    Order By AFD.Sort ";
                            DataView dv1 = Conn.Select(string.Format(strSql, ProjectsCode, MainSubDeptCode));
                            if (dv1.Count > 0)
                            {
                                //DataRow[] drUser = dv1.Table.Select("DeptCode = '" + CurrentUser.DeptID + "' ");
                                //if (drUser.Length > 0)
                                //{
                                    strApproveUser = dv1[0]["EmpID"].ToString();
                                    strApproveFlowDetailID = dv1[0]["ApproveFlowDetailID"].ToString();
                                    stepNo = Convert.ToInt32(dv1[0]["StepNo"]);
                                //}
                            }
                        }
                    }
                    else
                    {
                        DataRow[] drUser = dv.Table.Select("DeptCode = '" + CurrentUser.DeptID + "' ");
                        if (drUser.Length > 0)
                        {
                            strApproveUser = drUser[0]["EmpID"].ToString();
                            strApproveFlowDetailID = drUser[0]["ApproveFlowDetailID"].ToString();
                            stepNo = Convert.ToInt32(drUser[0]["StepNo"]);
                        }
                    }

                    if (!string.IsNullOrEmpty(EmpApproveID))
                    {
                        strApproveUser = EmpApproveID;
                    }

                    strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID)VALUES('{0}', '{1}', '{2}', {3}, '{4}');",
                    Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);

                //    Conn.AddNew("ProjectsApproveDetail", "ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID",
                //Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);
                }
                else
                {
                    strApproveUser = dv[0]["EmpID"].ToString();
                    strApproveFlowDetailID = dv[0]["ApproveFlowDetailID"].ToString();
                    stepNo = Convert.ToInt32(dv[0]["StepNo"]);

                    if (dv[0]["ckStatus"].ToString() == "E")
                    {
                        if (Convert.ToDecimal(dv[0]["BudgetLimit"]) != 0)
                        {
                            if (getTotalBudgetOfProject(ProjectsCode) <= Convert.ToDecimal(dv[0]["BudgetLimit"]))
                            {
                                strbSql.AppendFormat("Update Projects Set IsApprove = '{1}', IsWait = NULL, UserApprove = '{2}', DateApprove = '{3}', Comment = N'{4}' Where ProjectsCode = '{0}';",
                                ProjectsCode, IsApprove, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), Comment);

                                strbSql.AppendFormat("Update Activity Set ApproveFlag = 1, ApproveUser = '{1}' Where ProjectsCode = '{0}';",
                                ProjectsCode, CurrentUser.ID);

                                //Conn.Update("Projects", "Where ProjectsCode = '" + ProjectsCode + "' ", "IsApprove, IsWait, UserApprove, DateApprove, Comment",
                                //IsApprove, DBNull.Value, CurrentUser.ID, DateTime.Now.ToString("s"), Comment);
                                //Conn.Update("Activity", "Where ProjectsCode = '" + ProjectsCode + "' ", "ApproveFlag, ApproveUser", 1, CurrentUser.ID);
                            }
                            else
                            {
                                strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID)VALUES('{0}', '{1}', '{2}', {3}, '{4}');",
                                Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);

                                //Conn.AddNew("ProjectsApproveDetail", "ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID",
                                //Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);
                            }
                        }
                        else
                        {
                            strbSql.AppendFormat("Update Projects Set IsApprove = '{1}', IsWait = NULL, UserApprove = '{2}', DateApprove = '{3}', Comment = N'{4}' Where ProjectsCode = '{0}';",
                                ProjectsCode, IsApprove, CurrentUser.ID, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), Comment);

                            strbSql.AppendFormat("Update Activity Set ApproveFlag = 1, ApproveUser = '{1}' Where ProjectsCode = '{0}';",
                            ProjectsCode, CurrentUser.ID);

                            //Conn.Update("Projects", "Where ProjectsCode = '" + ProjectsCode + "' ", "IsApprove, IsWait, UserApprove, DateApprove, Comment", 
                            //    IsApprove, DBNull.Value, CurrentUser.ID, DateTime.Now.ToString("s"), Comment);
                            //Conn.Update("Activity", "Where ProjectsCode = '" + ProjectsCode + "' ", "ApproveFlag, ApproveUser", 1, CurrentUser.ID);
                        }
                    }
                    else
                    {
                        strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID)VALUES('{0}', '{1}', '{2}', {3}, '{4}');",
                        Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);

                        //Conn.AddNew("ProjectsApproveDetail", "ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID",
                        //        Guid.NewGuid().ToString(), ProjectsCode, strApproveUser, stepNo, strApproveFlowDetailID);
                    }
                }
            }
            else
            { //step 0 ผู้สร้างโครงการกด
                strSql = @"Select MSD.MainSubDeptCode, MSD.MainSubDeptName, AFD.ApproveFlowDetailID,
        AFD.UserRoleID, UR.UserRoleName, AFD.ApprovePositionID, AP.ApprovePositionName, AFD.ApproveStepID, APS.ApproveStepName,
        AFD.BudgetLimit, AFD.ckStatus, AFD.Sort As StepNo, E.EmpID, E.EmpName
        From ApproveFlow AF Inner Join ApproveFlowDetail AFD On AF.MainSubDeptCode = AFD.ApproveFlowID
        Inner Join MainSubDepartment MSD On AF.MainSubDeptCode = MSD.MainSubDeptCode
        Inner Join ApproveStep APS On AFD.ApproveStepID = APS.ApproveStepID
        Inner Join UserRole UR On AFD.UserRoleID = UR.UserRoleID 
        Inner Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
		Inner Join Employee E On E.UserRoleID = UR.UserRoleID
		Inner Join EmpDept ED On E.EmpID = ED.EmpID
        Where AF.MainSubDeptCode = '{0}' And ED.DeptCode = '{1}' And AFD.ckStatus = 'S' And E.HideFlag = 0
        Order By AFD.Sort";
                DataView dv1 = Conn.Select(string.Format(strSql, MainSubDeptCode, CurrentUser.DeptID));
                string empApproveId = dv1[0]["EmpID"].ToString();
                if (!string.IsNullOrEmpty(EmpApproveID))
                {
                    empApproveId = EmpApproveID;
                }

                strbSql.AppendFormat("INSERT INTO ProjectsApproveDetail (ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID)VALUES('{0}', '{1}', '{2}', {3}, '{4}');",
                        Guid.NewGuid().ToString(), ProjectsCode, empApproveId, stepNo, dv1[0]["ApproveFlowDetailID"].ToString());

                //Conn.AddNew("ProjectsApproveDetail", "ItemID, ProjectsCode, EmpID, StepNo, ApproveFlowDetailID", 
                //    Guid.NewGuid().ToString(), ProjectsCode, dv1[0]["EmpID"].ToString(), stepNo, dv1[0]["ApproveFlowDetailID"].ToString());
            }
        }
        else
        {
            strbSql.AppendFormat("Update ProjectsApproveDetail Set IsApprove = '{2}', CreateDate = '{3}', Comment = N'{4}' Where ProjectsCode = '{0}' And EmpID = '{1}' And StepNo = (Select Max(StepNo) From ProjectsApproveDetail Where ProjectsCode = '{0}') ;",
            ProjectsCode, ApproveUser, IsApprove, DateTime.Now.ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " " + DateTime.Now.ToString("HH:mm:ss"), Comment);

            //result = Conn.Update("ProjectsApproveDetail", "Where ProjectsCode = '" + ProjectsCode + "' And EmpID = '" + ApproveUser + "' And StepNo = (Select Max(StepNo) From ProjectsApproveDetail Where ProjectsCode = '" + ProjectsCode + "')", "IsApprove, CreateDate, Comment", 
            //    IsApprove, DateTime.Now.ToString("s"), Comment);
        }
        result = Conn.Execute(strbSql.ToString());
        return result;
    }
    public string getHeadCenterNameDeptJoin(string ProjectsCode)
    {
        string EmpID = "";
        string strSql = @"Select E.EmpID, E.EmpName, UR.UserRoleName, UR.RoleLevel, D.DeptName  
		From Projects P Inner Join Department D On P.DeptJoinCode = D.DeptCode 
		Inner Join EmpDept ED On D.DeptCode = ED.DeptCode
		Inner Join Employee E On E.EmpID = ED.EmpID
		Inner Join UserRole UR On E.UserRoleID = UR.UserRoleID And UR.RoleLevel = 65
		Where ProjectsCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));
        if (dv.Count > 0)
        {
            EmpID = dv[0]["EmpID"].ToString();
        }
        return EmpID;
    }
    public decimal getTotalBudgetOfProject(string ProjectsCode)
    {
        decimal TotalAmount = 0;
        string strSql = @"Select P.ProjectsCode, P.ProjectsName, IsNull(Sum(CD.TotalMoney),0) TotalMoney
		From Projects P Left Join Activity A On P.ProjectsCode = A.ProjectsCode
		Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode 
		Where P.ProjectsCode = '{0}'
		Group By P.ProjectsCode, P.ProjectsName ";
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));
        if (dv.Count > 0)
        {
            TotalAmount = Convert.ToDecimal(dv[0]["TotalMoney"]);
        }
        return TotalAmount;
    }
    public void getDefault(DropDownList ddl, string TableName, string FieldName)
    {
        
        DataView dv = Conn.Select("Select " + FieldName + " From " + TableName + " Where DelFlag = 0 And Df = 1");
        if (dv.Count != 0)
        {
            ddl.SelectedValue = dv[0][FieldName].ToString();
        }
    }
    public string getdvDefault(string TableName, string FieldName)
    {
        
        DataView dv = Conn.Select("Select " + FieldName + " From " + TableName + " Where DelFlag = 0 And Df = 1");
        if (dv.Count != 0)
        {
            return dv[0][FieldName].ToString();
        }
        else
        {
            return "";
        }
    }
    public void getddlYear(DropDownList ddl, int year)
    {
        for (int i = 0; i < year; i++)
        {
            ddl.Items.Insert(i, new ListItem(((DateTime.Now.Year + 543) - 2 + i).ToString(), ((DateTime.Now.Year + 543) - 2 + i).ToString()));
        }
        ddl.SelectedValue = (DateTime.Now.Year + 543).ToString();
    }
    public void UpdateDefault(string TableName)
    {
        
        Int32 i = Conn.Update(TableName, "Where Df = 1", "Df", 0);
    }
    public void ChangeDefault(string TableName, string FieldNameCode, string id)
    {
        
        Conn.Update(TableName, "Where Df = 1", "Df", 0);
        int result = Conn.Update(TableName, "WHERE " + FieldNameCode + " = '" + id + "' And DelFlag = 0 ", "Df", 1);
    }
    public Boolean CkDataDuplicate(string StudyYear, string TableName)
    {
        
        DataView dv = Conn.Select("Select * From " + TableName + " Where DelFlag = 0 And StudyYear = '" + StudyYear + "'");
        if (dv.Count != 0)
        {
            return true;
        }
        return false;
    }
    public Boolean CkUseData(string id, string FieldName, string TableName, string criteria)
    {
        
        string strSql = "Select " + FieldName + " From " + TableName + " Where " + FieldName + " = '" + id + "' " + criteria;
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            return true;
        }
        return false;
    }
    public Int32 ckChartStudy(DateTime d, Int32 y)
    {
        if ((d.Year + 543) == y)
        {
            switch (d.Month)
            {
                case 4:
                    if (d.Day < 8)
                    {
                        return 1;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 2;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 3;
                            }
                            else
                            {
                                return 4;
                            }
                        }
                    }
                    break;
                case 5:
                    if (d.Day < 8)
                    {
                        return 5;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 6;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 7;
                            }
                            else
                            {
                                return 8;
                            }
                        }
                    }
                    break;
                case 6:
                    if (d.Day < 8)
                    {
                        return 9;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 10;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 11;
                            }
                            else
                            {
                                return 12;
                            }
                        }
                    }
                    break;
                case 7:
                    if (d.Day < 8)
                    {
                        return 13;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 14;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 15;
                            }
                            else
                            {
                                return 16;
                            }
                        }
                    }
                    break;
                case 8:
                    if (d.Day < 8)
                    {
                        return 17;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 18;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 19;
                            }
                            else
                            {
                                return 20;
                            }
                        }
                    }
                    break;
                case 9:
                    if (d.Day < 8)
                    {
                        return 21;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 22;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 23;
                            }
                            else
                            {
                                return 24;
                            }
                        }
                    }
                    break;
                case 10:
                    if (d.Day < 8)
                    {
                        return 25;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 26;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 27;
                            }
                            else
                            {
                                return 28;
                            }
                        }
                    }
                    break;
                case 11:
                    if (d.Day < 8)
                    {
                        return 29;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 30;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 31;
                            }
                            else
                            {
                                return 32;
                            }
                        }
                    }
                    break;
                case 12:
                    if (d.Day < 8)
                    {
                        return 33;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 34;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 35;
                            }
                            else
                            {
                                return 36;
                            }
                        }
                    }
                    break;
                default:
                    return 0;
                    break;
            }
        }
        else
        {
            if ((d.Year + 543) == (y + 1))
            {
                switch (d.Month)
                {
                    case 1:
                        if (d.Day < 8)
                        {
                            return 37;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 38;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 39;
                                }
                                else
                                {
                                    return 40;
                                }
                            }
                        }
                        break;
                    case 2:
                        if (d.Day < 8)
                        {
                            return 41;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 42;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 43;
                                }
                                else
                                {
                                    return 44;
                                }
                            }
                        }
                        break;
                    case 3:
                        if (d.Day < 8)
                        {
                            return 45;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 46;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 47;
                                }
                                else
                                {
                                    return 48;
                                }
                            }
                        }
                        break;
                    default:
                        return 0;
                        break;
                }
            }
            else
            {
                return 0;
            }
        }
    }
    public Int32 ckChartBudget(DateTime d, Int32 y)
    {
        if ((d.Year + 543) == y - 1)
        {
            switch (d.Month)
            {
                case 10:
                    if (d.Day < 8)
                    {
                        return 1;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 2;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 3;
                            }
                            else
                            {
                                return 4;
                            }
                        }
                    }
                    break;
                case 11:
                    if (d.Day < 8)
                    {
                        return 5;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 6;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 7;
                            }
                            else
                            {
                                return 8;
                            }
                        }
                    }
                    break;
                case 12:
                    if (d.Day < 8)
                    {
                        return 9;
                    }
                    else
                    {
                        if (d.Day < 15)
                        {
                            return 10;
                        }
                        else
                        {
                            if (d.Day < 22)
                            {
                                return 11;
                            }
                            else
                            {
                                return 12;
                            }
                        }
                    }
                    break;
                default:
                    return 0;
                    break;
            }
        }
        else
        {
            if ((d.Year + 543) == (y))
            {
                switch (d.Month)
                {
                    case 1:
                        if (d.Day < 8)
                        {
                            return 13;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 14;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 15;
                                }
                                else
                                {
                                    return 16;
                                }
                            }
                        }
                        break;
                    case 2:
                        if (d.Day < 8)
                        {
                            return 17;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 18;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 19;
                                }
                                else
                                {
                                    return 20;
                                }
                            }
                        }
                        break;
                    case 3:
                        if (d.Day < 8)
                        {
                            return 21;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 22;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 23;
                                }
                                else
                                {
                                    return 24;
                                }
                            }
                        }
                        break;
                    case 4:
                        if (d.Day < 8)
                        {
                            return 25;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 26;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 27;
                                }
                                else
                                {
                                    return 28;
                                }
                            }
                        }
                        break;
                    case 5:
                        if (d.Day < 8)
                        {
                            return 29;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 30;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 31;
                                }
                                else
                                {
                                    return 32;
                                }
                            }
                        }
                        break;
                    case 6:
                        if (d.Day < 8)
                        {
                            return 33;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 34;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 35;
                                }
                                else
                                {
                                    return 36;
                                }
                            }
                        }
                        break;
                    case 7:
                        if (d.Day < 8)
                        {
                            return 37;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 38;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 39;
                                }
                                else
                                {
                                    return 40;
                                }
                            }
                        }
                        break;
                    case 8:
                        if (d.Day < 8)
                        {
                            return 41;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 42;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 43;
                                }
                                else
                                {
                                    return 44;
                                }
                            }
                        }
                        break;
                    case 9:
                        if (d.Day < 8)
                        {
                            return 45;
                        }
                        else
                        {
                            if (d.Day < 15)
                            {
                                return 46;
                            }
                            else
                            {
                                if (d.Day < 22)
                                {
                                    return 47;
                                }
                                else
                                {
                                    return 48;
                                }
                            }
                        }
                        break;
                    default:
                        return 0;
                        break;
                }
            }
            else
            {
                return 0;
            }
        }
    }
    public System.Drawing.Color getColorRowsGrid(string status)
    {
        switch (status)
        {
            case "1":
                return System.Drawing.Color.DarkCyan;
                break;
            case "2":
                return System.Drawing.Color.Red;
                break;
            case "3":
                return System.Drawing.Color.Green;
                break;
            case "4":
                return System.Drawing.Color.FromArgb(197, 150, 10);
                break;
            default:
                return System.Drawing.Color.Black;
                break;
        }
    }
    public void lblColor(Label lbl, decimal budget)
    {
        if (budget == 0)
        {
            lbl.ForeColor = System.Drawing.Color.Black;
        }
        else
        {
            if (budget > 0)
            {
                lbl.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lbl.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    public void UpdateStatusActivity()
    {
        string strSql = "";
        DataView ckdv = Conn.Select(string.Format("Select IsNull(ckSale, 0) ck_Sale From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'"));
        if (ckdv.Count != 0)
        { 
            if(Convert.ToBoolean(ckdv[0]["ck_Sale"]))
            {
                return;
            }
        }

        //update กิจกรรมที่รอดำเนินการ
        strSql = " Select ActivityCode From Activity Where SDate > cast(convert(varchar(10), getDate(),120) as datetime) And Status <> 3 ";
        DataView dv0 = Conn.Select(string.Format(strSql));
        if (dv0.Count != 0)
        {
            for (int i = 0; i < dv0.Count; i++)
            {
                Conn.Update("Activity", "Where ActivityCode = '" + dv0[i]["ActivityCode"] + "'", "Status", 0);
            }
        }

        //update กิจกรรมที่อยู่ระหว่างดำเนินการ
        strSql = " Select ActivityCode From Activity "
                + " Where cast(convert(varchar(10), getDate(),120) as datetime) Between SDate And EDate "
                + " And Status <> 3 ";
        DataView dv1 = Conn.Select(string.Format(strSql));
        if (dv1.Count != 0)
        {
            for (int i = 0; i < dv1.Count; i++)
            {
                Conn.Update("Activity", "Where ActivityCode = '" + dv1[i]["ActivityCode"] + "'", "Status", 1);
            }
        }

        //update กิจกรรมที่ใกล้เลยกำหนดการ
        strSql = " Select ActivityCode From Activity Where EDate - IsNull(AlertDay,0) <= cast(convert(varchar(10), getDate(),120) as datetime) And Status Not In (2,3) ";
        DataView dv2 = Conn.Select(string.Format(strSql));
        if (dv2.Count != 0)
        {
            for (int i = 0; i < dv2.Count; i++)
            {
                Conn.Update("Activity", "Where ActivityCode = '" + dv2[i]["ActivityCode"] + "'", "Status", 4);
            }
        }

        //update กิจกรรมเลยกำหนดการ
        strSql = " Select ActivityCode From Activity Where EDate < cast(convert(varchar(10), getDate(),120) as datetime) And Status <> 3 ";
        DataView dv = Conn.Select(string.Format(strSql));
        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                Conn.Update("Activity", "Where ActivityCode = '" + dv[i]["ActivityCode"] + "'", "Status", 2);
            }
        }
    }
    public Boolean CkStatusActivitySuccess(string ActivityCode)
    {      
        DataView dv = Conn.Select("Select Status, IsNull(ApproveFlag,0) ApproveFlag From Activity Where DelFlag = 0 And ActivityCode = '" + ActivityCode + "' ");
        if (dv.Count != 0)
        {
            if ((Convert.ToInt32(dv[0]["Status"]) == 3) || (Convert.ToInt32(dv[0]["ApproveFlag"]) == 0))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    public Boolean CkActivityApprove(string ActivityCode)
    {
        DataView ckApproveBudget = Conn.Select("Select IsNull(ApproveFlag, 0) ApproveFlag From Activity Where ActivityCode = '" + ActivityCode + "'");
        return Convert.ToBoolean(ckApproveBudget[0]["ApproveFlag"]);
    }
    public string getEmpDeptName(string EmpID)
    {
        
        string DeptName = "";
        string strSql = "Select a.*, b.DeptName From EmpDept a, Department b Where b.DelFlag = 0 And a.DeptCode = b.DeptCode And a.EmpID = '{0}'";
        DataView dvDept = Conn.Select(string.Format(strSql, EmpID));
        if (dvDept.Count != 0)
        {
            for (int i = 0; i < dvDept.Count; i++)
            {
                DeptName += dvDept[i]["DeptName"].ToString();
                if (i != dvDept.Count - 1)
                {
                    DeptName += ", ";
                }
            }
            return DeptName;
        }
        else
        {
            return "";
        }
    }
    public string getAcDeptName(string ActivityCode)
    {
        
        string DeptName = "";
        string strSql = "Select a.*, b.DeptName From dtAcDept a, Department b Where b.DelFlag = 0 And a.DeptCode = b.DeptCode And a.ActivityCode = '{0}'";
        DataView dvDept = Conn.Select(string.Format(strSql, ActivityCode));
        if (dvDept.Count != 0)
        {
            for (int i = 0; i < dvDept.Count; i++)
            {
                DeptName += dvDept[i]["DeptName"].ToString();
                if (i != dvDept.Count - 1)
                {
                    DeptName += ",";
                }
            }
            return DeptName;
        }
        else
        {
            return "";
        }
    }
    public string getAcEmpName(string ActivityCode)
    {
        
        string EmpName = "";
        string strSql = "Select a.*, b.EmpName From dtAcEmp a, Employee b Where b.DelFlag = 0 And a.EmpCode = b.EmpID And a.ActivityCode = '{0}'";
        DataView dvEmp = Conn.Select(string.Format(strSql, ActivityCode));
        if (dvEmp.Count != 0)
        {
            for (int i = 0; i < dvEmp.Count; i++)
            {
                EmpName += dvEmp[i]["EmpName"].ToString();
                if (i != dvEmp.Count - 1)
                {
                    EmpName += ",";
                }
            }
            return EmpName;
        }
        else
        {
            return "";
        }
    }
    public string getBudgetTypeName(string ActivityCode)
    {
        
        string BudgetTypeName = "";
        string strSql = "Select Distinct(b.BudgetTypeCode), b.BudgetTypeName From CostsDetail a, BudgetType b Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}'";
        DataView dvBudgetType = Conn.Select(string.Format(strSql, ActivityCode));
        if (dvBudgetType.Count != 0)
        {
            for (int i = 0; i < dvBudgetType.Count; i++)
            {
                BudgetTypeName += dvBudgetType[i]["BudgetTypeName"].ToString();
                if (i != dvBudgetType.Count - 1)
                {
                    BudgetTypeName += "/";
                }
            }
            return BudgetTypeName;
        }
        else
        {
            return "";
        }
    }
    public string getBudgetTypeNameAndBudget(string ActivityCode)
    {
        
        string BudgetTypeName = "";
        string strSql = "Select IsNull(Sum(a.TotalMoney2),0) TotalMoney2, b.BudgetTypeCode, b.BudgetTypeName From CostsDetail a, BudgetType b Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' Group By b.BudgetTypeCode, b.BudgetTypeName";
        DataView dvBudgetType = Conn.Select(string.Format(strSql, ActivityCode));
        if (dvBudgetType.Count != 0)
        {
            for (int i = 0; i < dvBudgetType.Count; i++)
            {
                BudgetTypeName += dvBudgetType[i]["BudgetTypeName"].ToString() + " (" + Convert.ToDecimal(dvBudgetType[i]["TotalMoney2"]).ToString("#,##0.00") + ")";
                if (i != dvBudgetType.Count - 1)
                {
                    BudgetTypeName += ", ";
                }
            }
            return BudgetTypeName;
        }
        else
        {
            return "";
        }
    }
    public Int32 getAcIndicators2(string ActivityCode)
    {
        
        string strSql = "Select Indicators2Code From Indicators2 Where DelFlag = 0 And ActivityCode = '{0}'";
        DataView dv = Conn.Select(string.Format(strSql, ActivityCode));
        if (dv.Count != 0)
        {        
            return dv.Count;
        }
        else
        {
            return 0;
        }
    }
    public Int32 getAcEvaluation(string ActivityCode)
    {
        
        string strSql = "Select EvaluationCode From Evaluation Where DelFlag = 0 And ActivityCode = '{0}'";
        DataView dv = Conn.Select(string.Format(strSql, ActivityCode));
        if (dv.Count != 0)
        {
            return dv.Count;
        }
        else
        {
            return 0;
        }
    }
    public decimal getNTotalAmount(string ActivityCode) //ยอดรวมงบย่อย
    {
        decimal NTotalAmount = 0;
        
        string strSql = " Select a.ActivityDetailCode, a.ActivityCode, IsNull(Sum(d.TotalMoney), 0) NAmount "
            + " From ActivityDetail a, Activity b, Projects c, ActivityCostsDetail d "
            + " Where a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And a.ActivityCode = '" + ActivityCode + "' "
            + " And a.ActivityCode = b.ActivityCode And b.ProjectsCode = c.ProjectsCode And a.ActivityDetailCode = d.ActivityDetailCode "
            + " Group By a.ActivityDetailCode, a.ActivityCode ";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                NTotalAmount += Convert.ToDecimal(dv[i]["NAMount"]);
            }
        }
        return NTotalAmount;
    }
    public Int32 getCountActivity(int mode, int i, string DeptCode, string EmpCode, string StudyYear, string StgCode, string ProjCode, string tMonth)
    {
        
        string strSql = " Select Count(a.ActivityCode) AcCount From Activity a "
            + " Where a.DelFlag = 0 ";

        if (!string.IsNullOrEmpty(DeptCode))
        {
            strSql = " Select Count(a.ActivityCode) AcCount From Activity a, dtAcDept b "
            + " Where a.DelFlag = 0 "
            + " And a.ActivityCode = b.ActivityCode And b.DeptCode = '" + DeptCode + "'";
        }

        if (!string.IsNullOrEmpty(EmpCode))
        {
            if (string.IsNullOrEmpty(DeptCode))
            {
                strSql = " Select Count(a.ActivityCode) AcCount From Activity a, dtAcEmp b "
                + " Where a.DelFlag = 0 "
                + " And a.ActivityCode = b.ActivityCode And b.EmpCode = '" + EmpCode + "'";
            }
            else
            {
                strSql = " Select Count(a.ActivityCode) AcCount From Activity a, dtAcEmp b, dtAcDept c "
                    + " Where a.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode"
                    + " And b.EmpCode = '" + EmpCode + "' And c.DeptCode = '" + DeptCode + "' ";
            }
        }

        if (mode == 1)
        {
            strSql = strSql + " And a.StudyYear = (Select StudyYear From StudyYear Where DelFlag = 0 And Df = 1) ";
        }
        else
        {
            strSql = strSql + " And a.StudyYear = '" + StudyYear + "' ";
        }

        if (!string.IsNullOrEmpty(StgCode))
        {
            strSql = strSql + " And a.StrategiesCode = '" + StgCode + "'";
        }
        if (!string.IsNullOrEmpty(ProjCode))
        {
            strSql = strSql + " And a.ProjectsCode = '" + ProjCode + "'";
        }
        if (tMonth != "0")
        {
            int CkYear = Convert.ToInt32(StudyYear) - 543;
            strSql = strSql + " And Month(a.SDate) = '" + tMonth + "' And Year(a.SDate) = " + CkYear + " ";
        }

        if (i != 5)
        {
            strSql = strSql + " And a.Status = '" + i + "' ";
        }

        DataView dv = Conn.Select(strSql);

        if (dv.Count != 0)
        {
            return Convert.ToInt32(dv[0]["AcCount"]);
        }
        else
        {
            return 0;
        }
    }
    public Boolean ckApproveFlow(string ProjectsCode)
    {
        string strSql = @"Select ItemID From ProjectsApproveDetail Where ProjectsCode = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, ProjectsCode));
        if (dv.Count > 1)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean CkActivityBudgetDetail(string ActivityCode)
    {     
        DataView dv = Conn.Select("Select ActivityCode From ActivityCostsDetail Where ActivityCode = '" + ActivityCode + "' ");
        DataView dv1 = Conn.Select("Select ActivityCode From Activity Where DelFlag = 0 And ActivityCode = '" + ActivityCode + "' And Status = 3");
        if ((dv.Count != 0) || (dv1.Count != 0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Boolean CkActivitySuccess(string ActivityCode)
    {
        DataView dv = Conn.Select("Select ActivityCode From Activity Where DelFlag = 0 And ActivityCode = '" + ActivityCode + "' And Status = 3");
        if (dv.Count != 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public void LinkReport(Literal ltr)
    {
        string link = " <a href=\"javascript:;\" " + getLinkReportWEP("W") + "  onclick=\"printRpt(0,'w');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"50px;\" height=\"50px;\" title=\"เรียกดูรายงาน แบบเอกสาร Word\" src=\"../Image/icon/WordIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" " + getLinkReportWEP("E") + " onclick=\"printRpt(0,'e');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร Excel\" src=\"../Image/icon/ExcelIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" " + getLinkReportWEP("P") + " onclick=\"printRpt(0,'p');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร PDF\" src=\"../Image/icon/PdfIcon.png\" /></a> ";
        ltr.Text = link;
    }

    public string getLinkReportWEP(string ckMode)
    { 
        string link = "style=\"display:none;\"";
        string strSql = " Select ckWord, ckExcel, ckPDF From MR_School Where SchoolID = '" + CurrentUser.SchoolID + "'";
        DataView dv = Conn.Select(strSql);
        if (dv.Count != 0)
        {
            if (ckMode == "W")
            {
                if (Convert.ToBoolean(dv[0]["ckWord"]))
                {
                    link = "";
                }
            }
            if (ckMode == "E")
            {
                if (Convert.ToBoolean(dv[0]["ckExcel"]))
                {
                    link = "";
                }
            }
            if (ckMode == "P")
            {
                if (Convert.ToBoolean(dv[0]["ckPDF"]))
                {
                    link = "";
                }
            }
        }

        return link;
    }
    public Boolean ckUserPassword(string EmpID, string pwd)
    {
        string strSql = "Select EmpID From Employee Where EmpID = '{0}' And Pwd = '{1}' ";
        DataView dv = Conn.Select(string.Format(strSql, EmpID, Star.Security.Cryptography.Text.Encrypt(pwd)));
        if (dv.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public DataTable GetEmployeeSingnature(string ProjectsCode)
    {
        string StrSql = @" Select PAD.*, AFD.ApproveFlowID, AFD.UserRoleID, IsNull(AFD.ApprovePositionID, 0) ApprovePositionID, IsNull(AP.ApprovePositionName, N'ผู้ใช้ตามหน่วยงาน') ApprovePositionName,
            AFD.ApproveStepID, IsNull(AST.ApproveStepName, N'ผู้รับผิดชอบโครงการ/กิจกรรม') ApproveStepName, E.EmpName, E.ImgPath
            From ProjectsApproveDetail PAD Left Join ApproveFlowDetail AFD On PAD.ApproveFlowDetailID = AFD.ApproveFlowDetailID
            Left Join ApproveStep AST On AFD.ApproveStepID = AST.ApproveStepID
            Left Join ApprovePosition AP On AFD.ApprovePositionID = AP.ApprovePositionID
            Left Join Employee E On PAD.EmpID = E.EmpID
            Where PAD.ProjectsCode = '{0}' And PAD.IsApprove = 1 And AST.Sort <> 1 And PAD.StepNo Not In (1)
            Order By PAD.StepNo ";
        DataView dv = Conn.Select(string.Format(StrSql, ProjectsCode));

        DataTable dt = new DataTable("Singnature");
        dt.Columns.Add("ApproveFlowID");
        dt.Columns.Add("ApprovePositionID");
        dt.Columns.Add("ApprovePositionName");
        dt.Columns.Add("ApproveStepID");
        dt.Columns.Add("ApproveStepName");
        dt.Columns.Add("EmpName");
        dt.Columns.Add("Singnature", typeof(System.Byte[]));

        for (int i = 0; i < dv.Count; i++)
        {
            DataRow dr;
            dr = dt.NewRow();
            dr["ApproveFlowID"] = dv[i]["ApproveFlowID"].ToString();
            dr["ApprovePositionID"] = dv[i]["ApprovePositionID"].ToString();
            dr["ApprovePositionName"] = dv[i]["ApprovePositionName"].ToString();
            dr["ApproveStepID"] = dv[i]["ApproveStepID"].ToString();
            dr["ApproveStepName"] = dv[i]["ApproveStepName"].ToString();
            dr["EmpName"] = dv[i]["EmpName"].ToString();

            string imgPath = "";
            if (!string.IsNullOrEmpty(dv[i]["ImgPath"].ToString()))
            {
                imgPath = dv[i]["ImgPath"].ToString();
                
            }
            dr["Singnature"] = GetImageFromURL(HttpContext.Current.Server.MapPath("~") + imgPath.Replace("..", ""));
            string path = imgPath;
            dt.Rows.Add(dr);
        }
        return dt;
    }
    public DataTable GetLogoImg()
    {
        string LogoPath = "";
        
        DataView dv = Conn.Select("Select LogoPath From MR_School Where DelFlag = 0 And SchoolID = '" + CurrentUser.SchoolID + "'");
        if (dv.Count != 0)
        {
            LogoPath = dv[0]["LogoPath"].ToString();
        }
        //DataSet ds = new DataSet();
        DataTable dt = new DataTable("Logo");
        DataColumn dc1 = new DataColumn("Picture", typeof(System.Byte[]));
        dt.Columns.Add(dc1);
        DataRow dr;
        dr = dt.NewRow();
        dr["Picture"] = GetImageFromURL(HttpContext.Current.Server.MapPath("~") + LogoPath.Replace("..", ""));
        
        // in my case i put the image called rptHeader.jpg in the root folder
        dt.Rows.Add(dr);
        //ds.Tables.Add(dt);
        //ds.Tables[2].TableName = "Logo";
        return dt ;
    }
    byte[] GetImageFromURL(string fileName)
    {
        try
        {
            //Method to load an image from disk and return it as a bytestream
            System.IO.FileStream fs = new System.IO.FileStream(fileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
            return (br.ReadBytes(Convert.ToInt32(br.BaseStream.Length)));
        }
        catch(Exception ex)
        {
            return null;
        }
    }
    public void SendMail(string id, string mode)
    {
        string strSubject = "", strTo = "", strBody = "";
        if (id == "0")
        {
            string[] strPorblems = mode.Split(',');
            strSubject = strPorblems[0];
            strTo = SchoolFieldName("MailTo", CurrentUser.SchoolID);  //*** ชื่อ Email Admin ของระบบ  ที่จะรับเมล์จากการ register
            strBody = strPorblems[1] + " <BR/> จากคุณ &nbsp;" + strPorblems[2];
        }
        
        MailMessage objEmail = new MailMessage();
        objEmail.To.Add(strTo);
        objEmail.From = new MailAddress("AD.StarSoftware@gmail.com","AdminStarSoftware");  //*** ชื่อ Email Admin ของระบบ
        objEmail.Subject = strSubject;
        objEmail.Body = strBody;
        objEmail.Priority = MailPriority.Normal;
        objEmail.IsBodyHtml = true;

        try
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Credentials = new System.Net.NetworkCredential("AD.StarSoftware@gmail.com", "St@rs0ft");  // ชื่อ Email และ Password ของ Admin ระบบ
            smtp.EnableSsl = true;
            smtp.Port = 587; //  ไม่ต้องมีก็ได้คับ  แต่  smtp.EnableSsl ต้องเป็น False
            smtp.Host = "smtp.gmail.com"; // ชื่อ  Host
            smtp.Send(objEmail);
        }
        catch (Exception exc)
        {

        }
    }
    public Boolean ckAttachFileGetExtensionError(FileUpload fpAttach)//กันการ Up ไฟล์ virus)
    {
        //if (Path.GetExtension(fpAttach.FileName).ToString() == ".htaccess")
        //{
        //    return false;
        //}
        //if (Path.GetExtension(fpAttach.FileName).ToString() == ".exe") 
        //{
        //    return false;
        //}
        //if (Path.GetExtension(fpAttach.FileName).ToString() == ".alfa")
        //{
        //    return false;
        //}
        //return true;

        //string[] arrTypes = { ".doc", ".txt", ".docx", ".pdf" };
        Hashtable hsh = new Hashtable();
        hsh.Add("doc", ".doc");
        hsh.Add("docx", ".docx");
        hsh.Add("xls", ".xls");
        hsh.Add("xlsx", ".xlsx");
        hsh.Add("ppt", ".ppt");
        hsh.Add("pdf", ".pdf");
        hsh.Add("txt", ".txt");
        hsh.Add("gif", ".gif");
        hsh.Add("jpeg", ".jpeg");
        hsh.Add("jpg", ".jpg");
        hsh.Add("png", ".png");
        hsh.Add("tiff", ".tiff");
        hsh.Add("bmp", ".bmp");
        hsh.Add("rar", ".rar");
        hsh.Add("zip", ".zip");
        hsh.Add("mp3", ".mp3");
        hsh.Add("mp4", ".mp4");
        hsh.Add("wav", ".wav");
        hsh.Add("wma", ".wma");
        hsh.Add("mov", ".mov");
        hsh.Add("mpg", ".mpg");
        hsh.Add("mpeg", ".mpeg");
        hsh.Add("swf", ".swf");
        hsh.Add("wmv", ".wmv");

        string strExt = Path.GetExtension(fpAttach.FileName).ToString().ToLower();
        if (hsh.ContainsValue(strExt) == true)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public Int32 getAttachType(string ContentType, int ckDuo)
    {
        Int32 cType = 1;
        //1 - image
        //2 - application
        //3 - audio
        //4 - video
        //5 - text
        //6 - Duo

        string[] ckType = ContentType.Split('/');
        if (ckType.Length > 0)
        {
            switch (ckType[0])
            {
                case "image":
                    cType = 1;
                    break;
                case "application":
                    if ((ckType[1] == "x-zip-compressed" && ckDuo == 1) || (ckType[1] == "octet-stream" && ckDuo == 1))
                    {
                        cType = 6;
                    }
                    else
                    {
                        cType = 2;
                    }
                    break;
                case "audio":
                    cType = 3;
                    break;
                case "video":
                    cType = 4;
                    break;
                case "text":
                    cType = 5;
                    break;
            }
        }
        return cType;
    }
    public string getImageAttachFileType(int cType, object ItemID, object title)
    {
        string link = "<div style=\"font-size:8px;color:#808080;float:none;overflow:hidden;text-align:center;\"><a target=\"_blank\" href=\"../AttachFile/{0}\" title=\"{2}\"><img style=\"border:none\" src=\"{1}\" />" + title.ToString() + "</a></div>";
        string pathimg = "";
        string pathlink = ItemID.ToString() + Path.GetExtension(title.ToString());

        if (cType == 1)
        {
            pathimg = "../AttachFile/Rz_" + ItemID.ToString() + Path.GetExtension(title.ToString());
        }
        if (cType == 2)
        {
            pathimg = "../Image/Icon/SystemIcon.png";
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".doc"))
            {
                pathimg = "../Image/Icon/WordIcon.png";
            }
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".xls"))
            {
                pathimg = "../Image/Icon/ExcelIcon.png";
            }
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".ppt"))
            {
                pathimg = "../Image/Icon/PowerpointIcon.png";
            }
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".pdf"))
            {
                pathimg = "../Image/Icon/PdfIcon.png";
            }
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".rar"))
            {
                pathimg = "../Image/Icon/RarIcon.png";
            }
            if (title.ToString().Substring(title.ToString().IndexOf('.')).Contains(".zip"))
            {
                pathimg = "../Image/Icon/RarIcon.png";
            }
        }
        if (cType == 3)
        {
            pathimg = "../Image/Icon/AudioICon.png";
        }
        if (cType == 4)
        {
            pathimg = "../Image/Icon/MovieICon.png";
        }
        if (cType == 5)
        {
            pathimg = "../Image/Icon/TextIcon.png";
        }
        if (cType == 6)
        {
            string path = ConfigurationManager.AppSettings["TempPath"].ToString();

            link = "<div style=\"font-size:8px;color:#808080;float:none;overflow:hidden;text-align:center;\"><a target=\"_blank\" href=\"../" + path + "/{0}\" title=\"{2}\"><img style=\"border:none\" src=\"{1}\" /></a><a href=\"../AttachFile/" + ItemID.ToString() + title.ToString().Substring(title.ToString().IndexOf('.')) + "\" title=\"" + title + "\">download</a></div>";
            pathlink = ItemID.ToString() + "/" + FindfileInFolder("htm", ItemID.ToString());
            pathimg = "../Image/Icon/DuoIcon.png";
        }
        return string.Format(link, pathlink, pathimg, title);
    }
    public void UploadFileAttach(FileUpload fpAttach, string NewID, int ckType)
    {
        string path = ConfigurationManager.AppSettings["FilePath"].ToString();

        if (fpAttach.HasFile)
        {
            int intWidth = 65;
            int intHeight = 50;
            string UlFileName = "";
            string NewFileName = "";

            //String.Concat(Path.GetFileNameWithoutExtension(fpAttach.FileName) เอาแต่ชื่อ, Path.GetExtension(fpAttach.FileName) เอาแต่นามสกุล)

            UlFileName = path + NewID + Path.GetExtension(fpAttach.FileName).ToString();  //fpAttach.FileName;

            if (ckAttachFileGetExtensionError(fpAttach))
            {
                //*** Save Images ***//
                Page sv = new Page();
                fpAttach.SaveAs(sv.Server.MapPath(UlFileName));

                if (ckType == 1)
                {
                    NewFileName = path + "Rz_" + NewID + Path.GetExtension(fpAttach.FileName).ToString();  //fpAttach.FileName;

                    System.Drawing.Image objGraphic = System.Drawing.Image.FromFile(sv.Server.MapPath(UlFileName));

                    //System.Drawing.Image objGraphic = System.Drawing.Image.FromFile(Files.GetDirectory(Files.FolderAttachFile, NewID + Path.GetExtension(fpAttach.PostedFile.FileName)));

                    System.Drawing.Bitmap objBitmap = default(System.Drawing.Bitmap);
                    //*** Calculate Height ***//
                    if (intHeight > 0)
                    {
                        objBitmap = new System.Drawing.Bitmap(objGraphic, intWidth, intHeight);
                    }
                    else
                    {
                        if (objGraphic.Width > intWidth)
                        {
                            double ratio = objGraphic.Height / objGraphic.Width;
                            intHeight = (int)ratio * (int)intWidth;
                            objBitmap = new System.Drawing.Bitmap(objGraphic, intWidth, intHeight);
                        }
                        else
                        {
                            objBitmap = new System.Drawing.Bitmap(objGraphic);
                        }
                    }

                    //*** Save As  ***//
                    //objBitmap.Save(Files.GetDirectory(Files.FolderAttachFile, NewID + "_Small" + Path.GetExtension(fpAttach.PostedFile.FileName)), objGraphic.RawFormat);
                    objBitmap.Save(sv.Server.MapPath(NewFileName.ToString()), objGraphic.RawFormat);

                    //*** Close ***//
                    objGraphic.Dispose();
                }

                if (ckType == 6)
                {

                }
            }
        }
    }

    public string FindfileInFolder(string fileType, string fileName)
    {
        string UlFileName = "~/Temp/" + fileName;
        Page sv = new Page();
        string[] filePaths = Directory.GetFiles(sv.Server.MapPath(UlFileName), "*." + fileType + "");
        string fName = Path.GetFileName(filePaths[0]);
        return fName;
    }
}

public class Folder
{
    private static double sizeInBytes;
    public static double Size(string directory, bool deep)
    {
        DirectoryInfo dir = new DirectoryInfo(directory);
        foreach (FileInfo f in dir.GetFiles())
        {
            sizeInBytes += f.Length;
        }
        if (deep)
        {
            foreach (DirectoryInfo d in dir.GetDirectories())
            {
                Size(d.FullName, deep);
            }
        }
        double bytes = sizeInBytes;
        sizeInBytes = 0;
        return bytes;
    }
}

