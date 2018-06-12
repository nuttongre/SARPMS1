using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;

public partial class GraphGetCountProjects : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    protected StringBuilder chartData;
    protected string chartType;
    DataView dvApproveFlow = null;
    DataView dvTotalAmout = null;
    DataView dvStatusApprove = null;
    decimal tTotalAmount = 0;

    protected override void OnPreInit(EventArgs e)
    {
        //if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        //{
        //    this.MasterPageFile = "~/Master/MasterManageView.master";
        //}
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tTotalAmount = 0;
            getddlYear(0);
            getrbtType();
            getddlMonth(0);
            getddlQuarter(0);
            LinkReport();
            string mode = Request.QueryString["mode"];
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
            btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
            btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
            btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
            DataBind();
        }
    }
    protected void LinkReport()
    {
        string link = " <a href=\"javascript:;\" " + btc.getLinkReportWEP("W") + "  onclick=\"printRpt(60,'w');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"50px;\" height=\"50px;\" title=\"เรียกดูรายงาน แบบเอกสาร Word\" src=\"../Image/icon/WordIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" onclick=\"printRpt(60,'e');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร Excel\" src=\"../Image/icon/ExcelIcon.png\" /></a> "
                    + " <a href=\"javascript:;\" " + btc.getLinkReportWEP("P") + " onclick=\"printRpt(60,'p');\"> "
                    + " <img style=\"border: 0; cursor: pointer; vertical-align: top;\" width=\"45px;\" height=\"45px;\" title=\"เรียกดูรายงาน แบบเอกสาร PDF\" src=\"../Image/icon/PdfIcon.png\" /></a> ";
        linkReport.Text = link;
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
    }
    private void getddlMonth(int mode)
    { 
        if(mode == 0)
        {
            btc.getddlMonth2(ddlMonth);
            ddlMonth.Items.Insert(0, new ListItem("- ทั้งหมด -", ""));
            ddlMonth.SelectedIndex = 0;
        }
    }
    private void getddlQuarter(int mode)
    {
        if (mode == 0)
        {
            btc.getddlQuarter2(ddlQuarter);
            ddlQuarter.Items.Insert(0, new ListItem("- ทั้งหมด -", ""));
        }
    }
    private void getrbtType()
    {
        rbtType.Items.Insert(0, new ListItem("รายเดือน", "0"));
        rbtType.Items.Insert(1, new ListItem("รายไตรมาส", "1"));
        rbtType.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        string strSql = "";
        DataView dv = null;

        string strNotPATWit = "";
        string strNotPATWit2 = "";
        if (CurrentUser.MainDeptID.ToUpper() == "BA422CC9-6E77-4D43-BAFB-7539B9286E59")
        {
            strNotPATWit = " And SD.MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
            strNotPATWit2 = " And MSD.MainSubDeptCode Not In ('80F1E0B3-E2A8-458E-A6E0-EAFD3593D56E', '8D892520-6C31-4BEB-A746-4BD69A8E3037') ";
        }

        //โครงการทั้งหมด
        strSql = @" Select D.DeptCode, REPLACE(D.DeptName,N'สำนัก','สน.')  As Name, Count(P.ProjectsCode) data, 0 As data1, 0 As data2, 0 As data3, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' ";
        if (ddlMonth.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfMonth(ddlMonth.SelectedValue, ddlSearchYear.SelectedValue);
        }
        if (ddlQuarter.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfQuarter(ddlQuarter.SelectedValue, ddlSearchYear.SelectedValue);
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        dv = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, ddlSearchYear.SelectedValue, strNotPATWit));

        //โครงการที่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data1, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 1 ";
        if (ddlMonth.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfMonth(ddlMonth.SelectedValue, ddlSearchYear.SelectedValue);
        }
        if (ddlQuarter.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfQuarter(ddlQuarter.SelectedValue, ddlSearchYear.SelectedValue);  
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv1 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, ddlSearchYear.SelectedValue, strNotPATWit));

        //โครงการที่ไม่อนุมัติ
        strSql = @" Select D.DeptCode, D.DeptName As Name, Count(P.ProjectsCode) data2, SD.Sort, D.Sort
        From  Department D Left Join Projects P On P.DeptCode = D.DeptCode And P.DelFlag = 0 And P.StudyYear = '{1}' And P.IsApprove = 0 ";
        if (ddlMonth.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfMonth(ddlMonth.SelectedValue, ddlSearchYear.SelectedValue);
        }
        if (ddlQuarter.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfQuarter(ddlQuarter.SelectedValue, ddlSearchYear.SelectedValue);  
        }
        strSql += @" Left Join MainSubDepartment SD On SD.MainSubDeptCode = D.MainSubDeptCode 
        Where D.DelFlag = 0 And SD.MainDeptCode = '{0}' {2}
        Group By D.DeptCode, D.DeptName, SD.Sort, D.Sort Order By SD.Sort, D.Sort ";
        DataView dv2 = Conn.Select(string.Format(strSql, CurrentUser.MainDeptID, ddlSearchYear.SelectedValue, strNotPATWit));
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

        if (dv.Count > 0)
        {
            ReportGraph("MSColumn2D", dv, 1);
        }
        else
        {
            dv = Conn.Select("Select '' As AcCode, '-' As FullName, '-' As DeptName, 0 As TotalBalance, '' As Name, 0 As data, 0 As data1, 0 As data2, 0 As data3 From Config");
            ReportGraph("MSColumn2D", dv, 1);
        }
        GridView1.DataSource = dv;
        GridView1.DataBind();

        strSql = @"Select P.ProjectsCode, P.ProjectsName, P.IsApprove, P.UserApprove, P.DateApprove, P.Comment,
            PD.EmpID, PD.IsApprove As IsApprove2, PD.CreateDate As DateApprove2, PD.Comment As Comment2 
            From Projects P Left Join ProjectsApproveDetail PD On PD.ProjectsCode = P.ProjectsCode
            Where P.DelFlag = 0 And P.StudyYear = '{0}' And P.SchoolID = '{1}' ";
        dvApproveFlow = Conn.Select(string.Format(strSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        strSql = @"Select P.ProjectsCode, P.ProjectsName, P.IsApprove, P.UserApprove, P.DateApprove, P.Comment,
            PD.EmpID, PD.IsApprove As IsApprove2, PD.CreateDate As DateApprove2, PD.Comment As Comment2,
			Aps.ApproveStepName,  E.EmpName
            From Projects P Left Join ProjectsApproveDetail PD On PD.ProjectsCode = P.ProjectsCode
			Left Join ApproveFlowDetail AD On PD.ApproveFlowDetailID = AD.ApproveFlowDetailID 
			Left Join ApproveStep Aps On AD.ApproveStepID = Aps.ApproveStepID
			Left Join Employee E On PD.EmpID = E.EmpID
            Where P.DelFlag = 0 And P.StudyYear = '{0}' And P.SchoolID = '{1}'
			And PD.IsApprove Is Null And PD.CreateDate Is Null
			Order By PD.StepNo ";
        dvStatusApprove = Conn.Select(string.Format(strSql, ddlSearchYear.SelectedValue, CurrentUser.SchoolID));

        strSql = @"Select P.ProjectsCode, IsNull(Sum(CD.TotalMoney), 0) TotalMoney From Projects P 
            Left Join Activity A On P.ProjectsCode = A.ProjectsCode
            Left Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
            Where P.DelFlag = 0 And P.StudyYear = '{0}' Group By P.ProjectsCode ";
        dvTotalAmout = Conn.Select(string.Format(strSql, ddlSearchYear.SelectedValue));

        strSql = @" Select P.ProjectsCode, P.StudyYear, P.ProjectsName, P.Df, Ep.EmpID, Ep.EmpName, P.Sdate, P.Edate,
            P.Sort, e.DeptName, P.IsApprove, IsNull(P.Quality, 0) Quality
            From Projects P Left Join dtStrategies S On P.ProjectsCode = S.ProjectsCode
            Left Join ProjectsApproveDetail PD On PD.ProjectsCode = P.ProjectsCode
            Left Join Employee d On PD.EmpID = d.EmpID  
            Left Join Employee Ep On P.CreateUser = Ep.EmpID
            Left Join Department e On P.DeptCode = e.DeptCode
            Left Join MainSubDepartment MSD On e.MainSubDeptCode = MSD.MainSubDeptCode
            Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
            Where P.DelFlag = 0 And d.DelFlag = 0 And d.hideFlag = 0 And P.StudyYear = '{0}' And P.SchoolID = '{1}' {2} ";
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            strSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            strSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
        }
        if (ddlSearchDept.SelectedIndex != 0)
        {
            strSql += " And e.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
        }
        if (ddlMonth.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfMonth(ddlMonth.SelectedValue, ddlSearchYear.SelectedValue);
        }
        if (ddlQuarter.SelectedIndex != 0)
        {
            strSql += btc.getMonthOfQuarter(ddlQuarter.SelectedValue, ddlSearchYear.SelectedValue); 
        }
        DataView dv9 = Conn.Select(string.Format(strSql + " Group By P.ProjectsCode, P.StudyYear, P.ProjectsName, P.Df, Ep.EmpID, Ep.EmpName, P.Sdate, P.Edate, P.Sort, e.DeptName, P.IsApprove, P.Quality Order By P.Sort Desc ", ddlSearchYear.SelectedValue, CurrentUser.SchoolID, strNotPATWit2));
        //TotalAmount = 0;
        ////เช็คผลรวม
        //try
        //{
        //    DataTable dt = dvTotalAmout.ToTable();
        //    tTotalAmount = Convert.ToDecimal(dt.Compute("Sum(TotalMoney)", dvTotalAmout.RowFilter));
        //}
        //catch (Exception ex)
        //{
        //}

        DataGridView1.DataSource = dv9;
        lblSearchTotal.InnerText = dv9.Count.ToString();
        DataGridView1.DataBind();
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    Int32 TotalAmount;
    Int32 TotalAmount1;
    Int32 TotalAmount2;
    Int32 TotalAmount3;
    public Int32 GetTotalAmount(Int32 Budget)
    {
        TotalAmount += Budget;
        return Budget;
    }
    public Int32 GetSumTotalAmount()
    {
        return TotalAmount;
    }
    public Int32 GetTotalAmount1(Int32 Budget)
    {
        TotalAmount1 += Budget;
        return Budget;
    }
    public Int32 GetSumTotalAmount1()
    {
        return TotalAmount1;
    }
    public Int32 GetTotalAmount2(Int32 Budget)
    {
        TotalAmount2 += Budget;
        return Budget;
    }
    public Int32 GetSumTotalAmount2()
    {
        return TotalAmount2;
    }
    public Int32 GetTotalAmount3(Int32 Budget)
    {
        TotalAmount3 += Budget;
        return Budget;
    }
    public Int32 GetSumTotalAmount3()
    {
        return TotalAmount3;
    }
    protected string GetPercen(object SetBudget, object UseBudget)
    {
        decimal setBudget = Convert.ToDecimal(SetBudget);
        decimal useBudget = Convert.ToDecimal(UseBudget);
        string strPercent = "100 %";
        if (setBudget == 0)
        {
            strPercent = (100 - (useBudget * 100) / 1).ToString("#,##0.00") + " %";
        }
        else {
            strPercent = (100 - (useBudget * 100 / setBudget)).ToString("#,##0.00") + " %";
        }
        return strPercent;
    }
    protected string PjOrAcName(string id, string strName)
    {
        return string.Format(strName);
    }

    void ReportGraph(string ChartName, DataView dv, int mode)
    {
        string chartData = "";
        if (mode == 1)
        {
            Suffix = "numberSuffix=''";
            string[] column = { "จำนวนโครงการนำเสนอ=data", "จำนวนโครงการอนุมัติ=data1", "จำนวนโครงการยกเลิก=data2", "จำนวนโครงการยังไม่อนุมัติ=data3" };
            //MaxValue = "yAxisMaxValue ='100'";
            chartData = GenerateChart(ChartName, dv, "", column, true, " ", "");
            //graphPnl2.Text = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", "MSColumn2D")), "", chartData.ToString(), "BB", "500", "320", false);
            graphPnl2.InnerHtml = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", ChartName)), "", chartData, "BB", "1000", "400", false);
        }
    }

    private string DatapieChart = "";
    private Boolean QCbar = false;
    #region GenerateChart

    private string Suffix = null;
    private string MaxValue = null;
    private string xaxisname = "";
    private string yaxisname = "";
    private Boolean NameCountPerson = false;
    string rotateNames = "";
    private int showLimits = 1;
    private string showLabels = "1";
    private string showName = "1";

    private string showYAxisValues = "1";
    private string valueslabel = "";
    private string setplaceValuesInside = "0";
    private string setValueInsideLabel = "";
    private string labelDisplay = "";
    private string slantLabels = "";
    private string chartLeftMargin = "";
    private string chartRightMargin = "";
    private string maxLabelWidthPercent = "";
    private string formatNumberScale = "";
    private string GenerateChart(string ChartName, DataView dv, string column, string[] columns, bool compare, string caption, string subCaption)
    {
        string chartName = ChartName;
        if (chartName == "MSLine" || chartName == "MSColumn2D")
        {
            compare = true;
        }

        if (dv.Count.Equals(0)) return "";

        string baseFont = "Microsoft Sans Serif";
        string baseFontColor = "787878";
        string bgColor = "FFFFFF";
        string canvasBgColor = "FFFFFF";
        string outCnvBaseFont = "Tahoma";
        string outCnvBaseFontColor = "787878";
        rotateNames = "rotateNames='0'";
        string[] color = { "0cb1cd", "afc000", "fe4d53", "949494", "ff9e02", "a47bb3", "b33539", "0098c1", "F3A01E", "238627", "78177E", "82B5D5", "7A4E28", "9D9F0C", "F97CC3", "A2919B", "ADFAF4" };
        int baseFontSize = 13;
        int outCnvBaseFontSize = 12;


        StringBuilder chartData = new StringBuilder();
        if (chartName == "ScrollColumn2D" || chartName == "ZoomLine")
        {
            chartData.Append(string.Format("<chart palette='2' showLimits='1' showValues='1' " + Suffix + " " + rotateNames + " caption='{0}' showvalues='0' useRoundEdges='1' legendBorderAlpha='0' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}' shownames='{13}' labelDisplay='{14}' slantLabels='{15}' chartLeftMargin='{16}' chartRightMargin='{17}' showLabels = '{18}' maxLabelWidthPercent='{19}' formatNumberScale='{20}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor, showName, labelDisplay, slantLabels, chartLeftMargin, chartRightMargin, showLabels, maxLabelWidthPercent, formatNumberScale));
            chartData.Append("<categories> ");
            if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
            {
                foreach (string col in column.Split(','))
                {
                    chartData.Append(string.Format("<category label='{0}'  />", col));
                }
                chartData.Append("</categories>");

                chartData.Append("<dataset showValues='1'>");
                int i = 0;
                foreach (string col in column.Split(','))
                {
                    chartData.Append(string.Format("<set value='{0}' color='{1}'/>", dv[0][col], GetColor(color, i)));
                    i++;
                }
            }
            else//gen xml แบบ record 2 คอลัม
            {
                foreach (DataRowView dr in dv)
                {
                    chartData.Append(string.Format("<category label='{0}'  />", dr["Name"]));
                }
                chartData.Append("</categories>");

                chartData.Append("<dataset showValues='1'>");
                int i = 0;
                foreach (DataRowView dr in dv)
                {
                    chartData.Append(string.Format("<set value='{0}' color='{1}'/>", dr["Data"], GetColor(color, i)));
                    i++;
                }
            }
            chartData.Append("</dataset>");
            chartData.Append("</chart>");
        }
        else
        {
            chartData.Append(string.Format("<chart palette='2' decimalPrecision='0' " + Suffix + " " + MaxValue + " " + rotateNames + " showValues='1'  showPercentageValues='1' showPercentageInLabel ='1' animation='1'  caption='{0}' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}' divLineIsDashed='1' placeValuesInside='{13}' showLabels='{14}' shownames='{15}' showYAxisValues='{16}' labelDisplay='{17}' slantLabels='{18}' maxLabelWidthPercent='{19}' formatNumberScale='{20}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor, setplaceValuesInside, showLabels, showName, showYAxisValues, labelDisplay, slantLabels, maxLabelWidthPercent, formatNumberScale));

            if (compare)//gen xml แบบ เปรียบเทียบ
            {
                chartData.Append("<categories font='Arial' fontSize='11' fontColor='000000'>");

                //-------========
                int i = 0;
                if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
                {
                    foreach (string col in column.Split(','))
                    {
                        chartData.Append(string.Format("<category name='{0}' />", col));
                    }
                    chartData.Append("</categories>");

                    foreach (string col in columns)
                    {
                        string[] value = col.Split('=');
                        chartData.Append(string.Format("<dataset seriesname='{0}' color='{1}' alpha='70'>", value[0], GetColor(color, i)));
                        string[] v = value[1].Split(',');
                        int c = 0;
                        foreach (string col1 in column.Split(','))
                        {
                            chartData.Append(string.Format("<set value='{0}' />", dv[0][v[c]]));
                            c++;
                        }
                        chartData.Append("</dataset>");
                        i++;
                    }
                }
                else//gen xml แบบ record
                {
                    foreach (DataRowView dr in dv)
                    {
                        string value = dr["Name"].ToString();
                        if (value.Length > 100)
                        {

                        }
                        chartData.Append(string.Format("<category name='{0}' />", value));
                    }
                    chartData.Append("</categories>");

                    foreach (string col in columns)
                    {
                        string[] value = col.Split('=');
                        bool IsTooltip = false;
                        if (dv.Table.Columns.Contains("Tooltip")) IsTooltip = true;
                        chartData.Append(string.Format("<dataset seriesname='{0}' color='{1}' alpha='70'>", value[0], GetColor(color, i)));
                        foreach (DataRowView dr in dv)
                        {
                            if (IsTooltip)
                                chartData.Append(string.Format("<set value='{0}' tooltext='{1}'/>", dr[value[1]], value[0] + ", " + dr["Tooltip"].ToString() + ", " + dr[value[1]]));
                            else
                                chartData.Append(string.Format("<set value='{0}'/>", dr[value[1]]));
                        }
                        chartData.Append("</dataset>");
                        i++;
                    }
                }
            }
            else
            {
                int i = 0;
                if (!string.IsNullOrEmpty(column))//gen xml แบบคอลัม 0 record
                {
                    foreach (string col in column.Split(','))
                    {
                        chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", col, dv[0][col], GetColor(color, i)));
                        i++;
                    }
                }
                else//gen xml แบบ record 2 คอลัม
                {
                    if (NameCountPerson == true)
                    {
                        if (QCbar == true)
                        {
                            foreach (DataRowView dr in dv)
                            {
                                chartData.Append(string.Format("<set label='{0} {3}' value='{1}' color='{2}' />", dr["Name"], dr["Data"], GetColor(color, i), dr["DepName"]));
                                i++;
                            }
                            QCbar = false;
                            NameCountPerson = false;
                        }
                        else
                        {
                            foreach (DataRowView dr in dv)
                            {
                                chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", dr["Name"], dr[DatapieChart], GetColor(color, i), valueslabel));
                                NameCountPerson = false;
                                i++;
                            }
                        }
                    }
                    else
                    {
                        foreach (DataRowView dr in dv)
                        {
                            chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", dr["Name"].ToString(), dr["Data"], GetColor(color, i)));
                            NameCountPerson = false;
                            i++;
                        }
                    }

                }
            }
            chartData.Append("</chart >");
        }
        return chartData.ToString();
    }

    private string GetColor(string[] color, int number)
    {
        string colorCode;
        if (number < color.Length)
        {
            colorCode = color[number];
        }
        else
        {
            colorCode = color[number % color.Length];
        }
        return colorCode;
    }
    #endregion
    private void getMonthYear(Int32 tMonth)
    {
        if (tMonth >= 1 && tMonth <= 4)
        {
            lblAcademicYear.Text = " / " + (Convert.ToInt32(ddlSearchYear.SelectedItem.Text) + 1).ToString();
        }
        else
        {
            lblAcademicYear.Text = "";
        }
    }
    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        Int32 tMonth = 0;
        if(ddlMonth.SelectedIndex != 0)
        {
            tMonth = Convert.ToInt32(ddlMonth.SelectedValue);
        }
        getMonthYear(tMonth);
        DataBind();
    }
    protected void ddlQuarter_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void rbtType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbtType.SelectedIndex == 0)
        {
            divMonth.Visible = true;
            divQuarter.Visible = false;
        }
        else
        {
            divMonth.Visible = false;
            divQuarter.Visible = true;
        }
        DataBind();
    }
    protected string GetstatusIsApprove(object ProjectsCode)
    {
        DataRow[] dr = dvStatusApprove.Table.Select("ProjectsCode = '" + ProjectsCode + "' ");
        if (dr.Length > 0)
        {
            return string.Format("<img style=\"border:0; width:24px; height:24px;\" title=\"รอการตัดสินใจ\" src=\"../Image/giphy.gif\" /><Br/><span style=\"font-size:11pt;\">" + dr[0]["ApproveStepName"].ToString() + "</span><BR/><span style=\"font-size:9pt;\">โดย : " + dr[0]["EmpName"].ToString() + "</span>");
        }
        else
        {
            return string.Format("<img style=\"border:0;\" title=\"อนุมัติ\" src=\"../Image/signature.png\" />");
        }
    }
    protected string statusIsApprove(object IsApprove)
    {
        if (Request.QueryString["mode"] != "2")
        {
            if (!string.IsNullOrEmpty(IsApprove.ToString()))
            {
                if (Convert.ToInt32(IsApprove) == 1)
                {
                    return string.Format("<img style=\"border:0;\" title=\"ลงนามอนุมัติ\" src=\"../Image/ok.png\" />");
                }
                else
                {
                    return string.Format("<img style=\"border:0;\" title=\"ไม่ลงนามอนุมัติ\" src=\"../Image/no.png\" />");
                }
            }
            else
            {
                return string.Format("<img style=\"border:0;width:24px; height:24px;\" title=\"รอการอนุมัติ\" src=\"../Image/giphy.gif\" />");
            }
        }
        else
        {
            if (!string.IsNullOrEmpty(IsApprove.ToString()))
            {
                if (Convert.ToInt32(IsApprove) == 1)
                {
                    return string.Format("<img style=\"border:0;\" title=\"อนุมัติ\" src=\"../Image/signature.png\" />");
                }
                else
                {
                    return string.Format("<img style=\"border:0;\" title=\"ไม่อนุมัติ\" src=\"../Image/UnApprove.png\" />");
                }
            }
            else
            {
                return string.Format("<img style=\"border:0;width:24px; height:24px;\" title=\"รอการตัดสินใจ\" src=\"../Image/giphy.gif\" />");
            }
        }
    }
    protected string getProjectDate(object Sdate, object Edate)
    {
        string Link = "";
        if ((!string.IsNullOrEmpty(Sdate.ToString())) && (!string.IsNullOrEmpty(Edate.ToString())))
        {
            Link = Convert.ToDateTime(Sdate).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(Edate).ToString("dd/MM/yyyy");
        }
        return Link;
    }
    public string GetBudget(string ProjectsCode)
    {
        //TotalAmount += Budget;
        string Total = "0.00";
        DataRow[] dr = dvTotalAmout.Table.Select("ProjectsCode = '" + ProjectsCode + "'");
        if (dr.Length > 0)
        {
            Total = Convert.ToDecimal(dr[0]["TotalMoney"]).ToString("#,##0.00");
            tTotalAmount += Convert.ToDecimal(dr[0]["TotalMoney"]);
        }
        return "<span>" + Total + "</span>";
    }
    public decimal GetTotalBudget()
    {
        return tTotalAmount;
    }
    protected void ddlSearchMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();
    }
    protected void ddlSearchMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();
    }
    protected void ddlSearchDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept.SelectedValue);
        DataBind();
    }
}
