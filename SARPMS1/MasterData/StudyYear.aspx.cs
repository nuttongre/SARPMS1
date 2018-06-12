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

public partial class StudyYear : System.Web.UI.Page
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

            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        txtStudyYear.Text = (DateTime.Now.Year + 543).ToString();
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                    case "7":
                        MultiView1.ActiveViewIndex = 0;
                        IsFinality(Request["sYear"], Convert.ToBoolean(Convert.ToInt32(Request["sts"])));
                        DataBind();
                        break;
                }
            }
            else
            {
                btc.CkAdmissionForAdmin(GridView1, btAdd, null);
                DataBind();
            }
        }
        txtStudyYear.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    public override void DataBind()
    {
        string StrSql = " Select * From StudyYear Where DelFlag = 0 ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And StudyYear Like '%" + txtSearch.Text + "%' ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By StudyYear "));
        GridView1.DataSource = dv;
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView1.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From StudyYear Where StudyYear = '" + id + "'"));
        if (dv.Count != 0)
        {
            txtStudyYear.Text = dv[0]["StudyYear"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "StudyYear", "StudyYear", id);
        }
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 i = 0;
        DataView dv = Conn.Select(string.Format("Select StudyYear From StudyYear Where StudyYear = '" + txtStudyYear.Text + "' And DelFlag = 0 "));
        if (dv.Count > 0)
        {
            btc.Msg_Head(Img1, MsgHead, true, "7", 0);
        }
        else
        {
            if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
            {
                btc.UpdateDefault("StudyYear");
                i = Conn.AddNew("StudyYear", "StudyYear, Df, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", txtStudyYear.Text, 1, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
                Response.Redirect("StudyYear.aspx?ckmode=1&Cr=" + i); 
            }
            if (Request["mode"] == "2")
            {
                i = Conn.Update("StudyYear", "Where StudyYear = '" + Request["id"] + "' ", "StudyYear, UpdateUser, UpdateDate", txtStudyYear.Text, CurrentUser.ID, DateTime.Now);
                Response.Redirect("StudyYear.aspx?ckmode=2&Cr=" + i); 
            }
        }
    }
    private void Delete(string id)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(id)) return;
        if (btc.CkUseData(id, "StudyYear", "Strategies", "And DelFlag = 0"))
        {
            Response.Redirect("StudyYear.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            i = Conn.Delete("StudyYear", "Where StudyYear = '" + id + "'");
            Response.Redirect("StudyYear.aspx?ckmode=3&Cr=" + i); 
        }
    }
    private void IsFinality(string id, bool status)
    {
        Conn.Update("StudyYear", "Where Df = 1", "Df", 0);
        Conn.Update("StudyYear", "Where StudyYear = '" + id + "'", "Df", !status);
        Response.Redirect("StudyYear.aspx");
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
}
