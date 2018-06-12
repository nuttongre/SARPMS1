using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Star.Security.Cryptography;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

public partial class EmployeeView : System.Web.UI.Page
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
            CkAdmission(GridView1, btAdd, null);

            if(Convert.ToInt32(CurrentUser.RoleLevel) < 98)
            {
                spnImportExcel.Visible = false;
                spnDownLoadFile.Visible = false;
                ddlSearchDept.Enabled = false;
                ddlSearch.Enabled = false;
                GridView1.Columns[GridView1.Columns.Count - 3].Visible = false;
            }
            string mode = Request["mode"];
            if (!String.IsNullOrEmpty(mode))
            {
                switch (mode.ToLower())
                {
                    case "1":
                        MultiView1.ActiveViewIndex = 1;
                        hdfEmpID.Value = Guid.NewGuid().ToString();
                        btc.getddlUserRole(1, ddlUserRole, null);
                        btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
                        btc.getddlDepartment(1, ddlDept, ddlMainSubDept.SelectedValue, null, null);
                        getSchool();
                        tblEditPwd.Visible = true;
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "Cktxt(0);", true);
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "function CkEmp(){" + Page.ClientScript.GetPostBackEventReference(btCkEmp, null, false) + ";}", true);
                        break;
                    case "2":
                        MultiView1.ActiveViewIndex = 1;
                        btc.getddlUserRole(1, ddlUserRole, null);
                        btc.getddlMainDepartment(1, ddlMainDept, null);
                        getSchool();
                        tblEditPwd.Visible = false;
                        GetData(Request["id"]);
                        break;
                    case "3":
                        MultiView1.ActiveViewIndex = 0;
                        Delete(Request["id"]);
                        break;
                    case "4":
                        MultiView1.ActiveViewIndex = 0;
                        ResetPwd(Request["id"]);
                        break;
                    case "5":
                        MultiView1.ActiveViewIndex = 0;
                        Hide(Request["id"]);
                        break;
                }
            }
            else
            {
                btc.getddlUserRole(0, ddlSearch, Cookie.GetValue2("ckRoleID"));
                btc.getddlMainDepartment(0, ddlSearchMainDept, Cookie.GetValue2("ckMainDeptID"));
                btc.getddlMainSubDepartment(0, ddlSearchMainSubDept, ddlSearchMainDept.SelectedValue, Cookie.GetValue2("ckMainSubDeptID"));
                btc.getddlDepartment(0, ddlSearchDept, ddlSearchMainSubDept.SelectedValue, Cookie.GetValue2("ckDeptID"), null);
                DataBind();
            }
        }
        txtUserName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtUserName.Attributes.Add("onchange", "var fnc=parent.eval('CkEmp'); if(typeof(fnc)=='function' && fnc) fnc();");
        txtPwd.Attributes.Add("onkeyup", "Cktxt(0);");
        txtConfirmPwd.Attributes.Add("onkeyup", "Cktxt(0);");
        txtName.Attributes.Add("onkeyup", "Cktxt(0);");
        txtEmail.Attributes.Add("onkeyup", "Cktxt(0);");
        txtTel.Attributes.Add("onkeyup", "Cktxt(0);");
        ddlSchool.Attributes.Add("onchange", "Cktxt(0);");
        ddlDept.Attributes.Add("onchange", "Cktxt(0);");
        ddlUserRole.Attributes.Add("onchange", "Cktxt(0);");
        ddlPosition.Attributes.Add("onchange", "Cktxt(0);");
    }
    private void CkAdmission(Star.Web.UI.Controls.DataGridView GridView1, Button btAdd, LinkButton btDel)
    {
        if (!string.IsNullOrEmpty(CurrentUser.RoleLevel.ToString()))
        {
            if (Convert.ToInt32(CurrentUser.RoleLevel) < 98)
            {
                if (btAdd != null)
                {
                    btAdd.Visible = false;
                }
                if (btDel != null)
                {
                    btDel.Enabled = false;
                }
                if (GridView1 != null)
                {
                    GridView1.Columns[GridView1.Columns.Count - 1].Visible = false;
                    GridView1.Columns[GridView1.Columns.Count - 2].Visible = false;
                }
            }
        }
        else
        {
            FormsAuthentication.RedirectToLoginPage();
        }
    }
    public override void DataBind()
    {
        string strSql = "";
        if (Convert.ToInt32(CurrentUser.RoleLevel) > 97)
        {
            strSql = @" SELECT a.EmpID, a.UserName, a.Pwd, a.EmpName, D.DeptName, c.UserRoleName, a.HideFlag, c.RoleLevel 
                    FROM Employee a Inner Join Department D On a.DeptCode = D.Deptcode 
                    Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                    Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode 
                    Inner Join UserRole c On a.UserRoleID = c.UserRoleID 
                    Where a.DelFlag = 0 And a.EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70') ";      
        }
        else
        {
            strSql = @" SELECT a.EmpID, a.UserName, a.Pwd, a.EmpName, D.DeptName, c.UserRoleName, a.HideFlag, c.RoleLevel 
                    FROM Employee a Inner Join Department D On a.DeptCode = D.Deptcode 
                    Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                    Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                    Inner Join UserRole c On a.UserRoleID = c.UserRoleID 
                    Where a.DelFlag = 0 AND a.EmpID = '{0}' 
                    And a.EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70') ";
        }

        if (ddlSearchDept.SelectedIndex != 0)
        {
            if (Convert.ToInt32(CurrentUser.RoleLevel) > 97)
            {
                strSql = @" SELECT a.EmpID, a.UserName, a.Pwd, a.EmpName, D.DeptName, c.UserRoleName, a.HideFlag, c.RoleLevel 
                        FROM Employee a 
                        Left Join EmpDept b On a.EmpID = b.EmpID 
                        Inner Join Department D On b.DeptCode = D.Deptcode 
                        Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                        Inner Join UserRole c On a.UserRoleID = c.UserRoleID 
                        Where a.DelFlag = 0 And a.EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70') ";
            }
            else
            {
                strSql = @" SELECT a.EmpID, a.UserName, a.Pwd, a.EmpName, D.DeptName, c.UserRoleName, a.HideFlag, c.RoleLevel
                        FROM Employee a 
                        Left Join EmpDept b On a.EmpID = b.EmpID 
                        Inner Join Department D On b.DeptCode = D.Deptcode 
                        Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode
                        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
                        Inner Join UserRole c On a.UserRoleID = c.UserRoleID 
                        Where a.DelFlag = 0 AND a.EmpID = '{0}' 
                        And a.EmpID Not In ('4E975C83-6E7B-4A48-A815-F733094B1234', '4C3E218F-D513-416E-BD10-B4F161717F70') ";
            }
            strSql = strSql + " And b.DeptCode = '" + ddlSearchDept.SelectedValue + "' ";
        }

        if (ddlSearch.SelectedIndex != 0)
        {
            strSql = strSql + " And c.UserRoleID = '" + ddlSearch.SelectedValue + "' ";
        }
        if (ddlSearchMainDept.SelectedIndex != 0)
        {
            strSql += " And MD.MainDeptCode = '" + ddlSearchMainDept.SelectedValue + "' ";
        }
        if (ddlSearchMainSubDept.SelectedIndex != 0)
        {
            strSql += " And MSD.MainSubDeptCode = '" + ddlSearchMainSubDept.SelectedValue + "' ";
        }
        if (txtSearch.Text != "")
        {
            strSql = strSql + " And (a.EmpName Like '%" + txtSearch.Text + "%' or a.UserName Like '%" + txtSearch.Text + "%') ";
        }

        DataView dv = Conn.Select(string.Format(strSql + " Order By c.RoleLevel Desc, MD.Sort, MSD.Sort, D.Sort, a.HideFlag, a.UserName ", CurrentUser.ID));
        GridView1.DataSource = dv;
        GridView1.DataBind();
        lblSearchTotal.InnerText = dv.Count.ToString();
    }
    private void GetData(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        DataView dv, dv1;
        string strSql = @" Select E.*, D.DeptName, MSD.MainSubDeptCode, MSD.MainSubDeptName, MD.MainDeptCode, MD.MainDeptName
        From Employee E Inner Join Department D On E.DeptCode = D.DeptCode
        Inner Join MainSubDepartment MSD On MSD.MainSubDeptCode = D.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
        Where E.DelFlag = 0 And E.EmpID = '{0}' ";
        dv = Conn.Select(string.Format(strSql, id));
        if (dv.Count != 0)
        {
            hdfEmpID.Value = dv[0]["EmpID"].ToString();
            txtUserName.Text = dv[0]["UserName"].ToString();
            txtUserName.ReadOnly = true;
            txtName.Text = dv[0]["EmpName"].ToString();
            txtEmail.Text = dv[0]["Email"].ToString();
            txtTel.Text = dv[0]["Tel"].ToString();
            ddlSchool.SelectedValue = dv[0]["SchoolID"].ToString();
            btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
            ddlMainSubDept.SelectedValue = dv[0]["MainSubDeptCode"].ToString();
            btc.getddlDepartment(1, ddlDept, ddlMainSubDept.SelectedValue, null, cblDept);
            ddlDept.SelectedValue = dv[0]["DeptCode"].ToString();
            ddlUserRole.SelectedValue = dv[0]["UserRoleID"].ToString();
            btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
            ddlPosition.SelectedValue = dv[0]["ApprovePositionID"].ToString();
            btc.getCreateUpdateUser(lblCreate, lblUpdate, "Employee", "EmpID", id);

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

            strSql = "Select DeptCode From EmpDept Where EmpID = '" + id + "' ";
            dv1 = Conn.Select(strSql);
            if (dv1.Count != 0)
            {
                for (int i = 0; i <= cblDept.Items.Count - 1; i++)
                {
                    for (int j = 0; j <= dv1.Count - 1; j++)
                    {
                        if (cblDept.Items[i].Value == dv1[j]["DeptCode"].ToString())
                        {
                            cblDept.Items[i].Selected = true;

                            if (cblDept.Items[i].Value == ddlDept.SelectedValue)
                            {
                                cblDept.Items[i].Enabled = false;
                            }
                            break;
                        }
                    }
                }
            }

            if (Convert.ToInt32(CurrentUser.RoleLevel) < 98)
            {
                ddlSchool.Enabled = false;
                ddlDept.Enabled = false;
                ddlUserRole.Enabled = false;
                cblDept.Enabled = false;
            }
            else
            {
                ddlSchool.Enabled = true;
                ddlDept.Enabled = true;
                ddlUserRole.Enabled = true;
                cblDept.Enabled = true;
            }
        }
    }
    private void getSchool()
    {
        ddlSchool.DataSource = btc.getddlSchool();
        ddlSchool.DataTextField = "SchoolName";
        ddlSchool.DataValueField = "SchoolID";
        ddlSchool.DataBind();
        ddlSchool.Items.Insert(0, new ListItem("-เลือก-", ""));
        ddlSchool.SelectedIndex = 1;
    }
    private void Delete(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        if (CurrentUser.ID.ToString() == Request["id"].ToString())
        {
            btc.Msg_Head(Img1, MsgHead, true, "3", 0);
        }
        else
        {
            Int32 i = 0;
            DataView dv = Conn.Select("Select EmpCode From dtAcEmp Where EmpCode = '" + Request["id"] + "'");
            if (dv.Count == 0)
            {
                i = Conn.Update("Employee", "Where EmpID = '" + Request["id"] + "' ", "DelFlag", 1);
                Conn.Delete("EmpDept", "Where EmpID = '" + Request["id"] + "' ");
            }
            Response.Redirect("EmployeeView.aspx?ckmode=3&Cr=" + i); 
        }
    }
    private void ResetPwd(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 i = Conn.Update("Employee", "Where EmpID = '" + Request["id"] + "' ", "Pwd", Text.Encrypt("password"));
        Response.Redirect("EmployeeView.aspx?ckmode=2&Cr=" + i); 
    }
    private void Hide(string id)
    {
        if (String.IsNullOrEmpty(id)) return;
        Int32 sts = 0;
        if(!string.IsNullOrEmpty(Request["sts"]))
        {
            sts = Convert.ToInt32(Request["sts"]);
            if (sts == 0)
            {
                sts = 1;
            }
            else
            {
                sts = 0;
            }
        }

        Int32 i = Conn.Update("Employee", "Where EmpID = '" + Request["id"] + "' ", "HideFlag", sts);
        Response.Redirect("EmployeeView.aspx?ckmode=2&Cr=" + i); 
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        DataBind();
    }
    protected void ddlSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Cookie.SetValue2("ckRoleID", ddlSearch.SelectedValue);
        DataBind();
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
    protected string linkHide(string id, Boolean HideFlag)
    {
        string ImgName = "off.png";
        string StatusName = "ปิดการใช้งานอยู่";

        if (!HideFlag)
        {
            ImgName = "OnB.png";
            StatusName = "เปิดการใช้งานอยู่";
        }

        DataView dv = Conn.Select("Select EmpID, UserName From Employee Where DelFlag = 0 And EmpID = '" + id + "'");
        if (dv.Count != 0)
        {
            if (dv[0]["UserName"].ToString() != "Admin")
            {
                return string.Format("<a href=\"javascript:HideItem('{0}', {1})\"><img style=\"border: 0; cursor: pointer;\" title=\"" + StatusName + "\" src=\"../Image/" + ImgName + "\" /></a>", id, Convert.ToInt32(HideFlag));
            }
            else
            {
                return String.Format("<img style=\"border: 0; \" title=\"" + StatusName + "\" src=\"../Image/" + ImgName + "\" />");
            }
        }
        else
        {
            return string.Format("<a href=\"javascript:HideItem('{0}', {1})\"><img style=\"border: 0; cursor: pointer;\" title=\"" + StatusName + "\" src=\"../Image/" + ImgName + "\" /></a>", id, Convert.ToInt32(HideFlag));
        }
    }
    protected string linkDel(string id)
    {
        DataView dv = Conn.Select("Select EmpID, UserName From Employee Where DelFlag = 0 And EmpID = '" + id + "'");
        if (dv.Count != 0)
        {
            if (dv[0]["UserName"].ToString() != "Admin")
            {
                return String.Format("<a href=\"javascript:deleteItem('{0}')\"><img style=\"border: 0; cursor: pointer;\" title=\"ลบ\" src=\"../Image/delete.gif\" /></a>", id);
            }
            else
            {
                return string.Format("");
            }
        }
        else
        {
            return string.Format("");
        }
    }
    private Boolean ckRoleDuplicate(string UserRoleID)
    {
        if (!string.IsNullOrEmpty(UserRoleID))
        {
            string strSql = "Select E.EmpID From Employee E Inner Join UserRole UR On E.UserRoleID = UR.UserRoleID Where E.UserRoleID = '{0}' And UR.RoleLevel >= 70 ";
            DataView dv = Conn.Select(string.Format(strSql, UserRoleID));
            if (dv.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return true;
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Request.QueryString["mode"]) || Request.QueryString["mode"] == "1")
        {
            if (!Cktxt())
            {
                return;
            }
            if (ckRoleDuplicate(ddlUserRole.SelectedValue))
            {
                lblRoleDuplicate.Visible = true;
                return;
            }
            lblRoleDuplicate.Visible = false;
            string ckPwd = "password";
            if (!string.IsNullOrEmpty(txtPwd.Text))
            {
                ckPwd = txtPwd.Text;
            }

            Int32 i = Conn.AddNew("Employee", "EmpID, UserName, Pwd, EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, HideFlag, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ApprovePositionID",
                hdfEmpID.Value, txtUserName.Text, Text.Encrypt(ckPwd), txtName.Text, txtEmail.Text, txtTel.Text, ddlSchool.SelectedValue, ddlDept.SelectedValue, ddlUserRole.SelectedValue, 0, 0, CurrentUser.ID, DateTime.Now, CurrentUser.ID, DateTime.Now, ddlPosition.SelectedValue);
            UploadImg();
            for (int j = 0; j <= cblDept.Items.Count - 1; j++)
            {
                if (cblDept.Items[j].Selected)
                {
                    Conn.AddNew("EmpDept", "EmpID, DeptCode", hdfEmpID.Value, cblDept.Items[j].Value);
                }
            }
            Response.Redirect("EmployeeView.aspx?ckmode=1&Cr=" + i);  
        }
        if (Request.QueryString["mode"] == "2")
        {
            if (ckRoleDuplicate(ddlUserRole.SelectedValue))
            {
                lblRoleDuplicate.Visible = true;
                return;
            }
            lblRoleDuplicate.Visible = false;

            Int32 i = Conn.Update("Employee", "WHERE EmpID = '" + Request.QueryString["id"] + "' ", "EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, UpdateUser, UpdateDate, ApprovePositionID", 
                txtName.Text, txtEmail.Text, txtTel.Text, ddlSchool.SelectedValue, ddlDept.SelectedValue, ddlUserRole.SelectedValue, CurrentUser.ID, DateTime.Now, ddlPosition.SelectedValue);
            UploadImg();

            ServiceReference2.ProfileServiceSoapClient PmsServices = new ServiceReference2.ProfileServiceSoapClient();
            PmsServices.setProfile(Request.QueryString["id"], txtName.Text, txtEmail.Text, txtTel.Text, CurrentUser.ID);

            Conn.Delete("EmpDept", "Where EmpID = '" + Request.QueryString["id"] + "' ");
            for (int j = 0; j <= cblDept.Items.Count - 1; j++)
            {
                if (cblDept.Items[j].Selected)
                {
                    Conn.AddNew("EmpDept", "EmpID, DeptCode", Request.QueryString["id"], cblDept.Items[j].Value);
                }
            }
            Response.Redirect("EmployeeView.aspx?ckmode=2&Cr=" + i);  
        }
    }
    private Boolean Cktxt()
    {
        string sql = string.Format("Select UserName From Employee Where UserName = '{0}' And DelFlag = 0", txtUserName.Text);
        DataView dv = Conn.Select(sql);

        if (dv.Count != 0)
        {
            return false;
        }
        return true;
    }
    protected void btCkEmp_Click(object sender, EventArgs e)
    {
        //Page.ClientScript.RegisterStartupScript(Page.GetType(), Guid.NewGuid().ToString(), "ImgWait();", true);
        if (!string.IsNullOrEmpty(txtUserName.Text))
        {
            string sql = string.Format("Select UserName From Employee Where UserName = '{0}' And DelFlag = 0", txtUserName.Text);
            DataView dv = Conn.Select(sql);
            if (dv.Count != 0)
            {
                lblErrorUserName.Visible = true;
                lblErrorUserName.Text = "ชื่อนี้มีผู้ใช้แล้ว";
                lblErrorUserName.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblErrorUserName.Visible = true;
                lblErrorUserName.Text = "ชื่อนี้ใช้ได้";
                lblErrorUserName.ForeColor = System.Drawing.Color.Green;
            }
        }
        else
        {
            lblErrorUserName.Visible = false;
        }
    }
    protected void ddlDept_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDept.SelectedIndex != 0)
        {
            //if (Request["mode"] != "1")
            //{
            //    cblDept.SelectedItem.Selected = false;
            //}

            for (int i = 0; i < cblDept.Items.Count; i++)
            {
                cblDept.Items[i].Enabled = true;
            }
            cblDept.SelectedValue = ddlDept.SelectedValue;
            cblDept.SelectedItem.Enabled = false;
        }
        else
        {
            for (int i = 0; i < cblDept.Items.Count; i++)
            {
                cblDept.Items[i].Selected = false;
            }
        }
    }
    protected void ddlUserRole_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlPosition(1, ddlPosition, ddlUserRole.SelectedValue, null);
        //if (ddlUserRole.SelectedIndex == 4)
        //{
        //    if (ddlDept.SelectedIndex != 0)
        //    {
        //        cblDept.SelectedItem.Selected = false;
        //        cblDept.SelectedValue = ddlDept.SelectedValue;
        //        cblDept.Enabled = false;
        //    }
        //}
        //else
        //{
        //    cblDept.Enabled = true;
        //}
    }
    protected void ddlMainDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlMainSubDepartment(1, ddlMainSubDept, ddlMainDept.SelectedValue, null);
    }
    protected void ddlMainSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        btc.getddlDepartment(1, ddlDept, ddlMainSubDept.SelectedValue, null, cblDept);
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

            UlFileName = "../Image/Signature/" + NewID + Path.GetExtension(fiUpload.FileName).ToString();  //fiUpload.FileName;

            //*** Save Images ***//
            fiUpload.SaveAs(Server.MapPath(UlFileName));

            NewFileName = "../Image/Signature/Rz_" + NewID + Path.GetExtension(fiUpload.FileName).ToString();  //fiUpload.FileName;

            Conn.Update("Employee", "Where EmpID = '" + hdfEmpID.Value + "' ", "ImgPath", NewFileName);

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
        Conn.Update("Employee", "Where EmpID = '" + hdfEmpID.Value + "'", "ImgPath", "");
        imgPicture.ImageUrl = "../Image/Menu9.png";
        ImgBt.Visible = false;
    }
}
