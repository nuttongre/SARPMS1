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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public partial class ApproveFlowDetail : System.Web.UI.Page
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
            btc.getddlMainSubDepartment(0, ddlSearch, CurrentUser.MainDeptID, Cookie.GetValue2("MainSubDept").ToString());
            btc.CkAdmission(GridView1, btAdd, null);
            string mode = Request["mode"];
            if (!string.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        hdfApproveFlowDetailID.Value = Guid.NewGuid().ToString();
                        btc.getddlMainSubDepartment(1, ddlApproveFlow, CurrentUser.MainDeptID, null);
                        getddlApproveStep();
                        btc.getddlUserRole(1, ddlUserRole, null);
                        btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
                        getddlckStatus();
                        btc.GenSort(txtSort, "ApproveFlowDetail", " And ApproveFlowID = '" + ddlApproveFlow.SelectedValue + "' ");
                        imgPicture.ImageUrl = "../Image/Menu9.png";
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        getddlApproveStep();
                        btc.getddlUserRole(1, ddlUserRole, null);
                        getddlckStatus();
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
        ddlUserRole.Attributes.Add("onchange", "Cktxt(0);");
        ddlApproveStep.Attributes.Add("onchange", "Cktxt(0);");
        ddlPosition.Attributes.Add("onchange", "Cktxt(0);");
        ddlApproveFlow.Attributes.Add("onchange", "Cktxt(0);");
        txtSort.Attributes.Add("onkeyup", "Cktxt(0);");
    }
    private void getddlApproveStep()
    {
        string strSql = " Select ApproveStepID, Cast(Sort As nVarchar) + '. ' + ApproveStepName As ApproveStepName From ApproveStep Where DelFlag = 0 Order By Sort ";
        DataView dv = Conn.Select(string.Format(strSql));
        ddlApproveStep.DataSource = dv;
        ddlApproveStep.DataTextField = "ApproveStepName";
        ddlApproveStep.DataValueField = "ApproveStepID";
        ddlApproveStep.DataBind();
        ddlApproveStep.Items.Insert(0, new ListItem("- เลือก -", ""));
        ddlApproveStep.SelectedIndex = 0;
    }
    private void getddlckStatus()
    {
        ddlckStatus.Items.Insert(0, new ListItem("ไม่เลือก", ""));
        ddlckStatus.Items.Insert(1, new ListItem("เริ่มต้น", "S"));
        ddlckStatus.Items.Insert(2, new ListItem("สิ้นสุด", "E"));
    }
    public override void DataBind()
    {
        string StrSql = @" Select a.ApproveFlowDetailID, c.ApprovePositionName, a.ImgPath, a.BudgetLimit, a.ckStatus, a.Sort, 
                        Ast.ApproveStepName, UR.UserRoleName 
                        From ApproveFlowDetail a Inner Join MainSubDepartment b On a.ApproveFlowID = b.MainSubDeptCode
                        Inner Join ApprovePosition c On a.ApprovePositionID = c.ApprovepositionID
                        Left Join ApproveStep Ast On Ast.ApproveStepID = a.ApproveStepID
                        Left Join UserRole UR On a.UserRoleID = UR.UserRoleID
                        Where a.DelFlag = 0 And b.MainDeptCode = '{0}' ";

        if (ddlSearch.SelectedIndex != 0)
        {
            StrSql = StrSql + " And a.ApproveFlowID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            StrSql = StrSql + " And (c.ApprovePositionName Like '%" + txtSearch.Text + "%' Or a.Sort Like '%" + txtSearch.Text + "%')  ";
        }
        DataView dv = Conn.Select(string.Format(StrSql + " Order By b.Sort, a.Sort", CurrentUser.MainDeptID));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();

        GridView2.DataSource = dv;
        GridView2.DataBind();
    }
    private void GetData(string id)
    {
        if (string.IsNullOrEmpty(id)) return;
        DataView dv = Conn.Select(string.Format("Select * From ApproveFlowDetail Where ApproveFlowDetailID = '" + id + "'"));

        if (dv.Count != 0)
        {
            hdfApproveFlowDetailID.Value = dv[0]["ApproveFlowDetailID"].ToString();
            btc.getddlMainSubDepartment(1, ddlApproveFlow, CurrentUser.MainDeptID, null);
            ddlApproveFlow.SelectedValue = dv[0]["ApproveFlowID"].ToString();
            ddlApproveStep.SelectedValue = dv[0]["ApproveStepID"].ToString();
            ddlUserRole.SelectedValue = dv[0]["UserRoleID"].ToString();
            btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
            ddlPosition.SelectedValue = dv[0]["ApprovePositionID"].ToString();
            txtBudgetLimit.Text = dv[0]["BudgetLimit"].ToString();
            ddlckStatus.SelectedValue = dv[0]["ckStatus"].ToString();
            txtSort.Text = dv[0]["Sort"].ToString();

            if (!string.IsNullOrEmpty(dv[0]["ImgPath"].ToString()))
            {
                imgPicture.ImageUrl = dv[0]["ImgPath"].ToString();
                ImgBt.Visible = true;
            }
            else
            {
                imgPicture.ImageUrl = "../Image/Menu9.png";
                ImgBt.Visible = false;
            }
        }
        btc.getCreateUpdateUser(lblCreate, lblUpdate, "ApproveFlowDetail", "ApproveFlowDetailID", id);
    }
    private void ClearAll()
    {
        hdfApproveFlowDetailID.Value = Guid.NewGuid().ToString();
        ddlUserRole.SelectedIndex = 0;
        ddlPosition.SelectedIndex = 0;
        txtBudgetLimit.Text = "0";
        ddlckStatus.SelectedIndex = 0;
        ddlApproveFlow.SelectedIndex = 0;
        txtSearch.Text = "";
        imgPicture.ImageUrl = "../Image/Menu9.png";
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("MainSubDept", ddlSearch.SelectedValue);
        DataBind();
    }
    private void bt_Save(string CkAgain)
    {
        Int32 i = 0;
        if (String.IsNullOrEmpty(Request["mode"]) || Request["mode"] == "1")
        {
            i = Conn.AddNew("ApproveFlowDetail", "ApproveFlowDetailID, UserRoleID, ApprovePositionID, ApproveStepID, ApproveFlowID, BudgetLimit, ckStatus, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate",
                hdfApproveFlowDetailID.Value, ddlUserRole.SelectedValue, ddlPosition.SelectedValue, ddlApproveStep.SelectedValue, ddlApproveFlow.SelectedValue, txtBudgetLimit.Text, ddlckStatus.SelectedValue, txtSort.Text, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now);
            UploadImg();
            if (CkAgain == "N")
            {
                Response.Redirect("ApproveFlowDetail.aspx?ckmode=1&Cr=" + i);    
            }
            if (CkAgain == "Y")
            {
                MultiView1.ActiveViewIndex = 1;
                btc.Msg_Head(Img1, MsgHead, true, "1", i);
                ClearAll();
                btc.GenSort(txtSort, "ApproveFlowDetail", " And ApproveFlowID = '" + ddlApproveFlow.SelectedValue + "' ");
                GridView2.Visible = true;
                DataBind();
            }
        }
        if (Request["mode"] == "2")
        {
            i = Conn.Update("ApproveFlowDetail", "Where ApproveFlowDetailID = '" + Request["id"] + "' ", "UserRoleID, ApproveFlowID, ApprovePositionID, ApproveStepID, BudgetLimit, ckStatus, Sort, UpdateUser, UpdateDate", 
                ddlUserRole.SelectedValue, ddlApproveFlow.SelectedValue, ddlPosition.SelectedValue, ddlApproveStep.SelectedValue, txtBudgetLimit.Text, ddlckStatus.SelectedValue, txtSort.Text, CurrentUser.ID, DateTime.Now);
            UploadImg();
            Response.Redirect("ApproveFlowDetail.aspx?ckmode=2&Cr=" + i); 
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
        //if (btc.CkUseData(id, "ApproveFlowDetailID", "Projects", "And DelFlag = 0"))
        //{
        //    Response.Redirect("ApproveFlowDetail.aspx?ckmode=3&Cr=0");    
        //}
        //else
        //{
            Int32 i = Conn.Update("ApproveFlowDetail", "Where ApproveFlowDetailID = '" + id + "' ", "DelFlag, UpdateUser, UpdateDate", 1, CurrentUser.ID, DateTime.Now);
            Response.Redirect("ApproveFlowDetail.aspx?ckmode=3&Cr=" + i);    
        //}
    }
    protected void ddlYearB_SelectedIndexChanged(object sender, EventArgs e)
    {
       btc.getddlMainSubDepartment(1, ddlApproveFlow, CurrentUser.MainDeptID, null);
       btc.GenSort(txtSort, "ApproveFlowDetail", " And ApproveFlowID = '" + ddlApproveFlow.SelectedValue + "'");
    }
    protected string checkedit(string id, string strName)
    {
        if (CurrentUser.RoleLevel < 98)
        {
            return strName;
        }
        else
        {
            return string.Format("<a href=\"javascript:;\" onclick=\"EditItem('{0}');\">{1}</a>", id, strName);
        }
    }
    protected void ddlApproveFlow_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.GenSort(txtSort, "ApproveFlowDetail", " And ApproveFlowID = '" + ddlApproveFlow.SelectedValue + "'");
    }
    protected void btnUpload_OnClick(object sender, EventArgs e)
    {
        UploadImg();
    }
    private void UploadImg()
    {
        if (fiUpload.HasFile)
        {

            int intWidth = 0;
            int intHeight = 0;
            string UlFileName = null;
            string NewFileName = null;
            string NewID = Guid.NewGuid().ToString();

            intWidth = 71;
            //*** Fix Width ***//
            //intHeight = 0   '*** If = 0 Auto Re-Cal Size ***//
            intHeight = 71;

            string[] filetype = fiUpload.FileName.Split('.');

            UlFileName = "../Image/Logo/" + NewID + "." + filetype[1].ToString();  //fiUpload.FileName;

            //*** Save Images ***//
            fiUpload.SaveAs(Server.MapPath(UlFileName));

            NewFileName = "../Image/Logo/Rz_" + NewID + "." + filetype[1].ToString();  //fiUpload.FileName;

            Connection Conn = new Connection();
            Conn.Update("ApproveFlowDetail", "Where ApproveFlowDetailID = '" + hdfApproveFlowDetailID.Value + "' ", "ImgPath", NewFileName);

            System.Drawing.Image objGraphic = System.Drawing.Image.FromFile(Server.MapPath(UlFileName));

            Bitmap objBitmap = default(Bitmap);
            //*** Calculate Height ***//
            if (intHeight > 0)
            {
                objBitmap = new Bitmap(objGraphic, intWidth, intHeight);
            }
            else
            {
                if (objGraphic.Width > intWidth)
                {
                    double ratio = objGraphic.Height / objGraphic.Width;
                    intHeight = (int)ratio * (int)intWidth;
                    objBitmap = new Bitmap(objGraphic, intWidth, intHeight);
                }
                else
                {
                    objBitmap = new Bitmap(objGraphic);
                }
            }

            //*** Save As  ***//
            objBitmap.Save(Server.MapPath(NewFileName.ToString()), objGraphic.RawFormat);

            //*** Close ***//
            objGraphic.Dispose();

            //*** View Images ***//
            imgPicture.Visible = true;
            imgPicture.ImageUrl = NewFileName;
            MsgHead.Text = "เรียบร้อย ! <BR> <small>Upload รูปใหม่เรียบร้อยแล้ว</small>";
            Img1.ImageUrl = "~/Image/msg_check.gif";
            MsgHead.CssClass = "headMsg";
            MsgHead.Visible = true;
            Img1.Visible = true;
            ImgBt.Visible = true;
        }
    }
    protected void DeleteImg(object sender, EventArgs e)
    {
        Conn.Update("ApproveFlowDetail", "Where ApproveFlowDetailID = '" + hdfApproveFlowDetailID.Value + "'", "ImgPath", "");
        imgPicture.ImageUrl = "../Image/Menu9.png";
        ImgBt.Visible = false;
    }
    protected void ddlUserRole_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
    }
}
