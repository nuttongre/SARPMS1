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

public partial class ReportCountNewStandard : System.Web.UI.Page
{
    protected StringBuilder chartData;
    protected string chartType;
    BTC btc = new BTC();
    Connection Conn = new Connection();
    protected override void OnPreInit(EventArgs e)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 2)
        {
            this.MasterPageFile = "~/Master/MasterManageView.master";
        }
    }
    DataView dv1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, null);

            getddlYear(1);
            getrbtlStatus();
            ckDivEnabled();
            GetData();
            GraphType();
            Report("1", ddlYearB.SelectedValue);
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
    private void getrbtlStatus()
    {
        rbtlStatus.Items.Insert(0, new ListItem(" <img src=\"../Image/MenuStlye/S06.gif\" /> แสดงผลแบบข้อความ", "0"));
        rbtlStatus.Items.Insert(1, new ListItem(" <img src=\"../Image/MenuStlye/S9.png\" /> แสดงผลแบบกราฟ", "1"));
        rbtlStatus.DataBind();
        rbtlStatus.SelectedIndex = 0;
    }
    private void ckDivEnabled()
    {
        if (rbtlStatus.SelectedIndex == 0)
        {
            divText.Visible = true;
            divGraph.Visible = false;
            divddlGraph.Visible = false;
        }
        else
        {
            divText.Visible = false;
            divGraph.Visible = true;
            divddlGraph.Visible = true;
        }
    }
    void GraphType()
    {
        ddlType.Items.Insert(0, new ListItem("2D Column Chart", "ScrollColumn2D"));
        ddlType.Items.Insert(1, new ListItem("3D Column Chart", "Column3D"));
        //ddlType.Items.Insert(2, new ListItem("2D Bar Chart", "Bar2D"));
        //ddlType.Items.Insert(2, new ListItem("2D Doughnut Chart", "Doughnut2D"));
        ddlType.Items.Insert(2, new ListItem("2D Pie Chart", "Pie2D"));
        ddlType.Items.Insert(3, new ListItem("3D Pie Chart", "Pie3D"));
        //ddlType.Items.Insert(4, new ListItem("2D Area Chart", "Area2D"));
    }
    void VisibleGraph(params int[] idx)
    {
        for (int i = 0; i < idx.Length; i++)
        {
            if (!IsPostBack && i == 0) ddlType.SelectedIndex = idx[i] - 1;
            ddlType.Items[idx[i] - 1].Enabled = true;
        }
    }
    private void GetData()
    {
        string strSql = " Select StandardCode, 'มาตรฐานที่ ' + Cast(Sort As nVarChar) + '. ' + StandardName FullStandardName, StandardName, Sort, 0 As CountAc "
                + " From NewStandard "
                + " Where DelFlag = 0 And StudyYear = '" + ddlYearB.SelectedValue + "' "  
                + " Order By Sort ";
        dv1 = Conn.Select(strSql);

        if (dv1.Count != 0)
        {
            Int32 CountAct = 0;
            for (int i = 0; i < dv1.Count; i++)
            {
                dv1[i]["StandardName"] = (dv1[i]["StandardName"].ToString().Length > 100 ? dv1[i]["StandardName"].ToString().Substring(0, 100) + "..." : dv1[i]["StandardName"]);

                strSql = " Select IsNull(Count(Distinct(ProjectsCode)), 0) ProjCount From dtNewStandard "
                    + " Where StandardCode = '" + dv1[i]["StandardCode"].ToString() + "' ";
                DataView ckDv = Conn.Select(strSql);

                if (ckDv.Count != 0)
                {
                    dv1[i]["CountAc"] = Convert.ToInt32(ckDv[0]["ProjCount"]);
                }
                else
                {
                    dv1[i]["CountAc"] = 0;
                }
            }
        }
        rptStandard.DataSource = dv1;
        rptStandard.DataBind();
    }
    void Report(string rpt, string CkYear)
    {
        string strSql;
        DataView dv1;
        DataView dv2 = null;
        string[] column;
        //string caption = "";
        switch (rpt.ToLower())
        {
            case "1":
                VisibleGraph(1, 2, 3, 4);

                strSql = " Select a.StandardCode, 'มาตรฐานที่ ' + Cast(a.Sort As nVarChar) + '. ' name, a.Sort, "
                + " 0 As data "
                + " From NewStandard a "
                + " Where a.DelFlag = 0 And a.StudyYear = '" + ddlYearB.SelectedValue + "' "
                + " Order By a.Sort ";
                dv1 = Conn.Select(strSql);

                if (dv1.Count != 0)
                {
                    Int32 CountAct = 0;
                    for (int i = 0; i < dv1.Count; i++)
                    {
                        strSql = @" Select IsNull(Count(Distinct(ProjectsCode)), 0) ActCount From dtNewStandard 
                        Where StandardCode = '{0}'";
                        DataView ckDv = Conn.Select(string.Format(strSql, dv1[i]["StandardCode"].ToString()));

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
                //Suffix = "numberSuffix='%25'";
                MaxValue = "yAxisMaxValue ='100'";

                GetChart(ddlType.SelectedValue, dv1, "", null, false, "กราฟแสดงจำนวนโครงการตามกลยุทธ์ระดับแผนงาน", "");
                break;

        }
        //graphPnl.InnerHtml = Graph.FusionCharts.RenderChart(this.ResolveUrl(string.Format("~/Charts/{0}.swf", ddlType.SelectedValue)), "", chartData, rpt.Replace("-", ""), "700", "450", false, false);
        try
        {
            graphPnl.InnerHtml = Graph.FusionCharts.RenderChartHTML(this.ResolveUrl(string.Format("~/Charts/{0}.swf", ddlType.SelectedValue)), "", chartData.ToString(), "AA", "700", "450", false);
        }
        catch (Exception ex)
        {
        }
    }
    #region Methods

    string Suffix = null;
    string MaxValue = null;
    string xaxisname = "";
    string yaxisname = "";
    protected void GetChart(string chartName, DataView dv, string column, string[] columns, Boolean compare, string caption, string subCaption)
    {
        if (!string.IsNullOrEmpty(chartName))
        {
            chartType = string.Format("../Charts/{0}.swf", chartName);
            if (chartName == "MSLine" || chartName == "MSColumn2D") compare = true;

            if (dv.Count.Equals(0)) return;

            string baseFont = "Microsoft Sans Serif";
            string baseFontColor = "787878";
            string bgColor = "FFFFFF";
            string canvasBgColor = "FFFFFF";
            string outCnvBaseFont = "Tahoma";
            string outCnvBaseFontColor = "787878";
            string rotateNames = "rotateNames='" + 0 + "'";
            string[] color = { "F31E38", "3C1EF3", "1EF328", "E61EF3", "1EE2F3", "F3EB1E", "FF7777", "FA33BB", "F3A01E", "238627", "78177E", "82B5D5", "7A4E28", "9D9F0C", "F97CC3", "A2919B", "ADFAF4" };
            int baseFontSize = 13;
            int outCnvBaseFontSize = 12;
            int showLimits = 0;

            chartData = new StringBuilder();
            if (chartName != "ScrollColumn2D")// ถ้าไม่ใช่กราฟแบบ scroll
            {
                chartData.Append(string.Format("<chart  palette='2' decimalPrecision='0' showLimits='1' " + Suffix + " " + MaxValue + " " + rotateNames + " shownames='1' showValues='1'  showPercentageValues='1' showPercentageInLabel ='1' animation='1'  caption='{0}' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor));

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
                            chartData.Append(string.Format("<category name='{0}' />", dr["name"]));
                        }
                        chartData.Append("</categories>");

                        foreach (string col in columns)
                        {
                            string[] value = col.Split('=');
                            chartData.Append(string.Format("<dataset seriesname='{0}' color='{1}' alpha='70'>", value[0], GetColor(color, i)));
                            foreach (DataRowView dr in dv)
                            {
                                chartData.Append(string.Format("<set value='{0}' />", dr[value[1]]));
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
                        foreach (DataRowView dr in dv)
                        {
                            chartData.Append(string.Format("<set label='{0}' value='{1}' color='{2}' />", dr["name"], dr["data"], GetColor(color, i)));
                            i++;
                        }
                    }
                }
                chartData.Append("</chart >");
            }
            else //ถ้าเป็นกราฟแบบ scroll
            {
                chartData.Append(string.Format("<chart palette='2' showLimits='1' shownames='1' showValues='1' " + Suffix + " " + rotateNames + " caption='{0}' shownames='1' showvalues='0' useRoundEdges='1' legendBorderAlpha='0' subCaption='{1}' yaxisname='{2}' xaxisname='{3}' baseFontSize='{4}' outCnvBaseFontSize='{5}' baseFont='{6}' outCnvBaseFont='{7}' bgColor='{8}' canvasBgColor='{9}' showLimits='{10}' baseFontColor='{11}' outCnvBaseFontColor='{12}'>", caption, subCaption, yaxisname, xaxisname, baseFontSize, outCnvBaseFontSize, baseFont, outCnvBaseFont, bgColor, canvasBgColor, showLimits, baseFontColor, outCnvBaseFontColor));
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
                        chartData.Append(string.Format("<category label='{0}'  />", dr["name"]));
                    }
                    chartData.Append("</categories>");

                    chartData.Append("<dataset showValues='1'>");
                    int i = 0;
                    foreach (DataRowView dr in dv)
                    {
                        chartData.Append(string.Format("<set value='{0}' color='{1}'/>", dr["data"], GetColor(color, i)));
                        i++;
                    }
                }
                chartData.Append("</dataset>");
                chartData.Append("</chart>");
            }
        }
    }

    protected string GetColor(string[] color, int num)
    {
        string colorCode;
        if (num < color.Length)
        {
            colorCode = color[num];
        }
        else
        {
            colorCode = color[num % color.Length];
        }
        return colorCode;
    }
    #endregion
    public DataView GetTopDataViewRows(DataView Mydv, int N)
    {
        DataTable TblClone = Mydv.Table.Clone();
        for (int i = 0; i <= N - 1; i++)
        {
            if (i >= Mydv.Count)
                break;
            TblClone.ImportRow(Mydv[i].Row);
        }
        return new DataView(TblClone, Mydv.RowFilter, Mydv.Sort, Mydv.RowStateFilter);
    }
    private void QureyCase()
    {
        Report("1", ddlYearB.SelectedValue);
    }
    protected void ddlYearB_OnSelectedChanged(object sender, EventArgs e)
    {
        GetData();
        QureyCase();
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        QureyCase();
    }
    protected void rbtlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        ckDivEnabled();
    }
}
