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

public partial class StrategicPlan : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            if (!string.IsNullOrEmpty(Request["Cr"]))
            {
                btc.Msg_Head(Img1, MsgHead, true, Request["ckmode"], Convert.ToInt32(Request["Cr"]));
            }

            //àªç¤»Õ§º»ÃÐÁÒ³
            btc.ckBudgetYear(lblSearchYear, lblYear);

            string mode = Request.QueryString["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
                        btc.getddlDepartment(1, ddlDepartment, ddlMainSubDept.SelectedValue, null, null);
                        btc.GenSort(txtSort, "StrategicPlan", " And StudyYear = '" + ddlYearB.SelectedValue + "' And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request.QueryString["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request.QueryString["id"]);
                        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "StrategicPlan", ddlSearchYear.SelectedValue);
                        break;
                }
            }
            else
            {
                getddlYear(0);
                btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "StrategicPlan", ddlSearchYear.SelectedValue);
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtStrategicPlan.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlDepartment.Attributes.Add("onchange", "Cktxt(0);");
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
            btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        }

        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.StrategicPlanID, Cast(a.Sort As nVarChar) + '. ' + a.StrategicPlanName As StrategicPlanName, a.Sort, D.DeptName 
                        From StrategicPlan a Left Join Department D On a.DeptCode = D.DeptCode
                        Left Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                        Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                        Where a.DelFlag = 0 ";
        if (string.IsNullOrEmpty(Request.QueryString["mode"]))
        {
            StrSql += " And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' ";
            if (ddlSearchMainDept.SelectedIndex != 0)
            {
                StrSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
            }
            if (ddlSearchMainSubDept.SelectedIndex != 0)
            {
                StrSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
            }
            if (ddlSearchDept.SelectedIndex != 0)
            {
                StrSql += " And D.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
            }
            if (txtSearch.Text != "")
            {
                StrSql += " And (a.StrategicPlanName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
            }
        }
        else
        {
            StrSql += " And a.StudyYear = '" + ddlYearB.SelectedValue + "' ";
            if (ddlSearchMainDept.SelectedIndex != 0)
            {
                StrSql += " And MD.MainDeptCode = '" + ddlMainDept.SelectedValue + "' ";
            }
            if (ddlSearchMainSubDept.SelectedIndex != 0)
            {
                StrSql += " And MSD.MainSubDeptCode = '" + ddlMainSubDept.SelectedValue + "' ";
            }
            if (ddlSearchDept.SelectedIndex != 0)
            {
                StrSql += " And D.DeptCode = '" + ddlDepartment.SelectedValue + "' ";
            }
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By D.Sort, a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @" Select SP.*, MSD.MainSubDeptCode, MD.MainDeptCode From StrategicPlan SP Left Join Department D On SP.DeptCode = D.DeptCode
                        Left Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                        Left Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
                        Where SP.StrategicPlanID = '{0}' ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            btc.getddlMainDepartment(1, ddlMainDept, null);
            ddlMainDept.SelectedValue = dv[0]["MainDeptCode"].ToString();
            btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
            ddlMainSubDept.SelectedValue = dv[0]["MainSubDeptCode"].ToString();
            btc.getddlDepartment(1, ddlDepartment, ddlMainSubDept.SelectedValue, null, null);
            ddlDepartment.SelectedValue = dv[0]["DeptCode"].ToString();
            txtStrategicPlan.Text = dv[0]["StrategicPlanName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "StrategicPlan", "StrategicPlanID", id);
        }
    }
    private void ClearAll()
    {
        txtStrategicPlan.Text = "";
        txtSearch.Text = "";
        txtDetail.Text = "";
        //ddlMainDept.SelectedIndex = 0;
        //ddlMainSubDept.SelectedIndex = 0;
        //ddlDepartment.SelectedIndex = 0;
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("StrategicPlan", "StrategicPlanID, StudyYear, StrategicPlanName, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, DeptCode", 
                NewID, ddlYearB.SelectedValue, txtStrategicPlan.Text, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, ddlDepartment.SelectedValue);           

            if (CkAgain == "N")
            {
                Response.Redirect("StrategicPlan.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "StrategicPlan", " And StudyYear = '" + ddlYearB.SelectedValue + "' And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request.QueryString["mode"] == "2")
        {
            i = Conn.Update("StrategicPlan", "Where StrategicPlanID = '" + Request["id"] + "' ", "StudyYear, StrategicPlanName, Detail, Sort, UpdateUser, UpdateDate, DeptCode", 
                ddlYearB.SelectedValue, txtStrategicPlan.Text, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now, ddlDepartment.SelectedValue);
            Response.Redirect("StrategicPlan.aspx?ckmode=2&Cr=" + i);    
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
        if (String.IsNullOrEmpty(id)) return;
        if (btc.CkUseData(id, "StrategicPlanID", "Projects", ""))
        {
            Response.Redirect("StrategicPlan.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("StrategicPlan", "Where StrategicPlanID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("StrategicPlan.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.CopyEnable(lblCopy, ddlOldYear, btCopy, "StrategicPlan", ddlSearchYear.SelectedValue);
        btc.getdllStudyYearForCopy(ddlOldYear, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "StrategicPlan", " And StudyYear = '" + ddlYearB.SelectedValue + "' And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
    }
    protected void btCopy_Click(object sender, EventArgs e)
    {
        if (btc.CkDataDuplicate(ddlSearchYear.SelectedValue, "StrategicPlan"))
        {
            Response.Redirect("StrategicPlan.aspx?ckmode=7&Cr=0");
        }
        string strSql = " Select StrategicPlanID, StudyYear, StrategicPlanName, Detail, Sort, DeptCode From StrategicPlan Where DelFlag = 0 And StudyYear = '" + ddlOldYear.SelectedValue + "' Order By Sort ";
        DataView dvStrategicPlan = Conn.Select(strSql);
        Int32 x = 0;
        if (dvStrategicPlan.Count != 0)
        {
            for (int i = 0; i < dvStrategicPlan.Count; i++)
            {
                string NewID = Guid.NewGuid().ToString();
                x += Conn.AddNew("StrategicPlan", "StrategicPlanID, StudyYear, StrategicPlanName, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, DeptCode", 
                    NewID, ddlSearchYear.SelectedValue, dvStrategicPlan[i]["StrategicPlanName"].ToString(), dvStrategicPlan[i]["Detail"].ToString(), dvStrategicPlan[i]["Sort"].ToString(), 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, dvStrategicPlan[i]["DeptCode"].ToString());
            }
            Response.Redirect("StrategicPlan.aspx?ckmode=1&Cr=" + x);
        }
        else
        {
            Response.Redirect("StrategicPlan.aspx?ckmode=6&Cr=0");
        }
    }
    protected string checkedit(string id, string strName)
    {
        if (CurrentUser.RoleLevel >= 98)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
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
    protected void ddlMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
        btc.getddlDepartment(1, ddlDepartment, ddlMainSubDept.SelectedValue, null, null);
    }
    protected void ddlMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlDepartment(0, ddlDepartment, ddlMainSubDept.SelectedValue, null, null);
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "StrategicPlan", " And StudyYear = '" + ddlYearB.SelectedValue + "' And DeptCode = '" + ddlDepartment.SelectedValue + "' ");
    }
}
