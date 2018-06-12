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
public partial class MasterData_Education21EvaluateView : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    DataView dvChildStandard = null;
    DataView dvChildIndicator = null;
    DataView dvEducation21Evaluate = null;
    DataView dvMaxScore = null;
    decimal TotalScore = 0;
    decimal TotalFullScore = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, null);

            getddlYear();
            //getddlEvaluateType(0);
            getData(0);
            getData(1);
            lblTotal.Text = string.Format("<img src=\"../Image/MenuStlye/M4.png\" style=\"float:left;border:none;width:25px;height:28px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:xx-large;font-weight:bold;width:600px;overflow:hidden;\" title=\"รวม\">{0}</span><span style=\"width:100px; text-align:right; float:right; margin:0 22px 0 0; color:black; font-size:28px; font-weight:bold;text-align:right;\">{2}</span><span style=\"width:100px; text-align:right;float:Right; margin:0 20px 0 0; color:black; font-size:28px; font-weight:bold;text-align:right;\">{1}</span><span style=\"float:right; padding:0 125px 0 0; color:#000000; font-size:xx-large; font-weight:bold;\"></span><br />", "รวมทั้งหมดทุกด้าน", TotalFullScore.ToString("#,##0.00"), TotalScore.ToString("#,##0.00"));
        }
    }
    //private void getddlEvaluateType(int mode)
    //{
    //    if (mode == 0)
    //    {
    //        ddlSearchEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
    //        ddlSearchEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
    //        ddlSearchEvaluateType.DataBind();
    //        //ddlSearchEvaluateType.SelectedIndex = 0;

    //        if (Cookie.GetValue2("EvaluateType") == null)
    //        {
    //            ddlSearchEvaluateType.SelectedIndex = 0;
    //        }
    //        else
    //        {
    //            try
    //            {
    //                ddlSearchEvaluateType.SelectedValue = Cookie.GetValue2("EvaluateType").ToString();
    //            }
    //            catch (Exception ex)
    //            {
    //                ddlSearchEvaluateType.SelectedIndex = 0;
    //            }
    //        }
    //    }

    //    if (mode == 1)
    //    {
    //    }
    //}
        private void BindMainDataView()
    {
        string strSql = @" Select ES.Education21SideID, ES.StudyYear, ES.Education21SideName, ES.Sort As ESSort, ED.ckEvaluate,
                ED.Education21StandardID, 'มาตรฐานที่ ' + Cast(ES.Sort As nVarChar) + '.' + Cast(ED.Sort As nVarChar) + ' ' + ED.Education21StandardName As Education21StandardName, ED.Sort As EDSort
                From Education21Side ES, Education21Standard ED
                Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0
                And ES.Education21SideID = ED.Education21SideID 
                Order By ES.Sort, ED.Sort ";
        dvChildStandard = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select ES.Education21SideID, ES.StudyYear, ES.Education21SideName, ES.Sort As ESSort,
                ED.Education21StandardID, 'มาตรฐานที่ ' + Cast(ES.Sort As nVarChar) + '.' + Cast(ED.Sort As nVarChar) + ' ' + ED.Education21StandardName As Education21StandardName, ED.Sort As EDSort,
                EI.Education21IndicatorID, 'ตัวชี้วัดที่ ' + Cast(ES.Sort As nVarChar) + '.' + Cast(ED.Sort As nVarChar) + '.' + Cast(EI.Sort As nVarChar) + ' ' + EI.Education21IndicatorName As Education21IndicatorName, EI.Sort As EISort
                From Education21Side ES, Education21Standard ED, Education21Indicator EI
                Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0 And EI.DelFlag = 0
                And ES.Education21SideID = ED.Education21SideID And ED.Education21StandardID = EI.Education21StandardID
                Order By ES.Sort, ED.Sort, EI.Sort ";
        dvChildIndicator = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

//        strSql = @" Select ES.Education21SideID, ES.StudyYear, ES.Sort As ESSort, ED.Sort As EDSort, EI.Sort As EISort,                
//                EC.Education21CriterionID, EC.Detail, EC.Score, EC.Sort As ECSort, 
//                EE.Education21EvaluateID, EE.Education21StandardID, EE.Education21IndicatorID, EE.Sort As EESort
//                From Education21Side ES, Education21Standard ED, Education21Indicator EI, Education21Criterion EC, Education21Evaluate EE
//                Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0 And EI.DelFlag = 0
//                And ES.Education21SideID = ED.Education21SideID And ED.Education21StandardID = EI.Education21StandardID
//                And EI.Education21IndicatorID = EC.Education21IndicatorID And EI.Education21IndicatorID = EE.Education21IndicatorID And EC.Sort = EE.Sort
//                Order By ES.Sort, ED.Sort, EI.Sort ";
        strSql = @" Select ES.Education21SideID, ES.StudyYear, ES.Sort As ESSort, ED.Sort As EDSort, EI.Sort As EISort,                
                EC.Education21CriterionID, EC.Detail, EC.Score, EC.Sort As ECSort, 
                EE.Education21EvaluateID, EE.Education21StandardID, EE.Education21IndicatorID, EE.Sort As EESort
                From Education21Side ES, Education21Standard ED, Education21Indicator EI, Education21Criterion EC, Education21Evaluate EE
                Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0 And EI.DelFlag = 0
                And ES.Education21SideID = ED.Education21SideID And ED.Education21StandardID = EI.Education21StandardID
                And EI.Education21IndicatorID = EC.Education21IndicatorID 
                And (EI.Education21IndicatorID = EE.Education21IndicatorID OR ED.Education21StandardID = EE.Education21StandardID)
                And EC.Sort = EE.Sort
                Order By ES.Sort, ED.Sort, EI.Sort ";
        dvEducation21Evaluate = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        strSql = @" Select ES.Education21SideID, ES.StudyYear, ED.Education21StandardID, EI.Education21IndicatorID, Max(EC.Score) MaxScore
                From Education21Side ES, Education21Standard ED, Education21Indicator EI, Education21Criterion EC
                Where ES.StudyYear = '{0}' And ES.DelFlag = 0 And ED.DelFlag = 0 And EI.DelFlag = 0
                And ES.Education21SideID = ED.Education21SideID And ED.Education21StandardID = EI.Education21StandardID
                And EI.Education21IndicatorID = EC.Education21IndicatorID
                Group By ES.Education21SideID, ES.StudyYear, ED.Education21StandardID, EI.Education21IndicatorID ";
        dvMaxScore = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));
    }
    private void getData(Int32 EvaluateType) //ด้าน
    {
        string strSql = @" Select Education21SideID, StudyYear, 'ด้านที่ ' + Cast(Sort As nVarChar) + '. ' + Education21SideName As Education21SideName, Sort 
                From Education21Side Where StudyYear = '{0}' And DelFlag = 0 And EvaluateType = " + EvaluateType + " Order By Sort ";
        DataView dv5 = Conn.Select(string.Format(strSql, ddlYearB.SelectedValue));

        BindMainDataView();
        decimal SideScore = 0;
        decimal SideFullScore = 0;

        for (int m = 0; m < dv5.Count; m++)
        {
            decimal sdScore = 0;
            decimal sdFullScore = 0;
            dvChildStandard.RowFilter = " Education21SideID = '" + dv5[m]["Education21SideID"].ToString() + "' ";

            for (int i = 0; i < dvChildStandard.Count; i++)
            {
                decimal stdScore = 0;
                decimal stdFullScore = 0;
                dvChildIndicator.RowFilter = " Education21StandardID = '" + dvChildStandard[i]["Education21StandardID"].ToString() + "' ";
                if (dvChildIndicator.Count != 0)
                {
                    for (int j = 0; j < dvChildIndicator.Count; j++)
                    {
                        string Criterion = "-";
                        decimal Score = 0;
                        decimal FullScore = 0;

                        if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "0") // ประเมินจากตัวชี้วัด
                        {
                            dvEducation21Evaluate.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                            if (dvEducation21Evaluate.Count != 0)
                            {
                                Criterion = dvEducation21Evaluate[0]["EESort"].ToString();
                                Score = Convert.ToDecimal(dvEducation21Evaluate[0]["Score"].ToString());
                                stdScore += Score;
                            }

                            dvMaxScore.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                            if (dvMaxScore.Count != 0)
                            {
                                FullScore = Convert.ToDecimal(dvMaxScore[0]["MaxScore"].ToString());
                                stdFullScore += FullScore;
                            }
                        }
                        if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "1") // ประเมินจากมาตรฐาน
                        {
                            dvEducation21Evaluate.RowFilter = " Education21StandardID = '" + dvChildIndicator[j]["Education21StandardID"].ToString() + "' ";
                            if (dvEducation21Evaluate.Count != 0)
                            {
                                Criterion = dvEducation21Evaluate[0]["EESort"].ToString();
                                Score = Convert.ToDecimal(dvEducation21Evaluate[0]["Score"].ToString());
                                stdScore += Score;
                            }

                            dvMaxScore.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                            if (dvMaxScore.Count != 0)
                            {
                                FullScore = Convert.ToDecimal(dvMaxScore[0]["MaxScore"].ToString());
                                stdFullScore += FullScore;
                            }
                        }
                    }
                    if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "0") // ประเมินจากตัวชี้วัด
                    {

                    }
                    if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "1") // ประเมินจากมาตรฐาน หาคะแนนเต็ม
                    {
                        if (dvEducation21Evaluate.Count != 0)
                        {
                            stdScore = stdScore / dvEducation21Evaluate.Count;
                        }
                        stdFullScore = stdFullScore / dvChildIndicator.Count;
                    }
                }
                sdScore += stdScore;
                sdFullScore += stdFullScore;               
            }

            SideScore += sdScore;
            SideFullScore += sdFullScore;

            TreeNode tNodeSide = new TreeNode();
            tNodeSide.Text = string.Format("<img src=\"../Image/MenuStlye/S3.png\" style=\"float:left;border:none;padding:0 0 0 20px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:20px;font-weight:bold;width:500px;overflow:hidden;\" title=\"{1}\">{0}</span><span style=\"float:right;margin-right:25px;color:black;font-size:20px;font-weight:bold;width:50px;overflow:hidden;text-align:right;\">{3}</span><span style=\"float:right;margin-right:70px;color:black;font-size:20px;font-weight:bold;width:70px;overflow:hidden;text-align:right;\">{2}</span><span style=\"float:right;padding-right:10px;color:black;font-size:large;font-weight:bold;width:140px;overflow:hidden;\">{4}</span>", (dv5[m]["Education21SideName"].ToString().Length > 60 ? dv5[m]["Education21SideName"].ToString().Substring(0, 60) + "..." : dv5[m]["Education21SideName"]), dv5[m]["Education21SideName"].ToString(), sdFullScore.ToString("#,##0.00"), sdScore.ToString("#,##0.00"), "");
            //tNode.Text = dv[i]["StandardName"].ToString();
            tNodeSide.Value = dv5[m]["Education21SideID"].ToString();
            AddChildStandard(tNodeSide);

            if (EvaluateType == 0)
            {
                TreeView1.Nodes.Add(tNodeSide);
            }
            if (EvaluateType == 1)
            {
                TreeView2.Nodes.Add(tNodeSide);
            }

        }
        if (EvaluateType == 0)
        {
            TreeView1.CollapseAll();
            TreeView1.NodeStyle.Width = new Unit("100%");
            lblSumSide1.Text = string.Format("<img src=\"../Image/MenuStlye/M7.png\" style=\"float:left;border:none;width:25px;height:28px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:x-large;font-weight:bold;width:600px;overflow:hidden;\" title=\"รวม\">{0}</span><span style=\"width:80px; text-align:right; float:right; margin:0 25px 0 0; color:black; font-size:24px; font-weight:bold;text-align:right;\">{2}</span><span style=\"width:80px; text-align:right;float:Right; margin:0 40px 0 0; color:black; font-size:24px; font-weight:bold;text-align:right;\">{1}</span><span style=\"float:right; padding:0 125px 0 0; color:#000000; font-size:x-large; font-weight:bold;\"></span><p style=\"clear:both; float:none;\"></p><hr /><br />", "รวมประเมินวิธีการทั้ง " + dv5.Count.ToString("0") + " ด้าน", SideFullScore.ToString("#,##0.00"), SideScore.ToString("#,##0.00"));
        }
        if (EvaluateType == 1)
        {
            TreeView2.CollapseAll();
            TreeView2.NodeStyle.Width = new Unit("100%");
            lblSumSide2.Text = string.Format("<img src=\"../Image/MenuStlye/M7.png\" style=\"float:left;border:none;width:25px;height:28px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:x-large;font-weight:bold;width:600px;overflow:hidden;\" title=\"รวม\">{0}</span><span style=\"width:80px; text-align:right; float:right; margin:0 25px 0 0; color:black; font-size:24px; font-weight:bold;text-align:right;\">{2}</span><span style=\"width:80px; text-align:right;float:Right; margin:0 40px 0 0; color:black; font-size:24px; font-weight:bold;text-align:right;\">{1}</span><span style=\"float:right; padding:0 125px 0 0; color:#000000; font-size:x-large; font-weight:bold;\"></span><p style=\"clear:both; float:none;\"></p><hr /><br />", "รวมประเมินผลงานทั้ง " + dv5.Count.ToString("0") + " ด้าน", SideFullScore.ToString("#,##0.00"), SideScore.ToString("#,##0.00"));
        }
        TotalScore += SideScore;
        TotalFullScore += SideFullScore;
    }
    private void AddChildStandard(TreeNode tNodeSide)  //มาตรฐาน
    {
        dvChildStandard.RowFilter = " Education21SideID = '" + tNodeSide.Value + "' ";
        for (int i = 0; i < dvChildStandard.Count; i++)
        {
            decimal stdScore = 0;
            decimal stdFullScore = 0;
            dvChildIndicator.RowFilter = " Education21StandardID = '" + dvChildStandard[i]["Education21StandardID"].ToString() + "' ";
            if (dvChildIndicator.Count != 0)
            {
                for (int j = 0; j < dvChildIndicator.Count; j++)
                {
                    string Criterion = "-";
                    decimal Score = 0;
                    decimal FullScore = 0;

                    if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "0") // ประเมินจากตัวชี้วัด
                    {
                        dvEducation21Evaluate.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                        if (dvEducation21Evaluate.Count != 0)
                        {
                            Criterion = dvEducation21Evaluate[0]["EESort"].ToString();
                            Score = Convert.ToDecimal(dvEducation21Evaluate[0]["Score"].ToString());
                            stdScore += Score;
                        }

                        dvMaxScore.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                        if (dvMaxScore.Count != 0)
                        {
                            FullScore = Convert.ToDecimal(dvMaxScore[0]["MaxScore"].ToString());
                            stdFullScore += FullScore;
                        }
                    }
                    if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "1") // ประเมินจากมาตรฐาน
                    {
                        dvEducation21Evaluate.RowFilter = " Education21StandardID = '" + dvChildIndicator[j]["Education21StandardID"].ToString() + "' ";
                        if (dvEducation21Evaluate.Count != 0)
                        {
                            Criterion = dvEducation21Evaluate[0]["EESort"].ToString();
                            Score = Convert.ToDecimal(dvEducation21Evaluate[0]["Score"].ToString());
                            stdScore += Score;
                        }

                        dvMaxScore.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[j]["Education21IndicatorID"].ToString() + "' ";
                        if (dvMaxScore.Count != 0)
                        {
                            FullScore = Convert.ToDecimal(dvMaxScore[0]["MaxScore"].ToString());
                            stdFullScore += FullScore;
                        }
                    }
                }
                if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "0") // ประเมินจากตัวชี้วัด
                {
                   
                }
                if (Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString() == "1") // ประเมินจากมาตรฐาน หาคะแนนเต็ม
                {
                    if (dvEducation21Evaluate.Count != 0)
                    {
                        stdScore = stdScore / dvEducation21Evaluate.Count;
                    }
                    stdFullScore = stdFullScore / dvChildIndicator.Count;
                }
            }

            TreeNode tNodeStandard = new TreeNode();
            tNodeStandard.Text = string.Format("<img src=\"../Image/MenuStlye/S21.png\" style=\"float:left;border:none;padding:0 0 0 20px;\"/>&nbsp;&nbsp;<span style=\"color:#424242;font-size:18px;font-weight:bold;width:600px;overflow:hidden;\" title=\"{1}\">{0}</span><span style=\"float:right;margin-right:25px;color:#424242;font-size:18px;font-weight:bold;width:50px;overflow:hidden;text-align:right;\">{3}</span><span style=\"float:right;margin-right:70px;color:#424242;font-size:18px;font-weight:bold;width:50px;overflow:hidden;text-align:right;\">{2}</span><span style=\"float:right;padding-right:10px;color:#424242;font-size:18px;font-weight:bold;width:140px;overflow:hidden;\">{4}</span>", (dvChildStandard[i]["Education21StandardName"].ToString().Length > 60 ? dvChildStandard[i]["Education21StandardName"].ToString().Substring(0, 60) + "..." : dvChildStandard[i]["Education21StandardName"]), dvChildStandard[i]["Education21StandardName"].ToString(), stdFullScore.ToString("#,##0.00"), stdScore.ToString("#,##0.00"), "");

            tNodeStandard.Value = dvChildStandard[i]["Education21StandardID"].ToString();
            AddChildIndicator(tNodeStandard, Convert.ToInt32(dvChildStandard[i]["ckEvaluate"]).ToString());
            tNodeSide.ChildNodes.Add(tNodeStandard);
        }
    }
    private void AddChildIndicator(TreeNode tNodeStandard, string ckEvaluate)  //ตัวบ่งชี้
    {
        dvChildIndicator.RowFilter = " Education21StandardID = '" + tNodeStandard.Value + "' ";
        for (int i = 0; i < dvChildIndicator.Count; i++)
        {
            string Criterion = "";
            string strScore = "";
            decimal Score = 0;
            string ckColor = "gray";
            string strFullScore = "";
            decimal FullScore = 0;

            if (ckEvaluate == "0") // ประเมินจากตัวชี้วัด ถ้าประเมินจากมาตรฐาน จะข้ามไปไม่ต้องทำ
            {
                dvEducation21Evaluate.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[i]["Education21IndicatorID"].ToString() + "' ";
                if (dvEducation21Evaluate.Count != 0)
                {
                    Criterion = dvEducation21Evaluate[0]["EESort"].ToString();
                    Score = Convert.ToDecimal(dvEducation21Evaluate[0]["Score"]);
                    strScore = Score.ToString("#,##0.00");

                    if (Convert.ToInt32(dvEducation21Evaluate[0]["EESort"].ToString()) == 1)
                    {
                        ckColor = "red";
                    }
                    if (Convert.ToInt32(dvEducation21Evaluate[0]["EESort"].ToString()) == 3)
                    {
                        ckColor = "green";
                    }
                }
                else
                {
                    strScore = "0.00";
                }

                dvMaxScore.RowFilter = " Education21IndicatorID = '" + dvChildIndicator[i]["Education21IndicatorID"].ToString() + "' ";
                if (dvMaxScore.Count != 0)
                {
                    FullScore = Convert.ToDecimal(dvMaxScore[0]["MaxScore"]);
                    strFullScore = FullScore.ToString("#,##0.00");
                }
                else
                {
                    strFullScore = "0.00";
                }
            }

            TreeNode tNodeIndicator = new TreeNode();
            tNodeIndicator.Text = string.Format("<img src=\"../Image/MenuStlye/S23.png\" style=\"float:left;border:none;padding:0 0 0 25px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:medium;width:580px;overflow:hidden;\" title=\"{1}\">{0}</span><span style=\"float:right;margin-right:25px;color:" + ckColor + ";font-size:12pt;width:40px;overflow:hidden;text-align:right;\">{3}</span><span style=\"float:right;margin-right:80px;color:" + ckColor + ";font-size:12pt;width:40px;overflow:hidden;text-align:right;\">{2}</span><span style=\"float:right;padding-right:10px;color:" + ckColor + ";font-size:12pt;width:140px;overflow:hidden;\">{4}</span>", (dvChildIndicator[i]["Education21IndicatorName"].ToString().Length > 70 ? dvChildIndicator[i]["Education21IndicatorName"].ToString().Substring(0, 70) + "..." : dvChildIndicator[i]["Education21IndicatorName"].ToString()), dvChildIndicator[i]["Education21IndicatorName"].ToString(), strFullScore, strScore, Criterion);
            tNodeStandard.ChildNodes.Add(tNodeIndicator);
        }
    }
    private void getddlYear()
    {
        btc.getdllStudyYear(ddlYearB);
        btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        TreeView1.Nodes.Clear();
        TreeView2.Nodes.Clear();
        getData(0);
        getData(1);
        lblTotal.Text = string.Format("<img src=\"../Image/MenuStlye/M4.png\" style=\"float:left;border:none;width:25px;height:28px;\"/>&nbsp;&nbsp;<span style=\"color:black;font-size:xx-large;font-weight:bold;width:600px;overflow:hidden;\" title=\"รวม\">{0}</span><span style=\"width:100px; text-align:right; float:right; margin:0 22px 0 0; color:black; font-size:28px; font-weight:bold;text-align:right;\">{2}</span><span style=\"width:100px; text-align:right;float:Right; margin:0 20px 0 0; color:black; font-size:28px; font-weight:bold;text-align:right;\">{1}</span><span style=\"float:right; padding:0 125px 0 0; color:#000000; font-size:xx-large; font-weight:bold;\"></span><br />", "รวมทั้งหมดทุกด้าน", TotalFullScore.ToString("#,##0.00"), TotalScore.ToString("#,##0.00"));

        //ScriptManager.RegisterStartupScript(btn1, typeof(Page), "gotoReferer", "Loading.close();", true);
    }
    //protected void ddlSearchEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    TreeView1.Nodes.Clear();
    //    Cookie.SetValue2("EvaluateType", ddlSearchEvaluateType.SelectedValue);
    //    DataBind();
    //    ScriptManager.RegisterStartupScript(btn1, typeof(Page), "gotoReferer", "Loading.close();", true);
    //}
    protected void btn1_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(200);
    }
    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {

    }
    protected void TreeView2_SelectedNodeChanged(object sender, EventArgs e)
    {

    }
}