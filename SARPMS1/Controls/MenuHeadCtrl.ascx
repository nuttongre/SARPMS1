<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MenuHeadCtrl.ascx.cs"
    Inherits="Controls_MenuHeadCtrl" %>
<div style="float:left;"><asp:Label ID="lblCkUpdate" runat="server"  ForeColor="Red"></asp:Label></div>
<div>
    <asp:HyperLink ID="hplEmp" runat="server" ForeColor="Black" NavigateUrl="../Setting/EmployeeView.aspx"
        Target="_parent" ToolTip="แก้ไข  เปลี่ยนแปลงข้อมูลส่วนตัว">ข้อมูลส่วนตัว <img src="../Image/user.gif" style="border:0; vertical-align:middle;" /></asp:HyperLink>&nbsp;&nbsp;
    <asp:HyperLink ID="hplEditPwd" runat="server" ForeColor="Black" NavigateUrl="../Setting/EditPassword.aspx"
        Target="_parent" ToolTip="แก้ไข  เปลี่ยนแปลงรหัสผ่าน">แก้ไขรหัสผ่าน <img src="../Image/script_edit.gif" style="border:0; vertical-align:middle;" /></asp:HyperLink>&nbsp;&nbsp;
    <asp:HyperLink ID="hplHelp" runat="server" ForeColor="Black" NavigateUrl="../Doc/manual.pdf"
        Target="_blank" ToolTip="คู่มือการใช้โปรแกรม">ช่วยเหลือ <img src="../Image/Help.gif" style="border:0; vertical-align:middle;" /></asp:HyperLink>&nbsp;&nbsp;
    <asp:HyperLink ID="hpProblems" runat="server" ForeColor="Black" NavigateUrl="../Setting/Problems.aspx"
        Target="_parent" ToolTip="แจ้งปัญหาการใช้งานของระบบ">แจ้งปัญหาการใช้งาน <img src="../Image/mail.png" style="border:0; vertical-align:middle; width:20px; height:20px;" /></asp:HyperLink>&nbsp;&nbsp;
    <asp:LinkButton ID="lbtLogOut" runat="server" ForeColor="Black" OnClick="lblLogOut_Click"
        ToolTip="ออกจากระบบ">ออกจากระบบ <img src="../Image/icon_logout.gif" alt="ออกจากระบบ" style="border:0; vertical-align:middle;" /></asp:LinkButton>
</div>
