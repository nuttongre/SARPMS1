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
using Star.Security.Cryptography;
using System.IO;


public partial class AttachFile : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

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
            //àªç¤»Õ§º»ÃÐÁÒ³
            btc.ckBudgetYear(lblSearchYear, null);

            getdllStudyYear();
            //DataBind();
            GetDataAttach(ddlSearchYear.SelectedValue);
        }
    }
    private void getdllStudyYear()
    {
        DataView dv = Conn.Select("Select Top 10 StudyYear, Df From StudyYear Where DelFlag = 0 Order By StudyYear");
        if (dv.Count != 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                ddlSearchYear.Items.Insert(i, new ListItem(dv[i]["StudyYear"].ToString(), dv[i]["StudyYear"].ToString() + "AAAA-1111-AAAA-1111-AAAA1111AAAA"));
            }
            DataView dv1 = Conn.Select("Select StudyYear From StudyYear Where DelFlag = 0 And Df = 1");
            if (dv1.Count != 0)
            {
                ddlSearchYear.SelectedValue = dv1[0]["StudyYear"].ToString() + "AAAA-1111-AAAA-1111-AAAA1111AAAA";
            }
        }
    }
    public override void DataBind()
    {
        String StrSql = "Select * From SarAttach Where DelFlag = 0 And StudyYear = SubString('" + ddlSearchYear.SelectedValue + "',1,4) ";

        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And FileName Like '%" + txtSearch.Text + "%' ";
        }

        DataView dv = Conn.Select(StrSql + " Order By FileName ");
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        //DataBind();
        GetDataAttach(ddlSearchYear.SelectedValue);
    }
    protected void ddlSearchYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DataBind();
        GetDataAttach(ddlSearchYear.SelectedValue);
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
        rptAttach.DataSource = dv;
        rptAttach.DataBind();
    }
    protected void btnAttach_Click(object sender, EventArgs e)
    {
        if (fpAttach.HasFile)
        {
            if (btc.ckAttachFileGetExtensionError(fpAttach))
            {
                string NewID = Guid.NewGuid().ToString();
                int rowsEffect = Conn.AddNew("Multimedia", "ItemID,TypeID,Title,FileUrl,FileSize,FileType,ReferID,MediaYear,CreateUser,CreateDate,UpdateUser,UpdateDate,Source,Shared,Enabled,Flag",
                    NewID, cbDuo.Checked, fpAttach.FileName, "", fpAttach.PostedFile.ContentLength, fpAttach.PostedFile.ContentType, ddlSearchYear.SelectedValue, DateTime.Now.Year, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, 1, 0, 1, 0);
                btc.UploadFileAttach(fpAttach, NewID, btc.getAttachType(fpAttach.PostedFile.ContentType, Convert.ToInt32(cbDuo.Checked)));

                if (cbDuo.Checked && fpAttach.FileName.ToString().Substring(fpAttach.FileName.ToString().IndexOf('.')).Contains(".zip"))
                {
                    UnZipFiles(fpAttach, NewID);
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "alert('äÁèÃÍ§ÃÑºä¿Åì¹Õé');", true);
            }
            cbDuo.Checked = false;
            GetDataAttach(ddlSearchYear.SelectedValue);
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
}
