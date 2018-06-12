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

public partial class Education21Standard : System.Web.UI.Page
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

            //เช็คปีงบประมาณ
            btc.ckBudgetYear(lblSearchYear, lblYear);

            //btc.LinkReport(linkReport);

            getddlYear(0);
            getddlEvaluateType(0);
            getddlEducation21Side(0, ddlSearchYear.SelectedValue);
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlEvaluateType(1);
                        getddlEducation21Side(1, ddlYearB.SelectedValue);
                        btc.GenSort(txtSort, "Education21Standard", " And Education21SideID = '" + ddlEducation21Side.SelectedValue + "' ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlYear(1);
                        getddlEvaluateType(1);
                        btc.btEnable(btSaveAgain, false);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                    case "7":
                        MultiView1.ActiveViewIndex = 0;
                        IsEvaluate(Request["id"], Convert.ToBoolean(Convert.ToInt32(Request["sts"])));
                        break;
                }
            }
            else
            {
                DataBind();
            }
        }
        txtEducation21Standard.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlEducation21Side.Attributes.Add("onchange", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getddlYear(int mode)
    {
        if (mode == 0)
        {
            btc.getdllStudyYear(ddlSearchYear);
            btc.getDefault(ddlSearchYear, "StudyYear", "StudyYear");
        }
        if (mode == 1)
        {
            btc.getdllStudyYear(ddlYearB);
            btc.getDefault(ddlYearB, "StudyYear", "StudyYear");
        }
    }
    private void getddlEvaluateType(int mode)
    {
        if (mode == 0)
        {
            ddlSearchEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
            ddlSearchEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
            ddlSearchEvaluateType.DataBind();
            //ddlSearchEvaluateType.SelectedIndex = 0;

            if (Cookie.GetValue2("EvaluateType") == null)
            {
                ddlSearchEvaluateType.SelectedIndex = 0;
            }
            else
            {
                try
                {
                    ddlSearchEvaluateType.SelectedValue = Cookie.GetValue2("EvaluateType").ToString();
                }
                catch (Exception ex)
                {
                    ddlSearchEvaluateType.SelectedIndex = 0;
                }
            }
        }

        if (mode == 1)
        {
            ddlEvaluateType.Items.Insert(0, new ListItem("ประเมินวิธีการ", "0"));
            ddlEvaluateType.Items.Insert(1, new ListItem("ประเมินผลงาน", "1"));
            ddlEvaluateType.DataBind();
            ddlEvaluateType.SelectedIndex = 0;
        }
    }
    private void getddlEducation21Side(int mode, string StudyYear)
    {
        string strSql = @"Select Education21SideID, Cast(Sort as nvarchar) + ' - ' + Education21SideName FullName, Sort 
            From Education21Side Where DelFlag = 0 And StudyYear = '{0}' And EvaluateType = '{1}' Order By Sort";

        if (mode == 0)
        {
            DataView dv = Conn.Select(string.Format(strSql, StudyYear, ddlSearchEvaluateType.SelectedValue));
            if (dv.Count != 0)
            {
                ddlSearch.DataSource = dv;
                ddlSearch.DataTextField = "FullName";
                ddlSearch.DataValueField = "Education21SideID";
                ddlSearch.DataBind();
                ddlSearch.Enabled = true;
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearch.SelectedIndex = 0;
            }
            else
            {
                ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
                ddlSearch.SelectedIndex = 0;
                ddlSearch.Enabled = false;
            }
        }

        if (mode == 1)
        {
            DataView dv = Conn.Select(string.Format(strSql, StudyYear, ddlEvaluateType.SelectedValue));
            if (dv.Count != 0)
            {
                ddlEducation21Side.DataSource = dv;
                ddlEducation21Side.DataTextField = "FullName";
                ddlEducation21Side.DataValueField = "Education21SideID";
                ddlEducation21Side.DataBind();
                ddlEducation21Side.Enabled = true;
                ddlEducation21Side.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Side.SelectedIndex = 0;
            }
            else
            {
                ddlEducation21Side.Items.Insert(0, new ListItem("-เลือก-", ""));
                ddlEducation21Side.SelectedIndex = 0;
                ddlEducation21Side.Enabled = false;
            }
        }
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.Education21StandardID, a.Education21StandardName, Cast(b.Sort As nVarChar(3)) + '.' + Cast(a.Sort As nVarChar(3)) As Sort1, a.ckEvaluate
                        From Education21Standard a Inner Join Education21Side b On a.Education21SideID = b.Education21SideID
                        Where a.DelFlag = 0 And b.StudyYear = '" + ddlSearchYear.SelectedValue + "' And b.EvaluateType = '" + ddlSearchEvaluateType.SelectedValue + "' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.Education21SideID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.Education21StandardName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort"));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        string strSql = @"Select SD.*, S.StudyYear, S.EvaluateType From Education21Side S, Education21Standard SD 
                Where SD.Education21StandardID = '{0}' And S.Education21SideID = SD.Education21SideID ";
        DataView dv = Conn.Select(string.Format(strSql, id));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlEvaluateType.SelectedValue = dv[0]["EvaluateType"].ToString();
            getddlEducation21Side(1, ddlYearB.SelectedValue);          
            ddlEducation21Side.SelectedValue = dv[0]["Education21SideID"].ToString();
            txtEducation21Standard.Text = dv[0]["Education21StandardName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            cbCkEvaluate.Checked = Convert.ToBoolean(dv[0]["ckEvaluate"]);
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "Education21Standard", "Education21StandardID", id);
    }
    private void ClearAll()
    {
        txtEducation21Standard.Text = "";
        ddlEducation21Side.SelectedIndex = 0;
        txtDetail.Text = "";
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Education21Standard", "Education21StandardID, Education21StandardName, Education21SideID, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ckEvaluate", 
                NewID, txtEducation21Standard.Text, ddlEducation21Side.SelectedValue, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, cbCkEvaluate.Checked);           

            if (CkAgain == "N")
            {
                Response.Redirect("Education21Standard.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Education21Standard", " And Education21SideID = '" + ddlEducation21Side.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Education21Standard", "Where Education21StandardID = '" + Request["id"] + "' ", "Education21StandardName, Education21SideID, Detail, Sort, UpdateUser, UpdateDate, ckEvaluate", 
                txtEducation21Standard.Text, ddlEducation21Side.SelectedValue, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now, cbCkEvaluate.Checked);
            Response.Redirect("Education21Standard.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "Education21StandardID", "Education21Indicator", "And DelFlag = 0"))
        {
            Response.Redirect("Education21Standard.aspx?ckmode=3&Cr=0");    
        }
        else
        {
            Int32 i = Conn.Update("Education21Standard", "Where Education21StandardID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Education21Standard.aspx?ckmode=3&Cr=" + i);    
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlSearchEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("EvaluateType", ddlSearchEvaluateType.SelectedValue);
        getddlEducation21Side(0, ddlSearchYear.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       getddlEducation21Side(1, ddlYearB.SelectedValue);
       btc.GenSort(txtSort, "Education21Standard", " And Education21SideID = '" + ddlEducation21Side.SelectedValue + "'");
    }
    protected void ddlEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Education21Standard", " And Education21SideID = '" + ddlEducation21Side.SelectedValue + "'");
    }
    protected string checkedit(string id, string strName)
    {
        if (btc.ckGetAdmission(CurrentUser.UserRoleID) == 1)
        {
            return String.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
        else
        {
            return strName;
        }
    }
    protected void ddlEducation21Side_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Education21Standard", " And Education21SideID = '" + ddlEducation21Side.SelectedValue + "'");
    }
    private void IsEvaluate(string id, bool status)
    {
        Conn.Update("Education21Standard", "Where Education21StandardID = '" + id + "'", "ckEvaluate", !status);
        Response.Redirect("Education21Standard.aspx");
    }
}
