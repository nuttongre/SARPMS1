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

public partial class ScoreGroup : System.Web.UI.Page
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
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        btc.GenSort(txtSort, "ScoreGroup", " ");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
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
        txtScoreGroup.Attributes.Add("onkeyup", "Cktxt(0);");
        txtWeightScore.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    public override void DataBind()
    {
        string StrSql = " Select ScoreGroupID, ScoreGroupName, WeightScore, Sort, CreateUser "
                    + " From ScoreGroup "
                    + " Where DelFlag = 0 ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And ScoreGroupName Like '%" + txtSearch.Text + "%' Or WeightScore Like '%" + txtSearch.Text + "%'  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By WeightScore Asc "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From ScoreGroup Where ScoreGroupID = '" + id + "'"));

        if (dv.Count != 0)
        {
            txtScoreGroup.Text = dv[0]["ScoreGroupName"].ToString();
            txtWeightScore.Text = dv[0]["WeightScore"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "ScoreGroup", "ScoreGroupID", id);
    }
    private void ClearAll()
    {
        txtScoreGroup.Text = "";
        txtWeightScore.Text = "0";
        txtSearch.Text = "";
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
            i = Conn.AddNew("ScoreGroup", "ScoreGroupID, WeightScore, ScoreGroupName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate", NewID, txtWeightScore.Text, txtScoreGroup.Text, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);           

            if (CkAgain == "N")
            {
                Response.Redirect("ScoreGroup.aspx?ckmode=1&Cr=" + i); 
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "ScoreGroup", " ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("ScoreGroup", "Where ScoreGroupID = '" + Request["id"] + "' ", "WeightScore, ScoreGroupName, Sort, UpdateUser, UpdateDate", txtWeightScore.Text, txtScoreGroup.Text, txtSort.Text, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ScoreGroup.aspx?ckmode=2&Cr=" + i); 
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
        if (btc.CkUseData(id, "ScoreGroupID", "Indicators", "") || btc.CkUseData(id, "ScoreGroupID", "Standard", "") || btc.CkUseData(id, "ScoreGroupID", "Side", ""))
        {
            Response.Redirect("ScoreGroup.aspx?ckmode=3&Cr=0"); 
        }
        else
        {
            Int32 i = Conn.Update("ScoreGroup", "Where ScoreGroupID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ScoreGroup.aspx?ckmode=3&Cr=" + i); 
        }
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
    protected string checkdel(string createuser, string id)
    {
        if (createuser != "9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A")
        {
            return "<a href=\"javascript:deleteItem('" + id + "');\">"
                   + "<img style=\"border: 0; cursor: pointer;\" title=\"ź\" src=\"../Image/delete.gif\" /></a>";
        }
        else
        {
            return "";
        }
    }
}
