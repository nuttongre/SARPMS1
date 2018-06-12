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

public partial class Education21Side : System.Web.UI.Page
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

            getddlYear(0);
            getddlEvaluateType(0);
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
                        btc.GenSort(txtSort, "Education21Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' And EvaluateType = '" + ddlEvaluateType.SelectedValue + "'");
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
                }
            }
            else
            {
                DataBind();
            }
        }
        txtEducation21Side.Attributes.Add("onkeyup", "Cktxt(0);");
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
    public override void DataBind()
    {
        string StrSql = @" Select a.Education21SideID, a.Education21SideName, a.Sort, a.EvaluateType
                        From Education21Side a 
                        Where a.DelFlag = 0 And a.StudyYear = '" + ddlSearchYear.SelectedValue + "' And a.EvaluateType = '" + ddlSearchEvaluateType.SelectedValue + "' ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.Education21SideName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Sort "));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From Education21Side Where Education21SideID = '" + id + "'"));

        if (dv.Count != 0)
        {
            ddlYearB.SelectedValue = dv[0]["StudyYear"].ToString();
            ddlEvaluateType.SelectedValue = dv[0]["EvaluateType"].ToString();
            txtEducation21Side.Text = dv[0]["Education21SideName"].ToString();
            txtDetail.Text = dv[0]["Detail"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Education21Side", "Education21SideID", id);
        }
    }
    private void ClearAll()
    {
        txtEducation21Side.Text = "";
        txtSearch.Text = "";
        txtDetail.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("Education21Side", "Education21SideID, StudyYear, Education21SideName, Detail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, EvaluateType", 
                NewID, ddlYearB.SelectedValue, txtEducation21Side.Text, txtDetail.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, ddlEvaluateType.SelectedValue);           

            if (CkAgain == "N")
            {
                Response.Redirect("Education21Side.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "Education21Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' And EvaluateType = '" + ddlEvaluateType.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("Education21Side", "Where Education21SideID = '" + Request["id"] + "' ", "StudyYear, Education21SideName, Detail, Sort, UpdateUser, UpdateDate, EvaluateType", 
                ddlYearB.SelectedValue, txtEducation21Side.Text, txtDetail.Text, txtSort.Text, CurrentUser.ID, DateTime.Now, ddlEvaluateType.SelectedValue);
            Response.Redirect("Education21Side.aspx?ckmode=2&Cr=" + i);    
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
        if (btc.CkUseData(id, "Education21SideID", "Education21Standard", "And DelFlag = 0"))
        {
            Response.Redirect("Education21Side.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("Education21Side", "Where Education21SideID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("Education21Side.aspx?ckmode=3&Cr=" + i); 
        }
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearchEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("EvaluateType", ddlSearchEvaluateType.SelectedValue);
        DataBind();
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Education21Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' And EvaluateType = '" + ddlEvaluateType.SelectedValue + "'");
    }
    protected void ddlEvaluateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "Education21Side", " And StudyYear = '" + ddlYearB.SelectedValue + "' And EvaluateType = '" + ddlEvaluateType.SelectedValue + "'");
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


}
