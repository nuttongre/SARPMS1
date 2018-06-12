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
using System.Drawing;
using System.Text;
using System.Globalization;

public partial class ftYearWithdraw : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount = 0;
    decimal TotalAmount2 = 0;
    decimal TotalAmount3 = 0;
    decimal TotalAmountAc = 0;
    decimal TotalAmount2Ac = 0;
    decimal TotalAmount3Ac = 0;

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
            btc.LinkReport(linkReport);
            if (!string.IsNullOrEmpty(Request.QueryString["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request.QueryString["ckmode"], Convert.ToInt32(Request.QueryString["Cr"]));
            }

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);
            
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1, ddlYearS);
                        getddlTerm(1, ddlTerm);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "5":
                        MultiView1.ActiveViewIndex = 2;
                        btc.CkAdmission(GridView2, null, null);
                        getddlYear(0, ddlSearchStudyYear2);
                        getddlTerm(0, ddlSearchTerm);
                        getddlftYearClass(0, ddlSearchClass);
                        getddlftYearBudgetType(0, ddlSearchBudgetType);
                        btc.getddlMainDepartment(0, ddlSearchMainDept2, Cookie.GetValue2("ckMainDeptID"));
                        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept2, ddlSearchMainDept2.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                        btc.getddlDepartment(0, ddlSearchDept2, ddlSearchMainSubDept2.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                        GetDataView(Request.QueryString["mid"]);
                        DataBind();
                        GetDataAttach(Request.QueryString["mid"]);
                        break;
                    case "7":
                        MultiView1.ActiveViewIndex = 3;
                        getddlftYearClass(1, ddlClass);
                        GetData2(Request.QueryString["id"]);
                        GetDataAttach(Request.QueryString["id"]);
                        if (ddlftYearBudgetType.SelectedValue == "1")
                        {
                            divSubsidy.Visible = true;
                        }
                        DataBind();
                        btc.btEnable(btSaveAgain, false);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt2(0); SumGridTotal();", true);
                        break;
                    case "9":
                        MultiView1.ActiveViewIndex = 4;
                        GetData3(Request.QueryString["id"]);
                        break;
                }
            }
            else
            {
                getddlYear(0, ddlSearchYear);
                btc.CkAdmission(GridView1, null, null);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                DataBind();
            }
        }
        ddlTerm.Attributes.Add("onchange", "Cktxt(0);");
        ddlYearS.Attributes.Add("onchange", "Cktxt(0);");
        ddlClass.Attributes.Add("onchange", "Cktxt2(0);");
        ddlftYearBudgetType.Attributes.Add("onchange", "Cktxt2(0);");
        ddlftYearBudgetTypeDetail.Attributes.Add("onchange", "Cktxt2(0);");
    }
    private void getddlYear(int mode, DropDownList ddl)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddl);
            btc.getDefault(ddl, "StudyYear", "StudyYear");
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddl);
            btc.getDefault(ddl, "StudyYear", "StudyYear");
        }
    }
    private void getddlTerm(int mode, DropDownList ddl)
    {
        ddl.Items.Clear();
        ddl.Items.Insert(0, new ListItem("1", "1"));
        ddl.Items.Insert(1, new ListItem("2", "2"));
        ddl.SelectedIndex = 0;
    }
    private void getddlftYearClass(int mode, DropDownList ddl)
    {
        string strSql = @" Select * From ftYearClass Order By ClassID ";
        DataView dv = Conn.Select(string.Format(strSql));
        if (dv.Count > 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "ClassName";
            ddl.DataValueField = "ClassID";
            ddl.DataBind();
        }
        if (mode == 0)
        {
            ddl.Items.Insert(0, new ListItem("- ทั้งหมด -", ""));
            if (Cookie.GetValue2("ckClassID") == null)
            {
                ddl.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddl.SelectedValue = Cookie.GetValue2("ckClassID").ToString();
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
        else
        {
            ddl.Items.Insert(0, new ListItem("- เลือก -", ""));
            ddl.SelectedIndex = 0;
        }
    }
    private void getddlftYearBudgetType(int mode, DropDownList ddl)
    {
        string strSql = @" Select * From ftYearBudgetType Order by BudgetTypeID ";
        DataView dv = Conn.Select(string.Format(strSql));
        if (dv.Count > 0)
        {
            ddl.DataSource = dv;
            ddl.DataTextField = "BudgetTypeName";
            ddl.DataValueField = "BudgetTypeID";
            ddl.DataBind();
        }
        if (mode == 0)
        {
            ddl.Items.Insert(0, new ListItem("- ทั้งหมด -", ""));
            if (Cookie.GetValue2("ckBudgetTypeID") == null)
            {
                ddl.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddl.SelectedValue = Cookie.GetValue2("ckBudgetTypeID").ToString();
                }
                catch (Exception ex)
                {
                    ddl.SelectedIndex = 0;
                }
            }
        }
        else
        {
            ddl.Items.Insert(0, new ListItem("- เลือก -", ""));
            ddl.SelectedIndex = 0;
        }
    }
    private void getddlftYearBudgetTypeDetail()
    {
        string strSql = @" Select * From ftYearBudgetTypeDetail Where BudgetTypeID = '{0}' Order By BudgetDetailTypeID ";
        DataView dv = Conn.Select(string.Format(strSql, ddlftYearBudgetType.SelectedValue));
        if (dv.Count > 0)
        {
            ddlftYearBudgetTypeDetail.DataSource = dv;
            ddlftYearBudgetTypeDetail.DataTextField = "BudgetDetailTypeName";
            ddlftYearBudgetTypeDetail.DataValueField = "BudgetDetailTypeID";
            ddlftYearBudgetTypeDetail.DataBind();
            ddlftYearBudgetTypeDetail.Items.Insert(0, new ListItem("- เลือก -", ""));
            ddlftYearBudgetTypeDetail.SelectedIndex = 0;
            ddlftYearBudgetTypeDetail.Enabled = true;
        }
        else
        {
            ddlftYearBudgetTypeDetail.Items.Insert(0, new ListItem("- เลือก -", ""));
            ddlftYearBudgetTypeDetail.SelectedIndex = 0;
            ddlftYearBudgetTypeDetail.Enabled = false;
        }
    }
    public override void DataBind()
    {
        if (string.IsNullOrEmpty(Request.QueryString["mode"]))
        {
            string StrSql = @" Select M.MasterID, M.Term, M.StudyYear, D.DeptName, D.DeptCode, SD.MainSubDeptCode, SD.MainSubDeptName, MD.MainDeptCode, MD.MainDeptName 
                        From ftYearMaster M Inner Join Department D On M.DeptCode = D.DeptCode
                        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
                        Inner Join MainDepartment MD ON SD.MainDeptCode = MD.MainDeptCode
                        Where M.DelFlag = 0 ";

            if (ddlSearchYear.SelectedIndex != 0)
            {
                StrSql += " And M.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
            }
            if (ddlSearchMainDept.SelectedIndex != 0)
            {
                StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "'";
            }
            if (ddlSearchMainSubDept.SelectedIndex != 0)
            {
                StrSql += " And SD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "'";
            }
            if (ddlSearchDept.SelectedIndex != 0)
            {
                StrSql += " And D.DeptCode = '" + ddlSearchDept.SelectedValue + "'";
            }
            if (txtSearch.Text != "")
            {
                StrSql += " And M.Term Like '%" + txtSearch.Text + "%' Or M.StudyYear Like '%" + txtSearch.Text + "%'  ";
            }
            DataView dv = Conn.Select(string.Format(StrSql + " Order By M.StudyYear Asc, M.Term "));

            GridView1.DataSource = dv;
            GridView1.DataBind();
            lblSearchTotal.InnerText = dv.Count.ToString();
        }
        else
        {
            if (Request.QueryString["mode"] == "5")
            {
                string StrSql = @" Select M.MasterID, M.Term, M.StudyYear, MD.ItemID, MD.Price, MD.Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount, 
                        C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Amount2, 0) Amount2, 
                        IsNull(MD.Price2, 0) Price2, IsNull(MD.Price2, 0) * IsNull(MD.Amount2, 0) As TotalAmount2, MD.WithdrawUser, MD.WithdrawDate, MD.BudgetDetailTypeID 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Inner Join ftYearClass C On MD.ClassID = C.ClassID
                        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
                        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
                        Inner Join Department D On M.DeptCode = D.DeptCode
                        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
                        Inner Join MainDepartment MDt ON SD.MainDeptCode = MDt.MainDeptCode
                        Where M.DelFlag = 0 And M.MasterID = '" + Request.QueryString["mid"] + "' ";

                if (ddlSearchClass.SelectedIndex != 0)
                {
                    StrSql += " And C.ClassID = '" + ddlSearchClass.SelectedValue + "' ";
                }
                if (ddlSearchBudgetType.SelectedIndex != 0)
                {
                    StrSql += " And BT.BudgetTypeID = '" + ddlSearchBudgetType.SelectedValue + "' ";
                }
                if (ddlSearchMainDept2.SelectedIndex != 0)
                {
                    StrSql += " And MDt.MainDeptCode = '" + ddlSearchMainDept2.SelectedValue + "' ";
                }
                if (ddlSearchMainSubDept2.SelectedIndex != 0)
                {
                    StrSql += " And SD.MainSubDeptCode = '" + ddlSearchMainSubDept2.SelectedValue + "' ";
                }
                if (ddlSearchDept2.SelectedIndex != 0)
                {
                    StrSql += " And D.DeptCode = '" + ddlSearchDept2.SelectedValue + "'";
                }
                if (txtSearch2.Text != "")
                {
                    StrSql += " And (C.ClassName Like '%" + txtSearch2.Text + "%' Or BD.BudgetDetailTypeName Like '%" + txtSearch2.Text + "%'  Or BT.BudgetTypeName Like '%" + txtSearch2.Text + "%') ";
                }
                DataView dv = Conn.Select(string.Format(StrSql + " And BD.BudgetDetailTypeID <> 5 Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID"));

                GridView2.DataSource = dv;
                GridView2.DataBind();
                lblSearchTotal2.InnerText = dv.Count.ToString();

                DataView dvAc = Conn.Select(string.Format(StrSql + " And BD.BudgetDetailTypeID = 5 Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID"));

                GridView3.DataSource = dvAc;
                GridView3.DataBind();

                StrSql = @" Select IsNull(Sum(IsNull(MD.Amount, 0)), 0) TotalStudent, IsNull(Sum(IsNull(MD.Price, 0)), 0) TotalPrice, 
                IsNull(Sum((IsNull(MD.Amount, 0) * IsNull(MD.Price, 0))), 0) SumTotal
		        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
		        Where M.DelFlag = 0 And M.MasterID = '{0}' And MD.BudgetDetailTypeID = 5 ";
                DataView dvMoneyActivity = Conn.Select(string.Format(StrSql, Request.QueryString["mid"]));
                if (dvMoneyActivity.Count > 0)
                {
                    lblTotalStudent.Text = Convert.ToInt32(dvMoneyActivity[0]["TotalStudent"]).ToString("#,##0");
                    lblTotalPrice.Text = Convert.ToDecimal(dvMoneyActivity[0]["TotalPrice"]).ToString("#,##0.00");
                    lblSumTotal.Text = Convert.ToDecimal(dvMoneyActivity[0]["SumTotal"]).ToString("#,##0.00");

                    decimal SumToal = 0;
                    decimal SetMoneyAcType = 0;
                    if ((!string.IsNullOrEmpty(lblSumTotal.Text)) && (!string.IsNullOrEmpty(lblSetMoneyAcType.Text)))
                    {
                        SumToal = Convert.ToDecimal(lblSumTotal.Text);
                        SetMoneyAcType = Convert.ToDecimal(lblSetMoneyAcType.Text);
                    }
                    lblSumTotalAll.Text = (SumToal + SetMoneyAcType).ToString("#,##0.00");
                }

                StrSql = @" Select IsNull(Sum(CD.TotalMoney2), 0) As MoneyAcType From Activity A 
                Inner Join dtAcDept dt On A.ActivityCode = dt.ActivityCode 
		        Inner Join CostsDetail CD On A.ActivityCode = CD.ActivityCode
		        Where A.DelFlag = 0 And A.ApproveFlag = 1 And A.Status = 3 
		        And A.StudyYear = '{0}' And A.Term = '{1}' And dt.DeptCode = '{2}'
		        And CD.BudgetTypeCode = 'b27b079f-5da5-4278-a172-b974be1ed317' ";
                DataView dvMoneyAcType = Conn.Select(string.Format(StrSql, lblStudyYear.Text, lblTerm.Text, ddlSearchDept2.SelectedValue));
                if (dvMoneyAcType.Count > 0)
                {
                    lblMoneyAcType.Text = Convert.ToDecimal(dvMoneyAcType[0]["MoneyAcType"]).ToString("#,##0.00");
                }

                lblTotalBalance.Text = (Convert.ToDecimal(lblSumTotalAll.Text) - Convert.ToDecimal(lblMoneyAcType.Text)).ToString("#,##0.00");
                btc.SetLableColor(lblTotalBalance);
            }
            else
            {
                if (Request.QueryString["mode"] == "7")
                {
                    string strSql = @"Select s.SubsidyID, s.SubsidyName, Sd.ItemID, IsNull(Sd.Money, 0) Money, Sd.BudgetTypeID 
                        From ftYearSubsidy s Left Join ftYearSubsidyDetail Sd On s.SubsidyID = Sd.SubsidyID And SD.BudgetTypeID = 1 And Sd.SubsidyItemID = '{0}'
                        Where s.Delflag = 0  
                        Order By s.SubsidyID ";
                    DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["id"]));
                    GridSubsidy.DataSource = dv;
                    GridSubsidy.DataBind();
                }
            }
        }
    }
    private void GetDataView(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select M.*, SD.MainSubDeptCode From ftYearMaster M Inner Join Department D On M.DeptCode = D.DeptCode
        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
        Where M.MasterID = '" + id + "' ";
        DataView dv = Conn.Select(string.Format(strSql));

        if (dv.Count != 0)
        {
            ddlSearchTerm.SelectedValue = dv[0]["Term"].ToString();
            ddlSearchStudyYear2.SelectedValue = dv[0]["StudyYear"].ToString();
            lblTerm.Text = dv[0]["Term"].ToString();
            lblStudyYear.Text = dv[0]["StudyYear"].ToString();
            ddlSearchMainSubDept2.SelectedValue = dv[0]["MainSubDeptCode"].ToString();
            ddlSearchMainSubDept2.Enabled = false;
            btc.getddlDepartment(0, ddlSearchDept2, ddlSearchMainSubDept2.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
            ddlSearchDept2.SelectedValue = dv[0]["DeptCode"].ToString();
            ddlSearchDept2.Enabled = false;

            if (dv[0]["Term"].ToString() == "1")
            {
                GridView2.Columns[GridView2.Columns.Count - 9].Visible = false;
                lblNoteSetMoneyAcType.Text = "งบประมาณจากหมวดค่าหนังสือเรียนปีที่ผ่านมา";
                DataView dvSetBudgetAcType = null;
                strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
                else
                {
                    lblSetMoneyAcType.Text = "0.00";
                    lblWithDrawUser.Text = "";
                }
            }
            else
            {
                lblNoteSetMoneyAcType.Text = "งบประมาณจากหมวดค่ากิจกรรมเทอมที่แล้ว";

                decimal SetBudgetAcType = 0;
                decimal SumTotal = 0;
                decimal MoneyAcType = 0;
                string mid = Request.QueryString["mid"];

                DataView dvSetBudgetAcType = null;
                strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
                else
                {

                }
            }
        }
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From ftYearMaster Where MasterID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlTerm.SelectedValue = dv[0]["Term"].ToString();
            ddlYearS.SelectedValue = dv[0]["StudyYear"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "ftYearMaster", "MasterID", id);
    }
    private void GetData2(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select M.MasterID, M.Term, M.StudyYear, MD.ClassID, C.ClassName, MD.BudgetDetailTypeID,
                        IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Amount, 0) Amount, IsNull(MD.Price, 0) Price, IsNull(MD.Amount2, 0) Amount2, IsNull(MD.Price2, 0) Price2,
                        BD.BudgetDetailTypeName, BT.BudgetTypeName, BT.BudgetTypeID 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Inner Join ftYearClass C On MD.ClassID = C.ClassID
                        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
                        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
                        Where M.DelFlag = 0 And M.MasterID = '{0}' And MD.ItemID = '{1}' ";
        DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["mid"], id));

        if (dv.Count != 0)
        {
            lblTerm.Text = dv[0]["Term"].ToString();
            lblStudyYear.Text = dv[0]["StudyYear"].ToString();
            ddlClass.SelectedValue = dv[0]["ClassID"].ToString();
            getddlftYearBudgetType(1, ddlftYearBudgetType);
            ddlftYearBudgetType.SelectedValue = dv[0]["BudgetTypeID"].ToString();
            getddlftYearBudgetTypeDetail();
            ddlftYearBudgetTypeDetail.SelectedValue = dv[0]["BudgetDetailTypeID"].ToString();
            ddlftYearBudgetTypeDetail.Enabled = false;
            lblSetBudget.Text = Convert.ToDecimal(dv[0]["SetMoney"]).ToString("#,##0.00");
            txtAmount.Text = Convert.ToInt32(dv[0]["Amount"]).ToString("#,##0");
            txtPrice.Text = Convert.ToDecimal(dv[0]["Price"]).ToString("#,##0.00");
            lblTotalAmount.Text = (Convert.ToDecimal(dv[0]["SetMoney"]) + (Convert.ToInt32(dv[0]["Amount"]) * Convert.ToDecimal(dv[0]["Price"]))).ToString("#,##0.00");
            txtAmount2.Text = Convert.ToInt32(dv[0]["Amount2"]).ToString("#,##0");
            txtPrice2.Text = Convert.ToDecimal(dv[0]["Price2"]).ToString("#,##0.00");
            lblTotalAmount2.Text = (Convert.ToInt32(dv[0]["Amount2"]) * Convert.ToDecimal(dv[0]["Price2"])).ToString("#,##0.00");
        }
        btc.getCreateUpdateUser(lblCreate2, lblUpdate2, "ftYearMasterDetail", "ItemID", id);
    }
    private void GetData3(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select M.MasterID, M.Term, M.StudyYear, MD.*, C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName, BT.BudgetTypeID 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Inner Join ftYearClass C On MD.ClassID = C.ClassID
                        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
                        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
                        Where M.DelFlag = 0 And M.MasterID = '{0}' And MD.ItemID = '{1}' ";
        DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["mid"], id));

        if (dv.Count != 0)
        {
            lblTerm.Text = dv[0]["Term"].ToString();
            lblStudyYear.Text = dv[0]["StudyYear"].ToString();
            ddlClass.SelectedValue = dv[0]["ClassID"].ToString();
            getddlftYearBudgetType(1, ddlftYearBudgetType);
            ddlftYearBudgetType.SelectedValue = dv[0]["BudgetTypeID"].ToString();
            getddlftYearBudgetTypeDetail();
            ddlftYearBudgetTypeDetail.SelectedValue = dv[0]["BudgetDetailTypeID"].ToString();
            txtAmount.Text = Convert.ToInt32(dv[0]["Amount"]).ToString("#,##0");
            txtPrice.Text = Convert.ToDecimal(dv[0]["Price"]).ToString("#,##0.00");
            lblTotalAmount.Text = (Convert.ToInt32(dv[0]["Amount"]) * Convert.ToDecimal(dv[0]["Price"])).ToString("#,##0.00");
        }
        btc.getCreateUpdateUser(lblCreate2, lblUpdate2, "ftYearMasterDetail", "ItemID", id);
    }
    private void ClearAll()
    {
        //ddlClass.SelectedIndex = 0;
        //ddlftYearBudgetType.SelectedIndex = 0;
        ddlftYearBudgetTypeDetail.SelectedIndex = 0;
        txtAmount.Text = "0";
        txtPrice.Text = "0";
        lblTotalAmount.Text = "0.00";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private Boolean ckDataDupicate()
    {
        string strSql = " Select MasterID From ftYearMaster Where Term = '{0}' And StudyYear = '{1}' And DelFlag = 0 And DeptCode = '{2}' ";
        DataView dv = Conn.Select(string.Format(strSql, ddlTerm.SelectedValue, ddlYearS.SelectedValue, CurrentUser.DeptID));
        if (dv.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            if (!ckDataDupicate())
            {
                string NewID = Guid.NewGuid().ToString();
                i = Conn.AddNew("ftYearMaster", "MasterID, Term, StudyYear, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, DeptCode",
                    NewID, ddlTerm.SelectedValue, ddlYearS.SelectedValue, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, CurrentUser.DeptID);
                lblDupicate.Visible = false;

                if (CkAgain == "N")
                {
                    Response.Redirect("ftYearWithdraw.aspx?ckmode=1&Cr=" + i);
                }
            }
            else
            {
                lblDupicate.Visible = true;
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        bt_Save("N");
    }
    private void Delete2(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        //if (btc.CkUseData(id, "IdentityNameCode", "dtIdentityName", ""))
        //{
        //    Response.Redirect("ftYearWithdraw.aspx?ckmode=3&Cr=0"); 
        //}
        //else
        //{
        Int32 i = Conn.Delete("ftYearMasterDetail", "Where ItemID = '" + id + "' ");
        Response.Redirect("ftYearWithdraw.aspx?mode=5&&mid=" + Request.QueryString["mid"] + "&ckmode=3&Cr=" + i);
        //}
    }
    protected string checkedit(string id, string strName)
    {
        if ((CurrentUser.RoleLevel == 1) || (CurrentUser.RoleLevel >= 98))
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"View2('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchTerm_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchStudyYear2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSearch2_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave2_Click(object sender, EventArgs e)
    {
        bt_Save2("N");
    }
    protected void btSaveAgain_Click(object sender, EventArgs e)
    {
        bt_Save2("Y");
    }
    private Boolean ckDataDupicate2()
    {
        string strSql = " Select ItemID From ftYearMasterDetail Where MasterID = '{0}' And ClassID = '{1}' And BudgetDetailTypeID = '{2}' ";
        DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["mid"], ddlClass.SelectedValue, ddlftYearBudgetTypeDetail.SelectedValue));
        if (dv.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    private void bt_Save2(string CkAgain)
    {
        Int32 i = 0;
        Int32 result = 0;
        StringBuilder strbSql = new StringBuilder();
       
        if (Request.QueryString["mode"] == "7")
        {
            //i = Conn.Update("ftYearMasterDetail", "Where ItemID = '" + Request.QueryString["id"] + "'", "Amount2, Price2, WithdrawUser, WithdrawDate", Convert.ToInt32(txtAmount2.Text.Replace(",", "")), Convert.ToDecimal(txtPrice2.Text.Replace(",", "")), CurrentUser.ID, DateTime.Now);
            strbSql.AppendFormat("UPDATE ftYearMasterDetail SET Amount2 = {1}, Price2 = {2}, WithdrawUser = '{3}', WithdrawDate = '{4}' Where ItemID = '{0}';",
                Request.QueryString["id"], Convert.ToInt32(txtAmount2.Text.Replace(",", "")), Convert.ToDecimal(txtPrice2.Text.Replace(",", "")), CurrentUser.ID, Convert.ToDateTime(DateTime.Now).ToString("yyyy-MM-dd", new CultureInfo("en-gb")) + " 00:00:00.000");

            if (ddlftYearBudgetType.SelectedValue == "1")
            {
                string strSql = " Select ItemID From ftYearSubsidyDetail Where SubsidyItemID = '{0}' ";
                DataView dv = Conn.Select(string.Format(strSql, Request.QueryString["id"]));
                if (dv.Count > 0)
                {
                    strbSql.AppendFormat("Delete ftYearSubsidyDetail Where SubsidyItemID = '{0}';", Request.QueryString["id"]);
                    for (int j = 0; j < GridSubsidy.Rows.Count; j++)
                    {
                        strbSql.AppendFormat("INSERT INTO ftYearSubsidyDetail (ItemID, SubsidyID, Money, BudgetTypeID, SubsidyItemID)VALUES('{0}',{1},{2},{3},'{4}');",
                        Guid.NewGuid().ToString(), Request["hdfSubsidyID" + j + ""].Trim(), Convert.ToDecimal(Request["txtMoney" + j + ""]), 1, Request.QueryString["id"]);
                    }
                }
                else
                {
                    for (int j = 0; j < GridSubsidy.Rows.Count; j++)
                    {
                        strbSql.AppendFormat("INSERT INTO ftYearSubsidyDetail (ItemID, SubsidyID, Money, BudgetTypeID, SubsidyItemID)VALUES('{0}',{1},{2},{3},'{4}');",
                        Guid.NewGuid().ToString(), Request["hdfSubsidyID" + j + ""].Trim(), Convert.ToDecimal(Request["txtMoney" + j + ""]), 1, Request.QueryString["id"]);
                    }
                }
            }
            result = Conn.Execute(strbSql.ToString());
            Response.Redirect("ftYearWithdraw.aspx?mode=5&ckmode=2&mid=" + Request.QueryString["mid"] + "&Cr=" + result);
        }
    }

    protected void ddlftYearBudgetType_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlftYearBudgetTypeDetail();
        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
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
    protected string getStrAmount(object txt)
    {
        string Link = "0";
        if (!string.IsNullOrEmpty(txt.ToString()))
        {
            Link = Convert.ToInt32(txt).ToString("#,##0");
        }
        return Link;
    }
    protected string getStrPrice(object txt)
    {
        string Link = "0.00";
        if (!string.IsNullOrEmpty(txt.ToString()))
        {
            Link = Convert.ToInt32(txt).ToString("#,##0.00");
        }
        return Link;
    }
    protected void ddlSearchClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckClassID", ddlSearchClass.SelectedValue);
        DataBind();
    }
    protected void ddlSearchBudgetType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckBudgetTypeID", ddlSearchBudgetType.SelectedValue);
        DataBind();
    }
    protected string GetAmount(object amount)
    {
        decimal Amount = 0;
        if (!string.IsNullOrEmpty(amount.ToString()))
        {
            Amount = Convert.ToDecimal(amount);
            TotalAmount += Convert.ToDecimal(amount);
        }
        return Amount.ToString("#,##0.00");
    }
    protected string GetTotalAmount()
    {
        return TotalAmount.ToString("#,##0.00");
    }
    protected string GetAmount2(object amount)
    {
        decimal Amount = 0;
        if (!string.IsNullOrEmpty(amount.ToString()))
        {
            Amount = Convert.ToDecimal(amount);
            TotalAmount2 += Convert.ToDecimal(amount);
        }
        return Amount.ToString("#,##0.00");
    }
    protected string GetTotalAmount2()
    {
        return TotalAmount2.ToString("#,##0.00");
    }
    protected string GetAmount3(object amount1, object amount2)
    {
        decimal Amount1 = 0;
        decimal Amount2 = 0;
        if ((!string.IsNullOrEmpty(amount1.ToString())) && (!string.IsNullOrEmpty(amount2.ToString())))
        {
            Amount1 = Convert.ToDecimal(amount1);
            Amount2 = Convert.ToDecimal(amount2);
            TotalAmount3 += (Convert.ToDecimal(Amount1) - Convert.ToDecimal(Amount2));
        }
        return (Convert.ToDecimal(Amount1) - Convert.ToDecimal(Amount2)).ToString("#,##0.00");
    }
    protected string GetTotalAmount3()
    {
        return TotalAmount3.ToString("#,##0.00");
    }
    protected string GetAmountAc(object amount)
    {
        decimal Amount = 0;
        if (!string.IsNullOrEmpty(amount.ToString()))
        {
            Amount = Convert.ToDecimal(amount);
            TotalAmountAc += Convert.ToDecimal(amount);
        }
        return Amount.ToString("#,##0.00");
    }
    protected string GetTotalAmountAc()
    {
        return TotalAmountAc.ToString("#,##0.00");
    }
    protected string GetAmount2Ac(object amount)
    {
        decimal Amount = 0;
        if (!string.IsNullOrEmpty(amount.ToString()))
        {
            Amount = Convert.ToDecimal(amount);
            TotalAmount2Ac += Convert.ToDecimal(amount);
        }
        return Amount.ToString("#,##0.00");
    }
    protected string GetTotalAmount2Ac()
    {
        return TotalAmount2Ac.ToString("#,##0.00");
    }
    protected string GetAmount3Ac(object amount1, object amount2)
    {
        decimal Amount1 = 0;
        decimal Amount2 = 0;
        if ((!string.IsNullOrEmpty(amount1.ToString())) && (!string.IsNullOrEmpty(amount2.ToString())))
        {
            Amount1 = Convert.ToDecimal(amount1);
            Amount2 = Convert.ToDecimal(amount2);
            TotalAmount3Ac += (Convert.ToDecimal(Amount1) - Convert.ToDecimal(Amount2));
        }
        return (Convert.ToDecimal(Amount1) - Convert.ToDecimal(Amount2)).ToString("#,##0.00");
    }
    protected string GetTotalAmount3Ac()
    {
        return TotalAmount3Ac.ToString("#,##0.00");
    }
    protected void ddlSearchMainDept2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainDeptID", ddlSearchMainDept2.SelectedValue);
        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept2, ddlSearchMainDept2.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
        btc.getddlDepartment(0, ddlSearchDept2, ddlSearchMainSubDept2.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();       
    }
    protected void ddlSearchMainSubDept2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckMainSubDeptID", ddlSearchMainSubDept2.SelectedValue);
        btc.getddlDepartment(0, ddlSearchDept2, ddlSearchMainSubDept2.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
        DataBind();
    }
    protected void ddlSearchDept2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckDeptID", ddlSearchDept2.SelectedValue);
        DataBind();
    }
    protected string getdtWithDraw(int mode, object ItemID, object ttAmount2, object ttName, object ttBudgetTypeDetailID)
    { 
        string ImageName = "MoneyIcon2.png";
        if(!string.IsNullOrEmpty(ttAmount2.ToString()))
        {
            if(Convert.ToDecimal(ttAmount2) > 0)
            {
                ImageName = "MoneyIcon.png";
            }
        }
        string Link = "<a href=\"javascript:;\" onclick=\"Withdraw('" + ItemID.ToString() + "');\"><img style=\"border: 0; cursor: pointer;\" title=\"ใช้เงิน\" src=\"../Image/" + ImageName + "\" /></a>";
        if (mode == 0)
        {
            Link = "<a href=\"javascript:;\" onclick=\"Withdraw('" + ItemID.ToString() + "');\">" + ttName.ToString() + "</a>";
        }

        if (ttBudgetTypeDetailID.ToString() == "5")
        {
            if (mode == 0)
            {
                Link = ttName.ToString();
            }
            else
            {
                Link = "";
            }
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
        if (Request.QueryString["mode"] == "5")
        {
            rptAttach2.DataSource = dv;
            rptAttach2.DataBind();
        }
        else
        {
            if (Request.QueryString["mode"] == "7")
            {
                rptAttach.DataSource = dv;
                rptAttach.DataBind();
            }
        }
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
    protected void btnAttach2_Click(object sender, EventArgs e)
    {
        if (fpAttach2.HasFile)
        {
            if (btc.ckAttachFileGetExtensionError(fpAttach2))
            {
                string NewID = Guid.NewGuid().ToString();
                int rowsEffect = Conn.AddNew("Multimedia", "ItemID,TypeID,Title,FileUrl,FileSize,FileType,ReferID,MediaYear,CreateUser,CreateDate,UpdateUser,UpdateDate,Source,Shared,Enabled,Flag",
                    NewID, cbDuo.Checked, fpAttach2.FileName, "", fpAttach2.PostedFile.ContentLength, fpAttach2.PostedFile.ContentType, Request.QueryString["mid"], DateTime.Now.Year, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, 1, 0, 1, 0);
                btc.UploadFileAttach(fpAttach2, NewID, btc.getAttachType(fpAttach2.PostedFile.ContentType, Convert.ToInt32(cbDuo.Checked)));

                if (cbDuo.Checked && fpAttach2.FileName.ToString().Substring(fpAttach2.FileName.ToString().IndexOf('.')).Contains(".zip"))
                {
                    UnZipFiles(fpAttach2, NewID);
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "alert('ไม่รองรับไฟล์นี้');", true);
            }
            cbDuo2.Checked = false;
            GetDataAttach(Request.QueryString["mid"]);
        }
    }
}
