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

public partial class LogSchoolSar : System.Web.UI.Page
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
            getddlProvince();
            getddlVersion();
            getddlServer();
            getddlStatus();
            getcblStatus();
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        getrbtlRenew();
                        btc.getddlDay(ddlSDay);
                        btc.getddlMonth2(ddlSMonth);
                        btc.getddlYear(ddlSYear, 5);
                        btc.getddlDay(ddlEDay);
                        btc.getddlMonth2(ddlEMonth);
                        btc.getddlYear(ddlEYear, 5);
                        txtSDay.Text = DateTime.Now.ToShortDateString();
                        txtEDay.Text = DateTime.Now.ToShortDateString();
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getrbtlRenew();
                        btc.getddlDay(ddlSDay);
                        btc.getddlMonth2(ddlSMonth);
                        btc.getddlYear(ddlSYear, 5);
                        btc.getddlDay(ddlEDay);
                        btc.getddlMonth2(ddlEMonth);
                        btc.getddlYear(ddlEYear, 5);
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                    case "9":
                        MultiView1.ActiveViewIndex = 0;
                        UpdateBackUp(Request["id"]);
                        Response.Redirect("LogSchoolSar.aspx");
                        break;
                }
            }
            else
            {
                DataBind();
            }
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "javascript", "function loadPageBackUp(){" + Page.ClientScript.GetPostBackEventReference(btLoadPage, null, false) + ";}", true);
        }
        txtVersion.Attributes.Add("onkeyup", "Cktxt(0);");
        txtVirtualName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtSchoolName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtIPaddress.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlSDay.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSMonth.Attributes.Add("onchange", "ckddlDate(1);");
        ddlSYear.Attributes.Add("onchange", "ckddlDate(1);");
        ddlEDay.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEMonth.Attributes.Add("onchange", "ckddlDate(2);");
        ddlEYear.Attributes.Add("onchange", "ckddlDate(2);");
    }
    private void getrbtlRenew()
    {
        rbtlRenew.Items.Insert(0, new ListItem(" <img src=\"../Image/onR.png\" /> ปิด", "0"));
        rbtlRenew.Items.Insert(1, new ListItem(" <img src=\"../Image/onB.png\" /> เปิด", "1"));
    }
    private void getddlProvince()
    {
        DataView dv = btc.getddlProvince();
        ddlSearch.DataSource = dv;
        ddlSearch.DataTextField = "ProvinceName";
        ddlSearch.DataValueField = "ProvinceID";
        ddlSearch.DataBind();
        ddlSearch.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));

        if (Cookie.GetValue2("Province") == null)
        {
            ddlSearch.SelectedIndex = 0;
        }
        else
        {
            try
            {
                ddlSearch.SelectedValue = Cookie.GetValue2("Province").ToString();
            }
            catch (Exception ex)
            {
                ddlSearch.SelectedIndex = 0;
            }
        }

        ddlProvince.DataSource = dv;
        ddlProvince.DataTextField = "ProvinceName";
        ddlProvince.DataValueField = "ProvinceID";
        ddlProvince.DataBind();
        ddlProvince.Items.Insert(0, new ListItem("-เลือก-", ""));
        ddlProvince.SelectedIndex = 0;
    }
    private void getddlVersion()
    {
        string strSql = "Select Distinct(Version) Version From LogSchoolSar Order By Version Desc ";
        DataView dv = Conn.Select(strSql);

        ddlSearch2.DataSource = dv;
        ddlSearch2.DataTextField = "Version";
        ddlSearch2.DataValueField = "Version";
        ddlSearch2.DataBind();
        ddlSearch2.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));

        if (Cookie.GetValue2("Version") == null)
        {
            ddlSearch2.SelectedIndex = 0;
        }
        else
        {
            try
            {
                ddlSearch2.SelectedValue = Cookie.GetValue2("Version").ToString();
            }
            catch (Exception ex)
            {
                ddlSearch2.SelectedIndex = 0;
            }
        }
    }
    private void getddlServer()
    {
        ddlSearch3.Items.Insert(0, new ListItem("-ทั้งหมด-", "0"));
        ddlSearch3.Items.Insert(1, new ListItem("Server บริษัท", "1"));
        ddlSearch3.Items.Insert(2, new ListItem("Server อื่น ๆ", "2"));

        if (Cookie.GetValue2("Server") == null)
        {
            ddlSearch3.SelectedIndex = 0;
        }
        else
        {
            try
            {
                ddlSearch3.SelectedValue = Cookie.GetValue2("Server").ToString();
            }
            catch (Exception ex)
            {
                ddlSearch3.SelectedIndex = 0;
            }
        }
    }
    private void getddlStatus()
    {
        ddlSearchStatus.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlSearchStatus.Items.Insert(1, new ListItem("เช่าใช้", "0"));
        ddlSearchStatus.Items.Insert(2, new ListItem("ซื้อขาด", "1"));
        ddlSearchStatus.Items.Insert(3, new ListItem("ทดลองใช้", "2"));

        if (Cookie.GetValue2("Status") == null)
        {
            ddlSearchStatus.SelectedIndex = 0;
        }
        else
        {
            try
            {
                ddlSearchStatus.SelectedValue = Cookie.GetValue2("Status").ToString();
            }
            catch (Exception ex)
            {
                ddlSearchStatus.SelectedIndex = 0;
            }
        }
    }
    private void getcblStatus()
    {
        rdoStatus.Items.Insert(0, new ListItem(" เช่าใช้", "0"));
        rdoStatus.Items.Insert(1, new ListItem(" ซื้อขาด", "1"));
        rdoStatus.Items.Insert(2, new ListItem(" ทดลองใช้", "2"));
        rdoStatus.DataBind();
    }
    public override void DataBind()
    {
        string StrSql = " Select a.*, b.ProvinceName "
                    + " From LogSchoolSar a Left Join Province b On a.ProvinceID = b.ProvinceID "
                    + " Where LogID Is Not NULL ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ProvinceID = '" + ddlSearch.SelectedValue + "'";
        }

        if (ddlSearch2.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.Version = '" + ddlSearch2.SelectedValue + "'";
        }

        if (cbRent.Checked)
        {
            StrSql += " And a.LogStatus = 0 And getDate() > a.eDate ";
        }

        if (ddlSearch3.SelectedIndex != 0)
        {
            if (ddlSearch3.SelectedIndex == 1)
            {
                StrSql = StrSql + " And a.IPaddress = '61.19.252.56'";
            }
            else
            {
                StrSql = StrSql + " And a.IPaddress <> '61.19.252.56'";
            }
        }

        if (ddlSearchStatus.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.LogStatus = '" + ddlSearchStatus.SelectedValue + "'";
        }

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (a.VirtualName Like '%" + txtSearch.Text + "%' Or a.SchoolName Like '%" + txtSearch.Text + "%'  Or a.ConnectName Like '%" + txtSearch.Text + "%' )";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By a.Version Desc, a.UpdateDate Desc, a.SchoolName "));

        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From LogSchoolSar Where LogID = '" + id + "'"));

        if (dv.Count != 0)
        {
            txtVersion.Text = dv[0]["Version"].ToString();
            txtVirtualName.Text = dv[0]["VirtualName"].ToString();
            txtSchoolName.Text = dv[0]["SchoolName"].ToString();
            ddlProvince.SelectedValue = dv[0]["ProvinceID"].ToString();
            txtIPaddress.Text = dv[0]["IPaddress"].ToString();
            txtConnectName.Text = dv[0]["ConnectName"].ToString();
            txtTel.Text = dv[0]["Tel"].ToString();
            txtSaleName.Text = dv[0]["SaleName"].ToString();
            rdoStatus.SelectedValue = dv[0]["LogStatus"].ToString();
            txtRent.Text = dv[0]["rent"].ToString();

            txtSDay.Text = (string.IsNullOrEmpty(dv[0]["SDate"].ToString()) ? DateTime.Now.ToShortDateString() : Convert.ToDateTime(dv[0]["SDate"]).ToShortDateString());
            ddlSDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate"].ToString()) ? DateTime.Now.Day.ToString("00") : Convert.ToDateTime(dv[0]["SDate"]).Day.ToString("00"));
            ddlSMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate"].ToString()) ? DateTime.Now.Month.ToString("00") : Convert.ToDateTime(dv[0]["SDate"]).Month.ToString("00"));
            ddlSYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["SDate"].ToString()) ? (DateTime.Now.Year + 543).ToString() : (Convert.ToDateTime(dv[0]["SDate"]).Year + 543).ToString());

            txtEDay.Text = (string.IsNullOrEmpty(dv[0]["EDate"].ToString()) ? DateTime.Now.ToShortDateString() : Convert.ToDateTime(dv[0]["EDate"]).ToShortDateString());
            ddlEDay.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate"].ToString()) ? DateTime.Now.Day.ToString("00") : Convert.ToDateTime(dv[0]["EDate"]).Day.ToString("00"));
            ddlEMonth.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate"].ToString()) ? DateTime.Now.Month.ToString("00") : Convert.ToDateTime(dv[0]["EDate"]).Month.ToString("00"));
            ddlEYear.SelectedValue = (string.IsNullOrEmpty(dv[0]["EDate"].ToString()) ? (DateTime.Now.Year + 543).ToString() : (Convert.ToDateTime(dv[0]["EDate"]).Year + 543).ToString());

            rbtlRenew.SelectedValue = Convert.ToInt32(dv[0]["ckExpDate"]).ToString();

            btc.getCreateUpdateUser(lblCreate, lblUpdate, "LogSchoolSar", "LogID", id);
        }
    }
    private void ClearAll()
    {
        txtVersion.Text = "";
        txtVirtualName.Text = "";
        txtSchoolName.Text = "";
        txtConnectName.Text = "";
        txtTel.Text = "";
        txtSaleName.Text = "";
        ddlProvince.SelectedIndex = 0;
        ddlSearch.SelectedIndex = 0;
        ddlSearch2.SelectedIndex = 0;
        txtSDay.Text = DateTime.Now.ToShortDateString();
        txtEDay.Text = DateTime.Now.ToShortDateString();
        txtSearch.Text = "";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            string NewID = Guid.NewGuid().ToString();
            i = Conn.AddNew("LogSchoolSar", "LogID, Version, VirtualName, SchoolName, ProvinceID, IPaddress, ConnectName, Tel, SaleName, sDate, eDate, LogStatus, CreateDate, UpdateDate, ckExpDate, rent",
                NewID, txtVersion.Text, txtVirtualName.Text, txtSchoolName.Text, ddlProvince.SelectedValue, txtIPaddress.Text, txtConnectName.Text, txtTel.Text, txtSaleName.Text, Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), Convert.ToInt32(rdoStatus.SelectedValue), DateTime.Now, DateTime.Now, rbtlRenew.SelectedValue, Convert.ToInt32(txtRent.Text));
            Response.Redirect("LogSchoolSar.aspx?ckmode=1&Cr=" + i);    
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("LogSchoolSar", "Where LogID = '" + Request["id"] + "' ", "Version, VirtualName, SchoolName, ProvinceID, IPaddress, ConnectName, Tel, SaleName, sDate, eDate, LogStatus, ckExpDate, rent",
                txtVersion.Text, txtVirtualName.Text, txtSchoolName.Text, ddlProvince.SelectedValue, txtIPaddress.Text, txtConnectName.Text, txtTel.Text, txtSaleName.Text, Convert.ToDateTime(txtSDay.Text).ToString("s"), Convert.ToDateTime(txtEDay.Text).ToString("s"), Convert.ToInt32(rdoStatus.SelectedValue), rbtlRenew.SelectedValue, Convert.ToInt32(txtRent.Text));
            Response.Redirect("LogSchoolSar.aspx?ckmode=2&Cr=" + i);  
        }
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 i = Conn.Delete("LogSchoolSar", "Where LogID = '" + id + "' ");
        Response.Redirect("LogSchoolSar.aspx?ckmode=3&Cr=" + i);  
    }
    private void UpdateBackUp(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 i = Conn.Update("LogSchoolSar", "Where LogID = '" + id + "' ", "UpdateDate", DateTime.Now);
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Province", ddlSearch.SelectedValue);
        DataBind();
    }
    protected void ddlSearch2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Version", ddlSearch2.SelectedValue);
        DataBind();
    }
    protected void ddlSearch3_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Server", ddlSearch3.SelectedValue);
        DataBind();
    }
    protected void ddlSearchStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("Status", ddlSearchStatus.SelectedValue);
        DataBind();
    }
    protected string getVirtualName(string VirtualName, string ServerName)
    {
        string strLink = VirtualName;

        if (!string.IsNullOrEmpty(VirtualName) || VirtualName != "-" || !string.IsNullOrEmpty(ServerName) || ServerName != "0")
        {
            strLink = "<a href=\"http://" + ServerName + "/" + VirtualName + "\" target=\"_blank\">" + VirtualName + "</a>";
        }
        return strLink;
    }
    protected void btLoadPage_Click(object sender, EventArgs e)
    {
        Int32 i = Conn.Update("LogSchoolSar", "Where LogID = '" + txtID.Text + "' ", "UpdateDate", DateTime.Now);
        DataBind();
    }
    protected string getImgDatabase(DateTime lastUpdate)
    { 
        TimeSpan diffTime = DateTime.Now - lastUpdate; //ปัจจุบัน - อดีต = ผลต่าง
        string imgName = "dbB.png";
        if (diffTime.Days > 7)
        {
            imgName = "dbR.png";
        }
        if (diffTime.Days == 0)
        {
            imgName = "dbG.png";
        }
        return "<img style=\"border: 0; cursor: pointer;\" title=\"สำรองข้อมูล\" src=\"../Image/MenuStlye/"+ imgName +"\" />";
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "LogStatus").ToString() != "1") // 1 =  ซื้อขาด
            {
                if (!string.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "eDate").ToString()))
                {
                    if (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "eDate")) < DateTime.Now)
                    {
                        e.Row.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            else
            {
                e.Row.ForeColor = System.Drawing.Color.Green;
            }
        }   
    }
    protected string getStatus(string status, object ckExpDate, string IPaddress, string VirtualName, string LogID, object eDate)
    {
        string Link = getImgStatus(status, ckExpDate);
        
        if(status != "1")
        {
            Link = "<a href=\"javascript:;\" onclick=\"getPopUpRenew('" + IPaddress + "','" + VirtualName + "','" + LogID + "','" + eDate + "', '" + ckExpDate + "');\">" + getImgStatus(status, ckExpDate) + "</a>";
        }
        return Link;
    }
    protected string getImgStatus(string status, object ckExpDate)
    {
        string SS = "";
        if (status == "0")
        {
            if (Convert.ToInt32(ckExpDate) == 0)
            {
                SS = "<img src=\"../Image/Icon/icon1r.png\" alt=\"เช่าใช้\" title=\"เช่าใช้\" />";
            }
            else
            {
                SS = "<img src=\"../Image/Icon/icon1.png\" alt=\"เช่าใช้\" title=\"เช่าใช้\" />";
            }
        }
        if (status == "1")
        {
            SS = "<img src=\"../Image/Icon/icon3g.png\" alt=\"ซื้อขาด\" title=\"ซื้อขาด\" />";
        }
        if (status == "2")
        {
            SS = "<img src=\"../Image/Icon/icon4.png\" alt=\"ทดลองใช้\" title=\"ทดลองใช้\" />";
        }
        return SS;
    }
    protected string getRent(string status, string rent)
    {
        string ckRent = "-";
        if (status == "0")
        {
            ckRent = rent;
        }
        return ckRent;
    }
    protected void cbRent_CheckedChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}

