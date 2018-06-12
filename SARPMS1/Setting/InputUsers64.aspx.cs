using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Text.RegularExpressions;
using System.Text;
using System.Data.OleDb;
using System.Data.SqlClient;
using Star.Security.Cryptography;

public partial class InputUsers64 : System.Web.UI.Page
{
    private OleDbConnection exConn;
    private DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string script = string.Format("document.getElementById('{0}').style.display='{1}';", btImport.ClientID, "block");
            script += string.Format("document.getElementById('{0}').style.display='{1}';", btSave.ClientID, "none");

            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "btImport", script, true);
        }
    }
    private void Upload()
    {
        string path = ipFile.FileName; //Request.Files[0].FileName;
        path = string.Format("~/Uploads/{0}", Path.GetFileName(path));
        path = Server.MapPath(path);

        string[] CkSprit;
        CkSprit = Path.GetFileName(path).Split('.');
        if (CkSprit[1] == "xls")
        {
            if (!Directory.Exists(Path.GetDirectoryName(path)))
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                //Request.Files[0].SaveAs(path);        
                Session["ExcelName"] = Path.GetFileName(path);
                Session["DataInput"] = getDataByWorksheet(Session["ExcelName"].ToString());
                DataBind();
        }
        else
        {
            Msg_Head(true, "9", 0, "");
            string script = string.Format("document.getElementById('{0}').style.display='{1}';", btImport.ClientID, "block");
            script += string.Format("document.getElementById('{0}').style.display='{1}';", btSave.ClientID, "none");
            script += string.Format("document.getElementByID('ipFile').disabled = 'false';");

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "btImport", script, true);
        }
    }
    public override void DataBind()
    {
        GridView1.DataSource = Session["DataInput"];
        GridView1.DataBind();
    }
    private DataTable getDataByWorksheet(string worksSheetNames)
    {
        Connection Conn = new Connection();
        ds = new DataSet();

        string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/Uploads/") + worksSheetNames + @";Extended Properties=""Excel 8.0;""";
        try
        {
            exConn = new OleDbConnection(strConn.ToString());
            exConn.Open();
            string strSql = " Select UserName, EmpName, Email, Tel, DeptName, '' As DeptCode From [Sheet1$] Where UserName <> '' And EmpName <> '' ";
            OleDbDataAdapter da = new OleDbDataAdapter(strSql, exConn);
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                for(Int32 i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
                {
                    DataView dvCkDept = Conn.Select("Select DeptCode From Department Where DeptName = '" + ds.Tables[0].Rows[i]["DeptName"] + "'");
                    if (dvCkDept.Count > 0)
                    { 
                        ds.Tables[0].Rows[i]["DeptCode"] = dvCkDept[0]["DeptCode"].ToString();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            MsgHead.Text = ex.ToString();
            MsgHead.Visible = true;
        }
        finally
        {
            if (exConn != null)
            {
                exConn.Close();
                exConn.Dispose();
            }
        }
        //เช็คมีข้อมูลหรือไม่
        if (ds.Tables.Count > 0)
        {
            Msg_Head(true, "1", 1, "");
            Cktxt(false);
            return ds.Tables[0];
        }
        else
        {
            Msg_Head(true, "1", 0, "");
            Cktxt(true);
            DelFile(worksSheetNames);
            return null;
        }
    }
    private void DelFile(string worksSheetNames)
    {
        //ลบไฟล์
        string x = Path.GetFileName(worksSheetNames);
        x = Server.MapPath("~/Uploads/" + x);
        if (File.Exists(x))
        {
            File.Delete(x);
        }
    }
    private void Msg_Head(Boolean Enables, String mode, Int32 i, string Msg)
    {
        if (i > 0)
        {
            switch (mode)
            {
                case "1":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>Upload File เรียบร้อยแล้ว</small>";
                    break;
                case "2":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>บันทึกข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "3":
                    MsgHead.Text = "เรียบร้อย ! <BR> <small>ลบข้อมูลเรียบร้อยแล้ว</small>";
                    break;
                case "4":
                    MsgHead.Text = "";
                    break;
            }
            Img1.ImageUrl = "~/Image/msg_check.gif";
            MsgHead.CssClass = "headMsg";
        }
        else
        {
            switch (mode)
            {
                case "1":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถ Upload File ได้</small>";
                    break;
                case "2":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถแก้ไขข้อมูลได้</small>";
                    break;
                case "3":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถลบข้อมูลได้  เนื่องจากข้อมูลถูกใช้อยู่</small>";
                    break;
                case "4":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ไม่สามารถเพิ่มข้อมูลได้</small>";
                    break;
                case "9":
                    MsgHead.Text = "ผิดพลาด ! <BR> <small>ต้องเป็น File Excel .xls เท่านั้น</small>";
                    break;
            }
            Img1.ImageUrl = "~/Image/msg_error.gif";
            MsgHead.CssClass = "headMsgError";
        }
        Img1.Visible = Enables;
        MsgHead.Visible = Enables;
    }
    private void Cktxt(Boolean Enables)
    {
        string script = string.Format("document.getElementById('{0}').style.display='{1}';", btImport.ClientID, Enables ? "block" : "none");
        script += string.Format("document.getElementById('{0}').style.display='{1}';", btSave.ClientID, !Enables ? "block" : "none");

        Page.ClientScript.RegisterStartupScript(Page.GetType(), "btImport", script, true);
    }
    private void ClealAll()
    {
        GridView1.DataSource = null;
        GridView1.DataBind();
    }
    protected void btUpload_Click(object sender, EventArgs e)
    {
        Upload();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        BTC btc = new BTC();
        Connection Conn = new Connection();
        string ExcelName = Session["ExcelName"].ToString();

        DataTable dtTable;
        dtTable = getDataByWorksheet(ExcelName);

        //string CkAccxCode = dtTable.Rows[0]["AccxCode"].ToString();

        //DataView dv = Conn.Select(string.Format("Select AccxCode, DeptID, MonthB, YearB, TypeB, CreateUser, CreateDate From DataInput Where AccxCode = '" + CkAccxCode + "' And DeptID = '" + ddlDepartment.SelectedValue + "' And MonthB = '" + ddlMonth.SelectedValue + "' And YearB = '" + txtYear.Text + "' And TypeB = '" + ddlBudget.SelectedValue + "' "));

        //if (dv.Count > 0)
        //{
        //    string CkCreateUser = dv.Table.Rows[0]["CreateUser"].ToString();
        //    DateTime CkCreateDate = Convert.ToDateTime(dv.Table.Rows[0]["CreateDate"]);

        //    Int32 j = Conn.Delete("DataInput", " Where DeptID = " + ddlDepartment.SelectedValue + " And MonthB = " + ddlMonth.SelectedValue + " And YearB = " + txtYear.Text + " And TypeB = " + ddlBudget.SelectedValue + " ");

        //    try
        //    {
        //        StringBuilder sql = new StringBuilder();
        //        for (int i = 0; i <= dtTable.Rows.Count - 1; i++)
        //        {
        //            sql.AppendFormat(" INSERT INTO DataInput (AccxCode, AccxThaiName, DabitMonth, CreditMonth, DabitTotal, CreditTotal, DeptID, MonthB, YearB, TypeB, CkTrue, CreateUser, CreateDate, UpdateUser, UpdateDate)VALUES('" + dtTable.Rows[i]["AccxCode"] + "', '" + dtTable.Rows[i]["AccxThaiName"] + "', " + dtTable.Rows[i]["jrdtdebt"] + ", " + dtTable.Rows[i]["jrdtcrdt"] + ", " + dtTable.Rows[i]["DebitTotal"] + ", " + dtTable.Rows[i]["CreditTotal"] + ", '" + ddlDepartment.SelectedValue + "', " + ddlMonth.SelectedValue + ", " + txtYear.Text + ", " + ddlBudget.SelectedValue + ", " + dtTable.Rows[i]["CkTrue"] + ", '" + CkCreateUser + "', '" + CkCreateDate.AddYears(-543).ToString("M/d/yyyy HH:mm:ss") + "', '" + CurrentUser.ID + "', '" + DateTime.Now.AddYears(-543).ToString("M/d/yyyy HH:mm:ss") + "')");
        //        }
        //        Conn.Execute(sql.ToString());
        //    }
        //    catch (Exception)
        //    {
        //        Label1.Text = "Error";
        //    }
        //}
        //else
        //{
        DataView dvSchoolCode = Conn.Select("Select SchoolID From MR_School Where DelFlag = 0 Order By Sort");
        string SchoolCode = dvSchoolCode[0]["SchoolID"].ToString();
            try
            {
                StringBuilder sql = new StringBuilder();
                for (int i = 0; i <= dtTable.Rows.Count - 1; i++)
                {
                    DataView dvUserName = Conn.Select("Select UserName From Employee Where DelFlag = 0 And UserName = '" + dtTable.Rows[i]["UserName"].ToString() + "'");
                    if (dvUserName.Count == 0)
                    {
                        string NewID = Guid.NewGuid().ToString();
                        sql.AppendFormat(" INSERT INTO Employee (EmpID, UserName, Pwd, EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)VALUES('" + NewID + "', '" + dtTable.Rows[i]["UserName"] + "', '+iSBLchCynpqcAk6Uu/Ung==', '" + dtTable.Rows[i]["EmpName"] + "', '" + dtTable.Rows[i]["Email"] + "', '" + dtTable.Rows[i]["Tel"] + "', '" + SchoolCode + "', '" + dtTable.Rows[i]["DeptCode"] + "', '68486861-2c0c-40f7-91e0-acd1c035c911', 0, '" + CurrentUser.ID + "', '" + DateTime.Now.AddYears(-543).ToString("M/d/yyyy HH:mm:ss") + "', '" + CurrentUser.ID + "', '" + DateTime.Now.AddYears(-543).ToString("M/d/yyyy HH:mm:ss") + "')");

                    }
                }
                Conn.Execute(sql.ToString());

                Session.Remove("ExcelName");
                Session.Remove("DataInput");
                Cktxt(true);
                ClealAll();
               
                DelFile(ExcelName);
                Response.Redirect("EmployeeView.aspx?mode=1&Cr=1");
            }
            catch (Exception)
            {
                Label1.Text = "Error";

                Session.Remove("ExcelName");
                Session.Remove("DataInput");
                Cktxt(true);
                ClealAll();
               
                DelFile(ExcelName);
                Msg_Head(true, "4", 0, "");
            }
        //}   
        string script = string.Format("document.getElementById('{0}').style.display='{1}';", btImport.ClientID, "block");
        script += string.Format("document.getElementById('{0}').style.display='{1}';", btSave.ClientID, "none");

        Page.ClientScript.RegisterStartupScript(Page.GetType(), "ClearbtImport", script, true);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Session.Remove("ExcelName");
        Session.Remove("DataInput");
        Response.Redirect("EmployeeView.aspx");
    }

}
