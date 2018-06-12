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
using Star.Web.UI.Controls;
using System.Text;

public partial class PopUpActivityDetail : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    decimal TotalMoney;
    decimal TotalMoney2;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetData(Request["id"]);

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
        }
    }
    private void getActivityDetail(string ActivityCode)
    {
        DataView dv = btc.getActivityDetailFinished(ActivityCode);
        if (dv.Count != 0)
        {
            txtActivityDetail.Text = dv[0]["ActivityDetail"].ToString();
            lblPlace.Text = dv[0]["Place"].ToString();
            lblType.Text = dv[0]["CostsType"].ToString();
            lblTerm.Text = dv[0]["Term"].ToString() + "/" + dv[0]["YearB"].ToString();
            lblBudgetYear.Text = dv[0]["BudgetYear"].ToString();

            //txtTotalAmount.Text = Convert.ToDecimal(dv[0]["TotalAmount"]).ToString("#,##0.00");

            string strSQL = " Select a.*, BudgetTypeName = Case a.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then a.BudgetTypeOtherName Else b.BudgetTypeName End, a.ListName,  IsNull(a.TotalMoney2,0) ValueT "
                    + " From CostsDetail a, BudgetType b "
                    + " Where a.BudgetTypeCode = b.BudgetTypeCode And a.ActivityCode = '{0}' ";
            DataView dv1 = Conn.Select(string.Format(strSQL + " Order By a.ListNo, b.Sort ", ActivityCode));

            GridViewBudget.DataSource = dv1;
            GridViewBudget.DataBind();

            //งบประมาณ
            DataTable dt2, dt3;
            dt2 = new DataTable();

            dt2 = dv1.ToTable(true, "BudgetTypeCode", "BudgetTypeName");
            //dt2.Columns.Add("BudgetTypeName");
            dt2.Columns.Add("TotalMoney");

            foreach (DataRow dr in dt2.Rows)
                dr["TotalMoney"] = dv1.ToTable().Compute("SUM(TotalMoney)", "BudgetTypeCode='" + dr["BudgetTypeCode"] + "'");

            if (dt2.Rows.Count != 0)
            {
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    if (dt2.Rows[i]["BudgetTypeCode"].ToString() == "88f2efd0-b802-4528-8ca8-aae8d8352649")
                    {
                        dt2.Rows[i]["BudgetTypeName"] = "อื่น ๆ";
                    }
                }
            }
            dt3 = dt2.DefaultView.ToTable(true, "BudgetTypeCode", "BudgetTypeName", "TotalMoney");
            dt3.Columns["BudgetTypeName"].ColumnName = "name";
            dt3.Columns["TotalMoney"].ColumnName = "data";
            dt3.AcceptChanges();
            ReportGraph(dt3.DefaultView, 1);


            DataTable dt1 = new DataTable();
            dt1.Columns.Add("name");
            dt1.Columns.Add("data");

            DataRow dr1;
            dr1 = dt1.NewRow();
            dr1["name"] = "งบประมาณตั้งไว้";
            dr1["data"] = Convert.ToDecimal(dv1.ToTable().Compute("Sum(TotalMoney)", ""));
            dt1.Rows.Add(dr1);

            dr1 = dt1.NewRow();
            dr1["name"] = "งบประมาณที่ใช้";
            dr1["data"] = Convert.ToDecimal(dv1.ToTable().Compute("Sum(ValueT)", ""));
            dt1.Rows.Add(dr1);

            ReportGraph(dt1.DefaultView, 0);


            cktxtBudget();

            //txtOldTotal.Text = Convert.ToDouble(dv[0]["TotalAmount"]).ToString("#,##0");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "ckddlDate();", true);

            lblDepartment.Text = dv[0]["DeptName"].ToString();
            lblEmpName.Text = dv[0]["EmpName"].ToString();
            txtSDay.Text = Convert.ToDateTime(dv[0]["SDate"]).ToString("dd/MM/yyyy");
            txtEDay.Text = Convert.ToDateTime(dv[0]["EDate"]).ToString("dd/MM/yyyy");
            txtSDay2.Text = Convert.ToDateTime(dv[0]["SDate2"]).ToString("dd/MM/yyyy");
            txtEDay2.Text = Convert.ToDateTime(dv[0]["EDate2"]).ToString("dd/MM/yyyy");
        }
        else
        {
            txtActivityDetail.Text = "";
            lblPlace.Text = "";
            lblType.Text = "";
            lblTerm.Text = "";
            lblBudgetYear.Text = "";
            //txtTotalAmount.Text = "0.00";
            lblDepartment.Text = "";
            lblEmpName.Text = "";
            txtSDay.Text = "";
            txtEDay.Text = "";
        }
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = "Select b.ProjectsCode, b.ProjectsName, b.MissionCode, b.GoalsCode, c.* "
                    + " From Projects b, Activity c "
                    + " Where c.ActivityCode = '" + id + "' And b.ProjectsCode = c.ProjectsCode ";
        DataView dv = Conn.Select(string.Format(strSql));

        if (dv.Count != 0)
        {
            lblYearB.Text = dv[0]["StudyYear"].ToString();
            lblStrategies.Text = btc.getStrategiesName(true, dv[0]["ProjectsCode"].ToString());
            lblProjects.Text = dv[0]["ProjectsName"].ToString();
            lblPurpose.Text = dv[0]["Purpose"].ToString();
            lblTarget.Text = dv[0]["Target"].ToString();
            lblTarget2.Text = dv[0]["Target2"].ToString();
            lblProjectsDetail.Text = dv[0]["ActivityDetail"].ToString();
            txtActivityCode.Text = dv[0]["ActivityCode"].ToString();
            txtActivity.Text = dv[0]["ActivityName"].ToString();
            getActivityDetail(dv[0]["ActivityCode"].ToString());
            txtEvaluation.Text = dv[0]["Evaluation"].ToString();
            txtEvaIndicators.Text = dv[0]["EvaIndicators"].ToString();
            txtEvaAssessment.Text = dv[0]["EvaAssessment"].ToString();
            txtEvaTool.Text = dv[0]["EvaTool"].ToString();
            txtExpected.Text = dv[0]["Expected"].ToString();
            lblMission.Text = btc.getMissionName(dv[0]["MissionCode"].ToString());
            lblGoals.Text = btc.getGoalsName(dv[0]["GoalsCode"].ToString());
            //lblStandardNationName.Text = btc.getStandardNationName(false, dv[0]["ProjectsCode"].ToString());
            //lblStandardMinistryName.Text = btc.getStandardMinistryName(false, dv[0]["ProjectsCode"].ToString());
            lblStandard.Text = btc.getSideNameOfActivity(false, id);
            lblIndicators.Text = btc.getStandardName(false, id);

            strSql = "Select *, txtWeightType = Case WeightType When 0 Then '%' When 1 Then 'จำนวน' End, txtCkCriterion = Case CkCriterion When 0 Then 'ไม่ผ่าน' When 1 Then 'ผ่าน' End From Indicators2 Where DelFlag = 0 And ActivityCode = '" + id + "'";
            DataView dv1 = Conn.Select(strSql);
            rptIncicators2.DataSource = dv1;
            rptIncicators2.DataBind();
        }
    }
    protected void rptIncicators2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rptAttach = (Repeater)e.Item.FindControl("rptAttach");
        string MID = ((DataRowView)e.Item.DataItem)["Indicators2Code"].ToString();
        DataView dv = Conn.Call("getAttachFile", "ReferID", MID);
        rptAttach.DataSource = dv;
        rptAttach.DataBind();
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
    public decimal GetTotalMoney2(decimal Budget2)
    {
        TotalMoney2 += Budget2;
        return Budget2;
    }
    public decimal GetSumTotalMoney2()
    {
        return TotalMoney2;
    }
    private void cktxtBudget()
    {
        if (TotalMoney == TotalMoney2)
        {
            lblBudget.Text = "ใช้งบประมาณตามแผนที่ตั้งไว้";
            lblBudget.ForeColor = System.Drawing.Color.Black;
        }
        else
        {
            if (TotalMoney > TotalMoney2)
            {
                lblBudget.Text = "ใช้งบประมาณน้อยกว่าแผนที่ตั้งไว้";
                lblBudget.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblBudget.Text = "ใช้งบประมาณมากกว่าแผนที่ตั้งไว้";
                lblBudget.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    protected string getImgAttatch(object ItemID, object title, object filetype, object TypeId)
    {
        string link = btc.getImageAttachFileType(btc.getAttachType(filetype.ToString(), Convert.ToInt32(TypeId)), ItemID, title);
        return string.Format(link);
    }

    protected StringBuilder chartData;
    protected string chartType;

    void ReportGraph(DataView dv, int mode)
    {
        string chartData = "";
        if (mode == 0)
        {
            Suffix = "numberSuffix=''";
            chartData = GenerateChart("column2d", dv, "", null, false, " ", "");
            graphPnl.InnerHtml = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", "column2d")), "", chartData, "AA", "300", "150", false);
        }
        if (mode == 1)
        {
            //MaxValue = "yAxisMaxValue ='100'";
            chartData = GenerateChart("Pie2D", dv, "", null, false, " ", "");
            graphPnl1.InnerHtml = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", "Pie2D")), "", chartData, "BB", "300", "150", false);
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
        string[] color = { "949494", "0cb1cd", "fe4d53", "afc000", "ff9e02", "F3EB1E", "FF7777", "FA33BB", "F3A01E", "238627", "78177E", "82B5D5", "7A4E28", "9D9F0C", "F97CC3", "A2919B", "ADFAF4" };
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
}
