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

public partial class GraphBudget : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected StringBuilder chartData;
    protected string chartType;
    protected override void OnPreInit(EventArgs e)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGraph();
        }       
    }
    private void LoadGraph()
    {
        string strSql = " Select Top 10 b.StudyYear name, IsNull(Sum(a.TotalAmount), 0) data, IsNull(Sum(a.TotalAmount2), 0) data1 "
                        + " From StudyYear b Left Join Activity a On b.StudyYear = a.StudyYear "
                        + " Where a.DelFlag = 0 And b.DelFlag = 0 And a.SchoolID = '" + CurrentUser.SchoolID + "' "
                        + " Group By b.StudyYear ";

        DataView dv1 = Conn.Select(strSql);
        if (dv1.Count > 0)
        {
            ReportGraph("MSColumn2D", dv1, 1);
        }
        else
        {
            dv1 = Conn.Select("Select '' As Name, 0 As Data, 0 As data1 From Config");
            ReportGraph("MSColumn2D", dv1, 1);
        }
    }
    protected void ddlBudget_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadGraph();
    }
    void ReportGraph(string ChartName, DataView dv, int mode)
    {
        string chartData = "";
        if (mode == 1)
        {
            Suffix = "numberSuffix=''";
            string[] column = { "งบตั้งไว้=data", "งบใช้ไป=data1" };
            //MaxValue = "yAxisMaxValue ='100'";
            chartData = GenerateChart(ChartName, dv, "", column, true, " ", "");
            graphPnl1.InnerHtml = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", ChartName)), "", chartData, "BB", "1000", "400", false);
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
