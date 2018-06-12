using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
public partial class Popup_UserList : System.Web.UI.Page
{
    DataView dv = new DataView();
    DataView dvUser = new DataView();
    StringBuilder script = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //userid.Value = CurrentUser.ID;
            getRoot();
            //this.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "CkUserId();", true);
        }
    }
    private void getRoot()
    {
        Connection Conn = new Connection();

        dvUser = new BTC().getddlEmployee();
        dv = new BTC().getddlDepartment();
       
        script.Append("var TreeMenu=new TreeView('TreeMenu');TreeMenu.imageFolder='../Image/tree/';TreeMenu.collapseText='ซ่อนรายการย่อย';TreeMenu.expandText='แสดงรายการย่อย';TreeMenu.config={target:'_self', folderLinks:false, useSelection:true, useCookies:true, useLines:false, useIcons:false, useStatusText:false, closeSameLevel:false, inOrder:false,  fullRowSelect:true};");
        //getRootMenu();
        getChildMenu();
        script.Append("TreeMenu.populate();");
        this.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);
    }
    //private void getRootMenu()
    //{
    //    DataRow[] drDepartment = dv;
    //    script.Append("TreeMenu.add(\"0\",\"-1\",\"รายชื่อพนักงานทั้งหมด\");");
    //    for (int i = 0; i < drDepartment.Length; i++)
    //    {
    //        //ฝ่าย
    //        script.AppendFormat("TreeMenu.add(\"{0}\",\"{1}\",\"{2}\",\"\",\"{2}\",null,null);", drDepartment[i]["DeptCode"].ToString(), string.IsNullOrEmpty(drDepartment[i]["ParentId"].ToString()) ? "0" : drDepartment[i]["ParentId"].ToString(), drDepartment[i]["Title"].ToString());
    //        getChildMenu(drDepartment[i]["DepID"].ToString());
    //    }
    //}
    private void getChildMenu()
    {
        DataRow[] drSubDepartment = dv.Table.Select("DeptCode Is Not Null");
        script.Append("TreeMenu.add(\"0\",\"-1\",\"รายชื่อพนักงานทั้งหมด\");");
        for (int i = 0; i < drSubDepartment.Length; i++)
        {
            //แผนก
            script.AppendFormat("TreeMenu.add(\"{0}\",\"{1}\",\"{2}\",\"\",\"{2}\",null,null);", drSubDepartment[i]["DeptCode"].ToString(), 0, drSubDepartment[i]["DeptName"].ToString());
            getLeafMenu(drSubDepartment[i]["DeptCode"].ToString());
        }
    }
    private void getLeafMenu(string sid)
    {
        Connection Conn  = new Connection();
        DataRow[] drUser = dvUser.Table.Select(string.Format("DeptCode='{0}'", sid));
        foreach (DataRow row in drUser)
        {
            //ชื่อ
            string ck = "";
            if (Request["mode"] == "2")
            {
                DataView dv = Conn.Select("Select * From dtAcEmp Where ActivityCode = '" + Request["acid"] + "' And EmpCode = '" + row["EmpID"].ToString() + "' ");
                DataView dv1 = Conn.Select("Select * From dtAcDept Where ActivityCode = '" + Request["acid"] + "' And DeptCode = '" + row["DeptCode"].ToString() + "' ");
                if (dv.Count != 0 && dv1.Count != 0)
                {
                    ck = "checked='true'";
                }
            }
            else
            {
                if (row["EmpID"].ToString() == CurrentUser.ID && row["DeptCode"].ToString() == CurrentUser.DeptID)
                    ck = "checked='true'";
            }

            script.AppendFormat("TreeMenu.add(\"{0}\",\"{1}\",\"<input type='checkbox' id='{0}{1}' name='rdUsers' " + ck + " /><label for='{0}'> {2}&nbsp;</label><input type='hidden' id='hidden_{0}{1}' value='{0}' /><input type='hidden' id='hdfdept_{0}{1}' value='{1}' /> \",\"\",\"{2}\",null,null);", row["EmpID"].ToString(), sid, row["EmpName"].ToString());
        }
    }
}
