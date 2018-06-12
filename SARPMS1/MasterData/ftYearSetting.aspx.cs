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

public partial class ftYearSetting : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();
    decimal TotalAmount = 0;

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
            
            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1, ddlYearS);
                        getddlTerm(1, ddlTerm);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1, ddlYearS);
                        getddlTerm(1, ddlTerm);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        break;
                    case "5":
                        MultiView1.ActiveViewIndex = 2;
                        btc.CkAdmission(GridView2, btAdd2, null);
                        getddlYear(0, ddlSearchStudyYear2);
                        getddlTerm(0, ddlSearchTerm);
                        getddlftYearClass(0, ddlSearchClass);
                        getddlftYearBudgetType(0, ddlSearchBudgetType);
                        btc.getddlMainDepartment(0, ddlSearchMainDept2, Cookie.GetValue2("ckMainDeptID"));
                        btc.getddlMainSubDepartment(0, ddlSearchMainSubDept2, ddlSearchMainDept2.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                        GetDataView(Request.QueryString["mid"]);
                        DataBind();
                        break;
                    case "6":
                        MultiView1.ActiveViewIndex = 3;
                        getddlftYearClass(1, ddlClass);
                        getddlftYearBudgetType(1, ddlftYearBudgetType);
                        getddlftYearBudgetTypeDetail();
                        GetDataView(Request.QueryString["mid"]);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt2(0);", true);
                        break;
                    case "7":
                        MultiView1.ActiveViewIndex = 3;
                        getddlftYearClass(1, ddlClass);
                        GetData2(Request.QueryString["id"]);
                        btc.btEnable(btSaveAgain, false);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt2(0);", true);
                        break;
                    case "8":
                        MultiView1.ActiveViewIndex = 2;
                        Delete2(Request.QueryString["id"]);
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
                btc.CkAdmission(GridView1, btAdd, null);
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
                string StrSql = @" Select M.MasterID, M.Term, M.StudyYear, MD.ItemID, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Price, 0 ) Price, 
                        IsNull(MD.Amount, 0) Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount, 
                        C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Inner Join ftYearClass C On MD.ClassID = C.ClassID
                        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
                        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
                        Inner Join Department D On M.DeptCode = D.DeptCode
                        Inner Join MainSubDepartment SD On D.MainSubDeptCode = SD.MainSubDeptCode
                        Inner Join MainDepartment MDt ON SD.MainDeptCode = MDt.MainDeptCode
                        Where M.DelFlag = 0 And M.StudyYear = '" + ddlSearchStudyYear2.SelectedValue + "' And M.Term = '" + ddlSearchTerm.SelectedValue + "' And M.MasterID = '" + Request.QueryString["mid"] + "' ";

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
                DataView dv = Conn.Select(string.Format(StrSql + " Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID"));

                GridView2.DataSource = dv;
                GridView2.DataBind();
                lblSearchTotal2.InnerText = dv.Count.ToString();

                StrSql = @" Select IsNull(Sum(IsNull(MD.Amount, 0)), 0) TotalStudent, IsNull(Sum(IsNull(MD.Price, 0)), 0) TotalPrice, 
                IsNull(Sum((IsNull(MD.Amount, 0) * IsNull(MD.Price, 0))), 0) SumTotal
		        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
		        Where M.DelFlag = 0 And M.MasterID = '{0}' And MD.BudgetDetailTypeID = 5 ";
                DataView dvMoneyActivity = Conn.Select(string.Format(StrSql, Request.QueryString["mid"]));
                if (dvMoneyActivity.Count > 0)
                {
                    lblTotalStudent.Text = Convert.ToInt32(dvMoneyActivity[0]["TotalStudent"]).ToString("#,##0");
                    lblTotalPrice.Text = Convert.ToInt32(dvMoneyActivity[0]["TotalPrice"]).ToString("#,##0.00");
                    lblSumTotal.Text = Convert.ToInt32(dvMoneyActivity[0]["SumTotal"]).ToString("#,##0.00");
                    decimal SumToal = 0;
                    decimal SetMoneyAcType = 0;
                    if ((!string.IsNullOrEmpty(lblSumTotal.Text)) && (!string.IsNullOrEmpty(txtSetMoneyAcType.Text)))
                    {
                        SumToal = Convert.ToDecimal(lblSumTotal.Text);
                        SetMoneyAcType = Convert.ToDecimal(txtSetMoneyAcType.Text);
                    }
                    lblSumTotalAll.Text = (SumToal + SetMoneyAcType).ToString("#,##0.00");
                }
            }
            else
            {
                if (Request.QueryString["mode"] == "6")
                {
                    string StrSql = @" Select M.MasterID, M.Term, M.StudyYear, MD.ItemID, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Price, 0 ) Price, 
                        IsNull(MD.Amount, 0) Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount, 
                        C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Inner Join ftYearClass C On MD.ClassID = C.ClassID
                        Inner Join ftYearBudgetTypeDetail BD On MD.BudgetDetailTypeID = BD.BudgetDetailTypeID   
                        Inner JOin ftYearBudgetType BT On BD.BudgetTypeID = BT.BudgetTypeID 
                        Where M.DelFlag = 0 And M.StudyYear = '" + lblStudyYear.Text + "' And M.Term = '" + lblTerm.Text + "' And M.MasterID = '" + Request.QueryString["mid"] + "' ";
                    DataView dv = Conn.Select(string.Format(StrSql + " Order By M.StudyYear Asc, M.Term, C.ClassID, BT.BudgetTypeID, BD.BudgetDetailTypeID"));

                    GridView4.DataSource = dv;
                    GridView4.DataBind();
                    GridView4.Visible = true;
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
            if (dv[0]["Term"].ToString() == "2")
            {
                divSetMoney.Visible = true;
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
                    txtSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    btSaveSetMoneyAcType.Visible = false;
                    txtSetMoneyAcType.Visible = false;
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    if ((CurrentUser.RoleLevel == 1) || (CurrentUser.RoleLevel >= 98))
                    {
                        lbtEditSetMoneyAcType.Visible = true;
                    }
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
                else
                {
                    string StrSql = @" Select MasterID From ftYearMaster
						Where StudyYear = '{0}' And Term = '1' And DelFlag = 0
						And DeptCode = '{1}' ";
                    DataView dvMid = Conn.Select(string.Format(StrSql, dv[0]["StudyYear"].ToString(), dv[0]["DeptCode"].ToString()));
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
                    DataView dvMoneyAcType = Conn.Select(string.Format(StrSql, lblStudyYear.Text, ddlSearchDept2.SelectedValue));
                    if (dvMoneyAcType.Count > 0)
                    {
                        MoneyAcType = Convert.ToDecimal(dvMoneyAcType[0]["MoneyAcType"]);
                    }

                    txtSetMoneyAcType.Text = ((SetBudgetAcType + SumTotal) - MoneyAcType).ToString("#,##0.00");
                }
            }
            else
            {
                lblNoteSetMoneyAcType.Text = "งบประมาณจากหมวดค่าหนังสือเรียนปีที่ผ่านมา";
                DataView dvSetBudgetAcType = null;
                strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    txtSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    btSaveSetMoneyAcType.Visible = false;
                    txtSetMoneyAcType.Visible = false;
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    if ((CurrentUser.RoleLevel == 1) || (CurrentUser.RoleLevel >= 98))
                    {
                        lbtEditSetMoneyAcType.Visible = true;
                    }
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
                else
                {
                    strSql = @" Select IsNull(IsNull((IsNull(Sum(MD.SetMoney), 0) + (IsNull(Sum(MD.Price), 0) * IsNull(Sum(MD.Amount), 0))), 0) - 
                        IsNull(IsNull(Sum(MD.Price2), 0) * IsNull(Sum(MD.Amount2), 0), 0), 0) As SetMoneyAcType 
                        From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
                        Where M.DelFlag = 0 And MD.BudgetDetailTypeID = '2'
						And M.MasterID = (Select MasterID From ftYearMaster
						Where StudyYear = '{0}' And Term = '{1}' And DelFlag = 0
						And DeptCode = '{2}') ";
                    dvSetBudgetAcType = Conn.Select(string.Format(strSql, Convert.ToInt32(dv[0]["StudyYear"]) - 1, "2", dv[0]["DeptCode"].ToString()));
                    if (dvSetBudgetAcType.Count > 0)
                    {
                        txtSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoneyAcType"]).ToString("#,##0.00");
                    }
                    else
                    {
                        txtSetMoneyAcType.Text = "0.00";
                    }
                }

                if (ddlftYearBudgetTypeDetail.SelectedValue == "5") //โหมดกิจกรรม
                {
                    divSetMoney.Visible = true;
                }
                else
                {
                    divSetMoney.Visible = false;
                }
                GridView2.Columns[GridView2.Columns.Count - 6].Visible = false;
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
        string strSql = @" Select M.MasterID, M.Term, M.StudyYear, C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName, BT.BudgetTypeID,
                        MD.ItemID, MD.MasterID, MD.ClassID, MD.BudgetDetailTypeID, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Price, 0 ) Price, 
                        IsNull(MD.Amount, 0) Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount 
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
            lblTotalAmount.Text = (Convert.ToDecimal(dv[0]["SetMoney"]) + (Convert.ToInt32(dv[0]["Amount"]) * Convert.ToDecimal(dv[0]["Price"]))).ToString("#,##0.00");

            if (dv[0]["Term"].ToString() == "2")
            {
                divSetMoney.Visible = true;
                txtSetMoney.Text = Convert.ToDecimal(dv[0]["SetMoney"]).ToString("#,##0.00");
            }
            else
            {
                //if (ddlftYearBudgetTypeDetail.SelectedValue == "5") //โหมดกิจกรรม
                //{
                //    divSetMoney.Visible = true;
                //}
                //else
                //{
                //    divSetMoney.Visible = false;
                //}
            }
        }
        btc.getCreateUpdateUser(lblCreate2, lblUpdate2, "ftYearMasterDetail", "ItemID", id);
    }
    private void GetData3(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select M.MasterID, M.Term, M.StudyYear, C.ClassName, BD.BudgetDetailTypeName, BT.BudgetTypeName, BT.BudgetTypeID,
                        MD.ItemID, MD.MasterID, MD.ClassID, MD.BudgetDetailTypeID, IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Price, 0 ) Price, 
                        IsNull(MD.Amount, 0) Amount, IsNull(MD.SetMoney, 0) + (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) As TotalAmount 
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
        txtSetMoney.Text = "0.00";
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
                    Response.Redirect("ftYearSetting.aspx?ckmode=1&Cr=" + i);
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
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        //if (btc.CkUseData(id, "IdentityNameCode", "dtIdentityName", ""))
        //{
        //    Response.Redirect("ftYearSetting.aspx?ckmode=3&Cr=0"); 
        //}
        //else
        //{
            Int32 i = Conn.Update("ftYearMaster", "Where MasterID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Conn.Delete("ftYearMasterDetail", "Where MasterID = '" + id + "' ");
            Conn.Delete("ftYearWithdrawActivityType", "Where MasterID = '" + id + "' ");
            Response.Redirect("ftYearSetting.aspx?ckmode=3&Cr=" + i); 
        //}
    }
    private void Delete2(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        //if (btc.CkUseData(id, "IdentityNameCode", "dtIdentityName", ""))
        //{
        //    Response.Redirect("ftYearSetting.aspx?ckmode=3&Cr=0"); 
        //}
        //else
        //{
        Int32 i = Conn.Delete("ftYearMasterDetail", "Where ItemID = '" + id + "' ");
        Response.Redirect("ftYearSetting.aspx?mode=5&&mid=" + Request.QueryString["mid"] + "&ckmode=3&Cr=" + i);
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
    protected string checkedit2(string id, string strName)
    {
        //if (CurrentUser.RoleLevel >= 98)
        //{
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        //}
        //else
        //{
        //    return strName;
        //}
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
        if (Request.QueryString["mode"] == "6")
        {
            if (!ckDataDupicate2())
            {
                string NewID = Guid.NewGuid().ToString();
                i = Conn.AddNew("ftYearMasterDetail", "ItemID, MasterID, ClassID, BudgetDetailTypeID, SetMoney, Amount, Price, CreateUser, CreateDate, UpdateUser, UpdateDate",
                    NewID, Request.QueryString["mid"], ddlClass.SelectedValue, ddlftYearBudgetTypeDetail.SelectedValue, Convert.ToDecimal(txtSetMoney.Text.Replace(",", "")), Convert.ToInt32(txtAmount.Text.Replace(",", "")), Convert.ToDecimal(txtPrice.Text.Replace(",", "")), CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
                lblDupicate2.Visible = false;

                if (CkAgain == "N")
                {
                    Response.Redirect("ftYearSetting.aspx?mode=5&ckmode=1&mid=" + Request.QueryString["mid"] + "&Cr=" + i);
                }
                if (CkAgain == "Y")
                {
                    MultiView1.ActiveViewIndex = 3;
                    btc.Msg_Head(Img1, MsgHead, true, "1", i);
                    //getddlftYearClass();
                    //getddlftYearBudgetType();
                    getddlftYearBudgetTypeDetail();
                    ClearAll();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt2(0);", true);
                    GridView4.Visible = true;
                    DataBind();
                }
            }
            else
            {
                lblDupicate2.Visible = true;
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), Guid.NewGuid().ToString(), "SumTotal();", true);
            }
        }
        if (Request.QueryString["mode"] == "7")
        {
            i = Conn.Update("ftYearMasterDetail", "Where ItemID = '" + Request.QueryString["id"] + "'", "SetMoney, Amount, Price, UpdateUser, UpdateDate",
                Convert.ToDecimal(txtSetMoney.Text.Replace(",", "")), Convert.ToInt32(txtAmount.Text.Replace(",", "")), Convert.ToDecimal(txtPrice.Text.Replace(",", "")), CurrentUser.ID, DateTime.Now);
            Response.Redirect("ftYearSetting.aspx?mode=5&ckmode=2&mid=" + Request.QueryString["mid"] + "&Cr=" + i);
        }
    }

    protected void ddlftYearBudgetType_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlftYearBudgetTypeDetail();
        txtSetMoney.Text = getSetMoney();
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
    protected void ddlftYearBudgetTypeDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (lblTerm.Text == "2")
        {
            divSetMoney.Visible = true;
            txtSetMoney.Text = getSetMoney();
        }
        else
        {
            //if (ddlftYearBudgetTypeDetail.SelectedValue == "5") //โหมดกิจกรรม
            //{
            //    divSetMoney.Visible = true;
            //}
            //else
            //{
            //    divSetMoney.Visible = false;
            //}
        }
    }
    private string getSetMoney()
    {
        string SetMoney = "0.00";
        string strSql = @" Select M.MasterID, M.Term, M.StudyYear,
            MD.ClassID, MD.BudgetDetailTypeID, IsNull(MD.Price, 0) Price, IsNull(MD.Amount, 0) Amount, 
            IsNull(MD.SetMoney, 0) SetMoney, IsNull(MD.Price2, 0) Price2, IsNull(MD.Amount2, 0) Amount2,
            (IsNull(MD.Price, 0) * IsNull(MD.Amount, 0)) - (IsNull(MD.Price2, 0) * IsNull(MD.Amount2, 0)) SetMoneyBalance
            From ftYearMaster M Inner Join ftYearMasterDetail MD On M.MasterID = MD.MasterID
            Where M.Term = '{0}' And M.StudyYear = '{1}' And ClassID = '{2}' And BudgetDetailTypeID = '{3}' 
            And M.DeptCode = (Select DeptCode From ftYearMaster Where MasterID = '{4}') ";
        DataView dv = null;
        if (lblTerm.Text == "1")
        {
            
        }
        else
        {
            if (ddlftYearBudgetTypeDetail.SelectedValue != "5")
            {
                dv = Conn.Select(string.Format(strSql, 1, lblStudyYear.Text, ddlClass.SelectedValue, ddlftYearBudgetTypeDetail.SelectedValue, Request.QueryString["mid"]));
                if (dv.Count > 0)
                {
                    SetMoney = Convert.ToDecimal(dv[0]["SetMoneyBalance"]).ToString("#,##0.00");
                }
                txtSetMoney.Enabled = true;
            }
            else
            {
                txtSetMoney.Enabled = false;
            }
        }
        return SetMoney;
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSetMoney.Text = getSetMoney();
    }
    protected void txtSetMoneyAcType_TextChanged(object sender, EventArgs e)
    {
        decimal SumToal = 0;
        decimal SetMoneyAcType = 0;
        if((!string.IsNullOrEmpty(lblSumTotal.Text)) && (!string.IsNullOrEmpty(txtSetMoneyAcType.Text)))
        {
            SumToal = Convert.ToDecimal(lblSumTotal.Text);
            SetMoneyAcType = Convert.ToDecimal(txtSetMoneyAcType.Text);
            txtSetMoneyAcType.Text = Convert.ToDecimal(txtSetMoneyAcType.Text).ToString("#,##0.00");
        }
        lblSumTotalAll.Text = (SumToal + SetMoneyAcType).ToString("#,##0.00");
    }
    protected void btSaveSetMoneyAcType_Click(object sender, EventArgs e)
    {
        DataView dvSetBudgetAcType = null;
        string strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
        dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
        if (dvSetBudgetAcType.Count > 0)
        {
            Int32 i = Conn.Update("ftYearWithdrawActivityType", "Where MasterID = '" + Request.QueryString["mid"] + "'", "WithdrawUser, WithdrawDate, SetMoney",
                 CurrentUser.ID, DateTime.Now, Convert.ToDecimal(txtSetMoneyAcType.Text.Replace(",", "")));
            if (i > 0)
            {
                dvSetBudgetAcType = null;
                strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    txtSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    btSaveSetMoneyAcType.Visible = false;
                    txtSetMoneyAcType.Visible = false;
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    if ((CurrentUser.RoleLevel == 1) || (CurrentUser.RoleLevel >= 98))
                    {
                        lbtEditSetMoneyAcType.Visible = true;
                    }
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
            }
        }
        else
        {
            Int32 i = Conn.AddNew("ftYearWithdrawActivityType", "MasterID, BudgetDetailTypeID, TotalAmount2, WithdrawUser, WithdrawDate, SetMoney",
                 Request.QueryString["mid"], "5", 0, CurrentUser.ID, DateTime.Now, Convert.ToDecimal(txtSetMoneyAcType.Text.Replace(",", "")));
            if (i > 0)
            {
                dvSetBudgetAcType = null;
                strSql = @" Select AT.MasterID, AT.BudgetDetailTypeID, IsNull(AT.TotalAmount2, 0) TotalAmount2,
						AT.WithdrawUser, AT.WithdrawDate, IsNull(AT.SetMoney, 0) SetMoney, E.EmpName
						From ftYearWithdrawActivityType AT Inner Join Employee E On AT.WithdrawUser = E.EmpID 
						Where AT.MasterID = '{0}' ";
                dvSetBudgetAcType = Conn.Select(string.Format(strSql, Request.QueryString["mid"]));
                if (dvSetBudgetAcType.Count > 0)
                {
                    txtSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    btSaveSetMoneyAcType.Visible = false;
                    txtSetMoneyAcType.Visible = false;
                    lblSetMoneyAcType.Text = Convert.ToDecimal(dvSetBudgetAcType[0]["SetMoney"]).ToString("#,##0.00");
                    if ((CurrentUser.RoleLevel == 1) || (CurrentUser.RoleLevel >= 98))
                    {
                        lbtEditSetMoneyAcType.Visible = true;
                    }
                    lblWithDrawUser.Text = "ผู้โอนเงิน : " + dvSetBudgetAcType[0]["EmpName"].ToString() + " วันที่โอน : " + Convert.ToDateTime(dvSetBudgetAcType[0]["WithdrawDate"]).ToString("dd/MM/yyyy");
                }
            }
        }
    }
    protected void lbtEditSetMoneyAcType_Click(object sender, EventArgs e)
    {
        txtSetMoneyAcType.Visible = true;
        btSaveSetMoneyAcType.Visible = true;
        lblSetMoneyAcType.Text = "";
        lbtEditSetMoneyAcType.Visible = false;
    }
}
