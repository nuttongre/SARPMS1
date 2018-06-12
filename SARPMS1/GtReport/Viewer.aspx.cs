using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.ViewerObjectModel;
using CrystalDecisions.ReportSource;
using System.Data.OleDb;
using System.Data.SqlClient;
using Star.Security.Cryptography;
using System.Data.SqlClient;
using System.IO;

public partial class Report_Viewer : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    
    private DataSet ds;
    private ReportDocument Report;
    string id = "";
    string EmpID = "";
    string SubDeptID = "";
    string DeptID = "";
    string MonthB;
    string YearB;
    string BudgetYear;
    string Ck;
    string reportName = "";
    string YearMode;
    string rptType = "p";

    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
        {
            Report = new ReportDocument();
            EmpID = string.IsNullOrEmpty(Request.QueryString["empid"]) ? "" : Request.QueryString["empid"];
            DeptID = string.IsNullOrEmpty(Request.QueryString["deptid"]) ? "" : Request.QueryString["deptid"];
            SubDeptID = string.IsNullOrEmpty(Request.QueryString["subdeptid"]) ? "" : Request.QueryString["subdeptid"];
            MonthB = string.IsNullOrEmpty(Request.QueryString["monthB"]) ? "" : Request.QueryString["monthB"];
            YearB = string.IsNullOrEmpty(Request.QueryString["yearB"]) ? "" : Request.QueryString["yearB"];
            BudgetYear = string.IsNullOrEmpty(Request.QueryString["bgyear"]) ? "" : Request.QueryString["bgyear"];
            id = string.IsNullOrEmpty(Request.QueryString["id"]) ? "" : Request.QueryString["id"];
            YearMode = string.IsNullOrEmpty(Request.QueryString["yearmode"]) ? "" : Request.QueryString["yearmode"];
            rptType = string.IsNullOrEmpty(Request.QueryString["rpttype"]) ? "" : Request.QueryString["rpttype"];
            Ck = Request.QueryString["ck"];
         
            string rpt = Request["rpt"];
            if (!String.IsNullOrEmpty(rpt))
            {
                switch (rpt.ToLower())
                {
                    case "1":
                        if (Ck == "1")
                        {
                            reportName = "Gt_Standard";  //รายงานประเมินตามเกณฑ์มาตรฐาน รูปแบบที่ 1
                        }
                        if (Ck == "3")
                        {
                            reportName = "Gt_Standard_G1";  //รายงานประเมินตามเกณฑ์มาตรฐาน รูปแบบที่ 2
                        }
                        SetReport1();  //รายงานประเมินตามเกณฑ์มาตรฐาน
                        break;
                    case "2":
                        if (Ck == "2")
                        {
                            reportName = "Gt_Indicators";  //รายงานประเมินตามเกณฑ์ตัวบ่งชี้ รูปแบบที่ 1
                        }
                        if (Ck == "4")
                        {
                            reportName = "Gt_Indicators_G1";  //รายงานประเมินตามเกณฑ์ตัวบ่งชี้ รูปแบบที่ 2
                        }
                        SetReport2();  //รายงานประเมินตามเกณฑ์ตัวบ่งชี้ 
                        break;
                    case "3":
                        reportName = "Gt_DevelopLevel";
                        SetReport3();
                        break;
                    case "4":
                        if (Request.QueryString["ckOld"] == "0")
                        {
                            reportName = "Gt_Costs";  //รายงานค่าใช้จ่ายรายกิจกรรม
                        }
                        SetReport4();
                        break;
                    case "5":
                        reportName = "Gt_Plans";  //แผนปฏิบัติการโรงเรียน แบบปีงบประมาณ
                        SetReport5();  
                        break;
                    case "6":
                        reportName = "Gt_Performance";  //แบบรายงานผลการปฏิบัติงาน
                        SetReport6();  
                        break;
                    case "7":
                        reportName = "Gt_PlansStudy";  //แผนปฏิบัติการโรงเรียน แบบปีการศึกษา
                        SetReport7();  
                        break;
                    case "8":
                        SetReport8();  //ตัวชี้วัดรายกิจกรรม
                        break;
                    case "11":
                        reportName = "Gt_ActivityDetail";
                        SetReport11();  //รายละเอียดกิจกรรม
                        break;
                    case "12":
                        reportName = "Gt_ProjectDetail";
                        SetReport12();  //รายงานสรุปกิจกรรมและค่าใช้จ่ายทั้งหมดภายใต้โครงการ
                        break;
                    case "13":
                        if (Ck == "1")
                        {
                            reportName = "SarReport";  //รายงานSar
                        }
                        if (Ck == "2")
                        {
                            reportName = "SarReport2";  //รายงานSar รูปแบบที่ 2
                        }
                        SetReport13();  
                        break;
                    case "14":
                        if (Request.QueryString["ckmode"] == "1")
                        {
                            reportName = "ReportBudgetProject";
                        }
                        else
                        {
                            reportName = "ReportAbstractProject";
                        }
                        SetReport14(); //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน
                        break;
                    case "15":
                        reportName = "ReportBudgetOfDept";
                        SetReport15(); //รายงานสรุปกิจกรรมและค่าใช้จ่ายตามหน่วยงาน
                        break;
                    case "16":
                        reportName = "ReportRequisition";
                        SetReport16(); //ใบเบิกรายการย่อย
                        break;
                    case "17":
                        if (Request.QueryString["ckmode"] == "1")
                        {
                            reportName = "ReportBudgetProjectOfAllDept";
                        }
                        else
                        {
                            reportName = "ReportAbstractBudgetProjectOfAllDept";
                        }
                        SetReport17(); //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรมทุกหน่วยงาน เรียงตามหน่วยงาน
                        break;
                    case "18":
                        reportName = "ReportPrimary";
                        SetReport18(); //รายงานรายหัวประถม
                        break;
                    case "19":
                        reportName = "ReportHighSchool";
                        SetReport19(); //รายงานรายหัวมัธยม
                        break;
                    case "20":
                        reportName = "ReportAnuban";
                        SetReport20(); //รายงานรายหัวอนุบาล
                        break;
                    case "21":
                        reportName = "ReportStrategiesOperations";
                        SetReport21(); //รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา
                        break;
                    case "22":
                        reportName = "Gt_Indicators_G2";
                        SetReport22(); //รายงานผลการดำเนินงานตามมาตรฐานการศึกษาของสถานศึกษา
                        break;
                    case "23":
                        reportName = "ReportExpect";
                        SetReport23(); //รายงานต้นทุนผลผลิต
                        break;
                    case "25":
                        reportName = "StandardReport";
                        SetReport25();  //รายงานมาตรฐานทั้งหมด
                        break;
                    case "26":
                        reportName = "SchoolDetail";
                        SetReport26();  //รายงานรายละเอียดโรงเรียน
                        break;
                    case "27":
                        reportName = "Calendar";
                        SetReport27();  //ปฏิทินปฏิบัติงาน
                        break;
                    case "28":
                        reportName = "EmpReport";
                        SetReport28();  //รายงานผู้ใช้ระบบ
                        break;
                    case "29":
                        reportName = "ReportEntryCosts";
                        SetReport29(); //รายงานรายละเอียดแผนการใช้จ่ายเงิน
                        break;
                    case "30":
                        reportName = "ReportRoutine";
                        SetReport30(); //รายงานงานประจำตามโครงสร้างการบริหารโรงเรียน
                        break;
                    case "31":
                        reportName = "ReportResults";
                        SetReport31(); //รายงานแบบสรุปการดำเนินงาน
                        break;
                    case "32":
                        reportName = "ReportCosts2";
                        SetReport32(); //รายงานบันทึกค่าใช้จ่ายรายกิจกรรม2
                        break;
                    case "33":
                        reportName = "ReportBudgetOfSubDept";
                        SetReport33(); //รายงานสรุปกิจกรรมและค่าใช้จ่ายตามหน่วยงานและหน่วยงานย่อย
                        break;
                    case "34":
                        reportName = "ReportIncome"; //รายงานรายรับ
                        SetReport34();
                        break;
                    case "35":
                        reportName = "ReportExpenses"; //รายงานรายจ่าย
                        SetReport35();
                        break;
                    case "36":
                        reportName = "ReportOther"; //รายงานรายจ่ายอื่น ๆ
                        SetReport36();
                        break;
                    case "37":
                        reportName = "ReportCountAct";  //รายงานจำนวนกิจกรรมตามตัวบ่งชี้
                        SetReport37();
                        break;
                    case "38":
                        reportName = "ReportFactor";
                        SetReport38(); //รายงานระดับความสำเร็จ/ปัจจัยที่สนับสนุนให้กิจกรรมสำเร็จ
                        break;
                    case "39":
                        reportName = "ReportProjectsJulaporn";
                        SetReport39(); //รายงานใบคำขอโครงการของกลุ่มจุฬาภรณ์
                        break;
                    case "40":
                        reportName = "TestImg";
                        SetReport40();
                        break;
                    case "41":
                        reportName = "ResponseProblems";
                        SetReport41(); //รายงานปัญหาโครงการปีผ่านมา
                        break;
                    case "42":
                        if (Request["graphtype"] == "0")
                        {
                            reportName = "GraphCountActColumn2D";
                        }
                        if (Request["graphtype"] == "1")
                        {
                            reportName = "GraphCountActColumn3D";
                        }
                        if (Request["graphtype"] == "2")
                        {
                            reportName = "GraphCountActPie2D";
                        }
                        if (Request["graphtype"] == "3")
                        {
                            reportName = "GraphCountActPie3D";
                        }
                        SetReport42(); //กราฟจำนวนกิจกรรมตามมาตรฐาน
                        break;
                    case "43": //รายงานการดำเนินการตามกลยุทธ์
                        reportName = "ReportStrategiesOperations2";
                        SetReport43();
                        break;
                    case "44": //รายงานการดำเนินการตามกลยุทธ์
                        reportName = "ReportStrategiesOperations3";
                        SetReport44();
                        break;
                    case "45": //รายงานจำนวนโครงการกิจกรรมตามหน่วยงาน
                        reportName = "ReportDeptOfProjectAndActivity";
                        SetReport45();
                        break;
                    case "48":
                        reportName = "ReportIndicatorsOfSuccess";
                        SetReport48(); //รายงานสภาพความสำเร็จที่คาดว่าจะเกิดขึ้นเมื่อสิ้นปีงบประมาณ
                        break;
                    case "49":
                        reportName = "ReportRequisition2";
                        SetReport49(); //ใบปะหน้าขอดำเนินโครงการ
                        break;
                    case "51":
                        reportName = "ReportBudgetProjectNotClose";
                        SetReport51(); //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน แบบยังไม่ปิดกิจกรรม
                        break;
                    case "52":
                        reportName = "ReportBudgetNotCloseByBudgetType";
                        SetReport52(); //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน แบบยังไม่ปิดกิจกรรม แยกตามประเภทงบประมาณ
                        break;
                    case "53":
                        reportName = "ReportSetBudgetProject";
                        SetReport53(); // รายงานสรุปงาน/กิจกรรมและงบประมาณที่ขออนุมัติดำเนินการ (เงินที่ตั้ง)
                        break;
                    case "54":
                        reportName = "ReportRoutine2";
                        SetReport54(); // รายงานแผนปฏิบัติการงานประจำ ตามโครงสร้างการบริหาร
                        break;
                    case "55":
                        reportName = "ReportStrategicObjectives";
                        SetReport55(); //รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา แบบแสดงวัตถุประสงค์เชิงกลยุทธ์
                        break;
                    case "56":
                        reportName = "Gt_ProjectDetailByActivity";
                        SetReport56();  //รายงานสรุปกิจกรรมและค่าใช้จ่ายทั้งหมดภายใต้โครงการ แยกตามกิจกรรม
                        break;
                    case "60":
                        if (rptType == "e")
                        {
                            reportName = "GraphGetCountProjectsExcel";
                        }
                        else
                        {
                            reportName = "GraphGetCountProjects";
                        }
                        SetReport60();  //กราฟสรุปจำนวนโครงการ
                        break;
                    case "61":
                        if (rptType == "e")
                        {
                            reportName = "GraphGetCountProjects2Excel";
                        }
                        else
                        {
                            reportName = "GraphGetCountProjects2";
                        }
                        SetReport61();  //กราฟเปรียบเทียบโครงการตามแผนงานกับโครงการที่ดำเนินการเสร็จเรียบร้อย
                        break;
                    case "62":
                        if (rptType == "e")
                        {
                            reportName = "GraphGetCountProjects3Excel";
                        }
                        else
                        {
                            reportName = "GraphGetCountProjects3";
                        }
                        SetReport62();  //กราฟเปรียบเทียบ งบประมาณตามแผนกับงบประมาณที่ใช้จริง
                        break;
                    case "63":
                        if (rptType == "e")
                        {
                            reportName = "GraphGetCountProjects4Excel";
                        }
                        else
                        {
                            reportName = "GraphGetCountProjects4";
                        }
                        SetReport63();  //กราฟรายงานคุณภาพโครงการ / กิจกรรมตามแผนงาน
                        break;
                    case "64":
                        if (rptType == "e")
                        {
                            reportName = "ftYearWithdrawReportExcel";
                        }
                        else
                        {
                            reportName = "ftYearWithdrawReport";
                        }
                        SetReport64();  //รายงานสรุปเงินอุดหนุนเรียนฟรี 15 ปี
                        break;
                    case "65":
                        if (rptType == "e")
                        {
                            reportName = "ftYearWithdraw2ReportExcel";
                        }
                        else
                        {
                            reportName = "ftYearWithdraw2Report";
                        }
                        SetReport65();  //รายงานสรุปเงินอุดหนุนเรียนฟรี 15 ปี
                        break;
                    case "66":
                        reportName = "Gt_ProjectAbstract";
                        SetReport66();  //รายงานสรุปโครงการ
                        break;
                }
            }
        }
    }
    private void SetReport1()  //รายงานประเมินตามเกณฑ์มาตรฐาน
    {
        
        DataTable dt = new DataTable();
        dt.Columns.Add("StandardCode", typeof(string));
        dt.Columns.Add("StandardName", typeof(string));
        dt.Columns.Add("WeightScore", typeof(decimal));
        dt.Columns.Add("Sort", typeof(int));
        dt.Columns.Add("Score", typeof(decimal));
        dt.Columns.Add("Translation", typeof(string));
        dt.Columns.Add("Grade", typeof(int));

        DataView dv, dv1, dv2, dv3, dv4;
        

        string strSql = " Select a.StandardCode, a.StandardName, a.ScoreGroupID, "
                + " IsNull(Sum(b.WeightScore), 0) WeightScore, a.Sort "
                + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + BudgetYear + "' "
                + " Group By a.StandardCode, a.StandardName, a.ScoreGroupID, a.Sort "
                + " Order By a.Sort ";
        dv = Conn.Select(strSql);

        double ckScore = 0;
        string ckTranslation = "";

        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select b.IndicatorsCode, b.WeightScore, b.IndicatorsName "
                    + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 "
                    + " And a.StudyYear = '" + BudgetYear + "' "
                    + " And b.StandardCode = '" + dv[i]["StandardCode"].ToString() + "' Order By a.Sort, b.Sort ";
            dv1 = Conn.Select(strSql);

            double IndPercent = 0;
            double ckIndScore = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (!string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + DeptID + "' ";
                }
                if (!string.IsNullOrEmpty(EmpID))
                {
                    if (string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' ";
                    }
                    else
                    {
                        strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                    + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                    }
                }
                dv2 = Conn.Select(strSql + " Group By a.ProjectsCode ");

                double PjPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (!string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + DeptID + "' ";
                    }
                    if (!string.IsNullOrEmpty(EmpID))
                    {
                        if (string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                                + " From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' ";
                        }
                        else
                        {
                            strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                                    + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                    + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                        }
                    }
                    dv3 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                    double AcPercent = 0;
                    for (int l = 0; l < dv3.Count; l++)
                    {
                        strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                        if (!string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + DeptID + "' ";
                        }
                        if (!string.IsNullOrEmpty(EmpID))
                        {
                            if (string.IsNullOrEmpty(DeptID))
                            {
                                strSql = " Select a.ActivityCode "
                                + " From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                                + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' ";
                            }
                            else
                            {
                                strSql = " Select a.ActivityCode "
                                    + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                    + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv1[j]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv2[k]["ProjectsCode"].ToString() + "' "
                                    + " And b.ActivityCode = '" + dv3[l]["ActivityCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                            }
                        }
                        dv4 = Conn.Select(strSql);

                        AcPercent += (Convert.ToDouble(dv3[l]["CkAPercent"]) * 100) / (Convert.ToDouble(dv4.Count) * 100);
                    }

                    PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv3.Count) * 100);
                }

                if (dv2.Count != 0)
                {
                    IndPercent = (PjPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
                }
                else
                {
                    IndPercent = 0;
                }

                double IndScore = 0;
                IndScore = (IndPercent * Convert.ToDouble(dv1[j]["WeightScore"])) / 100;

                //string[] IndCriterion = new BTC().ckTCriteria(Convert.ToDouble(dv1[j]["WeightScore"]), IndScore).Split(':');
                //ckIndScore += Convert.ToDouble(IndCriterion[0]);

                //เช็คการประเมินเชิงคุณภาพ
                IndScore = btc.getQuality(dv1[j]["IndicatorsCode"].ToString(), IndScore);

                ckIndScore += Convert.ToDouble(IndScore.ToString("#0.00"));
            }

            double hScore = 0;
            //hScore = (ckIndScore / Convert.ToDouble(dv1.Count));

            hScore = ckIndScore;

            string[] Tcriterion = new BTC().ckTCriteria(dv[i]["ScoreGroupID"].ToString(), hScore).Split(':');
            ckScore = Convert.ToDouble(Tcriterion[0]);
            ckTranslation = Tcriterion[1].ToString();

            DataRow dr = dt.NewRow();
            dr["StandardCode"] = dv[i]["StandardCode"].ToString();
            dr["StandardName"] = dv[i]["StandardName"].ToString();
            dr["WeightScore"] =  dv[i]["WeightScore"];
            dr["Sort"] = dv[i]["Sort"];
            dr["Score"] = hScore;
            dr["Translation"] = ckTranslation;
            dr["Grade"] = ckScore;
            dt.Rows.Add(dr);
        }
        DataSet ds = new DataSet("data1");
        ds.Tables.Add(dt);
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;   

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        string EmpName = btc.getEmpName(EmpID);
        string DeptName = btc.getDeptName(DeptID);

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("EmpName", EmpName);
        Report.SetParameterValue("DeptName", DeptName);

        ExportReport();

        this.Session["ReportSource1"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport2()  //รายงานประเมินตามเกณฑ์ตัวบ่งชี้
    {
        
        DataTable dt = new DataTable();
        dt.Columns.Add("StandardCode", typeof(string));
        dt.Columns.Add("StandardName", typeof(string));
        dt.Columns.Add("StdScoreGroupID", typeof(string));
        dt.Columns.Add("IndicatorsCode", typeof(string));
        dt.Columns.Add("IndicatorsName", typeof(string));
        dt.Columns.Add("WeightScore", typeof(decimal));
        dt.Columns.Add("Score", typeof(decimal));
        dt.Columns.Add("ScoreStd", typeof(decimal));
        dt.Columns.Add("Translation", typeof(string));
        dt.Columns.Add("Grade", typeof(int));
        dt.Columns.Add("GradeStd", typeof(int));
        dt.Columns.Add("Sort", typeof(int));
        dt.Columns.Add("Sort2", typeof(int));

        DataView dv, dv1, dv2, dv3;
        

        string strSql = " Select a.StandardCode, a.StandardName, a.Sort, b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.ScoreGroupID, b.Sort Sort2, a.ScoreGroupID StdScoreGroupID "
                    + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + BudgetYear + "' "
                    + " Order By a.Sort, b.Sort ";
        dv = Conn.Select(strSql);

        double CkCriterion = 0;

        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (!string.IsNullOrEmpty(DeptID))
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.DeptCode = '" + DeptID + "' ";
            }
            if (!string.IsNullOrEmpty(EmpID))
            {
                if (string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' ";
                }
                else
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                        + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                        + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                }
            }
            dv1 = Conn.Select(strSql + " Group By a.ProjectsCode ");

            double PjPercent = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (!string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                }
                if (!string.IsNullOrEmpty(EmpID))
                {
                    if (string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                    }
                    else
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                    }
                }
                dv2 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                double AcPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (!string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                    }
                    if (!string.IsNullOrEmpty(EmpID))
                    {
                        if (string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                        }
                        else
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                        }
                    }
                    dv3 = Conn.Select(strSql);

                    AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (Convert.ToDouble(dv3.Count) * 100);
                }

                PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
            }

            if (dv1.Count != 0)
            {
                CkCriterion = (PjPercent * 100) / (Convert.ToDouble(dv1.Count) * 100);
            }
            else
            {
                CkCriterion = 0;
            }

            double avg = 0;
            avg = CkCriterion;

            double hScore = 0;
            hScore = (avg * Convert.ToDouble(dv[i]["WeightScore"])) / 100;

            //เช็คการประเมินเชิงคุณภาพ
            hScore = btc.getQuality(dv[i]["IndicatorsCode"].ToString(), hScore);

            string[] Tcriterion = new BTC().ckTCriteria(dv[i]["ScoreGroupID"].ToString(), hScore).Split(':');
            double ckScore = Convert.ToDouble(Tcriterion[0]);
            string ckTranslation = Tcriterion[1].ToString();

            DataRow dr = dt.NewRow();
            dr["StandardCode"] = dv[i]["StandardCode"].ToString();
            dr["StandardName"] = dv[i]["StandardName"].ToString();
            dr["StdScoreGroupID"] = dv[i]["StdScoreGroupID"].ToString();
            dr["IndicatorsCode"] = dv[i]["IndicatorsCode"].ToString();
            dr["IndicatorsName"] = dv[i]["IndicatorsName"].ToString();
            dr["WeightScore"] = dv[i]["WeightScore"];
            dr["Score"] = Convert.ToDouble(Convert.ToDouble(hScore).ToString("#,##0.00"));
            dr["Translation"] = ckTranslation;
            dr["Grade"] = ckScore;
            dr["Sort"] = dv[i]["Sort"];
            dr["Sort2"] = dv[i]["Sort2"];
            dt.Rows.Add(dr);
        }

        DataView dvStd = Conn.Select("Select StandardCode, StandardName, StudyYear, ScoreGroupID From Standard Where DelFlag = 0 And StudyYear = '" + BudgetYear + "'");
        if(dvStd.Count != 0 )
        {
            for(int i = 0; i < dvStd.Count; i++)
            {
                object sumScore;
                sumScore = dt.Compute("Sum(Score)", "StandardCode = '" + dvStd[i]["StandardCode"].ToString() + "'");
                if (!string.IsNullOrEmpty(sumScore.ToString())) 
                {
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        if (dvStd[i]["StandardCode"].ToString() == dt.Rows[j]["StandardCode"].ToString())
                        {
                            dt.Rows[j]["ScoreStd"] = Convert.ToDecimal(sumScore);

                            string[] TcriterionStd = new BTC().ckTCriteria(dvStd[i]["ScoreGroupID"].ToString(), Convert.ToDouble(sumScore)).Split(':');
                            dt.Rows[j]["GradeStd"] = Convert.ToInt32(TcriterionStd[0]);
                        }
                    }
                }
            }
        }

        DataSet ds = new DataSet("data1");
        ds.Tables.Add(dt);
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));
        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        string EmpName = btc.getEmpName(EmpID);
        string DeptName = btc.getDeptName(DeptID);

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("EmpName", EmpName);
        Report.SetParameterValue("DeptName", DeptName);

        ExportReport();

        this.Session["ReportSource2"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport3()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("StandardCode", typeof(string));
        dt.Columns.Add("StandardName", typeof(string));
        dt.Columns.Add("IndicatorsCode", typeof(string));
        dt.Columns.Add("IndicatorsName", typeof(string));
        dt.Columns.Add("WeightScore", typeof(double));
        dt.Columns.Add("Score", typeof(double));
        dt.Columns.Add("Translation", typeof(string));
        dt.Columns.Add("Grade", typeof(int));
        dt.Columns.Add("Sort", typeof(int));
        dt.Columns.Add("Sort2", typeof(int));
        dt.Columns.Add("avg", typeof(float));
        dt.Columns.Add("LevelDetail", typeof(string));
        dt.Columns.Add("LevelScore", typeof(int));
        dt.Columns.Add("Weight", typeof(int));

        DataView dv, dv1, dv2, dv3;
        

        string strSql = " Select a.StandardCode, a.StandardName, a.Sort, b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.ScoreGroupID, b.Sort Sort2 "
                    + " From Standard a Left Join Indicators b On a.StandardCode = b.StandardCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 "
                    + " Order By a.Sort, b.Sort ";
        dv = Conn.Select(strSql);

        double CkCriterion = 0;

        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select ProjectsCode From Evaluation "
                        + " Where DelFlag = 0 And IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And StudyYear = '" + BudgetYear + "' And SchoolID = '" + CurrentUser.SchoolID + "' Group By ProjectsCode ";
            dv1 = Conn.Select(strSql);

            double PjPercent = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort";
                dv2 = Conn.Select(strSql);

                double AcPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    dv3 = Conn.Select(strSql);

                    AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (Convert.ToDouble(dv3.Count) * 100);
                }

                PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
            }

            if (dv1.Count != 0)
            {
                CkCriterion = (PjPercent * 100) / (Convert.ToDouble(dv1.Count) * 100);
            }
            else
            {
                CkCriterion = 0;
            }

            double avg = 0;
            avg = CkCriterion;

            double hScore = 0;
            hScore = (avg * Convert.ToDouble(dv[i]["WeightScore"])) / 100;

            string[] Tcriterion = new BTC().ckTCriteria(dv[i]["ScoreGroupID"].ToString(), hScore).Split(':');
            double ckScore = Convert.ToDouble(Tcriterion[0]);
            string ckTranslation = Tcriterion[1].ToString();

            strSql = " Select DevelopLevelCode, IndicatorsCode, LevelScore, Weight, LevelDetail From DevelopLevel Where DelFlag = 0 And IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' ";
            if (avg <= 25)
            {
                strSql = strSql + " And Weight = 25";
            }
            else
            {
                if (avg <= 50)
                {
                    strSql = strSql + " And Weight = 50";
                }
                else
                {
                    if (avg <= 75)
                    {
                        strSql = strSql + " And Weight = 75";
                    }
                    else
                    {
                        if (avg <= 100)
                        {
                            strSql = strSql + " And Weight = 100";
                        }
                    }
                }
            }

            DataView dv8 = Conn.Select(strSql);

            DataRow dr = dt.NewRow();
            dr["StandardCode"] = dv[i]["StandardCode"].ToString();
            dr["StandardName"] = dv[i]["StandardName"].ToString();
            dr["IndicatorsCode"] = dv[i]["IndicatorsCode"].ToString();
            dr["IndicatorsName"] = dv[i]["IndicatorsName"].ToString();
            dr["WeightScore"] = dv[i]["WeightScore"];
            dr["Score"] = hScore;
            dr["Translation"] = ckTranslation;
            dr["Grade"] = ckScore;
            dr["Sort"] = dv[i]["Sort"];
            dr["Sort2"] = dv[i]["Sort2"];

            if (dv8.Count != 0)
            {
                dr["LevelDetail"] = dv8[0]["LevelDetail"].ToString();
                dr["LevelScore"] = Convert.ToInt32(dv8[0]["LevelScore"]);
                dr["Weight"] = Convert.ToInt32(dv8[0]["Weight"]);
            }
            else
            {
                dr["LevelDetail"] = "";
                dr["LevelScore"] = 0;
                dr["Weight"] = 0;
            }

            dt.Rows.Add(dr);
        }

        strSql = " Select a.DevelopLevelCode, a.IndicatorsCode, a.LevelScore, a.Weight, a.LevelDetail "
                    + " From DevelopLevel a, DevelopLevelExpect b "
                    + " Where a.DelFlag = '0' And a.DevelopLevelCode = b.DevelopLevelCode And a.IndicatorsCode = b.IndicatorsCode "
                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
        DataView dv9 = Conn.Select(strSql);

        DataSet ds = new DataSet("data2");
        ds.Tables.Add(dt);
        ds.Tables.Add(dv.ToTable("data2"));
        ds.Tables.Add(dv9.ToTable("data3"));
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource3"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport4() //รายงานค่าใช้จ่ายรายกิจกรรม
    {      
        DataView dv, dv1, dv2, dv3;
        string ResponsAcName = "";
        string Solutions = "";
        string ResponsiblePosition = "";
        string StrategiesName = "";
        string Risk = "";
        string Protect = "";
        string Status = "";
        string IdentityName2 = "";

        string strSQL = @" Select a.ProjectsCode, e.ProjectsName, a.ActivityCode, a.ActivityName, a.CostsType, a.TotalAmount, a.Term, a.YearB, a.CreateUser, a.Risk, a.Protect, 
            a.Purpose, a.Target, a.Target2, a.ActivityDetail As ProjectsDetail, 
            a.Evaluation, a.EvaIndicators, a.EvaAssessment, a.EvaTool, a.Expected, a.IdentityName, a.IdentityName2, 
            e.ResponsibleName, e.ResponsiblePosition, 
            ProposeName = Case When a.ProposeName IS NULL Then e.ProposeName Else a.ProposeName End, 
            ProposePosition = Case When a.ProposePosition IS NULL Then e.ProposePosition Else a.ProposePosition End, 
            ApprovalName = Case When a.ApprovalName IS NULL Then e.ApprovalName Else a.ApprovalName End, 
            ApprovalPosition = Case When a.ApprovalPosition IS NULL Then e.ApprovalPosition Else a.ApprovalPosition End, 
            ApprovalName2 = Case When a.ApprovalName2 IS NULL Then e.ApprovalName2 Else a.ApprovalName2 End, 
            ApprovalPosition2 = Case When a.ApprovalPosition2 IS NULL Then e.ApprovalPosition2 Else a.ApprovalPosition2 End, 
            a.ActivityDetail, '' DeptName, '' EmpName, a.StudyYear, a.BudgetYear, a.SDate, a.EDate, '' As StandardNationName, 
            '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, a.Place, a.Solutions, a.ResponsiblePosition As ResponsiblePositionNew, 
            '' As SufficeSideName, '' As StrategicName, a.Status, e.PlanNo, e.StatuteNo, 
            a.SuanIdentityName, a.SuanIdentitySideName, a.SuanIdentityName2, a.SuanGood, a.AlertDay, a.RealSDate, a.RealEDate, a.VolumeExpect 
            From Activity a Inner Join Projects e On a.ProjectsCode = e.ProjectsCode
            Where a.DelFlag = 0 And e.DelFlag = 0
            And a.ActivityCode = '{0}' ";
        dv = Conn.Select(string.Format(strSQL, id));

        if (dv.Count != 0)
        {
            dv[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardName"] = btc.getStandardName(btc.ckIdentityName("ckFullText"), dv[0]["ActivityCode"].ToString());
            dv[0]["IndicatorsName"] = btc.getIndicatorsName(btc.ckIdentityName("ckFullText"), dv[0]["ActivityCode"].ToString());
            dv[0]["StrategicName"] = btc.getStrategicName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            if (btc.ckIdentityName("ckRisk")) // เช็คว่าเปิดโหมดความเสี่ยง
            {
                Risk = dv[0]["Risk"].ToString();
                Protect = dv[0]["Protect"].ToString();
            }
            
            Solutions = dv[0]["Solutions"].ToString();
            ResponsiblePosition = dv[0]["ResponsiblePositionNew"].ToString();

            for (int j = 0; j < dv.Count; j++)
            {
                dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
                dv[j]["EmpName"] = btc.getAcEmpName(dv[j]["ActivityCode"].ToString());
            }
            ResponsAcName = btc.getEmpName(dv[0]["CreateUser"].ToString());

            strSQL = " Select 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As StrategiesName From dtStrategies a, Strategies b Where a.ProjectsCode = '{0}' And a.StrategiesCode = b.StrategiesCode ";
            DataView dv9 = Conn.Select(string.Format(strSQL, dv[0]["ProjectsCode"].ToString()));
            if (dv9.Count != 0)
            {
                for (int i = 0; i < dv9.Count; i++)
                {
                    StrategiesName += dv9[i]["StrategiesName"].ToString() + ",";
                }
            }

            Status = dv[0]["Status"].ToString();

            strSQL = @" Select I.IdentityName From dtIdentityName dt Inner Join IdentityName I On dt.IdentityNameCode = I.IdentityNameCode
        Where dt.ProjectsCode = '{0}'";
            DataView dv7 = Conn.Select(string.Format(strSQL, dv[0]["ProjectsCode"].ToString()));
            if (dv7.Count != 0)
            {
                for (int i = 0; i < dv7.Count; i++)
                {
                    IdentityName2 += dv7[i]["IdentityName"].ToString() + ", ";
                }
            }
        }

        strSQL = " Select a.ActivityCode, "
                + " a.Operation1, a.Period1, a.Place1, a.Emp1, a.Period2, a.Place2, a.Emp2, a.Operation3, a.Period3, a.Place3, a.Emp3, "
                + " b.RecNum, b.Operation2, b.Budget2, b.BudgetOther "
                + " From Activity a Left Join ActivityOperation2 b On a.ActivityCode = b.ActivityCode "
                + " Where a.DelFlag = 0 "
                + " And a.ActivityCode = '" + id + "' Order By b.RecNum ";
        dv3 = Conn.Select(string.Format(strSQL));

        strSQL = " Select a.ActivityCode, "
                + " b.RecNum, b.IndicatorsName, b.MethodAss, b.ToolsAss "
                + " From Activity a Left Join ActivityAssessment b On a.ActivityCode = b.ActivityCode "
                + " Where a.DelFlag = 0 "
                + " And a.ActivityCode = '" + id + "' Order By b.RecNum ";
        DataView dv10 = Conn.Select(string.Format(strSQL));

        strSQL = " Select a.*, a.ListName As EntryCostsName, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End "
                + " From CostsDetail a, BudgetType b "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
        dv1 = Conn.Select(string.Format(strSQL + " Order By a.ListNo, b.Sort ", id));

        strSQL = " Select a.ActivityCode, a.BudgetTypeCode, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End, "
                + " Sum(a.TotalMoney) TotalMoney, b.Sort " 
                + " From CostsDetail a, BudgetType b "
                + " Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode "
                + " And a.ActivityCode = '{0}' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName, Sort ";
        dv2 = Conn.Select(string.Format(strSQL + " Order By b.Sort ", id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();

        string[] lblTarget = btc.getlblTarget().Split(',');
        string [] lblKeyWord = btc.getKeyWordResponsibleActivity().Split(',');

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("dtBudget"));
        ds.Tables.Add(dv2.ToTable("dtBudgetType"));
        ds.Tables.Add(dv3.ToTable("dtOperation2"));
        ds.Tables.Add(dv10.ToTable("dtBudgetTerm"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("identityName", ""); //btc.ckIdentityName("iNameShow") ? dv[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", !string.IsNullOrEmpty(IdentityName2) ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");  //btc.ckIdentityName("iNameShow2") ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("Solutions", Solutions);
        Report.SetParameterValue("ResponsAcName", ResponsAcName);
        Report.SetParameterValue("lblTarget1", lblTarget[0]);
        Report.SetParameterValue("lblTarget2", lblTarget[1]);
        Report.SetParameterValue("lblKeyWordResponsibleActivity", lblKeyWord[0]);
        Report.SetParameterValue("StrategicName", btc.ckIdentityName("ckStrategic") ? dv[0]["StrategicName"].ToString() : "");
        Report.SetParameterValue("StrategiesName", btc.ckIdentityName("ckStrategies") ? (!string.IsNullOrEmpty(StrategiesName) ? StrategiesName.Substring(0, StrategiesName.Length - 1) : "") : "");
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("ckSign", Request["ckSign"]);
        Report.SetParameterValue("ResponsiblePosition", ResponsiblePosition);
        Report.SetParameterValue("Status", Status);
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);
        Report.SetParameterValue("ckAcAssessment", btc.ckIdentityName("ckAcAssessment") ? "1" : "");
        Report.SetParameterValue("StandardNew", btc.ckIdentityName("ckStandardNew") ? "1" : ""); // โหมดมาตรฐานใหม่
        string AcSideName = btc.getSideNameOfActivity(btc.ckIdentityName("ckFullText"), dv[0]["ActivityCode"].ToString());
        Report.SetParameterValue("AcSideName", AcSideName);

        ExportReport();

        this.Session["ReportSource4"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    } 
    private void SetReport5()  //แผนปฏิบัติการโรงเรียน แบบปีงบประมาณ
    {
        DataView dv, dv1;
        
        string strSQL = " Select a.ProjectsCode, c.ProjectsName, a.ActivityCode, a.ActivityName, a.CostsType, "
                    + " a.TotalAmount, a.Term, a.YearB, a.SDate, 0 As SDay, a.EDate, 0 As EDay, "
                    + " c.Sort SortP, a.Sort SortAc, '' DeptCode, '' DeptName, '' BudgetTypeName "
                    + " From Activity a, Projects c "
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                    + " And a.ProjectsCode = c.ProjectsCode "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (btc.ckIdentityName("ckBudgetYear"))
        {
            strSQL += " And a.StudyYear = '" + BudgetYear + "' ";
        }
        else
        {
            strSQL += " And a.BudgetYear = '" + BudgetYear + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By c.Sort, a.Sort "));

        string str1 = " Select c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2, "
                    + " dbo.GetSort(c.Indicators2Code,'" + CurrentUser.SchoolID + "','" + BudgetYear + "') StSort "
                    + " From Indicators2 b, evaluation c, Standard d "
                    + " Where c.DelFlag = 0 And b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.Indicators2Code = c.Indicators2Code And c.StandardCode = d.StandardCode "
                    + " And c.SchoolID = '" + CurrentUser.SchoolID + "' And d.StudyYear = '" + BudgetYear + "' And c.StudyYear = '" + BudgetYear + "' "
                    + " Group By c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2 ";

        //" Select b.Indicators2Code, b.ProjectsCode, b.ActivityCode, b.IndicatorsName2 "
        //        + " From Projects a, Indicators2 b Where b.DelFlag = '0' "
        //        + " And a.ProjectsCode = b.ProjectsCode "
        //        + " And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.BudgetYear = '" + BudgetYear + "' ";
        dv1 = Conn.Select(string.Format(str1));

        //DateTime dt = DateTime.Now;
        //int w = (dt.DayOfYear);
        //Response.Write(w/7); return;
        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["SDay"] = btc.ckChartBudget(Convert.ToDateTime(dv[i]["SDate"]), Convert.ToInt32(BudgetYear));
                dv[i]["EDay"] = btc.ckChartBudget(Convert.ToDateTime(dv[i]["EDate"]), Convert.ToInt32(BudgetYear));
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
                dv[i]["BudgetTypeName"] = btc.getBudgetTypeName(dv[i]["ActivityCode"].ToString());
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("data2"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ProvinceName = btc.getProvinceName(dvSchool[0]["ProvinceID"].ToString());

        Report.SetParameterValue("BudgetYear", BudgetYear);
        Report.SetParameterValue("SchoolName", schoolName);
        Report.SetParameterValue("ProvinceName", ProvinceName.Trim());
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource5"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport6()  //แบบรายงานผลการปฏิบัติงาน
    {    
        DataView dv, dv1, dv3, dv4, dv5;
        //DataView[] dvi;

        string strSQL = @" Select a.ProjectsCode, b.ProjectsName, a.ActivityCode, a.ActivityName, a.Note, a.CostsType, 
        a.CostsType2, a.TotalStatement, a.TotalPersonnel, a.TotalFinance, a.SDate2, a.Edate2, 
        a.TotalAmount, a.TotalAmount2, a.Term, a.YearB, a.SDate, a.EDate, b.Sort SortP, a.Sort SortAc, '' BudgetTypeName,
        dtD.ActivityCode, D.DeptName, D.Sort As DeptSort
        From Activity a, Projects b, dtAcDept dtD, Department D
        Where a.DelFlag = 0 And b.DelFlag = 0 And a.ProjectsCode = b.ProjectsCode 
        And a.ActivityCode = dtD.ActivityCode And dtD.DeptCode = D.DeptCode
        And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + BudgetYear + "' ";
        if (!string.IsNullOrEmpty(SubDeptID))
        {
            strSQL += " And D.MainSubDeptCode = '" + SubDeptID + "' ";
        }
        if (!string.IsNullOrEmpty(DeptID))
        {
            strSQL += " And D.DeptCode = '" + DeptID + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By D.Sort, b.Sort Asc, a.Sort Asc "));

        string str1 = " Select c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2, b.WeightType, c.OffAll, b.Weight As OffThat, c.APercent, "
                    + " dbo.GetSort(c.Indicators2Code,'" + CurrentUser.SchoolID + "','" + BudgetYear + "') StSort "
                    + " From Indicators2 b, evaluation c, Standard d "
                    + " Where c.DelFlag = 0 And b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.Indicators2Code = c.Indicators2Code And c.StandardCode = d.StandardCode "
                    + " And c.SchoolID = '" + CurrentUser.SchoolID + "' And c.StudyYear = '" + BudgetYear + "' "
                    + " Group By c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2, b.WeightType, c.OffAll, b.Weight, c.APercent ";
        dv1 = Conn.Select(string.Format(str1));

        //StringBuilder sql = new StringBuilder();
        ////for (int i = 0; i < 3; i++)
        ////{
        //    sql.Append("Select a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, ");
        //    sql.Append(" Sum(b.TotalMoney) TotalMoney, c.BudgetType ");
        //    sql.Append(" From Costs a, CostsDetail b, EntryCosts c ");
        //    sql.Append(" Where a.DelFlag = '0' And a.CostsCode = b.CostsCode And b.EntryCostsCode = c.EntryCostsCode ");
        //    sql.AppendFormat(" And a.SchoolID = '{0}' And a.BudgetYear = '{1}' And c.BudgetType = {2} ", CurrentUser.SchoolID, BudgetYear, 0);
        //    sql.Append(" Group By a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, c.BudgetType ");
        //    dv3 = Conn.Select(sql.ToString());
        ////}
        //    sql = new StringBuilder();

        //    sql.Append("Select a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, ");
        //    sql.Append(" Sum(b.TotalMoney) TotalMoney, c.BudgetType ");
        //    sql.Append(" From Costs a, CostsDetail b, EntryCosts c ");
        //    sql.Append(" Where a.DelFlag = '0' And a.CostsCode = b.CostsCode And b.EntryCostsCode = c.EntryCostsCode ");
        //    sql.AppendFormat(" And a.SchoolID = '{0}' And a.BudgetYear = '{1}' And c.BudgetType = {2} ", CurrentUser.SchoolID, BudgetYear, 1);
        //    sql.Append(" Group By a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, c.BudgetType ");
        //    dv4 = Conn.Select(sql.ToString());

        //    sql = new StringBuilder();

        //    sql.Append("Select a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, ");
        //    sql.Append(" Sum(b.TotalMoney) TotalMoney, c.BudgetType ");
        //    sql.Append(" From Costs a, CostsDetail b, EntryCosts c ");
        //    sql.Append(" Where a.DelFlag = '0' And a.CostsCode = b.CostsCode And b.EntryCostsCode = c.EntryCostsCode ");
        //    sql.AppendFormat(" And a.SchoolID = '{0}' And a.BudgetYear = '{1}' And c.BudgetType = {2} ", CurrentUser.SchoolID, BudgetYear, 2);
        //    sql.Append(" Group By a.CostsCode, a.ProjectsCode, a.ActivityCode, a.CostsType, c.BudgetType ");
        //    //Response.Write(sql.ToString());
        //    //return;
        //    dv5 = Conn.Select(sql.ToString());

        //DateTime dt = DateTime.Now;
        //int w = (dt.DayOfYear);
        //Response.Write(w/7); return;

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["BudgetTypeName"] = btc.getBudgetTypeNameAndBudget(dv[i]["ActivityCode"].ToString());
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("data2"));

        //ds.Tables.Add(dv3.ToTable("data3"));
        //ds.Tables.Add(dv4.ToTable("data4"));
        //ds.Tables.Add(dv5.ToTable("data5"));

        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("BudgetYear", BudgetYear);
        Report.SetParameterValue("SchoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");

        ExportReport();

        this.Session["ReportSource6"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    //private void SetReport7()  //แผนปฏิบัติการโรงเรียน แบบปีการศึกษา
    //{
    //    DataView dv, dv1, dvSchool;
    //    

    //    string strSQL = " Select a.ProjectsCode, e.ProjectsName, a.ActivityCode, a.ActivityName, a.CostsType, "
    //                + " a.TotalAmount, a.Term, a.YearB, a.SDate, datepart(week ,a.SDate) SDay, a.EDate, datepart(week ,a.EDate) EDay, "
    //                + " e.Sort SortP, a.Sort SortAc, b.DeptCode, b.DeptName "
    //                + " From Activity a, Department b, Projects e "
    //                + " Where a.DelFlag = 0 And e.DelFlag = 0 And a.DeptCode = b.DeptCode "
    //                + " And a.ProjectsCode = e.ProjectsCode "
    //                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + BudgetYear + "' ";
    //    dv = Conn.Select(string.Format(strSQL + " Order By e.Sort, a.Sort "));

    //    string str1 = " Select c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2, "
    //                + " dbo.GetSort(c.Indicators2Code,'" + CurrentUser.SchoolID + "','" + BudgetYear + "') StSort "
    //                + " From Indicators2 b, evaluation c, Standard d "
    //                + " Where c.DelFlag = 0 And b.DelFlag = 0 And d.DelFlag = 0 "
    //                + " And b.Indicators2Code = c.Indicators2Code And c.StandardCode = d.StandardCode "
    //                + " And c.SchoolID = '" + CurrentUser.SchoolID + "' And d.StudyYear = '" + BudgetYear + "' And c.StudyYear = '" + BudgetYear + "' "
    //                + " Group By c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2 ";

    //    //" Select b.Indicators2Code, b.ProjectsCode, b.ActivityCode, b.IndicatorsName2 "
    //    //        + " From Projects a, Indicators2 b Where b.DelFlag = '0' "
    //    //        + " And a.ProjectsCode = b.ProjectsCode "
    //    //        + " And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.BudgetYear = '" + BudgetYear + "' ";
    //    dv1 = Conn.Select(string.Format(str1));

    //    //DateTime dt = DateTime.Now;
    //    //int w = (dt.DayOfYear);
    //    //Response.Write(w/7); return;

    //    if (dv.Count > 0)
    //    {
    //        for (int i = 0; i < dv.Count; i++)
    //        {
    //            if (Convert.ToInt32(dv[i]["SDay"]) > Convert.ToInt32(dv[i]["EDay"]))
    //            {
    //                switch (Convert.ToInt32(dv[i]["SDay"]))
    //                {
    //                    case 37:
    //                        dv[i]["SDay"] = "-12";
    //                        break;
    //                    case 38:
    //                        dv[i]["SDay"] = "-11";
    //                        break;
    //                    case 39:
    //                        dv[i]["SDay"] = "-10";
    //                        break;
    //                    case 40:
    //                        dv[i]["SDay"] = "-9";
    //                        break;
    //                    case 41:
    //                        dv[i]["SDay"] = "-8";
    //                        break;
    //                    case 42:
    //                        dv[i]["SDay"] = "-7";
    //                        break;
    //                    case 43:
    //                        dv[i]["SDay"] = "-6";
    //                        break;
    //                    case 44:
    //                        dv[i]["SDay"] = "-5";
    //                        break;
    //                    case 45:
    //                        dv[i]["SDay"] = "-4";
    //                        break;
    //                    case 46:
    //                        dv[i]["SDay"] = "-3";
    //                        break;
    //                    case 47:
    //                        dv[i]["SDay"] = "-2";
    //                        break;
    //                    case 48:
    //                        dv[i]["SDay"] = "-1";
    //                        break;
    //                }

    //            }
    //        }
    //    }

    //    ds = new DataSet();
    //    ds.Tables.Add(dv.ToTable("data1"));
    //    ds.Tables.Add(dv1.ToTable("data2"));
    //    //ds.WriteXmlSchema(Server.MapPath("ReportPlans.xsd"));
    //    //return;

    //    Report.Load(Server.MapPath("Gt_PlansStudy.rpt"));

    //    Report.SetDataSource(ds);
    //    Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

    //    dvSchool = new BTC().getMasterSchool();

    //    Report.SetParameterValue("BudgetYear", BudgetYear);
    //    Report.SetParameterValue("SchoolName", dvSchool.Table.Rows[0]["SchoolName"].ToString());
    //    Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

    //    this.Session["ReportSource7"] = Report;
    //    CrystalReportViewer1.ReportSource = Report;
    //    CrystalReportViewer1.DataBind();
    //}
    private void SetReport7()  //แผนปฏิบัติการโรงเรียน แบบปีการศึกษา
    {
        DataView dv, dv1;
        
        string strSQL = " Select a.ProjectsCode, e.ProjectsName, a.ActivityCode, a.ActivityName, a.CostsType, "
                    + " a.TotalAmount, a.Term, a.YearB, a.SDate, 0 SDay, a.EDate, 0 EDay, "
                    + " e.Sort SortP, a.Sort SortAc, '' DeptCode, '' DeptName, '' BudgetTypeName "
                    + " From Activity a, Projects e "
                    + " Where a.DelFlag = 0 And e.DelFlag = 0 "
                    + " And a.ProjectsCode = e.ProjectsCode "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (btc.ckIdentityName("ckBudgetYear"))
        {
            strSQL += " And a.BudgetYear = '" + BudgetYear + "' ";
        }
        else
        {
            strSQL += " And a.StudyYear = '" + BudgetYear + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By e.Sort, a.Sort "));

        string str1 = " Select c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2, "
                    + " dbo.GetSort(c.Indicators2Code,'" + CurrentUser.SchoolID + "','" + BudgetYear + "') StSort "
                    + " From Indicators2 b, evaluation c, Standard d "
                    + " Where c.DelFlag = 0 And b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.Indicators2Code = c.Indicators2Code And c.StandardCode = d.StandardCode "
                    + " And c.SchoolID = '" + CurrentUser.SchoolID + "' And d.StudyYear = '" + BudgetYear + "' And c.StudyYear = '" + BudgetYear + "' "
                    + " Group By c.Indicators2Code, c.ProjectsCode, c.ActivityCode, b.IndicatorsName2 ";

        //" Select b.Indicators2Code, b.ProjectsCode, b.ActivityCode, b.IndicatorsName2 "
        //        + " From Projects a, Indicators2 b Where b.DelFlag = '0' "
        //        + " And a.ProjectsCode = b.ProjectsCode "
        //        + " And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.BudgetYear = '" + BudgetYear + "' ";
        dv1 = Conn.Select(string.Format(str1));

        //DateTime dt = DateTime.Now;
        //int w = (dt.DayOfYear);
        //Response.Write(w/7); return;

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["SDay"] = btc.ckChartStudy(Convert.ToDateTime(dv[i]["SDate"]), Convert.ToInt32(BudgetYear));
                dv[i]["EDay"] = btc.ckChartStudy(Convert.ToDateTime(dv[i]["EDate"]), Convert.ToInt32(BudgetYear));
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
                dv[i]["BudgetTypeName"] = btc.getBudgetTypeName(dv[i]["ActivityCode"].ToString());
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("data2"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ProvinceName = btc.getProvinceName(dvSchool[0]["ProvinceID"].ToString());

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("BudgetYear", BudgetYear);
        Report.SetParameterValue("SchoolName", schoolName);
        Report.SetParameterValue("ProvinceName", ProvinceName.Trim());
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource7"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport8()
    {
        DataView dv;
        

        string strSQL = " Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, "
                    + " c.Indicators2Code, c.IndicatorsName2, a.Sort, b.Sort "
                    + " From Projects a, Activity b, Indicators2 c "
                    + " Where a.ProjectsCode = c.ProjectsCode And b.ActivityCode = c.ActivityCode "
                    + " And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And c.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And a.StudyYear = '" + BudgetYear + "' ";
        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        //ds.WriteXmlSchema(Server.MapPath("ReportProJbyIndicator.xsd"));
        //return;

        Report.Load(Server.MapPath("GT_ProJbyIndicator.rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource8"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport11()  //รายละเอียดกิจกรรม
    {
        DataView dv, dv1 = null, dv2 = null, dv3 = null;
        string ResponsAcName = "";
        string Solutions = "";
        string ResponsiblePosition = "";
        string SubDeptName = "";
        string TargetMode = "";
        string ProjectDes = "";
        string StrategiesName = "";
        string Status = "";

        string strSql = "Select 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
                    + " b.ProjectsName, c.Purpose, c.Target, c.Target2, c.ActivityDetail As ProjectsDetail, "
                    + " c.Evaluation, c.EvaIndicators, c.EvaAssessment, c.EvaTool, c.Expected,"
                    + " b.ResponsibleName, b.ResponsiblePosition, "
                    + " ProposeName = Case When c.ProposeName IS NULL Then b.ProposeName Else c.ProposeName End, "
                    + " ProposePosition = Case When c.ProposePosition IS NULL Then b.ProposePosition Else c.ProposePosition End, "
                    + " ApprovalName = Case When c.ApprovalName IS NULL Then b.ApprovalName Else c.ApprovalName End, "
                    + " ApprovalPosition = Case When c.ApprovalPosition IS NULL Then b.ApprovalPosition Else c.ApprovalPosition End, "
                    + " ApprovalName2 = Case When c.ApprovalName2 IS NULL Then b.ApprovalName2 Else c.ApprovalName2 End, "
                    + " ApprovalPosition2 = Case When c.ApprovalPosition2 IS NULL Then b.ApprovalPosition2 Else c.ApprovalPosition2 End, "
                    + " b.MissionCode, '' As MissionName, b.GoalsCode, '' As GoalsName, "
                    + " c.*, '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName,"
                    + " '' DeptName, '' EmpName, b.ProjectsCode,"
                    + " c.Place, c.Solutions, c.ResponsiblePosition As ResponsiblePositionNew, "
                    + " '' As WorldClassSideName, '' As WorldClassStandardName, '' As RoyalAwardSideName, '' As RoyalAwardIndicatorName, "
                    + " '' As SufficeSideName, '' As SufficeStandardName, '' As SufficeIndicatorName, "
                    + " '' As FourthAssessmentSideName, '' As FourthAssessmentIndicatorName, '' As StrategicName, c.Status "
                    + " From Projects b Left Join Strategies a On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode "
                    + " Where c.ActivityCode = '" + id + "' ";

        dv = Conn.Select(string.Format(strSql));
        if (dv.Count != 0)
        {
            dv[0]["MissionName"] = btc.getdtMissionName(dv[0]["ProjectsCode"].ToString());
            dv[0]["GoalsName"] = btc.getdtGoalsName(dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardName"] = btc.getStandardName(btc.ckIdentityName("ckFullText"), dv[0]["ActivityCode"].ToString());
            dv[0]["IndicatorsName"] = btc.getIndicatorsName(btc.ckIdentityName("ckFullText"), dv[0]["ActivityCode"].ToString());
            dv[0]["DeptName"] = btc.getAcDeptName(dv[0]["ActivityCode"].ToString());
            dv[0]["EmpName"] = btc.getAcEmpName(dv[0]["ActivityCode"].ToString());
            ResponsAcName = btc.getEmpName(dv[0]["CreateUser"].ToString());
            dv[0]["StrategicName"] = btc.getStrategicName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["WorldClassSideName"] = btc.getWorldClassSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            //dv[0]["WorldClassStandardName"] = btc.getWorldClassStandardName(false, dv[0]["ProjectsCode"].ToString());
            dv[0]["RoyalAwardSideName"] = btc.getRoyalAwardSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            //dv[0]["RoyalAwardIndicatorName"] = btc.getRoyalAwardIndicatorName(false, dv[0]["ProjectsCode"].ToString());
            dv[0]["FourthAssessmentSideName"] = btc.getFourthAssessmentSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            //dv[0]["FourthAssessmentIndicatorName"] = btc.getFourthAssessmentIndicatorName(false, dv[0]["ProjectsCode"].ToString());
            dv[0]["SufficeSideName"] = btc.getSufficeSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            //dv5[0]["SufficeStandardName"] = btc.getFourthAssessmentSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            //dv5[0]["SufficeIndicatorName"] = btc.getFourthAssessmentSideName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());

            Status = dv[0]["Status"].ToString();

            Solutions = dv[0]["Solutions"].ToString();
            ResponsiblePosition = dv[0]["ResponsiblePositionNew"].ToString();

            strSql = " Select TargetMode From dtTargetMode Where ProjectsCode = '{0}'";
            DataView dv6 = Conn.Select(string.Format(strSql, dv[0]["ProjectsCode"].ToString()));
            if (dv6.Count != 0)
            {
                for (int i = 0; i < dv6.Count; i++)
                {
                    TargetMode += dv6[i]["TargetMode"].ToString() + ",";
                }
            }

            strSql = " Select ProjectDes From dtProjectDes Where ProjectsCode = '{0}'";
            DataView dv7 = Conn.Select(string.Format(strSql, dv[0]["ProjectsCode"].ToString()));
            if (dv7.Count != 0)
            {
                for (int i = 0; i < dv7.Count; i++)
                {
                    ProjectDes += dv7[i]["ProjectDes"].ToString() + ",";
                }
            }

            strSql = " Select 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As StrategiesName From dtStrategies a, Strategies b Where a.ProjectsCode = '{0}' And a.StrategiesCode = b.StrategiesCode ";
            DataView dv9 = Conn.Select(string.Format(strSql, dv[0]["ProjectsCode"].ToString()));
            if (dv9.Count != 0)
            {
                for (int i = 0; i < dv9.Count; i++)
                {
                    StrategiesName += dv9[i]["StrategiesName"].ToString() + ",";
                }
            }
        }

        if (dv.Count != 0)
        {
            strSql = "Select b.*, txtWeightType = Case b.WeightType When 0 Then '%' When 1 Then 'จำนวน' End, txtCkCriterion = Case b.CkCriterion When 0 Then 'ไม่ผ่าน' When 1 Then 'ผ่าน' End  "
                    + " From Activity a, Indicators2 b Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = '" + id + "'";
            dv1 = Conn.Select(strSql);
        }

        strSql = " Select a.*, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, a.ListName As EntryCostsName "
                + " From CostsDetail a, BudgetType b "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
        dv2 = Conn.Select(string.Format(strSql + " Order By a.ListNo, b.Sort ", id));

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End, "
                + " Sum(a.TotalMoney2) TotalMoney, b.Sort "
                + " From CostsDetail a, BudgetType b "
                + " Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode "
                + " And a.ActivityCode = '{0}' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName, Sort ";
        dv3 = Conn.Select(string.Format(strSql + " Order By b.Sort ", id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        string[] lblTarget = btc.getlblTarget().Split(',');
        string[] lblKeyWord = btc.getKeyWordResponsibleActivity().Split(',');

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("ActivityDetail"));
        ds.Tables.Add(dv1.ToTable("Indicators2Detail"));
        ds.Tables.Add(dv2.ToTable("CostsDetail"));
        ds.Tables.Add(dv3.ToTable("dtBudgetType"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("identityName", btc.ckIdentityName("iNameShow") ? dv[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", ""); //btc.ckIdentityName("iNameShow2") ? dv[0]["IdentityName2"].ToString() : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("ResponsAcName", ResponsAcName);
        Report.SetParameterValue("lblTarget1", lblTarget[0]);
        Report.SetParameterValue("lblTarget2", lblTarget[1]);
        Report.SetParameterValue("lblKeyWordResponsibleActivity", lblKeyWord[0]);
        Report.SetParameterValue("lblKeyWordProposeActivity", lblKeyWord[1]);
        Report.SetParameterValue("lblKeyWordApprovalActivity", lblKeyWord[2]);
        Report.SetParameterValue("lblKeyWordApproval2Activity", lblKeyWord[3]);
        Report.SetParameterValue("StrategicName", btc.ckIdentityName("ckStrategic") ? dv[0]["StrategicName"].ToString() : "");
        Report.SetParameterValue("WorldClassSideName", btc.ckIdentityName("ckWorldClass") ? dv[0]["WorldClassSideName"].ToString() : "");
        Report.SetParameterValue("WorldClassStandardName", btc.ckIdentityName("ckWorldClass") ? dv[0]["WorldClassStandardName"].ToString() : "");
        Report.SetParameterValue("RoyalAwardSideName", btc.ckIdentityName("ckRoyalAward") ? dv[0]["RoyalAwardSideName"].ToString() : "");
        Report.SetParameterValue("RoyalAwardIndicatorName", btc.ckIdentityName("ckRoyalAward") ? dv[0]["RoyalAwardIndicatorName"].ToString() : "");
        Report.SetParameterValue("FourthAssessmentSideName", btc.ckIdentityName("ckFourthAssessment") ? dv[0]["FourthAssessmentSideName"].ToString() : "");
        Report.SetParameterValue("SufficeSideName", btc.ckIdentityName("ckSuffice") ? dv[0]["SufficeSideName"].ToString() : "");
        Report.SetParameterValue("TargetMode", btc.ckIdentityName("ckTargetMode") ? (!string.IsNullOrEmpty(TargetMode) ? TargetMode.Substring(0, TargetMode.Length - 1) : "") : "");
        Report.SetParameterValue("ProjectDes", btc.ckIdentityName("ckProjectDes") ? (!string.IsNullOrEmpty(ProjectDes) ? ProjectDes.Substring(0, ProjectDes.Length - 1) : "") : "");
        Report.SetParameterValue("StrategiesName", btc.ckIdentityName("ckStrategies") ? (!string.IsNullOrEmpty(StrategiesName) ? StrategiesName.Substring(0, StrategiesName.Length - 1) : "") : "");
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("ckSign", Request["ckSign"]);
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");
        Report.SetParameterValue("lblYear2", btc.ckIdentityName("ckBudgetYear") ? "ปีการศึกษา " : "ปีงบประมาณ ");
        Report.SetParameterValue("Resource", ""); //btc.getResourceName(dv[0]["ActivityCode"].ToString()));
        Report.SetParameterValue("ResponsiblePosition", ResponsiblePosition);
        Report.SetParameterValue("SubDeptName", SubDeptName);
        Report.SetParameterValue("Status", Status);
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);

        ExportReport();

        this.Session["ReportSource11"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport12() // รายงานสรุปกิจกรรมและค่าใช้จ่ายทั้งหมดภายใต้โครงการ
    {
        DataView dv, dv1, dv2, dv3, dv4, dv5;
        string StrategicPlan = "";
        string StrSql = @" Select a.*, '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, '' As StrategicName
                From Projects a Where a.DelFlag = 0 And a.ProjectsCode = '{0}' ";
        dv5 = Conn.Select(string.Format(StrSql, id));

        if (dv5.Count != 0)
        {
            dv5[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardName"] = btc.getStandardNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["IndicatorsName"] = btc.getIndicatorsNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StrategicName"] = btc.getStrategicName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            StrategicPlan = dv5[0]["StrategicPlan"].ToString();
        }  

        StrSql = " Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, "
                    + " a.Sort, b.Sort, '' As DeptName, b.MainActivityID, MA.MainActivityName, MA.Sort As MainAcSort "
                    + " From Projects a Left Join Activity b On a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " Left Join MainActivity MA On MA.MainActivityID = b.MainActivityID And MA.DelFlag = 0 "
                    + " Where a.DelFlag = 0 And a.ProjectsCode = '" + id + "' ";
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 1 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv1 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 2 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv2 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 3 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv3 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 5 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv4 = Conn.Select(string.Format(StrSql));

        string IdentityName2 = "";

        StrSql = @" Select I.IdentityName From dtIdentityName dt Inner Join IdentityName I On dt.IdentityNameCode = I.IdentityNameCode
        Where dt.ProjectsCode = '{0}'";
        DataView dv7 = Conn.Select(string.Format(StrSql, id));
        if (dv7.Count != 0)
        {
            for (int i = 0; i < dv7.Count; i++)
            {
                IdentityName2 += dv7[i]["IdentityName"].ToString() + ", ";
            }
        }

        string CorporateStrategyName = "";
        StrSql = @" Select CR.CorporateStrategyID, 'ตัวชี้วัดที่ ' + Cast(S.Sort As nVarChar) + '.' + Cast(CR.Sort As nVarChar) + ' ' + CR.CorporateStrategyName CorporateStrategyName 
        From CorporateStrategy CR Inner Join Strategies S On CR.StrategiesCode = S.StrategiesCode 
        Inner Join dtCorporateStrategy dt On CR.CorporateStrategyID = dt.CorporateStrategyID
        Where dt.ProjectsCode = '{0}' ";

        DataView dv10 = Conn.Select(string.Format(StrSql, id));
        if (dv10.Count != 0)
        {
            for (int i = 0; i < dv10.Count; i++)
            {
                CorporateStrategyName += dv10[i]["CorporateStrategyName"].ToString() + ",";
            }
        }

        string StrategiesName = "";
        StrSql = " Select 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As StrategiesName From dtStrategies a, Strategies b Where a.ProjectsCode = '{0}' And a.StrategiesCode = b.StrategiesCode ";
        DataView dv9 = Conn.Select(string.Format(StrSql, id));
        if (dv9.Count != 0)
        {
            for (int i = 0; i < dv9.Count; i++)
            {
                StrategiesName += dv9[i]["StrategiesName"].ToString() + ",";
            }
        }

        string StrategicPlanName = "";
        StrSql = " Select 'ตัวชี้วัดที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicPlanName As StrategicPlanName From dtStrategicPlan a, StrategicPlan b Where a.ProjectsCode = '{0}' And a.StrategicPlanID = b.StrategicPlanID ";
        DataView dv11 = Conn.Select(string.Format(StrSql, id));
        if (dv11.Count != 0)
        {
            for (int i = 0; i < dv11.Count; i++)
            {
                StrategicPlanName += dv11[i]["StrategicPlanName"].ToString() + ",";
            }
        }

        string StrategicObjectivesName = "";
        StrSql = " Select 'วัตถุประสงค์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicObjectivesName As StrategicObjectivesName From dtStrategicObjectives a, StrategicObjectives b Where a.ProjectsCode = '{0}' And a.StrategicObjectivesCode = b.StrategicObjectivesCode ";
        DataView dv13 = Conn.Select(string.Format(StrSql, id));
        if (dv13.Count != 0)
        {
            for (int i = 0; i < dv13.Count; i++)
            {
                StrategicObjectivesName += dv13[i]["StrategicObjectivesName"].ToString() + ",";
            }
        }

        StrSql = @" Select A.ActivityCode, A.ActivityName, A.Sort, A.ProjectsCode, A.Target, A.Target2, 
            I.Indicators2Code, I.IndicatorsName2, I.Weight, I.WeightType, I.OffAll, I.OffThat, I.APercent, 
            I.CkCriterion, I.EvaAssessment, I.EvaTool, I.Sort As IntSort 
            From Activity A Left Join Indicators2 I On A.ActivityCode = I.ActivityCode 
            Where A.ProjectsCode = '{0}'
            Order By A.Sort, I.Sort ";
        DataView dvAc = Conn.Select(string.Format(StrSql, id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();
        string spnResponsibleName = dvSchool[0]["spnResponsibleName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("BudgetType1"));
        ds.Tables.Add(dv2.ToTable("BudgetType2"));
        ds.Tables.Add(dv3.ToTable("BudgetType3"));
        ds.Tables.Add(dv4.ToTable("BudgetType4"));
        ds.Tables.Add(dv5.ToTable("data1"));
        ds.Tables.Add(dvAc.ToTable("dvAc"));
        ds.Tables.Add(btc.GetLogoImg());
        ds.Tables.Add(btc.GetEmployeeSingnature(id));
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;     

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("PositionManagerName", PositionManagerName);
        Report.SetParameterValue("identityName", btc.ckIdentityName("iNameShow") ? dv5[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", !string.IsNullOrEmpty(IdentityName2) ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");  //btc.ckIdentityName("iNameShow2") ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");
        Report.SetParameterValue("StrategicName", btc.ckIdentityName("ckStrategic") ? dv5[0]["StrategicName"].ToString() : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv5[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv5[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("StrategicPlanName", btc.ckIdentityName("ckStrategicPlan") ? (!string.IsNullOrEmpty(StrategicPlanName) ? StrategicPlanName.Substring(0, StrategicPlanName.Length - 1) : "") : "");
        Report.SetParameterValue("CorporateStrategyName", btc.ckIdentityName("ckCorporateStrategy") ? (!string.IsNullOrEmpty(CorporateStrategyName) ? CorporateStrategyName.Substring(0, CorporateStrategyName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategiesName", btc.ckIdentityName("ckStrategies") ? (!string.IsNullOrEmpty(StrategiesName) ? StrategiesName.Substring(0, StrategiesName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategicObjectivesName", btc.ckIdentityName("ckStrategicObjectives") ? (!string.IsNullOrEmpty(StrategicObjectivesName) ? StrategicObjectivesName.Substring(0, StrategicObjectivesName.Length - 1) : "") : "");
        Report.SetParameterValue("spnResponsibleName", spnResponsibleName);
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("ckSign", Request["ckSign"]);
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);
        Report.SetParameterValue("StrategicPlan", StrategicPlan);
        Report.SetParameterValue("CreateProjectsName", btc.getEmpName(dv5[0]["CreateUser"].ToString()));
        Report.SetParameterValue("ResponsibleName", dv5[0]["ResponsibleName"].ToString());
        Report.SetParameterValue("StandardNew", btc.ckIdentityName("ckStandardNew") ? "1" : ""); // โหมดมาตรฐานใหม่
        string SideName = btc.getSideNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
        Report.SetParameterValue("SideName", SideName);
        ExportReport();

        this.Session["ReportSource12"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport13() // รายงาน Sar
    {
        DataView dv = null, dv1 = null, dv2 = null, dv3 = null, dv4 = null, dv5 = null;
        
        string strSql = " Select z.SideCode, z.SideName, z.Sort As SortSide, a.StandardCode, a.StandardName, a.Sort As SortStd, "
        + " b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.Sort As SortInt, b.ScoreGroupID, "
        + " d.ProjectsCode, d.ProjectsName, d.EvaTool, e.ActivityCode, e.ActivityName, "
        + " f.Indicators2Code, f.IndicatorsName2, c.OffAll, c.OffThat, c.APercent, 0.00 As pjPercent, 0 As ckScore, '' As ckTranslation "
        + " From Side z Left Join Standard a On z.SideCode = a.SideCode "
        + " Left Join Indicators b On a.StandardCode = b.StandardCode "
        + " Left Join Evaluation c On c.IndicatorsCode = b.IndicatorsCode And c.StandardCode = a.StandardCode "
        + " Inner Join Projects d On c.ProjectsCode = d.ProjectsCode "
        + " Inner Join Activity e On c.ActivityCode = e.ActivityCode "
        + " Inner Join Indicators2 f On c.Indicators2Code = f.Indicators2Code "
        + " Where a.DelFlag = 0 And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And d.DelFlag = 0 And e.DelFlag = 0 And f.DelFlag = 0 "
        + " And z.StudyYear = '" + YearB + "' And d.StudyYear = '" + YearB + "' And c.SchoolID = '" + CurrentUser.SchoolID + "'";
        if (!string.IsNullOrEmpty(DeptID))
        {
            strSql = " Select z.SideCode, z.SideName, z.Sort As SortSide, a.StandardCode, a.StandardName, a.Sort As SortStd, "
          + " b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.Sort As SortInt, b.ScoreGroupID, "
          + " d.ProjectsCode, d.ProjectsName, d.EvaTool, e.ActivityCode, e.ActivityName, "
          + " f.Indicators2Code, f.IndicatorsName2, c.OffAll, c.OffThat, c.APercent, 0.00 As pjPercent, 0 As ckScore, '' As ckTranslation "
          + " From Side z Left Join Standard a On z.SideCode = a.SideCode "
          + " Left Join Indicators b On a.StandardCode = b.StandardCode "
          + " Left Join Evaluation c On c.IndicatorsCode = b.IndicatorsCode And c.StandardCode = a.StandardCode "
          + " Inner Join Projects d On c.ProjectsCode = d.ProjectsCode "
          + " Inner Join Activity e On c.ActivityCode = e.ActivityCode "
          + " Inner Join dtAcDept y On c.ActivityCode = y.ActivityCode "
          + " Inner Join Indicators2 f On c.Indicators2Code = f.Indicators2Code "
          + " Where a.DelFlag = 0 And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And d.DelFlag = 0 And e.DelFlag = 0 And f.DelFlag = 0 "
          + " And z.StudyYear = '" + YearB + "' And d.StudyYear = '" + YearB + "' And c.SchoolID = '" + CurrentUser.SchoolID + "'"
          + " And y.DeptCode = '" + DeptID + "' ";
        }
        if (!string.IsNullOrEmpty(EmpID))
        {
            if (string.IsNullOrEmpty(DeptID))
            {
                strSql = " Select z.SideCode, z.SideName, z.Sort As SortSide, a.StandardCode, a.StandardName, a.Sort As SortStd, "
              + " b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.Sort As SortInt, b.ScoreGroupID, "
              + " d.ProjectsCode, d.ProjectsName, d.EvaTool, e.ActivityCode, e.ActivityName, "
              + " f.Indicators2Code, f.IndicatorsName2, c.OffAll, c.OffThat, c.APercent, 0.00 As pjPercent, 0 As ckScore, '' As ckTranslation "
              + " From Side z Left Join Standard a On z.SideCode = a.SideCode "
              + " Left Join Indicators b On a.StandardCode = b.StandardCode "
              + " Left Join Evaluation c On c.IndicatorsCode = b.IndicatorsCode And c.StandardCode = a.StandardCode "
              + " Inner Join Projects d On c.ProjectsCode = d.ProjectsCode "
              + " Inner Join Activity e On c.ActivityCode = e.ActivityCode "
              + " Inner Join dtAcEmp y On c.ActivityCode = y.ActivityCode "
              + " Inner Join Indicators2 f On c.Indicators2Code = f.Indicators2Code "
              + " Where a.DelFlag = 0 And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And d.DelFlag = 0 And e.DelFlag = 0 And f.DelFlag = 0 "
              + " And z.StudyYear = '" + YearB + "' And d.StudyYear = '" + YearB + "' And c.SchoolID = '" + CurrentUser.SchoolID + "'"
              + " And y.EmpCode = '" + EmpID + "' ";
            }
            else
            {
                strSql = " Select z.SideCode, z.SideName, z.Sort As SortSide, a.StandardCode, a.StandardName, a.Sort As SortStd, "
                + " b.IndicatorsCode, b.IndicatorsName, b.WeightScore, b.Sort As SortInt, b.ScoreGroupID, "
                + " d.ProjectsCode, d.ProjectsName, d.EvaTool, e.ActivityCode, e.ActivityName, "
                + " f.Indicators2Code, f.IndicatorsName2, c.OffAll, c.OffThat, c.APercent, 0.00 As pjPercent, 0 As ckScore, '' As ckTranslation "
                + " From Side z Left Join Standard a On z.SideCode = a.SideCode "
                + " Left Join Indicators b On a.StandardCode = b.StandardCode "
                + " Left Join Evaluation c On c.IndicatorsCode = b.IndicatorsCode And c.StandardCode = a.StandardCode "
                + " Inner Join Projects d On c.ProjectsCode = d.ProjectsCode "
                + " Inner Join Activity e On c.ActivityCode = e.ActivityCode "
                + " Inner Join dtAcEmp y On c.ActivityCode = y.ActivityCode "
                + " Inner Join dtAcDept x On c.ActivityCode = x.ActivityCode "
                + " Inner Join Indicators2 f On c.Indicators2Code = f.Indicators2Code "
                + " Where a.DelFlag = 0 And a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 And d.DelFlag = 0 And e.DelFlag = 0 And f.DelFlag = 0 "
                + " And z.StudyYear = '" + YearB + "' And d.StudyYear = '" + YearB + "' And c.SchoolID = '" + CurrentUser.SchoolID + "'"
                + " And y.EmpCode = '" + EmpID + "' And x.DeptCode = '" + DeptID + "' ";
            }
        }
        dv = Conn.Select(string.Format(strSql + " Order By z.Sort, a.Sort, b.Sort "));

        double CkCriterion = 0;
        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (!string.IsNullOrEmpty(DeptID))
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.DeptCode = '" + DeptID + "' ";
            }
            if (!string.IsNullOrEmpty(EmpID))
            {
                if (string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' ";
                }
                else
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                        + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                        + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                        + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                }
            }
            dv1 = Conn.Select(strSql + " Group By a.ProjectsCode ");

            double PjPercent = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (!string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                }
                if (!string.IsNullOrEmpty(EmpID))
                {
                    if (string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                    }
                    else
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                                + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                    }
                }
                dv2 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                double AcPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (!string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                    }
                    if (!string.IsNullOrEmpty(EmpID))
                    {
                        if (string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                        }
                        else
                        {
                            strSql = " Select a.ActivityCode "
                                + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                                + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                        }
                    }
                    dv3 = Conn.Select(strSql);

                    if (dv3.Count != 0)
                    {
                        AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (Convert.ToDouble(dv3.Count) * 100);
                    }
                    else
                    {
                        AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (1 * 100);
                    }
                }
                if (dv2.Count != 0)
                {
                    PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
                }
                else
                {
                    PjPercent += (AcPercent * 100) / (1 * 100);
                }
            }
            if (dv1.Count != 0)
            {
                CkCriterion = (PjPercent * 100) / (Convert.ToDouble(dv1.Count) * 100);
            }
            else
            {
                CkCriterion = 0;
            }

            double avg = 0;
            avg = CkCriterion;

            double hScore = 0;
            hScore = (avg * Convert.ToDouble(dv[i]["WeightScore"])) / 100;

            //เช็คการประเมินเชิงคุณภาพ
            hScore = btc.getQuality(dv[i]["IndicatorsCode"].ToString(), hScore);

            string[] Tcriterion = new BTC().ckTCriteria(dv[i]["ScoreGroupID"].ToString(), hScore).Split(':');
            dv[i]["ckScore"] = Convert.ToDouble(Tcriterion[0]);
            dv[i]["ckTranslation"] = Tcriterion[1].ToString();
        }

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                strSql = " Select a.ActivityCode, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (!string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ActivityCode, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + DeptID + "' ";
                }
                if (!string.IsNullOrEmpty(EmpID))
                {
                    if (string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode, Sum(b.APercent) CkAPercent "
                                + " From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' ";
                    }
                    else
                    {
                        strSql = " Select a.ActivityCode, Sum(b.APercent) CkAPercent "
                                + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                    }
                }
                dv4 = Conn.Select(string.Format(strSql + " Group By a.ActivityCode "));

                if (dv4.Count > 0)
                {
                    double AcPercent2 = 0;
                    for (int j = 0; j < dv4.Count; j++)
                    {
                        strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv4[j]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                        if (!string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcDept c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv4[j]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.DeptCode = '" + DeptID + "' ";
                        }
                        if (!string.IsNullOrEmpty(EmpID))
                        {
                            if (string.IsNullOrEmpty(DeptID))
                            {
                                strSql = " Select a.ActivityCode "
                                + " From Activity a, Evaluation b, dtAcEmp c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                                + " And b.ActivityCode = '" + dv4[j]["ActivityCode"].ToString() + "' "
                                + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' ";
                            }
                            else
                            {
                                strSql = " Select a.ActivityCode "
                                    + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                    + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' "
                                    + " And b.ActivityCode = '" + dv4[j]["ActivityCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                            }
                        }
                        dv5 = Conn.Select(strSql);
                        if (dv5.Count != 0)
                        {
                            AcPercent2 += (Convert.ToDouble(dv4[j]["CkAPercent"]) * 100) / (Convert.ToDouble(dv5.Count) * 100);
                        }
                        else
                        {
                            AcPercent2 += (Convert.ToDouble(dv4[j]["CkAPercent"]) * 100) / (1 * 100);
                        }
                    }
                    if (dv4.Count != 0)
                    {
                        dv[i]["pjPercent"] = (AcPercent2 * 100) / (Convert.ToDouble(dv4.Count) * 100);
                    }
                    else
                    {
                        dv[i]["pjPercent"] = (AcPercent2 * 100) / (1 * 100);
                    }
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource13"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport14()  //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน
    {
        string StrSql = "";
        DataView dv;
        //if (id == "")
        //{
        //    if (DeptID == "")
        //    {
        //        StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear,'โครงการ' + a.ProjectsName As FullName, a.Df, "
        //                + " a.Sort, b.Sort Sort1, b.StrategiesName, IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
        //                + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, '' As AcCode, "
        //                + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
        //                + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
        //                + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
        //                + " Where a.DelFlag = 0 And c.DelFlag = 0 And a.StudyYear = '" + YearB + "' "
        //                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //    }
        //    else
        //    {
        //        StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear,'โครงการ' + a.ProjectsName As FullName, a.Df, "
        //                + " a.Sort, b.Sort Sort1, b.StrategiesName, IsNull(Sum(c.TotalAmount), 0) TotalAmount1, "
        //                + " IsNull(Sum(c.TotalAmount2), 0) TotalAmount2, '' As AcCode, "
        //                + " (IsNull(Sum(c.TotalAmount), 0) - IsNull(Sum(c.TotalAmount2), 0)) TotalBalance "
        //                + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
        //                + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
        //                + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
        //                + " Where a.DelFlag = 0 And c.DelFlag = 0 And a.StudyYear = '" + YearB + "' "
        //                + " And d.DeptCode = '" + DeptID + "' "
        //                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        //    }
        //}
        //else
        //{
            if (DeptID == "")
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                        + " IsNull(c.TotalAmount, 0) TotalAmount1, "
                        + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
                        + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                        + " Where a.DelFlag = 0 And c.DelFlag = 0 And a.IsApprove = 1 "
                        + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                }                
            }
            else
            {
                StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
                        + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                        + " IsNull(c.TotalAmount, 0) TotalAmount1, "
                        + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
                        + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' DeptName "
                        + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                        + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode And c.DeptCode = '" + DeptID + "' "
                        + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                        + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                        + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And d.DeptCode = '" + DeptID + "' "
                        + "   ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                }         
            }
            if (id != "")
            {
                  StrSql = StrSql + " And a.ProjectsCode = '" + id + "'";
            }
        //}

        //if (id == "")
        //{
        //    StrSql = StrSql + " Group By a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.ProjectsDetail, a.Df, a.Sort, b.Sort, b.StrategiesName ";
        //}
        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["AcCode"].ToString());
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataBudget"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("deptName", (DeptID != "") ? btc.getDeptName(DeptID) : "");
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource14"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport15() // รายงานสรุปกิจกรรมและค่าใช้จ่ายตามหน่วยงาน
    {
        DataView dv, dv1, dv2, dv3, dv4;

        string strNotPATWit = " And MainSubDeptCode In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        if (CurrentUser.MainDeptID.ToUpper() == "BA422CC9-6E77-4D43-BAFB-7539B9286E59")
        {
            strNotPATWit = " And MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        }

        string StrSql = " Select DeptCode, DeptName, "
                    + " 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Other "
                    + " From Department Where DelFlag = 0 {0} ";
        dv = Conn.Select(string.Format(StrSql, strNotPATWit));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                StrSql = " Select a.DeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 1 "
                    + " And a.DeptCode = '" + dv[i]["DeptCode"].ToString() + "' ";
                
                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv1 = Conn.Select(StrSql + " Group By a.DeptCode ");

                StrSql = " Select a.DeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 2 "
                    + " And a.DeptCode = '" + dv[i]["DeptCode"].ToString() + "' ";
                
                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv2 = Conn.Select(StrSql + " Group By a.DeptCode ");

                StrSql = " Select a.DeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 3 "
                    + " And a.DeptCode = '" + dv[i]["DeptCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv3 = Conn.Select(StrSql + " Group By a.DeptCode ");

                StrSql = " Select a.DeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 5 "
                    + " And a.DeptCode = '" + dv[i]["DeptCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv4 = Conn.Select(StrSql + " Group By a.DeptCode ");

                if (dv1.Count > 0)
                {
                    dv[i]["Subsidies"] = Convert.ToDecimal(dv1[0]["TotalMoney"]);
                }
                if (dv2.Count > 0)
                {
                    dv[i]["Revenue"] = Convert.ToDecimal(dv2[0]["TotalMoney"]);
                }
                if (dv3.Count > 0)
                {
                    dv[i]["Free"] = Convert.ToDecimal(dv3[0]["TotalMoney"]);
                }
                if (dv4.Count > 0)
                {
                    dv[i]["Other"] = Convert.ToDecimal(dv4[0]["TotalMoney"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource15"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport16() // เบิกย่อย
    {
        DataView dv, dv1, dv2, dv3, dv4;
        decimal TotalAmount = 0;
        string ActivityDetail = "";


        string strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.BudgetYear, "
            + " b.ActivityDetailCode, b.TDay, '' As DeptName,  IsNull(b.Sort, 0) As AcDSort, b.ActivityDetail, c.ProjectsName, "
            + " b.ResponsibleName, b.PositionResponsible, b.HeadGroupName, b.PositionHeadGroup, b.HeadGroupSaraName, b.PositionHeadGroupSara "
            + " From Activity a, ActivityDetail b, Projects c "
            + " Where a.DelFlag = 0 And b.DelFlag = 0 And b.ActivityDetailCode = '" + id + "'"
            + " And a.ActivityCode = b.ActivityCode And a.ProjectsCode = c.ProjectsCode ";
        dv = Conn.Select(string.Format(strSql));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
            ActivityDetail = dv[0]["ActivityDetail"].ToString();
        }

        strSql = @" Select a.ActivityCode, a.ListName, a.ListName As EntryCostsCode, a.BudgetTypeCode, 
            a.TotalP, a.TotalD, IsNull(e.Cost, 0) As TotalG, a.TotalMoney, a.TotalMoney2, 
            BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, 
            a.ListName As EntryCostsName, IsNull(e.TotalMoney,0) ValueT, IsNull(e.TotalDD, 0) TotalDD, '' TotalMoney2Ag 
            From CostsDetail a, BudgetType b, ActivityDetail d, ActivityCostsDetail e 
            Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = d.ActivityCode And d.ActivityDetailCode = e.ActivityDetailCode 
            And a.ItemID = e.ItemID 
            And e.ActivityDetailCode = '{0}' Order By a.ListNo, b.Sort ";
        dv1 = Conn.Select(string.Format(strSql, id));
        if (dv1.Count != 0)
        { 
            for(int i = 0;i<dv1.Count;i++)
            {
                TotalAmount += Convert.ToDecimal(dv1[i]["ValueT"]);
            }
        }

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End, "
                + " Sum(a.TotalMoney) Money1, 0.0 As Money2, 0.0 As Money3, b.Sort "
                + " From CostsDetail a, BudgetType b "
                + " Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode "
                + " And a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName, Sort ";
        dv2 = Conn.Select(string.Format(strSql + " Order By b.Sort ", id));

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, Sum(IsNull(e.TotalMoney,0)) ValueT, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End "
                + " From CostsDetail a, BudgetType b, ActivityDetail d, ActivityCostsDetail e "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = d.ActivityCode "
                + " And d.ActivityDetailCode = e.ActivityDetailCode "
                + " And a.ItemID = e.ItemID "
                + " And a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' And e.ActivityDetailCode = '{0}' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName ";
        dv3 = Conn.Select(string.Format(strSql, id));

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, Sum(IsNull(e.TotalMoney,0)) ValueT, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End "
                + " From CostsDetail a Left Join BudgetType b On a.BudgetTypeCode = b.BudgetTypeCode "
                + " Left Join ActivityDetail d On a.ActivityCode = d.ActivityCode "
                + " Left Join ActivityCostsDetail e On d.ActivityDetailCode = e.ActivityDetailCode And a.ItemID = e.ItemID "
                + " And e.ActivityDetailCode Not In ('{0}') And d.Sort < {1} "
                + " Where a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName ";
        dv4 = Conn.Select(string.Format(strSql, id, Convert.ToInt32(dv[0]["AcDSort"])));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(dv1.ToTable("Costs"));
        ds.Tables.Add(dv2.ToTable("dtBudgetType"));
        ds.Tables.Add(dv3.ToTable("dtBudgetOut"));
        ds.Tables.Add(dv4.ToTable("dtBudgetUse"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("PositionManagerName", PositionManagerName);
        Report.SetParameterValue("TotalAmount", TotalAmount);
        Report.SetParameterValue("ActivityDetail", ActivityDetail);
        Report.SetParameterValue("ManagerSaraGroupName", btc.SchoolFieldName("ManagerSaraGroupName", CurrentUser.SchoolID));
        
        //หัวหน้างานนโยบายและแผน
        string ManagerPlanName = "", PositionPlanName = "";
        string [] strPlan = btc.SchoolFieldName("ManagerPlanName", CurrentUser.SchoolID).Split(':');
        ManagerPlanName = strPlan[0];
        PositionPlanName = strPlan[1];
        Report.SetParameterValue("ManagerPlanName", ManagerPlanName);
        Report.SetParameterValue("PositionPlanName", PositionPlanName);
        
        //หัวหน้างานพัสดุ
        string ManagerSuppliesName = "", PositionSuppliesName = "";
        string[] strSupplies = btc.SchoolFieldName("ManagerSuppliesName", CurrentUser.SchoolID).Split(':');
        ManagerSuppliesName = strSupplies[0];
        PositionSuppliesName = strSupplies[1];
        Report.SetParameterValue("ManagerSuppliesName", ManagerSuppliesName);
        Report.SetParameterValue("PositionSuppliesName", PositionSuppliesName);

        //หัวหน้างานการเงิน
        string ManagerMoneyName = "", PositionMoneyName = "";
        string[] strMoney = btc.SchoolFieldName("ManagerMoneyName", CurrentUser.SchoolID).Split(':');
        ManagerMoneyName = strMoney[0];
        PositionMoneyName = strMoney[1];
        Report.SetParameterValue("ManagerMoneyName", ManagerMoneyName);
        Report.SetParameterValue("PositionMoneyName", PositionMoneyName);

        //รอง ผอ. กลุ่มบริหารงานงบประมาณ
        string UnderBudgetName = "", PositionManagerBudgetName = "";
        string[] strBudget = btc.SchoolFieldName("UnderBudgetName", CurrentUser.SchoolID).Split(':');
        UnderBudgetName = strBudget[0];
        PositionManagerBudgetName = strBudget[1];
        Report.SetParameterValue("UnderBudgetName", UnderBudgetName);
        Report.SetParameterValue("PositionManagerBudgetName", PositionManagerBudgetName);

        //ผู้รับผิดชอบกิจกรรม
        //string PositionResponsible = "";
        //string[] strResponsible = btc.SchoolFieldName("Responsible", CurrentUser.SchoolID).Split(':');
        //PositionResponsible = strResponsible[1];
        Report.SetParameterValue("ResponsibleName", dv[0]["ResponsibleName"].ToString());
        Report.SetParameterValue("PositionResponsible", (!string.IsNullOrEmpty(dv[0]["PositionResponsible"].ToString()) ? dv[0]["PositionResponsible"].ToString() : "ผู้รับผิดชอบกิจกรรม"));

        //หัวหน้างาน / กลุ่มสาระ
        //string PositionHeadGroupSara = "";
        //string[] strHeadGroupSara = btc.SchoolFieldName("HeadGroupSara", CurrentUser.SchoolID).Split(':');
        //PositionHeadGroupSara = strHeadGroupSara[1];
        Report.SetParameterValue("HeadGroupSaraName", dv[0]["HeadGroupSaraName"].ToString());
        Report.SetParameterValue("PositionHeadGroupSara", (!string.IsNullOrEmpty(dv[0]["PositionHeadGroupSara"].ToString()) ? dv[0]["PositionHeadGroupSara"].ToString() : "หัวหน้างาน/กลุ่มสาระฯ"));

        //หัวหน้ากลุ่มงาน
        //string PositionHeadGroup = "";
        //string[] strHeadGroup = btc.SchoolFieldName("HeadGroup", CurrentUser.SchoolID).Split(':');
        //PositionHeadGroup = strHeadGroup[1];
        Report.SetParameterValue("HeadGroupName", dv[0]["HeadGroupName"].ToString());
        Report.SetParameterValue("PositionHeadGroup", (!string.IsNullOrEmpty(dv[0]["PositionHeadGroup"].ToString()) ? dv[0]["PositionHeadGroup"].ToString() : "หัวหน้ากลุ่มงาน"));

        Report.SetParameterValue("ProjectsName", dv[0]["ProjectsName"].ToString());
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource16"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }  //ใบเบิกรายการย่อย
    private void SetReport17()  //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรมทุกหน่วยงาน เรียงตามหน่วยงาน
    {
        string StrSql = "";
        DataView dv;

        StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
                    + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                    + " IsNull(c.TotalAmount, 0) TotalAmount1, "
                    + " IsNull(c.TotalAmount2, 0) TotalAmount2, "
                    + " (IsNull(c.TotalAmount, 0) - IsNull(c.TotalAmount2, 0)) TotalBalance, '' DeptName, d.DeptCode, '' HDeptName "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 And a.IsApprove = 1 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = d.DeptCode ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And c.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And c.BudgetYear = '" + YearB + "' ";
            }
        }        
        if (id != "")
        {
            StrSql = StrSql + " And a.ProjectsCode = '" + id + "'";
        }
        //}

        //if (id == "")
        //{
        //    StrSql = StrSql + " Group By a.ProjectsCode, a.StrategiesCode, a.StudyYear, a.ProjectsName, a.ProjectsDetail, a.Df, a.Sort, b.Sort, b.StrategiesName ";
        //}
        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["AcCode"].ToString());
            dv[j]["HDeptName"] = btc.getDeptName(dv[j]["DeptCode"].ToString());
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataBudget"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("deptName", (DeptID != "") ? btc.getDeptName(DeptID) : "");
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource17"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport18() //รายหัวประถม
    {
        DataView dv;
        
        
        string strSql = " Select a.StudyYear, b.P1No, b.P1Value, b.P2No, b.P2Value, b.P3No, b.P3Value, "
                + " b.P4No, b.P4Value, b.P5No, b.P5Value, b.P6No, b.P6Value "
                + " From Income a, IncomeDetail b "
                + " Where a.IncomeCode = b.IncomeCode And a.DelFlag = 0 And a.IncomeCode = '" + id + "'";
        dv = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource18"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport19() //รายหัวมัธยม
    {
        DataView dv;
        
        
        string strSql = " Select a.StudyYear, b.M1No, b.M1Value, b.M2No, b.M2Value, b.M3No, b.M3Value, "
                + " b.M4No, b.M4Value, b.M5No, b.M5Value, b.M6No, b.M6Value "
                + " From Income a, IncomeDetail b "
                + " Where a.IncomeCode = b.IncomeCode And a.DelFlag = 0 And a.IncomeCode = '" + id + "'";
        dv = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource19"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport20() //รายหัวอนุบาล
    {
        DataView dv;
        
        
        string strSql = " Select a.StudyYear, b.A1No, b.A1Value, b.A2No, b.A2Value, b.A3No, b.A3Value "
                + " From Income a, IncomeDetail b "
                + " Where a.IncomeCode = b.IncomeCode And a.DelFlag = 0 And a.IncomeCode = '" + id + "'";
        dv = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource20"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport21() //รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา
    {
        
        DataView dv, dv1, dv2, dv3;
        

        string strSQL = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
            + " b.ProjectsCode, b.ProjectsName, c.ActivityCode, c.ActivityName, "
            + " c.Purpose, c.Target, c.Target2, '' As StandardName, a.Sort As StgSort, b.Sort As PrjSort, c.Sort As AcSort "
            + " From Strategies a Left Join dtStrategies dtS On a.StrategiesCode = dtS.StrategiesCode "
            + " Left Join Projects b On dtS.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
            + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode  "
            + " Where a.DelFlag = 0 And c.DelFlag = 0 And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + YearB + "' ";
        if(!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.StrategiesCode = '" + id + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["StandardName"] = btc.getStandardName(false, dv[i]["ActivityCode"].ToString()).Replace("ตัวบ่งชี้ที่ ", "");
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource21"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport22()  //รายงานผลการดำเนินงานตามมาตรฐานการศึกษาของสถานศึกษา
    {
        
        DataTable dt = new DataTable();
        dt.Columns.Add("SideCode", typeof(string));
        dt.Columns.Add("SideName", typeof(string));
        dt.Columns.Add("StandardCode", typeof(string));
        dt.Columns.Add("StandardName", typeof(string));
        dt.Columns.Add("IndicatorsCode", typeof(string));
        dt.Columns.Add("IndicatorsName", typeof(string));
        dt.Columns.Add("WeightScore", typeof(double));
        dt.Columns.Add("Score", typeof(double));
        dt.Columns.Add("ScoreStd", typeof(decimal));
        dt.Columns.Add("Translation", typeof(string));
        dt.Columns.Add("Grade", typeof(int));
        dt.Columns.Add("GradeStd", typeof(int));
        dt.Columns.Add("SortSd", typeof(int));
        dt.Columns.Add("Sort", typeof(int));
        dt.Columns.Add("Sort2", typeof(int));

        DataView dv, dv1, dv2, dv3;
        

        string strSql = " Select z.SideCode, z.SideName, a.StandardCode, a.StandardName, a.Sort, b.IndicatorsCode, "
                    + " b.IndicatorsName, b.WeightScore, b.Sort Sort2, z.Sort SortSd, b.ScoreGroupID, a.ScoreGroupID StdScoreGroupID "
                    + " From Side z Left Join Standard a On z.SideCode = a.SideCode "
                    + " Left Join Indicators b On a.StandardCode = b.StandardCode "
                    + " Where z.DelFlag = 0 And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + BudgetYear + "' "
                    + " Order By z.Sort, a.Sort, b.Sort ";
        dv = Conn.Select(strSql);

        double CkCriterion = 0;

        for (int i = 0; i < dv.Count; i++)
        {
            strSql = " Select a.ProjectsCode From Activity a, Evaluation b "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
            if (!string.IsNullOrEmpty(DeptID))
            {
                strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcDept c "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.DeptCode = '" + DeptID + "' ";
            }
            if (!string.IsNullOrEmpty(EmpID))
            {
                if (string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c "
                                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                                    + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                    + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                    + " And c.EmpCode = '" + EmpID + "' ";
                }
                else
                {
                    strSql = " Select a.ProjectsCode From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                        + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                        + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                }
            }
            dv1 = Conn.Select(strSql + " Group By a.ProjectsCode ");

            double PjPercent = 0;
            for (int j = 0; j < dv1.Count; j++)
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode  "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                if (!string.IsNullOrEmpty(DeptID))
                {
                    strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                }
                if (!string.IsNullOrEmpty(EmpID))
                {
                    if (string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                    }
                    else
                    {
                        strSql = " Select a.ActivityCode, a.ActivityName, a.Sort, Sum(b.APercent) CkAPercent "
                                + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                    }
                }
                dv2 = Conn.Select(strSql + " Group By a.ActivityCode, a.ActivityName, a.Sort Order By a.Sort");

                double AcPercent = 0;
                for (int k = 0; k < dv2.Count; k++)
                {
                    strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";
                    if (!string.IsNullOrEmpty(DeptID))
                    {
                        strSql = " Select a.ActivityCode "
                        + " From Activity a, Evaluation b, dtAcDept c "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                        + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                        + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                        + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.DeptCode = '" + DeptID + "' ";
                    }
                    if (!string.IsNullOrEmpty(EmpID))
                    {
                        if (string.IsNullOrEmpty(DeptID))
                        {
                            strSql = " Select a.ActivityCode "
                            + " From Activity a, Evaluation b, dtAcEmp c "
                            + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode And a.ActivityCode = c.ActivityCode "
                            + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                            + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                            + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' ";
                        }
                        else
                        {
                            strSql = " Select a.ActivityCode "
                                + " From Activity a, Evaluation b, dtAcEmp c, dtAcDept d "
                                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.ActivityCode = b.ActivityCode "
                                + " And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                                + " And b.IndicatorsCode = '" + dv[i]["IndicatorsCode"].ToString() + "' And a.ProjectsCode = '" + dv1[j]["ProjectsCode"].ToString() + "' "
                                + " And b.ActivityCode = '" + dv2[k]["ActivityCode"].ToString() + "' "
                                + " And b.StudyYear = '" + BudgetYear + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                                + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
                        }
                    }
                    dv3 = Conn.Select(strSql);

                    AcPercent += (Convert.ToDouble(dv2[k]["CkAPercent"]) * 100) / (Convert.ToDouble(dv3.Count) * 100);
                }

                PjPercent += (AcPercent * 100) / (Convert.ToDouble(dv2.Count) * 100);
            }

            if (dv1.Count != 0)
            {
                CkCriterion = (PjPercent * 100) / (Convert.ToDouble(dv1.Count) * 100);
            }
            else
            {
                CkCriterion = 0;
            }

            double avg = 0;
            avg = CkCriterion;

            double hScore = 0;
            hScore = (avg * Convert.ToDouble(dv[i]["WeightScore"])) / 100;

            //เช็คการประเมินเชิงคุณภาพ
            hScore = btc.getQuality(dv[i]["IndicatorsCode"].ToString(), hScore);

            string[] Tcriterion = new BTC().ckTCriteria(dv[i]["ScoreGroupID"].ToString(), hScore).Split(':');
            double ckScore = Convert.ToDouble(Tcriterion[0]);
            string ckTranslation = Tcriterion[1].ToString();

            DataRow dr = dt.NewRow();
            dr["SideCode"] = dv[i]["SideCode"].ToString();
            dr["SideName"] = dv[i]["SideName"].ToString();
            dr["StandardCode"] = dv[i]["StandardCode"].ToString();
            dr["StandardName"] = dv[i]["StandardName"].ToString();
            dr["IndicatorsCode"] = dv[i]["IndicatorsCode"].ToString();
            dr["IndicatorsName"] = dv[i]["IndicatorsName"].ToString();
            dr["WeightScore"] = dv[i]["WeightScore"];
            dr["Score"] = Convert.ToDouble(Convert.ToDouble(hScore).ToString("#,##0.00"));
            dr["Translation"] = ckTranslation;
            dr["Grade"] = ckScore;
            dr["SortSd"] = dv[i]["SortSd"];
            dr["Sort"] = dv[i]["Sort"];
            dr["Sort2"] = dv[i]["Sort2"];
            dt.Rows.Add(dr);
        }

        DataView dvStd = Conn.Select("Select StandardCode, StandardName, StudyYear, ScoreGroupID From Standard Where DelFlag = 0 And StudyYear = '" + BudgetYear + "'");
        if (dvStd.Count != 0)
        {
            for (int i = 0; i < dvStd.Count; i++)
            {
                object sumScore;
                sumScore = dt.Compute("Sum(Score)", "StandardCode = '" + dvStd[i]["StandardCode"].ToString() + "'");
                if (!string.IsNullOrEmpty(sumScore.ToString()))
                {
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        if (dvStd[i]["StandardCode"].ToString() == dt.Rows[j]["StandardCode"].ToString())
                        {
                            dt.Rows[j]["ScoreStd"] = Convert.ToDecimal(sumScore);

                            string[] TcriterionStd = new BTC().ckTCriteria(dvStd[i]["ScoreGroupID"].ToString(), Convert.ToDouble(sumScore)).Split(':');
                            dt.Rows[j]["GradeStd"] = Convert.ToInt32(TcriterionStd[0]);
                        }
                    }
                }
            }
        }

        DataSet ds = new DataSet("data1");
        ds.Tables.Add(dt);
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));
        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        string EmpName = btc.getEmpName(EmpID);
        string DeptName = btc.getDeptName(DeptID);

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("EmpName", EmpName);
        Report.SetParameterValue("DeptName", DeptName);

        ExportReport();

        this.Session["ReportSource22"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport23()  //รายงานต้นทุนผลผลิต
    {
        DataView dv, dv1 = null;
        
        

        string strSql = "Select ActivityCode, ActivityName, IsNull(VolumeExpect, 0) VolumeExpect, IsNull(VolumeCan, 0) VolumeCan, "
                    + " IsNull(TotalAmount, 0) TotalAmount, IsNull(TotalAmount2, 0) TotalAmount2, '' DeptName, '' EmpName, StudyYear "
                    + " From Activity "
                    + " Where ActivityCode = '" + id + "' ";

        dv = Conn.Select(string.Format(strSql));
        if (dv.Count != 0)
        {
            dv[0]["DeptName"] = btc.getAcDeptName(dv[0]["ActivityCode"].ToString());
            dv[0]["EmpName"] = btc.getAcEmpName(dv[0]["ActivityCode"].ToString());
        }

        strSql = "Select a.BudgetTypeCode, a.BudgetTypeName, a.Sort, "
                    + " Sum(IsNull(b.TotalMoney, 0)) TotalAmount, Sum(IsNull(b.TotalMoney2, 0)) TotalAmount2 "
                    + " From BudgetType a Left Join CostsDetail b On a.BudgetTypeCode = b.BudgetTypeCode "
                    + " And b.ActivityCode = '" + id + "' "
                    + " Group By a.BudgetTypeCode, a.BudgetTypeName, a.Sort "
                    + " Order By a.Sort ";
        dv1 = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("ActivityDetail"));
        ds.Tables.Add(dv1.ToTable("BudgetDetail"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);

        ExportReport();

        this.Session["ReportSource23"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport25() // รายงานมาตรฐานทั้งหมด
    {
        DataView dv;
        string StrSql = @"Select a.SideCode, a.SideName, a.Sort, 
            b.StandardCode, b.StandardName, b.Sort, 
            c.IndicatorsCode, c.IndicatorsName, c.WeightScore, c.Sort 
            From Side a Left Join Standard b On a.SideCode = b.SideCode 
            Left Join Indicators c On b.StandardCode = c.StandardCode 
            Where a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 
            And a.StudyYear = '" + YearB + "' And b.StudyYear = '" + YearB + "' ";

        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort, c.Sort "));

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("StandardDetail"));

        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        ExportReport();

        this.Session["ReportSource25"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport26() // รายงานรายละเอียดโรงเรียน
    {
        DataView dv, dv1, dv2, dv3;
        string StrSql = @" Select SchoolID, SchoolNo, SchoolName, Address, Tel, Fax, IsPrimaryEdu, IsSecondary, IsHighSc, AreaStudyID, 
                BirthDate, Philosophy, Slogan, Policy, History, StudyYear, IdentityName, Vision, ManagerName, LogoPath, Sort, ProvinceID, SchoolColor, IdentityName2, strTotalArea As TotalArea 
                
                From MR_School Where DelFlag = 0 And SchoolID = '" + CurrentUser.SchoolID + "' ";
        dv = Conn.Select(string.Format(StrSql));

        StrSql = "Select * From Mission Where DelFlag = 0 And StudyYear = '" + YearB + "' Order By Sort ";
        dv1 = Conn.Select(string.Format(StrSql));

        StrSql = "Select * From Goals Where DelFlag = 0 And StudyYear = '" + YearB + "' Order By Sort ";
        dv2 = Conn.Select(string.Format(StrSql));

        StrSql = "Select * From Strategies Where DelFlag = 0 And StudyYear = '" + YearB + "' Order By Sort ";
        dv3 = Conn.Select(string.Format(StrSql));

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("SchoolDetail"));
        ds.Tables.Add(dv1.ToTable("Mission"));
        ds.Tables.Add(dv2.ToTable("Goals"));
        ds.Tables.Add(dv3.ToTable("Strategies"));
        ds.Tables.Add(btc.GetLogoImg());

        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        ExportReport();

        this.Session["ReportSource26"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport27() // ปฏิทินปฏิบัติงาน
    {
        DataView dv;
        string strSql = " Select ActivityCode, ActivityName, StudyYear, RealSDate As SDate, RealEDate As EDate, '' EmpName, '' DeptName "
                    + " From Activity Where DelFlag = 0  And StudyYear = '" + YearB + "' "
                    + " And SchoolID = '" + CurrentUser.SchoolID + "'";

        if (MonthB != "00")
        { 
            strSql += " And '" + Convert.ToInt32(MonthB) + "' Between Month(RealSDate) And Month(RealEDate) ";
        }

        if (!string.IsNullOrEmpty(DeptID))
        {
            strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                    + " From Activity a, dtAcDept c "
                    + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + DeptID + "' ";

            if (MonthB != "00")
            {
                strSql += " And '" + Convert.ToInt32(MonthB) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
            }
        }
        if (!string.IsNullOrEmpty(EmpID))
        {
            if (string.IsNullOrEmpty(DeptID))
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                        + " From Activity a, dtAcEmp c "
                        + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode "
                        + " And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + EmpID + "' ";

                if (MonthB != "00")
                {
                    strSql += " And '" + Convert.ToInt32(MonthB) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
                }
            }
            else
            {
                strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.RealSDate As SDate, a.RealEDate As EDate, '' EmpName, '' DeptName "
                            + " From Activity a, dtAcEmp c, dtAcDept d "
                            + " Where a.DelFlag = 0 And a.ActivityCode = c.ActivityCode And a.ActivityCode = d.ActivityCode "
                            + " And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";

                if (MonthB != "00")
                {
                    strSql += " And '" + Convert.ToInt32(MonthB) + "' Between Month(a.RealSDate) And Month(a.RealEDate) ";
                }
            }
        }
        dv = Conn.Select(string.Format(strSql + " Order By RealSDate"));

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["EmpName"] = btc.getAcEmpName(dv[i]["ActivityCode"].ToString());
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("monthB", MonthB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource27"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport28() //รายผู้ใช้ระบบ
    {
        DataView dv;     
        string strSql = @" Select a.EmpID, a.UserName, a.EmpName, a.Email, a.Tel, '' DeptName, c.UserRoleName 
            From Employee a Inner Join UserRole c On a.UserRoleID = c.UserRoleId 
            Inner Join EmpDept ED On ED.EmpID = a.EmpID
            Inner Join Department D On D.DeptCode = ED.DeptCode
            Inner Join MainSubDepartment MS On MS.MainSubDeptCode = D.MainSubDeptCode
            Inner Join MainDepartment MD On MD.MainDeptCode = MS.MainDeptCode
            Where a.DelFlag = 0 ";

        if (!string.IsNullOrEmpty(DeptID))
        {
            strSql += " And D.DeptCode = '" + DeptID + "' ";
        }
        if (!string.IsNullOrEmpty(Request.QueryString["subdepid"]))
        {
            strSql += " And MS.MainSubDeptCode = '" + Request.QueryString["subdepid"] + "' ";
        }
        if (!string.IsNullOrEmpty(Request.QueryString["maindeptID"]))
        {
            strSql += " And MD.MainDeptCode = '" + Request.QueryString["maindeptID"] + "' ";
        }
        if (!string.IsNullOrEmpty(Request.QueryString["roleid"]))
        {
            strSql += " And c.UserRoleID = '" + Request.QueryString["roleid"] + "' ";
        }
        if (CurrentUser.RoleLevel == 1)
        {
            strSql += " And a.EmpID = '" + CurrentUser.ID + "' ";
        }
        dv = Conn.Select(string.Format(strSql + " Order By c.RoleLevel Desc, MS.Sort, D.Sort, a.UserName, a.EmpName "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getEmpDeptName(dv[i]["EmpID"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource28"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport29()  //รายงานรายละเอียดแผนการใช้จ่ายเงิน
    {
        string StrSql = "";
        DataView dv, dv1, dv2, dv3, dv4, dv5, dv6, dv7, dv8;
        
        StrSql = " Select a.ProjectsCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, a.Sort As SortPrj, "
            + " c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, c.Sort As SortAct, "
            + " e.DeptCode, e.DeptName, e.Sort As SortDept, '' EmpName "
            + " From Projects a Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
            //+ " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
            + " Left Join Department e On c.DeptCode = e.DeptCode "
            + " Where a.DelFlag = 0 And c.DelFlag = 0 "
            + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And c.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And c.BudgetYear = '" + YearB + "' ";
            }
        }        

            if (DeptID != "")
            {
                StrSql = StrSql + " And c.DeptCode = '" + DeptID + "' ";
            }

            if (id != "")
            {
                StrSql = StrSql + " And a.ProjectsCode = '" + id + "'";
            }
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, c.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            dv[j]["EmpName"] = btc.getAcEmpName(dv[j]["AcCode"].ToString());
        }

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 1 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv1 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 2 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv2 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 3 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv3 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 4 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv4 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 5 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv5 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 6 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv6 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 7 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv7 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        StrSql = " Select a.ActivityCode, a.DeptCode, IsNull(Sum(b.TotalMoney), 0) TotalMoney "
            + " From Activity a Left Join CostsDetail b On a.ActivityCode = b.ActivityCode "
            + " Left Join EntryCosts c On b.EntryCostsCode = c.EntryCostsCode And c.DelFlag = 0 "
            //+ " Left Join dtAcDept d On a.ActivityCode = d.ActivityCode "
            + " Where a.DelFlag = 0 And c.Sort = 8 ";

        if (btc.ckIdentityName("ckBudgetYear"))
        {
            if (YearMode == "0")
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
        }
        else
        {
            if (YearMode == "0")
            {
                StrSql += " And a.StudyYear = '" + YearB + "' ";
            }
            else
            {
                StrSql += " And a.BudgetYear = '" + YearB + "' ";
            }
        }        

        dv8 = Conn.Select(string.Format(StrSql + " Group By a.ActivityCode, a.DeptCode "));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataBudget"));
        ds.Tables.Add(dv1.ToTable("EnCst1"));
        ds.Tables.Add(dv2.ToTable("EnCst2"));
        ds.Tables.Add(dv3.ToTable("EnCst3"));
        ds.Tables.Add(dv4.ToTable("EnCst4"));
        ds.Tables.Add(dv5.ToTable("EnCst5"));
        ds.Tables.Add(dv6.ToTable("EnCst6"));
        ds.Tables.Add(dv7.ToTable("EnCst7"));
        ds.Tables.Add(dv8.ToTable("EnCst8"));
        ds.Tables.Add(btc.GetLogoImg());

        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource29"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport30()  //รายงานงานประจำตามโครงสร้างการบริหารโรงเรียน
    {
        string StrSql = "";
        DataView dv, dv1;

        if (!string.IsNullOrEmpty(DeptID))
        {
            StrSql = " Select a.ActivityCode, a.ProjectsCode, a.ActivityName, a.Purpose, a.StudyYear, "
                + " IsNull(a.VolumeCan, 0) VolumeCan, a.SDate, a.EDate, '' DeptName, '' EmpName, "
                + " 0 As Bursary, 0 As OtherMoney "
                + " From Activity a, dtAcDept b "
                + " Where a.DelFlag = 0 And a.ActivityCode = b.ActivityCode And b.DeptCode = '" + DeptID + "' "
                + " And a.CostsType = 1 And a.StudyYear = '" + YearB + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        }
        else
        {
            StrSql = " Select a.ActivityCode, a.ProjectsCode, a.ActivityName, a.Purpose, a.StudyYear, "
                + " IsNull(a.VolumeCan, 0) VolumeCan, a.SDate, a.EDate, '' DeptName, '' EmpName, "
                + " 0.0 As Bursary, 0.0 As OtherMoney "
                + " From Activity a "
                + " Where a.DelFlag = 0 And a.CostsType = 1 And a.StudyYear = '" + YearB + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        }
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort "));

        for (int i = 0; i < dv.Count; i++)
        {
            dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            dv[i]["EmpName"] = btc.getAcEmpName(dv[i]["ActivityCode"].ToString());
            
            //หาเงินอุดหนุน
           StrSql = " Select IsNull(Sum(TotalMoney), 0) TotalMoney "
            + " From CostsDetail "
            + " Where ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' And BudgetTypeCode = '618fb47f-94b4-4998-ad52-5068a15e02d1' ";
           DataView dvT1 = Conn.Select(StrSql);
           if (dvT1.Count != 0)
           {
               dv[i]["Bursary"] = Convert.ToDecimal(dvT1[0]["TotalMoney"]);
           }

            //หาเงินอื่น ๆ
           StrSql = " Select IsNull(Sum(TotalMoney), 0) TotalMoney "
            + " From CostsDetail "
            + " Where ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' And BudgetTypeCode <> '618fb47f-94b4-4998-ad52-5068a15e02d1' ";
           DataView dvT2 = Conn.Select(StrSql);
           if (dvT2.Count != 0)
           {
               dv[i]["OtherMoney"] = Convert.ToDecimal(dvT2[0]["TotalMoney"]);
           }
        }

        StrSql = " Select * From ActivityOperation2 Order By RecNum ";
        dv1 = Conn.Select(StrSql);


        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(dv1.ToTable("detail"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource30"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport31() //แบบสรุปการดำเนินงาน
    {      
        string strSql = " Select ActivityName As ProjectsName, Purpose, '' As Purpose2, Target, Target2, Goal, Results "
                + " From Activity Where DelFlag = 0 And StudyYear = '" + YearB + "' ";

        if(!string.IsNullOrEmpty(id))
        {
            strSql += " And ActivityCode = '" + id + "'";
        }

        DataView dv = Conn.Select(string.Format(strSql + "Order By Sort"));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string[] lblTarget = btc.getlblTarget().Split(',');

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("lblTarget1", lblTarget[0]);
        Report.SetParameterValue("lblTarget2", lblTarget[1]);
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Boolean ckLogo = true;
        if (!string.IsNullOrEmpty(Request["ckLogo"]))
        {
            ckLogo = Convert.ToBoolean(Request["ckLogo"]);
        }
        Report.SetParameterValue("ckLogo", ckLogo);

        ExportReport();

        this.Session["ReportSource31"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport32() //รายงานบันทึกค่าใช้จ่ายรายกิจกรรม2
    {       
        DataView dv, dv1;      
        string strSQL = " Select a.ProjectsCode, e.ProjectsName, a.ActivityCode, a.ActivityName, a.CostsType, a.TotalAmount, a.Term, a.YearB, "
                + " 'กลยุทธ์ที่ ' + Cast(f.Sort As nVarChar) + '. ' + f.StrategiesName StrategiesName, "
                + " a.ActivityDetail, '' DeptName, '' EmpName, a.StudyYear, a.BudgetYear, a.SDate, a.EDate, a.SDate2, a.EDate2, "
                + " '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, a.Place "
                + " From Activity a, Projects e, Strategies f "
                + " Where a.DelFlag = 0 And e.DelFlag = 0 And f.DelFlag = 0 "
                + " And a.ProjectsCode = e.ProjectsCode "
                + " And e.StrategiesCode = f.StrategiesCode "
                + " And a.ActivityCode = '" + id + "' ";
        dv = Conn.Select(string.Format(strSQL));

        if (dv.Count != 0)
        {
            dv[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv[0]["ProjectsCode"].ToString());
            dv[0]["StandardName"] = btc.getStandardName(false, dv[0]["ActivityCode"].ToString());
            dv[0]["IndicatorsName"] = btc.getIndicatorsName(false, dv[0]["ActivityCode"].ToString());

            for (int j = 0; j < dv.Count; j++)
            {
                dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());
                dv[j]["EmpName"] = btc.getAcEmpName(dv[j]["ActivityCode"].ToString());
            }
        }
        strSQL = "Select * From ActivityDetail Where ActivityCode = '" + id + "' And DelFlag = 0";
        DataView dvCkDt = Conn.Select(strSQL);

        strSQL = "Select IsNull(TotalAmount2,0) TotalAmount2 From Activity Where ActivityCode = '" + id + "'";
        DataView dvckTl = Conn.Select(strSQL);

        if ((dvCkDt.Count == 0) || (Convert.ToDecimal(dvckTl[0]["TotalAmount2"]) != 0))
        {
            strSQL = " Select a.ActivityCode, a.ListName, a.ListName As EntryCostsCode, a.BudgetTypeCode, "
            + " a.TotalP, a.TotalD, a.TotalG, a.TotalMoney, a.TotalMoney2, "
            + " BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, "
            + " a.ListName As EntryCostsName,  ValueT = Case IsNull(a.TotalMoney2,0) When 0 Then 0 Else a.TotalMoney2 End, '' As TotalMoney2Ag "
                + " From CostsDetail a, BudgetType b "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
            dv1 = Conn.Select(string.Format(strSQL + " Order By b.Sort ", id));
        }
        else
        {
            strSQL = " Select a.ActivityCode, a.ListName, a.ListName As EntryCostsCode, a.BudgetTypeCode, a.BudgetTypeOtherName, a.TotalP, a.TotalD, a.TotalG, "
                    + " a.TotalMoney, a.TotalMoney2, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, "
                    + " a.ListName As EntryCostsName, IsNull(Sum(e.TotalMoney),0) ValueT, '' As TotalMoney2Ag, b.Sort "
                    + " From CostsDetail a, BudgetType b, ActivityDetail d, ActivityCostsDetail e "
                    + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = d.ActivityCode "
                    + " And d.ActivityDetailCode = e.ActivityDetailCode And a.ItemID = e.ItemID "
                    + " And a.ActivityCode = '{0}'  "
                    + " Group By a.ActivityCode, a.BudgetTypeCode, a.BudgetTypeOtherName, "
                    + " a.TotalP, a.TotalD, a.TotalG, a.TotalMoney, a.TotalMoney2, BudgetTypeName, a.ListName, b.Sort ";
            dv1 = Conn.Select(string.Format(strSQL + " Order By b.Sort ", id));
        }
        if (dv1.Count != 0)
        {
            for (int j = 0; j < dv1.Count; j++)
            {
                dv1[j]["TotalMoney2Ag"] = Convert.ToDecimal(dv1[j]["ValueT"]).ToString("#,##0.00");
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("dtBudget"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource32"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport33() // รายงานสรุปกิจกรรมและค่าใช้จ่ายตามหน่วยงานและหน่วยงานย่อย
    {
        DataView dv, dv1, dv2, dv3, dv4;
        string StrSql = " Select a.DeptCode, a.DeptName, b.SubDeptCode, b.SubDeptName, "
                    + " 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Other "
                    + " From Department a Left Join SubDepartment b On a.DeptCode = b.DeptCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 ";
        dv = Conn.Select(string.Format(StrSql));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                StrSql = " Select a.SubDeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcSubDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 1 "
                    + " And a.SubDeptCode = '" + dv[i]["SubDeptCode"].ToString() + "' ";
                if (YearMode == "0")
                {
                    StrSql += " And b.StudyYear = '" + YearB + "' ";
                }
                else
                {
                    StrSql += " And b.BudgetYear = '" + YearB + "' ";
                }
                dv1 = Conn.Select(StrSql + " Group By a.SubDeptCode ");

                StrSql = " Select a.SubDeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcSubDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 2 "
                    + " And a.SubDeptCode = '" + dv[i]["SubDeptCode"].ToString() + "' ";
                if (YearMode == "0")
                {
                    StrSql += " And b.StudyYear = '" + YearB + "' ";
                }
                else
                {
                    StrSql += " And b.BudgetYear = '" + YearB + "' ";
                }
                dv2 = Conn.Select(StrSql + " Group By a.SubDeptCode ");

                StrSql = " Select a.SubDeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcSubDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 3 "
                    + " And a.SubDeptCode = '" + dv[i]["SubDeptCode"].ToString() + "' ";
                if (YearMode == "0")
                {
                    StrSql += " And b.StudyYear = '" + YearB + "' ";
                }
                else
                {
                    StrSql += " And b.BudgetYear = '" + YearB + "' ";
                }
                dv3 = Conn.Select(StrSql + " Group By a.SubDeptCode ");

                StrSql = " Select a.SubDeptCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From dtAcSubDept a, Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                    + " And a.SubDeptCode = '" + dv[i]["SubDeptCode"].ToString() + "' ";
                if (YearMode == "0")
                {
                    StrSql += " And b.StudyYear = '" + YearB + "' ";
                }
                else
                {
                    StrSql += " And b.BudgetYear = '" + YearB + "' ";
                }
                dv4 = Conn.Select(StrSql + " Group By a.SubDeptCode ");

                if (dv1.Count > 0)
                {
                    dv[i]["Subsidies"] = Convert.ToDecimal(dv1[0]["TotalMoney"]);
                }
                if (dv2.Count > 0)
                {
                    dv[i]["Revenue"] = Convert.ToDecimal(dv2[0]["TotalMoney"]);
                }
                if (dv3.Count > 0)
                {
                    dv[i]["Free"] = Convert.ToDecimal(dv3[0]["TotalMoney"]);
                }
                if (dv4.Count > 0)
                {
                    dv[i]["Other"] = Convert.ToDecimal(dv4[0]["TotalMoney"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource33"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport34() //รายงานรายรับสถานศึกษา
    {
        DataView dv;       
        string strSql = " Select IncomeCode, StudyYear, IsNull(Ma, 0) Ma, IsNull(Subsidies, 0) Subsidies, IsNull(MaRevenue, 0) MaRevenue, IsNull(Revenue, 0) Revenue, "
                + " IsNull(MaFree, 0) MaFree, IsNull(Free, 0) Free, IsNull(MaOther, 0) MaOther, IsNull(Other, 0) Other, IsNull(MaReserve, 0) MaReserve,  IsNull(Reserve, 0) Reserve "
                + " From Income Where DelFlag = 0 And IncomeCode = '" + id + "' ";
        dv = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource34"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport35() //รายงานรายรับสถานศึกษา
    {
        DataView dv;       
        string strSql = " Select ExpensesCode, StudyYear, IsNull(Subsidies, 0) Subsidies, IsNull(Revenue, 0) Revenue, "
                + " IsNull(Free, 0) Free, IsNull(Other, 0) Other, IsNull(Ma, 0) Ma "
                + " From Expenses Where DelFlag = 0 And ExpensesCode = '" + id + "' ";
        dv = Conn.Select(string.Format(strSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource35"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport36() // รายงานงบประมาณอื่น ๆ
    {
        DataView dv, dv1, dv2, dv3, dv4, dv5, dv6, dv7;     
        string StrSql = "";

        //if (DeptID == "")
        //{
            StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
                    + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
                    + " '' DeptName, 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And c.DelFlag = 0 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

        //}
        //else
        //{
        //    StrSql = " Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
        //            + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, "
        //            + " '' DeptName, 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special "
        //            + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
        //            + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
        //            + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
        //            + " Where a.DelFlag = 0 And c.DelFlag = 0 "
        //            + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
        //            + " And d.DeptCode = '" + DeptID + "' ";

            if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And c.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And c.BudgetYear = '" + YearB + "' ";
                    }
                }        
        //}

        dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 1 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        
            
                dv1 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 2 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv2 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 3 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv3 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                    + " And REPLACE(REPLACE(c.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'สวัสดิการ' "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv4 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select ckType From BudgetType Where DelFlag = 0 And ckType = 5 ";
                DataView dvckType5 = Conn.Select(StrSql);

                if (dvckType5.Count == 0) // เช็คกรณีมีการเพิ่ม Type ใหม่ที่มากกว่า 4 ค่า ในนี้เป็นเงินสมาคม รร. สตรีสมุทรปราการ ถ้าไม่เพิ่ม ก็ใช้แบบเดิม
                {
                    StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                        + " From Activity b, CostsDetail c, BudgetType d "
                        + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                        + " And b.ActivityCode = c.ActivityCode "
                        + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                        + " And REPLACE(REPLACE(c.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'สปค.สก.' "
                        + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                    if (btc.ckIdentityName("ckBudgetYear"))
                    {
                        if (YearMode == "0")
                        {
                            StrSql += " And b.BudgetYear = '" + YearB + "' ";
                        }
                        else
                        {
                            StrSql += " And b.StudyYear = '" + YearB + "' ";
                        }
                    }
                    else
                    {
                        if (YearMode == "0")
                        {
                            StrSql += " And b.StudyYear = '" + YearB + "' ";
                        }
                        else
                        {
                            StrSql += " And b.BudgetYear = '" + YearB + "' ";
                        }
                    }

                    dv5 = Conn.Select(StrSql + " Group By b.ActivityCode ");
                }
                else // เช็คกรณีมีการเพิ่ม Type ใหม่ที่มากกว่า 4 ค่า ในนี้เป็นเงินสมาคม รร. สตรีสมุทรปราการ
                {
                    StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 5 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                    if (btc.ckIdentityName("ckBudgetYear"))
                    {
                        if (YearMode == "0")
                        {
                            StrSql += " And b.BudgetYear = '" + YearB + "' ";
                        }
                        else
                        {
                            StrSql += " And b.StudyYear = '" + YearB + "' ";
                        }
                    }
                    else
                    {
                        if (YearMode == "0")
                        {
                            StrSql += " And b.StudyYear = '" + YearB + "' ";
                        }
                        else
                        {
                            StrSql += " And b.BudgetYear = '" + YearB + "' ";
                        }
                    }

                    dv5 = Conn.Select(StrSql + " Group By b.ActivityCode ");
                }

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                    + " And ((REPLACE(REPLACE(c.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'มูลนิธิ') OR "
					+ " (REPLACE(REPLACE(BudgetTypeOtherName,')',''),'อื่น ๆ (','') Not In ('งบอุดหนุน','รายได้สถานศึกษา','บำรุงการศึกษา','สมาคม','สวัสดิการ','โครงการพิเศษ'))) "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv6 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                    + " And REPLACE(REPLACE(c.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'โครงการพิเศษ' "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                if (btc.ckIdentityName("ckBudgetYear"))
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                }
                else
                {
                    if (YearMode == "0")
                    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                    }
                    else
                    {
                        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                    }
                }        

                dv7 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                if (dv1.Count > 0)
                {
                    dv[i]["Subsidies"] = Convert.ToDecimal(dv1[0]["TotalMoney"]);
                }
                if (dv2.Count > 0)
                {
                    dv[i]["Revenue"] = Convert.ToDecimal(dv2[0]["TotalMoney"]);
                }
                if (dv3.Count > 0)
                {
                    dv[i]["Free"] = Convert.ToDecimal(dv3[0]["TotalMoney"]);
                }
                if (dv4.Count > 0)
                {
                    dv[i]["Welfare"] = Convert.ToDecimal(dv4[0]["TotalMoney"]);
                }
                if (dv5.Count > 0)
                {
                    dv[i]["SPK"] = Convert.ToDecimal(dv5[0]["TotalMoney"]);
                }
                if (dv6.Count > 0)
                {
                    dv[i]["Fund"] = Convert.ToDecimal(dv6[0]["TotalMoney"]);
                }
                if (dv7.Count > 0)
                {
                    dv[i]["Special"] = Convert.ToDecimal(dv7[0]["TotalMoney"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource36"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport37() // รายงานจำนวนกิจกรรมตามตัวบ่งชี้
    {
        DataView dv, dv1;
        string strSQL = " Select a.SideCode StandardCode, 'มาตรฐานที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.SideName FullStandardName, a.SideName StandardName, a.Sort, "
                + " b.StandardCode IndicatorsCode,'ตัวบ่งชี้ที่ ' + Cast(a.Sort As nVarChar) + '.' + Cast(b.Sort As nVarChar) + ' ' + b.StandardName FullIndicatorsName, b.StandardName IndicatorsName, b.Sort, "
                + " 0 As CountAc, 0 As CountSt "
                + " From Side a Left Join Standard b On a.SideCode = b.SideCode "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + YearB + "' "
                + " Group By a.SideCode, a.SideName, a.Sort, b.StandardCode, b.StandardName, b.Sort "
                + " Order By a.Sort, b.Sort ";
        dv = Conn.Select(string.Format(strSQL));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                strSQL = " Select IsNull(Count(E.ActivityCode), 0) CountSt From Evaluation E Left Join Standard S On E.StandardCode = S.StandardCode "
                    + " Where S.SideCode = '" + dv[i]["StandardCode"].ToString() + "' "
                    + " And E.DelFlag = 0 And E.StudyYear = '" + YearB + "' And E.SchoolID = '" + CurrentUser.SchoolID + "' ";
                DataView ckDv = Conn.Select(strSQL);

                if (ckDv.Count != 0)
                {
                    dv[i]["CountSt"] = Convert.ToInt32(ckDv[0]["CountSt"]);
                }
                else
                {
                    dv[i]["CountSt"] = 0;
                }
            }
        }

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                strSQL = " Select IsNull(Count(Distinct(E.ActivityCode)), 0) ActCount From Evaluation E Left Join Standard S On E.StandardCode = S.StandardCode "
                    + " Where S.SideCode = '" + dv[i]["StandardCode"].ToString() + "' "
                    + " And E.StandardCode = '" + dv[i]["IndicatorsCode"].ToString() + "' "
                    + " And E.DelFlag = 0 And E.StudyYear = '" + YearB + "' And E.SchoolID = '" + CurrentUser.SchoolID + "' ";
                DataView ckDv = Conn.Select(strSQL);

                if (ckDv.Count != 0)
                {
                    dv[i]["CountAc"] = Convert.ToInt32(ckDv[0]["ActCount"]);
                }
                else
                {
                    dv[i]["CountAc"] = 0;
                }
            }
        }

        strSQL = " Select b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, s.SideCode StandardCode, a.StandardCode IndicatorsCode, '' As EmpName "
                    + " From Evaluation a, Activity b, Standard s "
                    + " Where a.ActivityCode = b.ActivityCode And a.StandardCode = s.StandardCode "
                    + " And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' ";

        if (!string.IsNullOrEmpty(DeptID))
        {
            strSQL = " Select b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, s.SideCode StandardCode, a.StandardCode IndicatorsCode, '' As EmpName "
                    + " From Evaluation a, Activity b, dtAcDept c, Standard s "
                    + " Where a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode And a.StandardCode = s.StandardCode "
                    + " And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + DeptID + "' ";
        }
        if (!string.IsNullOrEmpty(EmpID))
        {
            if (string.IsNullOrEmpty(DeptID))
            {
                strSQL = " Select b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, s.SideCode StandardCode, a.StandardCode IndicatorsCode, '' As EmpName "
                    + " From Evaluation a, Activity b, dtAcEmp c, Standard s "
                    + " Where a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode And a.StandardCode = s.StandardCode "
                    + " And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.EmpCode = '" + EmpID + "' ";
            }
            else
            {
                strSQL = " Select b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, s.SideCode StandardCode, a.StandardCode IndicatorsCode, '' As EmpName "
                    + " From Evaluation a, Activity b, dtAcEmp c, dtAcDept d, Standard s "
                    + " Where a.ActivityCode = b.ActivityCode And b.ActivityCode = c.ActivityCode And b.ActivityCode = d.ActivityCode And a.StandardCode = s.StandardCode "
                    + " And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '" + YearB + "' And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "' ";
            }
        }
        dv1 = Conn.Select(strSQL + " Group By b.ActivityCode, b.ActivityName, b.TotalAmount, b.TotalAmount2, s.SideCode, a.StandardCode ");

        if (dv1.Count != 0)
        {
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["EmpName"] = btc.getAcEmpName(dv1[i]["ActivityCode"].ToString());
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(dv1.ToTable("Activity"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("StudyYear", Convert.ToInt32(YearB));
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");

        ExportReport();

        this.Session["ReportSource37"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport38() //รายงานระดับความสำเร็จ/ปัจจัยที่สนับสนุนให้กิจกรรมสำเร็จ
    {          
        string strSQL = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
            + " b.ProjectsCode, b.ProjectsName, c.ActivityCode, c.ActivityName, d.Translation, '' FactorName, "
            + " c.Purpose, c.Target, c.Target2, '' As StandardName, a.Sort As StgSort, b.Sort As PrjSort, c.Sort As AcSort, "
            + " IsNull(c.TotalAmount, 0) TotalAmount, IsNull(c.TotalAmount2, 0) TotalAmount2 "
            + " From Strategies a Left Join Projects b On a.StrategiesCode = b.StrategiesCode And b.DelFlag = 0 "
            + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
            + " Left Join FactorRate d On c.FactorRateID = d.FactorRateID "
            + " Where a.DelFlag = 0  And a.StudyYear = '" + YearB + "' "
            + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.StrategiesCode = '" + id + "' ";
        }
        DataView dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["StandardName"] = btc.getStandardName(false, dv[i]["ActivityCode"].ToString());
                dv[i]["FactorName"] = btc.getFactorName(dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource38"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport39() // รายงานใบคำขอของกลุ่มโรงเรียนจุฬาภรณ์
    {
        DataView dv, dv1, dv2, dv3, dv5;
        string StrSql = " Select a.*, "
                + " 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName StrategiesName, "
                + " '' As MissionName, '' As GoalsName, "
                + " '' As PolicyName, '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, '' As StrategySPTName "
                + " From Projects a, Strategies b "
                + " Where a.DelFlag = 0 And b.DelFlag = 0 "
                + " And a.StrategiesCode = b.StrategiesCode "
                + " And a.ProjectsCode = '" + id + "' ";
        dv5 = Conn.Select(string.Format(StrSql));

        if (dv5.Count != 0)
        {
            dv5[0]["MissionName"] = btc.getMissionName(dv5[0]["MissionCode"].ToString());
            dv5[0]["GoalsName"] = btc.getGoalsName(dv5[0]["GoalsCode"].ToString());
            dv5[0]["PolicyName"] = btc.getPolicyName(dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardName"] = btc.getStandardNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["IndicatorsName"] = btc.getIndicatorsNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StrategySPTName"] = btc.getStrategySPTName(dv5[0]["ProjectsCode"].ToString());
        }

        StrSql = " Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, "
                    + " a.Sort, b.Sort, '' As DeptName "
                    + " From Projects a Left Join Activity b On a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " Where a.DelFlag = 0 And a.ProjectsCode = '" + id + "' ";
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        StrSql = " Select 'ยุทธศาสตร์ด้านที่ ' + cast(b.Sort As nVarChar) + ' ' + b.StrategicName As FullName "
                + " FROM dtStrategic a, Strategic b "
                + " Where a.ProjectsCode = '" + id + "' "
                + " And a.StrategicCode = b.StrategicCode Order By b.Sort ";
        dv1 = Conn.Select(string.Format(StrSql));

        StrSql = " Select * From ProjectsMoneyDetail "
            + " Where ProjectsCode = '" + id + "' Order By MoneyNo ";
        dv2 = Conn.Select(string.Format(StrSql));

        StrSql = " Select * From ProjectsQuarterDetail "
            + " Where ProjectsCode = '" + id + "' Order By QuarterNo, QuarterSort ";
        dv3 = Conn.Select(string.Format(StrSql));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("Strategic"));
        ds.Tables.Add(dv2.ToTable("Money"));
        ds.Tables.Add(dv3.ToTable("Quarter"));
        ds.Tables.Add(dv5.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("identityName", btc.ckIdentityName("iNameShow") ? dv5[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", btc.ckIdentityName("iNameShow2") ? dv5[0]["IdentityName2"].ToString() : "");
        Report.SetParameterValue("PlanNo", btc.ckIdentityName("ckPlanNo") ? dv5[0]["PlanNo"].ToString() : "");
        Report.SetParameterValue("StrategySPTName", btc.ckIdentityName("ckStrategySPT") ? dv5[0]["StrategySPTName"].ToString() : "");
        Report.SetParameterValue("StrategySPMName", btc.ckIdentityName("ckStrategySPM") ? btc.getStrategySPMName(dv5[0]["ProjectsCode"].ToString()) : "");
        Report.SetParameterValue("StandardSPMName", btc.ckIdentityName("ckStandardSPM") ? btc.getStandardSPMName(dv5[0]["ProjectsCode"].ToString()) : "");
        Report.SetParameterValue("StatuteNo", btc.ckIdentityName("ckStatute") ? "มาตราที่ " + dv5[0]["StatuteNo"].ToString() : "");
        Report.SetParameterValue("PolicyName", btc.ckIdentityName("ckPolicy") ? dv5[0]["PolicyName"].ToString() : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv5[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv5[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("ckSign", Request["ckSign"]);

        ExportReport();

        this.Session["ReportSource39"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport40() // testImageDinamic
    {
        DataView dv;
        string StrSql = "Select * From MR_School Where DelFlag = 0  ";
        dv = Conn.Select(string.Format(StrSql));

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("SchoolDetail"));
        ds.Tables.Add(btc.GetLogoImg());

        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        ExportReport();

        this.Session["ReportSource40"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport41() //รายงานปัญหาโครงการปีที่ผ่านมา
    {
        string strSQL = " Select a.Sort As SortRb, a.ResponseProblemsName, a.Detail, c.ProjectsName, c.Sort As SortPj "
            + " From ResponseProblems a Left Join dtResponseProblems b On a.ResponseProblemsCode = b.ResponseProblemsCode "
            + " Left Join Projects c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
            + " Where a.StudyYear = '"+ YearB +"' And a.DelFlag = 0  ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.ResponseProblemsCode = '" + id + "' ";
        }
        DataView dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, c.Sort "));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");

        ExportReport();

        this.Session["ReportSource41"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport42() //กราฟจำนวนกิจกรรมตามมาตรฐาน
    {
        string strSql = " Select a.StandardCode, ' ' name, a.Sort, "
                + " 0 As data "
                + " From Standard a "
                + " Where a.DelFlag = 0 And a.StudyYear = '" + YearB + "' "
                + " Order By a.Sort ";
        DataView dv1 = Conn.Select(strSql);

        if (dv1.Count != 0)
        {
            Int32 CountAct = 0;
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["name"] = "มฐ.ที่ " + Convert.ToInt32(dv1[i]["Sort"]).ToString("00") + ". " + dv1[i]["name"].ToString();

                strSql = " Select IsNull(Count(Distinct(ActivityCode)), 0) ActCount From Evaluation "
                    + " Where StandardCode = '" + dv1[i]["StandardCode"].ToString() + "' "
                    + " And DelFlag = 0 And StudyYear = '" + YearB + "' And SchoolID = '" + CurrentUser.SchoolID + "' ";
                DataView ckDv = Conn.Select(strSql);

                if (ckDv.Count != 0)
                {
                    dv1[i]["data"] = Convert.ToInt32(ckDv[0]["ActCount"]);
                }
                else
                {
                    dv1[i]["data"] = 0;
                }
            }
            //dv2 = dv1.ToTable(true, "StandardCode", "FullStandardName", "StandardName").DefaultView;
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv1.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("lblYear", btc.ckIdentityName("ckBudgetYear") ? "ปีงบประมาณ " : "ปีการศึกษา ");

        ExportReport();

        this.Session["ReportSource42"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport43() // รายงานการดำเนินงานตามกลยุทธ์
    {
        DataView dv;
        string strSQL = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
            + " b.ProjectsCode, b.ProjectsName, c.ActivityCode, c.ActivityName, "
            + " c.Purpose, c.Target, c.Target2, '' As StandardName, a.Sort As StgSort, b.Sort As PrjSort, c.Sort As AcSort, "
            + " dbo.GetActivityName(a.StrategiesCode,b.ProjectsCode) as Activity ,dbo.GetStandardSort(b.ProjectsCode,b.StudyYear) as GetStandardSort "
            + " From Strategies a Left Join dtStrategies dts On a.StrategiesCode = dts.StrategiesCode "
            + " And dts.ProjectsCode In (Select ProjectsCode From Projects Where DelFlag = 0) "
            + " Left Join Projects b On dts.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
            + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
            + " Where a.DelFlag = 0 And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + YearB + "' ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.StrategiesCode = '" + id + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["StandardName"] = btc.getStandardName(false, dv[i]["ActivityCode"].ToString()).Replace("ตัวบ่งชี้ที่ ", "");
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource43"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();

    }
    private void SetReport44() // รายงานการดำเนินงานตามกลยุทธ์
    {
        DataView dv;
        string strSQL = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
            + " b.ProjectsCode, b.ProjectsName, c.ActivityCode, c.ActivityName, "
            + " c.Purpose, c.Target, c.Target2, '' As StandardName, a.Sort As StgSort, b.Sort As PrjSort, c.Sort As AcSort, "
            + " dbo.GetActivityName(a.StrategiesCode,b.ProjectsCode) as Activity ,dbo.GetStandardSort(b.ProjectsCode,b.StudyYear) as GetStandardSort "
            + " From Strategies a Left Join dtStrategies dtS On a.StrategiesCode = dtS.StrategiesCode "
            + " And dts.ProjectsCode In (Select ProjectsCode From Projects Where DelFlag = 0) "
            + " Left Join Projects b On dtS.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
            + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
            + " Where a.DelFlag = 0 And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + YearB + "' ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.StrategiesCode = '" + id + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["StandardName"] = btc.getStandardName(false, dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource44"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();

    }
    private void SetReport45() // รายงานจำนวนโครงการกิจกรรมตามหน่วยงาน
    {
        DataView dv;
        string strSQL = @" Select a.DeptCode, a.DeptName, a.Sort As DeptSort,
                c.ActivityCode, c.ActivityName, c.TotalAmount, c.Sort As AcSort,
                d.ProjectsCode, d.ProjectsName, '' As BudgetTypeName, d.Sort As PjSort
                From Department a Left Join dtAcDept b On a.DeptCode = b.DeptCode
                Left Join Activity c On c.ActivityCode = b.ActivityCode And c.DelFlag = 0
                Left Join Projects d On d.ProjectsCode = c.ProjectsCode And d.DelFlag = 0
                Where a.DelFlag = 0 And c.SchoolID = '{0}'  ";

        if (Request.QueryString["yearmode"] == "1")
        {
            strSQL += " And c.BudgetYear = '" + BudgetYear + "' ";
        }
        else
        {
            strSQL += " And c.StudyYear = '" + BudgetYear + "' ";
        }
        if (!string.IsNullOrEmpty(id))
        {
            strSQL += " And d.ProjectsCode = '" + id + "' ";
        }
        if (!string.IsNullOrEmpty(DeptID))
        {
            strSQL += " And b.DeptCode = '" + DeptID + "' ";
        }

        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, d.Sort, c.Sort ", CurrentUser.SchoolID));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["BudgetTypeName"] = btc.getBudgetTypeName(dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource45"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();

    }
    private void SetReport48() // รายงานสภาพความสำเร็จที่คาดว่าจะเกิดขึ้นเมื่อสิ้นปีงบประมาณ
    {
        DataView dv, dv1;

        string StrSql = @" Select S.StrategiesCode, S.StrategiesName, S.Sort As StgSort,
            P.ProjectsCode, P.ProjectsName, P.Sort As PjSort,
            A.ActivityCode, A.ActivityName, A.Sort AS AcSort,
            I.Indicators2Code, I.IndicatorsName2, I.Sort As IndSort
            From Strategies S Inner Join Projects P On S.StrategiesCode = P.StrategiesCode And P.DelFlag = 0
            Inner Join Activity A On P.ProjectsCode = A.ProjectsCode And A.DelFlag = 0
            Inner Join Indicators2 I On A.ActivityCode = I.ActivityCode And I.DelFlag = 0
            Where S.DelFlag= 0 And S.StudyYear = '{0}' ";

        if (!string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            StrSql += " And S.StrategiesCode = '{1}' ";
        }

        dv = Conn.Select(string.Format(StrSql + " Order By S.Sort, P.Sort, A.Sort, I.Sort ", YearB, id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string ManagerName = dvSchool[0]["ManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        //ds.Tables.Add(dv1.ToTable("dataProjects"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        ExportReport();

        this.Session["ReportSource48"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport49() // ใบปะหน้าขอดำเนินโครงการ
    {
        DataView dv, dv2, dv3, dv4;
        decimal TotalAmount = 0;
        string ActivityDetail = "";


        string strSql = " Select a.ActivityCode, a.ActivityName, a.StudyYear, a.BudgetYear, a.Sort As SortAc, d.Sort As SortPj, "
            + " b.ActivityDetailCode, b.TDay, '' As DeptName,  IsNull(b.Sort, 0) As AcDSort, b.ActivityDetail, a.sDate, a.eDate, c.EmpName, d.ProjectsName, b.UnderManagerName, b.PositionUnderManagerName "
            + " From Activity a, ActivityDetail b, Employee c, Projects d "
            + " Where a.ActivityCode = b.ActivityCode And a.CreateUser = c.EmpID And a.ProjectsCode = d.ProjectsCode And a.DelFlag = 0 And b.DelFlag = 0 And b.ActivityDetailCode = '" + id + "'";
        dv = Conn.Select(string.Format(strSql));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
            ActivityDetail = dv[0]["ActivityDetail"].ToString();
        }

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End, "
                + " Sum(a.TotalMoney) Money1, 0.0 As Money2, 0.0 As Money3, b.Sort "
                + " From CostsDetail a, BudgetType b "
                + " Where b.DelFlag = 0 And a.BudgetTypeCode = b.BudgetTypeCode "
                + " And a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName, Sort ";
        dv2 = Conn.Select(string.Format(strSql + " Order By b.Sort ", id));

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, Sum(IsNull(e.TotalMoney,0)) ValueT, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End "
                + " From CostsDetail a, BudgetType b, ActivityDetail d, ActivityCostsDetail e "
                + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = d.ActivityCode "
                + " And d.ActivityDetailCode = e.ActivityDetailCode "
                + " And a.ItemID = e.ItemID "
                + " And a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' And e.ActivityDetailCode = '{0}' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName ";
        dv3 = Conn.Select(string.Format(strSql, id));

        strSql = " Select a.ActivityCode, a.BudgetTypeCode, Sum(IsNull(e.TotalMoney,0)) ValueT, "
                + " BudgetTypeName = Case b.BudgetTypeName When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then b.BudgetTypeName Else a.BudgetTypeOtherName End "
                + " From CostsDetail a Left Join BudgetType b On a.BudgetTypeCode = b.BudgetTypeCode "
                + " Left Join ActivityDetail d On a.ActivityCode = d.ActivityCode "
                + " Left Join ActivityCostsDetail e On d.ActivityDetailCode = e.ActivityDetailCode And a.ItemID = e.ItemID "
                + " And e.ActivityDetailCode Not In ('{0}' ) And d.Sort < {1} "
                + " Where a.ActivityCode = '" + dv[0]["ActivityCode"].ToString() + "' "
                + " Group By a.ActivityCode, a.BudgetTypeCode, b.BudgetTypeName, a.BudgetTypeOtherName ";
        dv4 = Conn.Select(string.Format(strSql, id, Convert.ToInt32(dv[0]["AcDSort"])));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(dv2.ToTable("dtBudgetType"));
        ds.Tables.Add(dv3.ToTable("dtBudgetOut"));
        ds.Tables.Add(dv4.ToTable("dtBudgetUse"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("PositionManagerName", PositionManagerName);
        Report.SetParameterValue("TotalAmount", TotalAmount);
        Report.SetParameterValue("ActivityDetail", ActivityDetail);
        Report.SetParameterValue("ManagerSaraGroupName", btc.SchoolFieldName("ManagerSaraGroupName", CurrentUser.SchoolID));

        //หัวหน้างานนโยบายและแผน
        string ManagerPlanName = "", PositionPlanName = "";
        string[] strPlan = btc.SchoolFieldName("ManagerPlanName", CurrentUser.SchoolID).Split(':');
        ManagerPlanName = strPlan[0];
        PositionPlanName = strPlan[1];
        Report.SetParameterValue("ManagerPlanName", ManagerPlanName);
        Report.SetParameterValue("PositionPlanName", PositionPlanName);

        //หัวหน้างานพัสดุ
        string ManagerSuppliesName = "", PositionSuppliesName = "";
        string[] strSupplies = btc.SchoolFieldName("ManagerSuppliesName", CurrentUser.SchoolID).Split(':');
        ManagerSuppliesName = strSupplies[0];
        PositionSuppliesName = strSupplies[1];
        Report.SetParameterValue("ManagerSuppliesName", ManagerSuppliesName);
        Report.SetParameterValue("PositionSuppliesName", PositionSuppliesName);

        //หัวหน้างานการเงิน
        string ManagerMoneyName = "", PositionMoneyName = "";
        string[] strMoney = btc.SchoolFieldName("ManagerMoneyName", CurrentUser.SchoolID).Split(':');
        ManagerMoneyName = strMoney[0];
        PositionMoneyName = strMoney[1];
        Report.SetParameterValue("ManagerMoneyName", ManagerMoneyName);
        Report.SetParameterValue("PositionMoneyName", PositionMoneyName);

        //รอง ผอ. กลุ่มบริหารงานงบประมาณ
        string UnderBudgetName = "", PositionManagerBudgetName = "";
        string[] strBudget = btc.SchoolFieldName("UnderBudgetName", CurrentUser.SchoolID).Split(':');
        UnderBudgetName = strBudget[0];
        PositionManagerBudgetName = strBudget[1];
        Report.SetParameterValue("UnderBudgetName", UnderBudgetName);
        Report.SetParameterValue("PositionManagerBudgetName", PositionManagerBudgetName);

        //รอง ผอ. กลุ่ม
        string UnderManagerName = "", PositionUnderManagerName = "";
        string[] strUnderManagerName = btc.SchoolFieldName("UnderManagerName", CurrentUser.SchoolID).Split(':');
        UnderManagerName = strUnderManagerName[0];
        PositionUnderManagerName = strUnderManagerName[1];
        Report.SetParameterValue("UnderManagerName", (!string.IsNullOrEmpty(dv[0]["UnderManagerName"].ToString()) ? dv[0]["UnderManagerName"].ToString() : UnderManagerName));
        Report.SetParameterValue("PositionUnderManagerName", (!string.IsNullOrEmpty(dv[0]["PositionUnderManagerName"].ToString()) ? dv[0]["PositionUnderManagerName"].ToString() : PositionUnderManagerName));

        //ผู้รับผิดชอบกิจกรรม
        string PositionResponsible = "";
        string[] strResponsible = btc.SchoolFieldName("Responsible", CurrentUser.SchoolID).Split(':');
        PositionResponsible = strResponsible[1];
        Report.SetParameterValue("PositionResponsible", PositionResponsible);

        //หัวหน้างาน / กลุ่มสาระ
        string PositionHeadGroupSara = "";
        string[] strHeadGroupSara = btc.SchoolFieldName("HeadGroupSara", CurrentUser.SchoolID).Split(':');
        PositionHeadGroupSara = strHeadGroupSara[1];
        Report.SetParameterValue("PositionHeadGroupSara", PositionHeadGroupSara);

        //หัวหน้ากลุ่มงาน
        string PositionHeadGroup = "";
        string[] strHeadGroup = btc.SchoolFieldName("HeadGroup", CurrentUser.SchoolID).Split(':');
        PositionHeadGroup = strHeadGroup[1];
        Report.SetParameterValue("PositionHeadGroup", PositionHeadGroup);

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource49"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport51()  //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน
    {
        string StrSql = "";
       StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, "
                    + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus, "
                    + " a.Sort As PjSort, b.Sort As AcSort "
                    + " From Projects a, Activity b "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " And a.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' ";

       if (DeptID != "")
        {
            StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
                    + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, "
                    + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus, "
                    + " a.Sort As PjSort, b.Sort As AcSort "
                    + " From Projects a, Activity b, dtAcDept c "
                    + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                    + " And a.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And c.DeptCode = '" + DeptID + "'";
        }
        if (EmpID != "")
        {
            if (DeptID == "")
            {
                StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
                        + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, "
                        + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus, "
                        + " a.Sort As PjSort, b.Sort As AcSort "
                        + " From Projects a, Activity b, dtAcEmp c "
                        + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode "
                        + " And a.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " And c.EmpCode = '" + EmpID + "'";
            }
            else
            {
                StrSql = "Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, b.SDate , b.EDate, '' As DeptName, b.Status, b.Df, "
                            + " b.CostsType, IsNull(b.TotalAmount, 0) TotalAmount, IsNull(b.TotalAmount2, 0) TotalAmount2, "
                            + " IsNull((Cast(b.Term As nVarChar) + '/' + Cast(b.YearB As nVarChar)), '') Term, IsNull(b.ActivityStatus, 0) As ActivityStatus, "
                            + " a.Sort As PjSort, b.Sort As AcSort "
                            + " From Projects a, Activity b, dtAcEmp c, dtAcDept d "
                            + " Where a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 And b.ActivityCode = c.ActivityCode And b.ActivityCode = d.ActivityCode "
                            + " And a.StudyYear = '" + YearB + "' And b.SchoolID = '" + CurrentUser.SchoolID + "' "
                            + " And c.EmpCode = '" + EmpID + "' And d.DeptCode = '" + DeptID + "'";
            }
        }
        if (id != "")
        {
            StrSql = StrSql + " And a.ProjectsCode = '" + id + "'";
        }

        DataView dv = Conn.Select(string.Format(StrSql + " And ApproveFlag = 1 Order By a.Sort, b.Sort "));

        for (int j = 0; j < dv.Count; j++)
        {
            decimal TtAmount2 = Convert.ToDecimal(btc.getNTotalAmount(dv[j]["ActivityCode"].ToString()));
            dv[j]["DeptName"] = btc.getAcDeptName(dv[j]["ActivityCode"].ToString());

            if (TtAmount2 != 0)
            {
                dv[j]["TotalAmount2"] = TtAmount2.ToString();
            }
        }

        if (!btc.ckIdentityName("ckBudgetYear"))
        {
            YearMode = "0";
        }
        else
        {
            YearMode = "1";
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataBudget"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("deptName", (DeptID != "") ? btc.getDeptName(DeptID) : "");
        Report.SetParameterValue("empName", (EmpID != "") ? btc.getEmpName(EmpID) : "");
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource51"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport52()  //รายงานงบประมาณตามโปรเจ็ค ตามกิจกรรม ตามหน่วยงาน แบบยังไม่ปิดกิจกรรม แยกตามประเภทงบประมาณ
    {
        string StrSql = "";
        StrSql = @" Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, 
                    a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, 
                    dm.DeptName, 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special 
                    From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode 
                    Left Join Activity c On a.ProjectsCode = c.ProjectsCode 
                    Left Join dtAcDept d On c.ActivityCode = d.ActivityCode 
                    Left Join Department dm On d.DeptCode = dm.DeptCode
                    Where a.DelFlag = 0 And c.DelFlag = 0 
                    And a.SchoolID = '{0}' ";

        if (DeptID != "")
        {
            StrSql = @" Select a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, 
                    a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, 
                    dm.DeptName, 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special 
                    From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode 
                    Left Join Activity c On a.ProjectsCode = c.ProjectsCode 
                    Left Join dtAcDept d On c.ActivityCode = d.ActivityCode
                    Left Join Department dm On d.DeptCode = dm.DeptCode
                    Where a.DelFlag = 0 And c.DelFlag = 0 
                    And a.SchoolID = '{0}' And d.DeptCode = '" + DeptID + "' ";
        }

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And c.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And c.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And c.BudgetYear = '" + YearB + "' ";
        //    }
        //}        

        if (id != "")
        {
            StrSql += " And a.ProjectsCode = '" + id + "'";
        }

        DataView dv = Conn.Select(string.Format(StrSql + " And c.ApproveFlag = 1 Order By b.Sort, a.Sort, c.Sort ", CurrentUser.SchoolID));

        StrSql = @" Select b.ActivityCode, b.ProjectsCode, IsNull(Sum(d.TotalMoney),0) TotalMoney 
            From Activity b, ActivityDetail c, ActivityCostsDetail d, CostsDetail e, BudgetType f 
            Where b.DelFlag = 0 And c.DelFlag = 0 And f.DelFlag = 0 And b.ApproveFlag = 1
            And b.ActivityCode = c.ActivityCode And c.ActivityDetailCode = d.ActivityDetailCode
            And d.ItemID = e.ItemID
            And e.BudgetTypeCode = f.BudgetTypeCode And f.ckType = 1 ";

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //}
        DataView dvSubsidies = Conn.Select(StrSql + " Group By b.ActivityCode, b.ProjectsCode "); //อุดหนุน

        StrSql = @" Select b.ActivityCode, b.ProjectsCode, IsNull(Sum(d.TotalMoney),0) TotalMoney 
            From Activity b, ActivityDetail c, ActivityCostsDetail d, CostsDetail e, BudgetType f 
            Where b.DelFlag = 0 And c.DelFlag = 0 And f.DelFlag = 0 And b.ApproveFlag = 1
            And b.ActivityCode = c.ActivityCode And c.ActivityDetailCode = d.ActivityDetailCode
            And d.ItemID = e.ItemID
            And e.BudgetTypeCode = f.BudgetTypeCode And f.ckType = 2 ";

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //}
        DataView dvRevenue = Conn.Select(StrSql + " Group By b.ActivityCode, b.ProjectsCode "); //รายได้สถานศึกษา

        StrSql = @" Select b.ActivityCode, b.ProjectsCode, IsNull(Sum(d.TotalMoney),0) TotalMoney 
            From Activity b, ActivityDetail c, ActivityCostsDetail d, CostsDetail e, BudgetType f 
            Where b.DelFlag = 0 And c.DelFlag = 0 And f.DelFlag = 0 And b.ApproveFlag = 1
            And b.ActivityCode = c.ActivityCode And c.ActivityDetailCode = d.ActivityDetailCode
            And d.ItemID = e.ItemID
            And e.BudgetTypeCode = f.BudgetTypeCode And f.ckType = 3 ";

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //}
        DataView dvFree = Conn.Select(StrSql + " Group By b.ActivityCode, b.ProjectsCode "); //เรียนฟรี / บำรุงการศึกษา

        StrSql = @" Select b.ActivityCode, b.ProjectsCode, IsNull(Sum(d.TotalMoney),0) TotalMoney 
            From Activity b, ActivityDetail c, ActivityCostsDetail d, CostsDetail e, BudgetType f 
            Where b.DelFlag = 0 And c.DelFlag = 0 And f.DelFlag = 0 And b.ApproveFlag = 1
            And b.ActivityCode = c.ActivityCode And c.ActivityDetailCode = d.ActivityDetailCode
            And d.ItemID = e.ItemID
            And e.BudgetTypeCode = f.BudgetTypeCode And f.ckType = 5 ";

//        StrSql = @" Select b.ActivityCode, b.ProjectsCode, IsNull(Sum(d.TotalMoney),0) TotalMoney 
//            From Activity b, ActivityDetail c, ActivityCostsDetail d, CostsDetail e, BudgetType f 
//            Where b.DelFlag = 0 And c.DelFlag = 0 And f.DelFlag = 0 And b.ApproveFlag = 1
//            And b.ActivityCode = c.ActivityCode And c.ActivityDetailCode = d.ActivityDetailCode
//            And d.ItemID = e.ItemID
//            And e.BudgetTypeCode = f.BudgetTypeCode And f.ckType = 4 
//            And ((REPLACE(REPLACE(e.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'มูลนิธิ') OR 
//            (REPLACE(REPLACE(e.BudgetTypeOtherName,')',''),'อื่น ๆ (','') Not In ('งบอุดหนุน','รายได้สถานศึกษา','บำรุงการศึกษา','สมาคม')))  ";

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And b.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
        //    }
        //}

        DataView dvFund = Conn.Select(StrSql + " Group By b.ActivityCode, b.ProjectsCode ");
        

        for (int i = 0; i < dv.Count; i++)
        {
            DataRow[] drSubsidies = dvSubsidies.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' And ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
            if (drSubsidies.Length > 0 && !string.IsNullOrEmpty(drSubsidies[0]["TotalMoney"].ToString()))
            {
                dv[i]["Subsidies"] = Convert.ToDecimal(drSubsidies[0]["TotalMoney"].ToString());
            }

            DataRow[] drRevenue = dvRevenue.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' And ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
            if (drRevenue.Length > 0 && !string.IsNullOrEmpty(drRevenue[0]["TotalMoney"].ToString()))
            {
                dv[i]["Revenue"] = Convert.ToDecimal(drRevenue[0]["TotalMoney"].ToString());
            }

            DataRow[] drFree = dvFree.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' And ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
            if (drFree.Length > 0 && !string.IsNullOrEmpty(drFree[0]["TotalMoney"].ToString()))
            {
                dv[i]["Free"] = Convert.ToDecimal(drFree[0]["TotalMoney"].ToString());
            }

            DataRow[] drFund = dvFund.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' And ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
            if (drFund.Length > 0 && !string.IsNullOrEmpty(drFund[0]["TotalMoney"].ToString()))
            {
                dv[i]["Fund"] = Convert.ToDecimal(drFund[0]["TotalMoney"].ToString());
            }
        }

        if (!btc.ckIdentityName("ckBudgetYear"))
        {
            YearMode = "0";
        }
        else
        {
            YearMode = "1";
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        //Report.SetParameterValue("deptName", (DeptID != "") ? btc.getDeptName(DeptID) : "");
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource52"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport53() // รายงานสรุปงาน/กิจกรรมและงบประมาณที่ขออนุมัติดำเนินการ (เงินที่ตั้ง)
    {
        DataView dv, dv1, dv2, dv3, dv4, dv5, dv6, dv7, dv8, dv9, dv10;
        string StrSql = "";

        if (DeptID == "")
        {
            StrSql = " Select dm.DeptName, dm.DeptCode, a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df,  "
                    + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, c.CostsType, '' As StdName, '' As StrategyName, '' As IndicatorsSMSName, "
                    + " 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special, 0.0 As SPST, 0.0 As STS, 0.0 AS BKS "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                    + " Left Join Department dm On d.DeptCode = dm.DeptCode"
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        }
        else
        {
            StrSql = " Select dm.DeptName, dm.DeptCode, a.ProjectsCode, a.StrategiesCode, a.StudyYear, 'โครงการ' + a.ProjectsName ProjectsName, a.Df, "
                    + " a.Sort, b.Sort Sort1, b.StrategiesName, c.ActivityCode AcCode,'กิจกรรม' + c.ActivityName As FullName, c.CostsType, '' As StdName, '' As StrategyName, '' As IndicatorsSMSName, "
                    + " 0.0 As Subsidies, 0.0 As Revenue, 0.0 As Free, 0.0 As Welfare, 0.0 As SPK, 0.0 As Fund, 0.0 As Special, 0.0 As SPST, 0.0 As STS, 0.0 AS BKS "
                    + " From Projects a Left Join Strategies b On a.StrategiesCode = b.StrategiesCode "
                    + " Left Join Activity c On a.ProjectsCode = c.ProjectsCode "
                    + " Left Join dtAcDept d On c.ActivityCode = d.ActivityCode "
                    + " Left Join Department dm On d.DeptCode = dm.DeptCode"
                    + " Where a.DelFlag = 0 And c.DelFlag = 0 "
                    + " And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                    + " And d.DeptCode = '" + DeptID + "' ";
        }

        //if (btc.ckIdentityName("ckBudgetYear"))
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And c.BudgetYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
                StrSql += " And c.StudyYear = '" + YearB + "' ";
        //    }
        //}
        //else
        //{
        //    if (YearMode == "0")
        //    {
        //        StrSql += " And c.StudyYear = '" + YearB + "' ";
        //    }
        //    else
        //    {
        //        StrSql += " And c.BudgetYear = '" + YearB + "' ";
        //    }
        //}
        //}

        dv = Conn.Select(string.Format(StrSql + " Order By dm.Sort, b.Sort, a.Sort "));

        StrSql = @" Select distinct S.Sort As SortInd, Sd.Sort As SortStd, E.ActivityCode 
            From Evaluation E Inner Join Standard S On E.StandardCode = S.StandardCode
            Inner Join Side Sd On Sd.SideCode = S.SideCode 
            Where E.DelFlag = 0 And E.StudyYear = '{0}'
            Order By Sd.Sort, S.Sort ";
        DataView dvEvaluation = Conn.Select(string.Format(StrSql, YearB));

        StrSql = @" Select S.Sort As SortIndicatorsSMS, A.ActivityCode 
            From dtIndicatorSMS dtS Inner Join IndicatorSMS S On dtS.IndicatorSMSCode = S.IndicatorSMSCode
            Inner Join Projects P On dtS.ProjectsCode = P.ProjectsCode
            Inner Join Activity A On P.ProjectsCode = A.ProjectsCode
            Where P.StudyYear = '{0}' And A.StudyYear = '{0}' And P.DelFlag = 0 And A.DelFlag = 0 ";
        DataView dvIndicatorsSMS = Conn.Select(string.Format(StrSql, YearB));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 1 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                //if (btc.ckIdentityName("ckBudgetYear"))
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //}
                //else
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //}

                dv1 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 2 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                //if (btc.ckIdentityName("ckBudgetYear"))
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //}
                //else
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //}

                dv2 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 3 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                //if (btc.ckIdentityName("ckBudgetYear"))
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //}
                //else
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //}

                dv3 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                StrSql = " Select ckType From BudgetType Where DelFlag = 0 And ckType = 5 ";
                DataView dvckType5 = Conn.Select(StrSql);

                StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                    + " From Activity b, CostsDetail c, BudgetType d "
                    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                    + " And b.ActivityCode = c.ActivityCode "
                    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 5 "
                    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                //StrSql = " Select b.ActivityCode, IsNull(Sum(c.TotalMoney),0) TotalMoney "
                //    + " From Activity b, CostsDetail c, BudgetType d "
                //    + " Where b.DelFlag = 0 And d.DelFlag = 0 "
                //    + " And b.ActivityCode = c.ActivityCode "
                //    + " And c.BudgetTypeCode = d.BudgetTypeCode And d.ckType = 4 "
                //    + " And ((REPLACE(REPLACE(c.BudgetTypeOtherName,')',''),'อื่น ๆ (','') = 'มูลนิธิ') OR "
                //    + " (REPLACE(REPLACE(BudgetTypeOtherName,')',''),'อื่น ๆ (','') Not In ('งบอุดหนุน','รายได้สถานศึกษา','บำรุงการศึกษา','สมาคม','สวัสดิการ','โครงการพิเศษ','ส.ผ.ศ.ท.','ศ.ท.ศ.','บกศ.'))) "
                //    + " And b.ActivityCode = '" + dv[i]["AcCode"].ToString() + "' And b.ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ";

                //if (btc.ckIdentityName("ckBudgetYear"))
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //}
                //else
                //{
                //    if (YearMode == "0")
                //    {
                //        StrSql += " And b.StudyYear = '" + YearB + "' ";
                //    }
                //    else
                //    {
                //        StrSql += " And b.BudgetYear = '" + YearB + "' ";
                //    }
                //}

                dv6 = Conn.Select(StrSql + " Group By b.ActivityCode ");

                if (dv1.Count > 0)
                {
                    dv[i]["Subsidies"] = Convert.ToDecimal(dv1[0]["TotalMoney"]);
                }
                if (dv2.Count > 0)
                {
                    dv[i]["Revenue"] = Convert.ToDecimal(dv2[0]["TotalMoney"]);
                }
                if (dv3.Count > 0)
                {
                    dv[i]["Free"] = Convert.ToDecimal(dv3[0]["TotalMoney"]);
                }
                if (dv6.Count > 0)
                {
                    dv[i]["Fund"] = Convert.ToDecimal(dv6[0]["TotalMoney"]);
                }

                DataRow[] drStd = dvEvaluation.Table.Select("ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
                string StdName = "";
                if (drStd.Length > 0)
                {
                    for (int j = 0; j < drStd.Length; j++)
                    {
                        StdName += drStd[j]["SortStd"].ToString() + "." + drStd[j]["SortInd"].ToString() + ", ";
                    }
                    if (!string.IsNullOrEmpty(StdName))
                    {
                        dv[i]["StdName"] = StdName.Substring(0, StdName.Length - 2);
                    }
                    else
                    {
                        dv[i]["StdName"] = "";
                    }
                }

                //DataRow[] drIndicatorsSMS = dvIndicatorsSMS.Table.Select("ActivityCode = '" + dv[i]["AcCode"].ToString() + "'");
                //string IndicatorsSMSName = "";
                //if (drIndicatorsSMS.Length > 0)
                //{
                //    for (int j = 0; j < drIndicatorsSMS.Length; j++)
                //    {
                //        IndicatorsSMSName += drIndicatorsSMS[j]["SortIndicatorsSMS"].ToString() + ", ";
                //    }
                //    if (!string.IsNullOrEmpty(IndicatorsSMSName))
                //    {
                //        dv[i]["IndicatorsSMSName"] = "สมศ. " + IndicatorsSMSName.Substring(0, IndicatorsSMSName.Length - 2);
                //    }
                //    else
                //    {
                //        dv[i]["IndicatorsSMSName"] = "";
                //    }
                //}
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("yearmode", YearMode);

        ExportReport();

        this.Session["ReportSource53"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport54()  //รายงานแผนปฏิบัติการงานประจำ  ตาโครงสร้างการบริหาร
    {
        string StrSql = "";
        DataView dv, dv1;

        StrSql = @" Select distinct S.Sort As SortStd, I.Sort As SortInd, E.ActivityCode 
            From Evaluation E Inner Join Standard S On E.StandardCode = S.StandardCode
            Inner Join Indicators I On E.IndicatorsCode = I.IndicatorsCode 
            Where E.DelFlag = 0 And E.StudyYear = '{0}'
            Order By S.Sort, I.Sort ";
        DataView dvEvaluation = Conn.Select(string.Format(StrSql, YearB));

        StrSql = @" Select S.Sort As SortIndicatorsSMS, A.ActivityCode 
            From dtIndicatorSMS dtS Inner Join IndicatorSMS S On dtS.IndicatorSMSCode = S.IndicatorSMSCode
            Inner Join Projects P On dtS.ProjectsCode = P.ProjectsCode
            Inner Join Activity A On P.ProjectsCode = A.ProjectsCode
            Where P.StudyYear = '{0}' And A.StudyYear = '{0}' And P.DelFlag = 0 And A.DelFlag = 0 ";
        DataView dvIndicatorsSMS = Conn.Select(string.Format(StrSql, YearB));

        if (!string.IsNullOrEmpty(DeptID))
        {
            StrSql = " Select a.ActivityCode, a.ProjectsCode, a.ActivityName, a.Purpose, a.StudyYear, "
                + " IsNull(a.VolumeCan, 0) VolumeCan, a.SDate, a.EDate, '' DeptName, '' EmpName, "
                + " 0 As Bursary, 0 As OtherMoney, c.MainActivityID, c.Sort As MainAcSort, c.MainActivityName, c.aTarget, c.aTarget2, '' As StdName, '' As IndicatorsSMSName "
                + " From Activity a Left Join MainActivity c On a.MainActivityID = c.MainActivityID And c.DelFlag = 0 "
                + " Left Join dtAcDept b On a.ActivityCode = b.ActivityCode "
                + " Where a.DelFlag = 0 And b.DeptCode = '" + DeptID + "' "
                + " And a.CostsType = 1 And a.StudyYear = '" + YearB + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "'  ";
        }
        else
        {
            StrSql = " Select a.ActivityCode, a.ProjectsCode, a.ActivityName, a.Purpose, a.StudyYear, "
                + " IsNull(a.VolumeCan, 0) VolumeCan, a.SDate, a.EDate, '' DeptName, '' EmpName, "
                + " 0.0 As Bursary, 0.0 As OtherMoney, c.MainActivityID, c.Sort As MainAcSort, c.MainActivityName, c.aTarget, c.aTarget2, '' As StdName, '' As IndicatorsSMSName "
                + " From Activity a Left Join MainActivity c On a.MainActivityID = c.MainActivityID And c.DelFlag = 0 "
                + " Where a.DelFlag = 0 And a.CostsType = 1 And a.StudyYear = '" + YearB + "' "
                + " And a.SchoolID = '" + CurrentUser.SchoolID + "' ";
        }
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort "));

        for (int i = 0; i < dv.Count; i++)
        {
            dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            dv[i]["EmpName"] = btc.getAcEmpName(dv[i]["ActivityCode"].ToString());

            //หาเงินอุดหนุน เงินงบประมาณ
            StrSql = " Select IsNull(Sum(TotalMoney), 0) TotalMoney "
             + " From CostsDetail "
             + " Where ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' And BudgetTypeCode = '618fb47f-94b4-4998-ad52-5068a15e02d1' ";
            DataView dvT1 = Conn.Select(StrSql);
            if (dvT1.Count != 0)
            {
                dv[i]["Bursary"] = Convert.ToDecimal(dvT1[0]["TotalMoney"]);
            }

            //หาเงินอื่น ๆ เงินนอกงบประมาณ
            StrSql = " Select IsNull(Sum(TotalMoney), 0) TotalMoney "
             + " From CostsDetail "
             + " Where ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "' And BudgetTypeCode <> '618fb47f-94b4-4998-ad52-5068a15e02d1' ";
            DataView dvT2 = Conn.Select(StrSql);
            if (dvT2.Count != 0)
            {
                dv[i]["OtherMoney"] = Convert.ToDecimal(dvT2[0]["TotalMoney"]);
            }

            DataRow[] drStd = dvEvaluation.Table.Select("ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "'");
            string StdName = "";
            if (drStd.Length > 0)
            {
                for (int j = 0; j < drStd.Length; j++)
                {
                    StdName += drStd[j]["SortStd"].ToString() + "." + drStd[j]["SortInd"].ToString() + ", ";
                }
                if (!string.IsNullOrEmpty(StdName))
                {
                    dv[i]["StdName"] = "มฐ. " + StdName.Substring(0, StdName.Length - 2);
                }
                else
                {
                    dv[i]["StdName"] = "";
                }
            }

            DataRow[] drIndicatorsSMS = dvIndicatorsSMS.Table.Select("ActivityCode = '" + dv[i]["ActivityCode"].ToString() + "'");
            string IndicatorsSMSName = "";
            if (drIndicatorsSMS.Length > 0)
            {
                for (int j = 0; j < drIndicatorsSMS.Length; j++)
                {
                    IndicatorsSMSName += drIndicatorsSMS[j]["SortIndicatorsSMS"].ToString() + ", ";
                }
                if (!string.IsNullOrEmpty(IndicatorsSMSName))
                {
                    dv[i]["IndicatorsSMSName"] = "สมศ. " + IndicatorsSMSName.Substring(0, IndicatorsSMSName.Length - 2);
                }
                else
                {
                    dv[i]["IndicatorsSMSName"] = "";
                }
            }
        }

        StrSql = " Select * From ActivityOperation2 Order By RecNum ";
        dv1 = Conn.Select(StrSql);


        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data"));
        ds.Tables.Add(dv1.ToTable("detail"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());

        ExportReport();

        this.Session["ReportSource54"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport55() //รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา แบบแสดงวัตถุประสงค์เชิงกลยุทธ์
    {

        DataView dv;

        string strSQL = " Select a.StrategiesCode, 'กลยุทธ์ที่ ' + Cast(a.Sort As nVarChar) + '. ' + a.StrategiesName StrategiesName, "
            + " b.ProjectsCode, b.ProjectsName, c.ActivityCode, c.ActivityName, c.Results, c.EvaTool, '' As StrategicObjectives, "
            + " c.Purpose, c.Target, c.Target2, '' As StandardName, a.Sort As StgSort, b.Sort As PrjSort, c.Sort As AcSort "
            + " From Strategies a Left Join dtStrategies dtS On a.StrategiesCode = dtS.StrategiesCode "
            + " And dts.ProjectsCode In (Select ProjectsCode From Projects Where DelFlag = 0) "
            + " Left Join Projects b On dtS.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
            + " Left Join Activity c On b.ProjectsCode = c.ProjectsCode And c.DelFlag = 0 "
            + " Where a.DelFlag = 0 And a.SchoolID = '" + CurrentUser.SchoolID + "' And a.StudyYear = '" + YearB + "' ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And a.StrategiesCode = '" + id + "' ";
        }
        dv = Conn.Select(string.Format(strSQL + " Order By a.Sort, b.Sort, c.Sort "));

        strSQL = @" Select P.ProjectsCode, Cast(SO.Sort As nVarchar) + '. ' + SO.StrategicObjectivesName As StrategicObjectivesName
            From Projects P Inner Join Activity A On P.ProjectsCode = A.ProjectsCode
            Inner Join dtStrategicObjectives dtSO On P.ProjectsCode = dtSO.ProjectsCode
            Inner Join StrategicObjectives SO On dtSO.StrategicObjectivesCode = SO.StrategicObjectivesCode
            Where P.DelFlag = 0 And A.DelFlag = 0 And SO.DelFlag = 0 
            And a.SchoolID = '{0}' And a.StudyYear = '{1}' ";
        if (!string.IsNullOrEmpty(id))
        {
            strSQL = strSQL + " And P.StrategiesCode = '" + id + "' ";
        }
        strSQL += " Group By P.ProjectsCode, SO.Sort, SO.StrategicObjectivesName ";
        DataView dvStrategicObjectives = Conn.Select(string.Format(strSQL, CurrentUser.SchoolID, YearB));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                string StrategicObjectivesName = "";

                DataRow[] drStrategicObjectives = dvStrategicObjectives.Table.Select("ProjectsCode = '" + dv[i]["ProjectsCode"].ToString() + "' ");
                if (drStrategicObjectives.Length > 0)
                {
                    for (int j = 0; j < drStrategicObjectives.Length; j++)
                    {
                        StrategicObjectivesName += drStrategicObjectives[j]["StrategicObjectivesName"].ToString() + ",";
                    }
                    dv[i]["StrategicObjectives"] = StrategicObjectivesName.Substring(0, StrategicObjectivesName.Length - 1);
                }
                dv[i]["StandardName"] = btc.getStandardName(false, dv[i]["ActivityCode"].ToString());
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);

        ExportReport();

        this.Session["ReportSource55"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport56() // รายงานสรุปกิจกรรมและค่าใช้จ่ายทั้งหมดภายใต้โครงการ แยกตามกิจกรรม
    {
        DataView dv, dv1, dv2, dv3, dv4, dv5;
        string StrategicPlan = "";
        string StrSql = @" Select a.*, '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, '' As StrategicName
                From Projects a Where a.DelFlag = 0 And a.ProjectsCode = '{0}' ";
        dv5 = Conn.Select(string.Format(StrSql, id));

        if (dv5.Count != 0)
        {
            dv5[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardName"] = btc.getStandardNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["IndicatorsName"] = btc.getIndicatorsNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StrategicName"] = btc.getStrategicName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            StrategicPlan = dv5[0]["StrategicPlan"].ToString();
        }

        StrSql = " Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, "
                    + " a.Sort, b.Sort, '' As DeptName, b.MainActivityID, MA.MainActivityName, MA.Sort As MainAcSort "
                    + " From Projects a Left Join Activity b On a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " Left Join MainActivity MA On MA.MainActivityID = b.MainActivityID And MA.DelFlag = 0 "
                    + " Where a.DelFlag = 0 And a.ProjectsCode = '" + id + "' ";
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 1 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv1 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 2 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv2 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 3 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv3 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 5 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv4 = Conn.Select(string.Format(StrSql));

        StrSql = @" Select a.*, a.ListName As EntryCostsName, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End,
        e.EntryCostsName, c.Sort As SortAc, c.ActivityName 
        From CostsDetail a Inner Join BudgetType b On a.BudgetTypeCode = b.BudgetTypeCode
        Inner Join Activity c On a.ActivityCode = c.ActivityCode
        Inner Join Projects d On c.ProjectsCode = d.ProjectsCode
        Left Join EntryCosts e On a.EntryCostsCode = e.EntryCostsCode
        Where d.ProjectsCode = '{0}' ";
        DataView dv666 = Conn.Select(string.Format(StrSql + " Order By c.Sort, a.ListNo, b.Sort ", id));

        string IdentityName2 = "";

        StrSql = @" Select I.IdentityName From dtIdentityName dt Inner Join IdentityName I On dt.IdentityNameCode = I.IdentityNameCode
        Where dt.ProjectsCode = '{0}'";
        DataView dv7 = Conn.Select(string.Format(StrSql, id));
        if (dv7.Count != 0)
        {
            for (int i = 0; i < dv7.Count; i++)
            {
                IdentityName2 += dv7[i]["IdentityName"].ToString() + ", ";
            }
        }

        string CorporateStrategyName = "";
        StrSql = @" Select CR.CorporateStrategyID, 'ตัวชี้วัดที่ ' + Cast(S.Sort As nVarChar) + '.' + Cast(CR.Sort As nVarChar) + ' ' + CR.CorporateStrategyName CorporateStrategyName 
        From CorporateStrategy CR Inner Join Strategies S On CR.StrategiesCode = S.StrategiesCode 
        Inner Join dtCorporateStrategy dt On CR.CorporateStrategyID = dt.CorporateStrategyID
        Where dt.ProjectsCode = '{0}' ";

        DataView dv10 = Conn.Select(string.Format(StrSql, id));
        if (dv10.Count != 0)
        {
            for (int i = 0; i < dv10.Count; i++)
            {
                CorporateStrategyName += dv10[i]["CorporateStrategyName"].ToString() + ",";
            }
        }

        string StrategiesName = "";
        StrSql = " Select 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As StrategiesName From dtStrategies a, Strategies b Where a.ProjectsCode = '{0}' And a.StrategiesCode = b.StrategiesCode ";
        DataView dv9 = Conn.Select(string.Format(StrSql, id));
        if (dv9.Count != 0)
        {
            for (int i = 0; i < dv9.Count; i++)
            {
                StrategiesName += dv9[i]["StrategiesName"].ToString() + ",";
            }
        }

        string StrategicPlanName = "";
        StrSql = " Select 'ตัวชี้วัดที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicPlanName As StrategicPlanName From dtStrategicPlan a, StrategicPlan b Where a.ProjectsCode = '{0}' And a.StrategicPlanID = b.StrategicPlanID ";
        DataView dv11 = Conn.Select(string.Format(StrSql, id));
        if (dv11.Count != 0)
        {
            for (int i = 0; i < dv11.Count; i++)
            {
                StrategicPlanName += dv11[i]["StrategicPlanName"].ToString() + ",";
            }
        }

        string StrategicObjectivesName = "";
        StrSql = " Select 'วัตถุประสงค์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicObjectivesName As StrategicObjectivesName From dtStrategicObjectives a, StrategicObjectives b Where a.ProjectsCode = '{0}' And a.StrategicObjectivesCode = b.StrategicObjectivesCode ";
        DataView dv13 = Conn.Select(string.Format(StrSql, id));
        if (dv13.Count != 0)
        {
            for (int i = 0; i < dv13.Count; i++)
            {
                StrategicObjectivesName += dv13[i]["StrategicObjectivesName"].ToString() + ",";
            }
        }

        StrSql = @" Select A.ActivityCode, A.ActivityName, A.Sort, A.ProjectsCode, A.Target, A.Target2, 
            I.Indicators2Code, I.IndicatorsName2, I.Weight, I.WeightType, I.OffAll, I.OffThat, I.APercent, 
            I.CkCriterion, I.EvaAssessment, I.EvaTool, I.Sort As IntSort 
            From Activity A Left Join Indicators2 I On A.ActivityCode = I.ActivityCode 
            Where A.ProjectsCode = '{0}'
            Order By A.Sort, I.Sort ";
        DataView dvAc = Conn.Select(string.Format(StrSql, id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();
        string spnResponsibleName = dvSchool[0]["spnResponsibleName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("BudgetType1"));
        ds.Tables.Add(dv2.ToTable("BudgetType2"));
        ds.Tables.Add(dv3.ToTable("BudgetType3"));
        ds.Tables.Add(dv4.ToTable("BudgetType4"));
        ds.Tables.Add(dv5.ToTable("data1"));
        ds.Tables.Add(dv666.ToTable("ActivityBudget"));
        ds.Tables.Add(dvAc.ToTable("dvAc"));
        ds.Tables.Add(btc.GetLogoImg());
        ds.Tables.Add(btc.GetEmployeeSingnature(id));
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("PositionManagerName", PositionManagerName);
        Report.SetParameterValue("identityName", btc.ckIdentityName("iNameShow") ? dv5[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", !string.IsNullOrEmpty(IdentityName2) ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");  //btc.ckIdentityName("iNameShow2") ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");
        Report.SetParameterValue("StrategicName", btc.ckIdentityName("ckStrategic") ? dv5[0]["StrategicName"].ToString() : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv5[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv5[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("StrategicPlanName", btc.ckIdentityName("ckStrategicPlan") ? (!string.IsNullOrEmpty(StrategicPlanName) ? StrategicPlanName.Substring(0, StrategicPlanName.Length - 1) : "") : "");
        Report.SetParameterValue("CorporateStrategyName", btc.ckIdentityName("ckCorporateStrategy") ? (!string.IsNullOrEmpty(CorporateStrategyName) ? CorporateStrategyName.Substring(0, CorporateStrategyName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategiesName", btc.ckIdentityName("ckStrategies") ? (!string.IsNullOrEmpty(StrategiesName) ? StrategiesName.Substring(0, StrategiesName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategicObjectivesName", btc.ckIdentityName("ckStrategicObjectives") ? (!string.IsNullOrEmpty(StrategicObjectivesName) ? StrategicObjectivesName.Substring(0, StrategicObjectivesName.Length - 1) : "") : "");
        Report.SetParameterValue("spnResponsibleName", spnResponsibleName);
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("ckSign", Request["ckSign"]);
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);
        Report.SetParameterValue("StrategicPlan", StrategicPlan);
        Report.SetParameterValue("CreateProjectsName", btc.getEmpName(dv5[0]["CreateUser"].ToString()));
        Report.SetParameterValue("ResponsibleName", dv5[0]["ResponsibleName"].ToString());
        Report.SetParameterValue("StandardNew", btc.ckIdentityName("ckStandardNew") ? "1" : ""); // โหมดมาตรฐานใหม่
        string SideName = btc.getSideNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
        Report.SetParameterValue("SideName", SideName);
        ExportReport();

        this.Session["ReportSource56"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport60() //กราฟสรุปจำนวนโครงการ
    {
        string strSql = "";
        DataView dv = null;
        string strNotPATWit = "";
        if (CurrentUser.MainDeptID.ToUpper() == "BA422CC9-6E77-4D43-BAFB-7539B9286E59")
        {
            strNotPATWit = " And SD.MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        }

        //โครงการทั้งหมด
        strSql = @" Select D.DeptCode, REPLACE(D.DeptName,N'สำนัก','สน.')  As Name, Count(P.ProjectsCode) data, 0 As data1, 0 As data2, 0 As data3, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //โครงการที่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data1, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv1 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //โครงการที่ไม่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 0 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv2 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));
        if (dv.Count > 0)
        {
            for (int j = 0; j < dv.Count; j++)
            {
                DataRow[] drData1 = dv1.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData1.Length > 0)
                {
                    dv[j]["data1"] = Convert.ToInt32(drData1[0]["data1"]);
                }

                DataRow[] drData2 = dv2.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData2.Length > 0)
                {
                    dv[j]["data2"] = Convert.ToInt32(drData2[0]["data2"]);
                }

                dv[j]["data3"] = Convert.ToInt32(dv[j]["data"]) - Convert.ToInt32(drData1[0]["data1"]);
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("flagDate", "1");

        ExportReport();

        this.Session["ReportSource60"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport61() //กราฟเปรียบเทียบโครงการตามแผนงานกับโครงการที่ดำเนินการเสร็จเรียบร้อย
    {
        string strSql = "";
        DataView dv = null;

        //โครงการทั้งหมด
        strSql = @" Select D.DeptCode, REPLACE(D.DeptName,N'สำนัก','สน.')  As Name, Count(P.ProjectsCode) data, 0 As data1, 0 As data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}'
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB));

        //โครงการที่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data1, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}'
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv1 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB));

        //คุณภาพโครงการ
        strSql = @" Select D.DeptCode, D.DeptName As Name, IsNull(Sum(P.Quality), 0) / Case Count(P.ProjectsCode) When 0 Then 1 Else Count(P.ProjectsCode) End data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 
		And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}'
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv2 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB));
        if (dv.Count > 0)
        {
            for (int j = 0; j < dv.Count; j++)
            {
                DataRow[] drData1 = dv1.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData1.Length > 0)
                {
                    dv[j]["data1"] = Convert.ToInt32(drData1[0]["data1"]);
                }

                DataRow[] drData2 = dv2.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData2.Length > 0)
                {
                    dv[j]["data2"] = Convert.ToInt32(drData2[0]["data2"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);

        ExportReport();

        this.Session["ReportSource61"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport62() //กราฟเปรียบเทียบ งบประมาณตามแผนกับงบประมาณที่ใช้จริง
    {
        string strSql = "";
        DataView dv = null;
        string strNotPATWit = "";
        if (CurrentUser.MainDeptID.ToUpper() == "BA422CC9-6E77-4D43-BAFB-7539B9286E59")
        {
            strNotPATWit = " And SD.MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        }

        //โครงการอนุมัติทั้งหมด
        strSql = @" Select D.DeptCode, REPLACE(D.DeptName,N'สำนัก','สน.')  As Name, Count(P.ProjectsCode) data, 0 As data1, 0 As data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //งบอนุมัติตั้งขึ้น
        strSql = @" Select D.DeptCode, D.DeptName As Name, IsNull(Sum(A.TotalAmount), 0) data1, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Left Join Activity A On A.ProjectsCode = P.ProjectsCode And A.DelFlag = 0
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv1 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //งบค่าใช้จ่ายจริง
        strSql = @" Select D.DeptCode, D.DeptName As Name, IsNull(Sum(A.TotalAmount2), 0) data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 
		And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Left Join Activity A On A.ProjectsCode = P.ProjectsCode And A.DelFlag = 0
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv2 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));
        if (dv.Count > 0)
        {
            for (int j = 0; j < dv.Count; j++)
            {
                DataRow[] drData1 = dv1.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData1.Length > 0)
                {
                    dv[j]["data1"] = Convert.ToInt32(drData1[0]["data1"]);
                }

                DataRow[] drData2 = dv2.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData2.Length > 0)
                {
                    dv[j]["data2"] = Convert.ToInt32(drData2[0]["data2"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("flagDate", "1");

        ExportReport();

        this.Session["ReportSource62"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport63() //กราฟรายงานคุณภาพโครงการ / กิจกรรมตามแผนงาน
    {
        string strSql = "";
        DataView dv = null;
        string strNotPATWit = "";
        if (CurrentUser.MainDeptID.ToUpper() == "BA422CC9-6E77-4D43-BAFB-7539B9286E59")
        {
            strNotPATWit = " And SD.MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        }

        //โครงการทั้งหมด
        strSql = @" Select D.DeptCode, REPLACE(D.DeptName,N'สำนัก','สน.')  As Name, Count(P.ProjectsCode) data, 0 As data1, 0 As data2, 0 As data3, 0 As data4, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' ";
        //if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        //{
        //    strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        //}
        //if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        //{
        //    strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        //}
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //โครงการที่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data1, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv1 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //คุณภาพโครงการ
        strSql = @" Select D.DeptCode, D.DeptName As Name, IsNull(Sum(P.Quality), 0) / Case Count(P.ProjectsCode) When 0 Then 1 Else Count(P.ProjectsCode) End data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 
		And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv2 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));

        //โครงการไตรมาส
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data4, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (!string.IsNullOrEmpty(Request.QueryString["monthB"]))
        {
            strSql += btc.getMonthOfMonth(Request.QueryString["monthB"], YearB);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["quarter"]))
        {
            strSql += btc.getMonthOfQuarter(Request.QueryString["quarter"], YearB);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv4 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, YearB, strNotPATWit));
        if (dv.Count > 0)
        {
            Int32 dt = 1;
            Int32 dt1 = 0;

            for (int j = 0; j < dv.Count; j++)
            {
                DataRow[] drData1 = dv1.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData1.Length > 0)
                {
                    dv[j]["data1"] = Convert.ToInt32(drData1[0]["data1"]);
                    dt1 = Convert.ToInt32(drData1[0]["data1"]);
                }

                DataRow[] drData2 = dv2.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData2.Length > 0)
                {
                    dv[j]["data2"] = Convert.ToInt32(drData2[0]["data2"]);
                }

                if (Convert.ToInt32(dv[j]["data"]) != 0)
                {
                    dt = Convert.ToInt32(dv[j]["data"]);
                }
                dv[j]["data3"] = (100 * dt1) / dt;

                DataRow[] drData4 = dv4.Table.Select("DeptCode = '" + dv[j]["DeptCode"].ToString() + "'");
                if (drData4.Length > 0)
                {
                    dv[j]["data4"] = Convert.ToInt32(drData4[0]["data4"]);
                }
            }
        }

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("data1"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("yearB", YearB);
        Report.SetParameterValue("flagDate", "1");

        ExportReport();

        this.Session["ReportSource63"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport64() // รายงานสรุปเงินอุดหนุนเรียนฟรี 15 ปี
    {
        DataView dv, dv1, dv2, dv3;
        string StrSql = @" Select * From ftYearBudgetTypeDetail Order By BudgetDetailTypeID ";
        dv = Conn.Select(string.Format(StrSql));

        StrSql = @" Select M.MasterID, M.DeptCode, M.Term, M.StudyYear, MD.ItemID, MD.Price, MD.Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount, 
        C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Amount2, 0) Amount2, 
        IsNull(MD.Price2, 0) Price2, IsNull(MD.Price2, 0) * IsNull(MD.Amount2, 0) As TotalAmount2, MD.WithdrawUser, MD.WithdrawDate, MD.BudgetDetailTypeID 
        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
        Inner Join ftYearClass C On MD.ClassID = C.ClassID
        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
        Inner Join Department D On M.DeptCode = D.DeptCode
        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
        Inner Join MainDepartment MDt ON SD.MainDeptCode = MDt.MainDeptCode
        Where M.DelFlag = 0 And M.MasterID = '{0}'  ";

        dv1 = Conn.Select(string.Format(StrSql + " And C.ClassID = 1 Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID", Request.QueryString["mid"]));
        dv2 = Conn.Select(string.Format(StrSql + " And C.ClassID = 2 Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID", Request.QueryString["mid"]));
        dv3 = Conn.Select(string.Format(StrSql + " And C.ClassID = 3 Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID", Request.QueryString["mid"]));


        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string DeptName = "";
        string StudyYear = "";
        string Term = "";
        decimal SetMoneyAcType = 0;
        decimal MoneyAcType = 0;
        StrSql = "Select Term, StudyYear, DeptCode From ftYearMaster Where MasterID = '{0}' ";
        DataView dvM = Conn.Select(string.Format(StrSql, Request.QueryString["mid"]));
        if (dvM.Count > 0)
        {
            DeptName = btc.getDeptName(dvM[0]["DeptCode"].ToString());
            StudyYear = dvM[0]["StudyYear"].ToString();
            Term = dvM[0]["Term"].ToString();

            if (dvM[0]["Term"].ToString() == "1")
            {
                DataView dvSetBudgetAcType = null;
                StrSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2, IsNull(AT.SetMoney, 0) SetMoney
						From ftYearWithdrawActivityType AT Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(StrSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    SetMoneyAcType = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]);
                }
            }
            else
            {
                decimal SetBudgetAcType = 0;
                decimal SumTotal = 0;
                string mid = Request.QueryString["mid"];

                DataView dvSetBudgetAcType = null;
                string strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    SetMoneyAcType = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]);
                }
                else
                {
                    StrSql = @" Select MasterID From ftYearMaster
						Where StudyYear = '{0}' And Term = '1' And DelFlag = 0
						And DeptCode = '{1}' ";
                    DataView dvMid = Conn.Select(string.Format(StrSql, dvM[0]["StudyYear"].ToString(), dvM[0]["DeptCode"].ToString()));
                    if (dvMid.Count > 0)
                    {
                        mid = dvMid[0]["MasterID"].ToString();
                    }

                    StrSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                    dvSetBudgetAcType = Conn.Select(string.Format(StrSql, mid));
                    if (dvSetBudgetAcType.Count > 0)
                    {
                        SetBudgetAcType = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]);
                    }

                    StrSql = @" Select IsNull(Sum(IsNull(MD.Amount, 0)), 0) TotalStudent, IsNull(Sum(IsNull(MD.Price, 0)), 0) TotalPrice, 
                IsNull(Sum((IsNull(MD.Amount, 0) * IsNull(MD.Price, 0))), 0) SumTotal
		        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
		        Where M.DelFlag = 0 And M.MasterID = '{0}' And MD.BudgetDetailTypeID = 5 ";
                    DataView dvMoneyActivity = Conn.Select(string.Format(StrSql, mid));
                    if (dvMoneyActivity.Count > 0)
                    {
                        SumTotal = Convert.ToDecimal(dvMoneyActivity[0]["SumTotal"]);
                    }

                    StrSql = @" Select IsNull(Sum(CD.TotalMoney2), 0) As MoneyAcType From Activity A 
                Inner Join dtAcDept dt On A.ActivityCode = dt.ActivityCode
		        Inner Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
		        Where A.DelFlag = 0 And A.ApproveFlag = 1 And A.Status = 3 
		        And A.StudyYear = '{0}' And A.Term = '1' And dt.DeptCode = '{1}'
		        And CD.BudgetTypeCode = 'b27b079f-5da5-4278-a172-b974be1ed317' ";
                    DataView dvMoneyAcType = Conn.Select(string.Format(StrSql, dvM[0]["StudyYear"].ToString(), dvM[0]["DeptCode"].ToString()));
                    if (dvMoneyAcType.Count > 0)
                    {
                        MoneyAcType = Convert.ToDecimal(dvMoneyAcType[0]["MoneyAcType"]);
                    }

                    SetMoneyAcType = ((SetBudgetAcType + SumTotal) - MoneyAcType);
                }
                
            }

            StrSql = @" Select IsNull(Sum(CD.TotalMoney2), 0) As MoneyAcType From Activity A 
                Inner Join dtAcDept dt On A.ActivityCode = dt.ActivityCode 
		        Inner Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
		        Where A.DelFlag = 0 And A.ApproveFlag = 1 And A.Status = 3 
		        And A.StudyYear = '{0}' And A.Term = '{1}' And dt.DeptCode = '{2}'
		        And CD.BudgetTypeCode = 'b27b079f-5da5-4278-a172-b974be1ed317' ";

            DataView dvMoneyAcType1 = Conn.Select(string.Format(StrSql, dvM[0]["StudyYear"], dvM[0]["Term"], dvM[0]["DeptCode"].ToString()));
            if (dvMoneyAcType1.Count > 0)
            {
                MoneyAcType = Convert.ToDecimal(dvMoneyAcType1[0]["MoneyAcType"]);
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("Dept1"));
        ds.Tables.Add(dv2.ToTable("Dept2"));
        ds.Tables.Add(dv3.ToTable("Dept3"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Landscape;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("DeptName", DeptName);
        Report.SetParameterValue("StudyYear", StudyYear);
        Report.SetParameterValue("Term", Term);
        Report.SetParameterValue("SetMoney", SetMoneyAcType);
        Report.SetParameterValue("MoneyAcType", MoneyAcType);
        ExportReport();

        this.Session["ReportSource64"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport65() // รายงานสรุปเงินอุดหนุนเรียนฟรี 15 ปี
    {
        DataView dv, dv1, dv2;
        string StrSql = @" Select * From ftYearBudgetTypeDetail Order By BudgetDetailTypeID ";
        dv = Conn.Select(string.Format(StrSql));

        StrSql = @" Select M.MasterID, M.DeptCode, M.Term, M.StudyYear, Sum(IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0))) As TotalAmount, 
        Sum(IsNull(MD.Price2, 0) * IsNull(MD.Amount2, 0)) As TotalAmount2, MD.BudgetDetailTypeID 
        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
        Inner Join Department D On M.DeptCode = D.DeptCode
        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
        Inner Join MainDepartment MDt ON SD.MainDeptCode = MDt.MainDeptCode
        Where M.DelFlag = 0 And M.MasterID = (Select MasterID From ftYearMaster Where DeptCode = '{0}' And StudyYear = {1} And Term = {2})
		Group By M.MasterID, M.DeptCode, M.Term, M.StudyYear, MD.BudgetDetailTypeID   ";

        dv1 = Conn.Select(string.Format(StrSql, DeptID, YearB, 1));
        dv2 = Conn.Select(string.Format(StrSql, DeptID, YearB, 2));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string DeptName = "";
        string StudyYear = "";
        decimal SetMoneyAcType = 0;
        decimal MoneyAcTypeTerm1 = 0;
        decimal MoneyAcTypeTerm2 = 0;
        StrSql = "Select Term, StudyYear, DeptCode From ftYearMaster Where MasterID = (Select MasterID From ftYearMaster Where DeptCode = '{0}' And StudyYear = {1} And Term = {2}) ";
        DataView dvM = Conn.Select(string.Format(StrSql, DeptID, YearB, 1));
        if (dvM.Count > 0)
        {
            DeptName = btc.getDeptName(dvM[0]["DeptCode"].ToString());
            StudyYear = dvM[0]["StudyYear"].ToString();

            if (dvM[0]["Term"].ToString() == "1")
            {
                DataView dvSetBudgetAcType = null;
                StrSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2, IsNull(AT.SetMoney, 0) SetMoney
						From ftYearWithdrawActivityType AT Where AT.MasterID = (Select MasterID From ftYearMaster Where DeptCode = '{0}' And StudyYear = {1} And Term = {2}) ";
                dvSetBudgetAcType = Conn.Select(string.Format(StrSql, DeptID, Convert.ToInt32(YearB), 1));
                if (dvSetBudgetAcType.Count > 0)
                {
                    SetMoneyAcType = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]);
                }
            }
            else
            {

            }

            StrSql = @" Select IsNull(Sum(CD.TotalMoney2), 0) As MoneyAcType From Activity A 
                Inner Join dtAcDept dt On A.ActivityCode = dt.ActivityCode 
		        Inner Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
		        Where A.DelFlag = 0 And A.ApproveFlag = 1 And A.Status = 3 
		        And A.StudyYear = '{0}' And A.Term = '{1}' And dt.DeptCode = '{2}'
		        And CD.BudgetTypeCode = 'b27b079f-5da5-4278-a172-b974be1ed317' ";

            DataView dvMoneyAcTypeTerm1 = Conn.Select(string.Format(StrSql, YearB, 1, DeptID));
            if (dvMoneyAcTypeTerm1.Count > 0)
            {
                MoneyAcTypeTerm1 = Convert.ToDecimal(dvMoneyAcTypeTerm1[0]["MoneyAcType"]);
            }

            DataView dvMoneyAcTypeTerm2 = Conn.Select(string.Format(StrSql, YearB, 2, DeptID));
            if (dvMoneyAcTypeTerm2.Count > 0)
            {
                MoneyAcTypeTerm2 = Convert.ToDecimal(dvMoneyAcTypeTerm2[0]["MoneyAcType"]);
            }
        }

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("Term1"));
        ds.Tables.Add(dv2.ToTable("Term2"));
        ds.Tables.Add(btc.GetLogoImg());
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("DeptName", DeptName);
        Report.SetParameterValue("StudyYear", StudyYear);
        Report.SetParameterValue("SetMoney", SetMoneyAcType);
        Report.SetParameterValue("MoneyAcTypeTerm1", MoneyAcTypeTerm1);
        Report.SetParameterValue("MoneyAcTypeTerm2", MoneyAcTypeTerm2);
        ExportReport();

        this.Session["ReportSource65"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }
    private void SetReport66() // รายงานสรุปโครงการ
    {
        DataView dv, dv1, dv2, dv3, dv4, dv5;
        string StrategicPlan = "";
        string StrSql = @" Select a.*, '' As StandardNationName, '' As StandardMinistryName, '' As StandardName, '' As IndicatorsName, '' As StrategicName, Isnull(a.Quality, 0) As PjQuality
                From Projects a Where a.DelFlag = 0 And a.ProjectsCode = '{0}' ";
        dv5 = Conn.Select(string.Format(StrSql, id));

        if (dv5.Count != 0)
        {
            dv5[0]["StandardNationName"] = btc.getStandardNationName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardMinistryName"] = btc.getStandardMinistryName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StandardName"] = btc.getStandardNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["IndicatorsName"] = btc.getIndicatorsNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            dv5[0]["StrategicName"] = btc.getStrategicName(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
            StrategicPlan = dv5[0]["StrategicPlan"].ToString();
        }

        StrSql = " Select a.ProjectsCode, a.ProjectsName, b.ActivityCode, b.ActivityName, "
                    + " a.Sort, b.Sort, '' As DeptName, b.MainActivityID, MA.MainActivityName, MA.Sort As MainAcSort "
                    + " From Projects a Left Join Activity b On a.ProjectsCode = b.ProjectsCode And b.DelFlag = 0 "
                    + " Left Join MainActivity MA On MA.MainActivityID = b.MainActivityID And MA.DelFlag = 0 "
                    + " Where a.DelFlag = 0 And a.ProjectsCode = '" + id + "' ";
        dv = Conn.Select(string.Format(StrSql + " Order By a.Sort, b.Sort "));

        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                dv[i]["DeptName"] = btc.getAcDeptName(dv[i]["ActivityCode"].ToString());
            }
        }

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 1 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv1 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 2 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv2 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 3 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv3 = Conn.Select(string.Format(StrSql));

        StrSql = " Select a.ProjectsCode, b.ActivityCode, IsNull(Sum(TotalMoney),0) TotalMoney "
                    + " From Projects a Inner Join Activity b On a.ProjectsCode = b.ProjectsCode "
                    + " Left Join CostsDetail c On b.ActivityCode = c.ActivityCode "
                    + " Left Join BudgetType d On c.BudgetTypeCode = d.BudgetTypeCode "
                    + " Where a.DelFlag = 0 And b.DelFlag = 0 And d.ckType = 5 And a.ProjectsCode = '" + id + "' "
                    + " Group By a.ProjectsCode, b.ActivityCode ";
        dv4 = Conn.Select(string.Format(StrSql));

        StrSql = @" Select a.*, a.ListName As EntryCostsName, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End,
        e.EntryCostsName, c.Sort As SortAc, c.ActivityName 
        From CostsDetail a Inner Join BudgetType b On a.BudgetTypeCode = b.BudgetTypeCode
        Inner Join Activity c On a.ActivityCode = c.ActivityCode
        Inner Join Projects d On c.ProjectsCode = d.ProjectsCode
        Left Join EntryCosts e On a.EntryCostsCode = e.EntryCostsCode
        Where d.ProjectsCode = '{0}' ";
        DataView dv666 = Conn.Select(string.Format(StrSql + " Order By c.Sort, a.ListNo, b.Sort ", id));

        string IdentityName2 = "";

        StrSql = @" Select I.IdentityName From dtIdentityName dt Inner Join IdentityName I On dt.IdentityNameCode = I.IdentityNameCode
        Where dt.ProjectsCode = '{0}'";
        DataView dv7 = Conn.Select(string.Format(StrSql, id));
        if (dv7.Count != 0)
        {
            for (int i = 0; i < dv7.Count; i++)
            {
                IdentityName2 += dv7[i]["IdentityName"].ToString() + ", ";
            }
        }

        string CorporateStrategyName = "";
        StrSql = @" Select CR.CorporateStrategyID, 'ตัวชี้วัดที่ ' + Cast(S.Sort As nVarChar) + '.' + Cast(CR.Sort As nVarChar) + ' ' + CR.CorporateStrategyName CorporateStrategyName 
        From CorporateStrategy CR Inner Join Strategies S On CR.StrategiesCode = S.StrategiesCode 
        Inner Join dtCorporateStrategy dt On CR.CorporateStrategyID = dt.CorporateStrategyID
        Where dt.ProjectsCode = '{0}' ";

        DataView dv10 = Conn.Select(string.Format(StrSql, id));
        if (dv10.Count != 0)
        {
            for (int i = 0; i < dv10.Count; i++)
            {
                CorporateStrategyName += dv10[i]["CorporateStrategyName"].ToString() + ",";
            }
        }

        string StrategiesName = "";
        StrSql = " Select 'กลยุทธ์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategiesName As StrategiesName From dtStrategies a, Strategies b Where a.ProjectsCode = '{0}' And a.StrategiesCode = b.StrategiesCode ";
        DataView dv9 = Conn.Select(string.Format(StrSql, id));
        if (dv9.Count != 0)
        {
            for (int i = 0; i < dv9.Count; i++)
            {
                StrategiesName += dv9[i]["StrategiesName"].ToString() + ",";
            }
        }

        string StrategicPlanName = "";
        StrSql = " Select 'ตัวชี้วัดที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicPlanName As StrategicPlanName From dtStrategicPlan a, StrategicPlan b Where a.ProjectsCode = '{0}' And a.StrategicPlanID = b.StrategicPlanID ";
        DataView dv11 = Conn.Select(string.Format(StrSql, id));
        if (dv11.Count != 0)
        {
            for (int i = 0; i < dv11.Count; i++)
            {
                StrategicPlanName += dv11[i]["StrategicPlanName"].ToString() + ",";
            }
        }
        string StrategicObjectivesName = "";
        StrSql = " Select 'วัตถุประสงค์ที่ ' + Cast(b.Sort As nVarChar) + '. ' + b.StrategicObjectivesName As StrategicObjectivesName From dtStrategicObjectives a, StrategicObjectives b Where a.ProjectsCode = '{0}' And a.StrategicObjectivesCode = b.StrategicObjectivesCode ";
        DataView dv13 = Conn.Select(string.Format(StrSql, id));
        if (dv13.Count != 0)
        {
            for (int i = 0; i < dv13.Count; i++)
            {
                StrategicObjectivesName += dv13[i]["StrategicObjectivesName"].ToString() + ",";
            }
        }

        StrSql = @" Select A.ActivityCode, A.ActivityName, A.Sort, A.ProjectsCode, A.Target, A.Target2, 
            I.Indicators2Code, I.IndicatorsName2, I.Weight, I.WeightType, I.RateType, I.OffAll, I.OffThat, I.APercent, 
            I.CkCriterion, I.EvaAssessment, I.EvaTool, I.Sort As IntSort 
            From Activity A Left Join Indicators2 I On A.ActivityCode = I.ActivityCode 
            Where A.ProjectsCode = '{0}'
            Order By A.Sort, I.Sort ";
        DataView dvAc = Conn.Select(string.Format(StrSql, id));

        DataView dvSchool = btc.getMasterSchool();
        string schoolName = "";
        if (dvSchool.Count > 0)
        {
            schoolName = dvSchool[0]["SchoolName"].ToString();
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }

        string ManagerName = dvSchool[0]["ManagerName"].ToString();
        string PositionManagerName = dvSchool[0]["PositionManagerName"].ToString();
        string spnResponsibleName = dvSchool[0]["spnResponsibleName"].ToString();

        ds = new DataSet();
        ds.Tables.Add(dv.ToTable("dataMaster"));
        ds.Tables.Add(dv1.ToTable("BudgetType1"));
        ds.Tables.Add(dv2.ToTable("BudgetType2"));
        ds.Tables.Add(dv3.ToTable("BudgetType3"));
        ds.Tables.Add(dv4.ToTable("BudgetType4"));
        ds.Tables.Add(dv5.ToTable("data1"));
        ds.Tables.Add(dv666.ToTable("ActivityBudget"));
        ds.Tables.Add(dvAc.ToTable("dvAc"));
        ds.Tables.Add(btc.GetLogoImg());
        ds.Tables.Add(btc.GetEmployeeSingnature(id));
        //ds.WriteXmlSchema(Server.MapPath(reportName + ".xsd"));
        //return;

        Report.Load(Server.MapPath(reportName + ".rpt"));

        Report.SetDataSource(ds);
        Report.PrintOptions.PaperSize = PaperSize.PaperA4;
        Report.PrintOptions.PaperOrientation = PaperOrientation.Portrait;

        Report.SetParameterValue("schoolName", schoolName);
        Report.SetParameterValue("managerName", ManagerName);
        Report.SetParameterValue("PositionManagerName", PositionManagerName);
        Report.SetParameterValue("identityName", btc.ckIdentityName("iNameShow") ? dv5[0]["IdentityName"].ToString() : "");
        Report.SetParameterValue("identityName2", !string.IsNullOrEmpty(IdentityName2) ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");  //btc.ckIdentityName("iNameShow2") ? IdentityName2.Substring(0, IdentityName2.Length - 2) : "");
        Report.SetParameterValue("StrategicName", btc.ckIdentityName("ckStrategic") ? dv5[0]["StrategicName"].ToString() : "");
        Report.SetParameterValue("StandardNationName", btc.ckIdentityName("ckStandardNation") ? dv5[0]["StandardNationName"].ToString() : "");
        Report.SetParameterValue("StandardMinistryName", btc.ckIdentityName("ckStandardMinistry") ? dv5[0]["StandardMinistryName"].ToString() : "");
        Report.SetParameterValue("StrategicPlanName", btc.ckIdentityName("ckStrategicPlan") ? (!string.IsNullOrEmpty(StrategicPlanName) ? StrategicPlanName.Substring(0, StrategicPlanName.Length - 1) : "") : "");
        Report.SetParameterValue("CorporateStrategyName", btc.ckIdentityName("ckCorporateStrategy") ? (!string.IsNullOrEmpty(CorporateStrategyName) ? CorporateStrategyName.Substring(0, CorporateStrategyName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategiesName", btc.ckIdentityName("ckStrategies") ? (!string.IsNullOrEmpty(StrategiesName) ? StrategiesName.Substring(0, StrategiesName.Length - 1) : "") : "");
        Report.SetParameterValue("StrategicObjectivesName", btc.ckIdentityName("ckStrategicObjectives") ? (!string.IsNullOrEmpty(StrategicObjectivesName) ? StrategicObjectivesName.Substring(0, StrategicObjectivesName.Length - 1) : "") : "");
        Report.SetParameterValue("spnResponsibleName", spnResponsibleName);
        Report.SetParameterValue("FullText", btc.ckIdentityName("ckFullText"));
        Report.SetParameterValue("pjName", ConfigurationManager.AppSettings["ProjectName"].ToString());
        Report.SetParameterValue("ckSign", Request["ckSign"]);
        Report.SetParameterValue("ckLogo", Request["ckLogo"]);
        Report.SetParameterValue("StrategicPlan", StrategicPlan);
        Report.SetParameterValue("PjQuality", Convert.ToDecimal(dv5[0]["PjQuality"]));

        string Conclusion = dv5[0]["Conclusion"].ToString();
        string Performance = dv5[0]["Performance"].ToString();
        string Problem = dv5[0]["Problem"].ToString();
        string Solutions = dv5[0]["Solutions"].ToString();
        Report.SetParameterValue("Conclusion", Conclusion);
        Report.SetParameterValue("Performance", Performance);
        Report.SetParameterValue("Problem", Problem);
        Report.SetParameterValue("Solutions", Solutions);

        decimal TotalAmount = 0;
        decimal TotalAmount2 = 0;
        StrSql = @"Select P.ProjectsCode, IsNull(Sum(CD.TotalMoney), 0) TotalMoney, IsNull(Sum(CD.TotalMoney2), 0) TotalMoney2 From Projects P 
            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
            Where P.DelFlag = 0 And A.DelFlag = 0 And P.ProjectsCode = '{0}' 
            Group By P.ProjectsCode ";
        DataView dvTotalAmout = Conn.Select(string.Format(StrSql, Request.QueryString["id"]));
        if (dvTotalAmout.Count > 0)
        {
            TotalAmount = Convert.ToDecimal(dvTotalAmout[0]["TotalMoney"]);
            TotalAmount2 = Convert.ToDecimal(dvTotalAmout[0]["TotalMoney2"]);
        }
        Report.SetParameterValue("TotalAmount", TotalAmount);
        Report.SetParameterValue("TotalAmount2", TotalAmount2);

        decimal TotalMoney15Year = 0;
        StrSql = @"Select P.ProjectsCode, IsNull(Sum(CD.TotalMoney2), 0) TotalMoney15Year From Projects P 
            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
            Where P.DelFlag = 0 And A.DelFlag = 0 And P.ProjectsCode = '{0}' 
			And CD.BudgetTypeCode = 'b27b079f-5da5-4278-a172-b974be1ed317'
			Group By P.ProjectsCode";
        DataView dvTotalMoney15Year = Conn.Select(string.Format(StrSql, Request.QueryString["id"]));
        if (dvTotalMoney15Year.Count > 0)
        {
            TotalMoney15Year = Convert.ToDecimal(dvTotalMoney15Year[0]["TotalMoney15Year"]);
        }
        Report.SetParameterValue("TotalMoney15Year", TotalMoney15Year);

        Report.SetParameterValue("StandardNew", btc.ckIdentityName("ckStandardNew") ? "1" : ""); // โหมดมาตรฐานใหม่
        string SideName = btc.getSideNameOfProjects(btc.ckIdentityName("ckFullText"), dv5[0]["ProjectsCode"].ToString());
        Report.SetParameterValue("SideName", SideName);
        ExportReport();

        this.Session["ReportSource66"] = Report;
        CrystalReportViewer1.ReportSource = Report;
        CrystalReportViewer1.DataBind();
    }




    private void ExportReport()
    {
        // ============================ Export to pdf file =============================
        if (rptType == "p")
        {
            Report.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "ExportedReport");
        }
        else
        {
            if (rptType == "w")
            {
                Report.ExportToHttpResponse(ExportFormatType.WordForWindows, Response, false, Page.Title);
            }
            else
            {
                Report.ExportToHttpResponse(ExportFormatType.Excel, Response, false, Page.Title);
            }
        }
        Report.PrintToPrinter(2, true, 1, 2);
        // =============================================================================
    }
    protected override void OnPreInit(EventArgs e)
    {
        //CrystalReportViewer1.ReportSource = this.Session["ReportSource"];
        //base.OnPreInit(e);
        if (Request["rpt"] == "1")
        {
            if (Session["ReportSource1"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource1"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "2")
        {
            if (Session["ReportSource2"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource2"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "3")
        {
            if (Session["ReportSource3"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource3"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "4")
        {
            if (Session["ReportSource4"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource4"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "5")
        {
            if (Session["ReportSource5"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource5"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "6")
        {
            if (Session["ReportSource6"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource6"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "7")
        {
            if (Session["ReportSource7"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource7"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "8")
        {
            if (Session["ReportSource8"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource8"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "9")
        {
            if (Session["ReportSource9"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource9"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "10")
        {
            if (Session["ReportSource10"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource10"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "11")
        {
            if (Session["ReportSource11"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource11"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "12")
        {
            if (Session["ReportSource12"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource12"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "13")
        {
            if (Session["ReportSource13"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource13"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "14")
        {
            if (Session["ReportSource14"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource14"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "15")
        {
            if (Session["ReportSource15"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource15"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "16")
        {
            if (Session["ReportSource16"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource16"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "17")
        {
            if (Session["ReportSource17"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource17"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "18")
        {
            if (Session["ReportSource18"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource18"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "19")
        {
            if (Session["ReportSource19"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource19"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "20")
        {
            if (Session["ReportSource20"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource20"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "21")
        {
            if (Session["ReportSource21"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource21"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "22")
        {
            if (Session["ReportSource22"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource22"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "23")
        {
            if (Session["ReportSource23"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource23"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "24")
        {
            if (Session["ReportSource24"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource24"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "25")
        {
            if (Session["ReportSource25"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource25"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "26")
        {
            if (Session["ReportSource26"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource26"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "27")
        {
            if (Session["ReportSource27"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource27"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "28")
        {
            if (Session["ReportSource28"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource28"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "29")
        {
            if (Session["ReportSource29"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource29"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "30")
        {
            if (Session["ReportSource30"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource30"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "31")
        {
            if (Session["ReportSource31"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource31"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "32")
        {
            if (Session["ReportSource32"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource32"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "33")
        {
            if (Session["ReportSource33"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource33"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "34")
        {
            if (Session["ReportSource34"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource34"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "35")
        {
            if (Session["ReportSource35"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource35"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "36")
        {
            if (Session["ReportSource36"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource36"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "37")
        {
            if (Session["ReportSource37"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource37"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "38")
        {
            if (Session["ReportSource38"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource38"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "39")
        {
            if (Session["ReportSource39"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource39"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "40")
        {
            if (Session["ReportSource40"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource40"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "41")
        {
            if (Session["ReportSource41"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource41"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "42")
        {
            if (Session["ReportSource42"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource42"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "43")
        {
            if (Session["ReportSource43"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource43"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "44")
        {
            if (Session["ReportSource44"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource44"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "45")
        {
            if (Session["ReportSource45"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource45"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "46")
        {
            if (Session["ReportSource46"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource46"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "47")
        {
            if (Session["ReportSource47"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource47"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "48")
        {
            if (Session["ReportSource48"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource48"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "49")
        {
            if (Session["ReportSource49"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource49"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "50")
        {
            if (Session["ReportSource50"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource50"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "51")
        {
            if (Session["ReportSource51"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource51"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "52")
        {
            if (Session["ReportSource52"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource52"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "53")
        {
            if (Session["ReportSource53"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource53"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "54")
        {
            if (Session["ReportSource54"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource54"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "55")
        {
            if (Session["ReportSource55"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource55"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "56")
        {
            if (Session["ReportSource56"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource56"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "60")
        {
            if (Session["ReportSource60"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource60"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "61")
        {
            if (Session["ReportSource61"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource61"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "62")
        {
            if (Session["ReportSource62"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource62"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "63")
        {
            if (Session["ReportSource63"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource63"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "64")
        {
            if (Session["ReportSource64"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource64"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "65")
        {
            if (Session["ReportSource65"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource65"];
                //base.OnPreInit(e);
            }
        }
        if (Request["rpt"] == "66")
        {
            if (Session["ReportSource66"] != null)
            {
                CrystalReportViewer1.ReportSource = this.Session["ReportSource66"];
                //base.OnPreInit(e);
            }
        }
    }
}
