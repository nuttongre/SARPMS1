<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BannerCtrl.ascx.cs" Inherits="Controls_Banner" %>
    <script type="text/javascript">
        function SystemConfirm(ck)
        {
            var str = 'ต้องการปิดระบบชั่วคราว ใช่หรือไม่';
            if(ck == 1)
            {
                str = 'ต้องการเปิดระบบ ใช่หรือไม่';
            }
            if(confirm(str))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    </script>
<div id="txtSchool">
    <asp:Image ID="ImgLogo" runat="server" Width="30" Height="30" />
    <asp:LinkButton ID="txtSchoolName" CssClass="SchoolName" runat="server" OnClick="txtSchoolName_OnClick" ForeColor="White" ToolTip="แก้ไขรายละเอียดโรงเรียน"></asp:LinkButton>
    <asp:Button ID="Button1" runat="server" Text="" TabIndex="0" Width="0" Height="0" CssClass="dpnone" />
    <div style="float: right; padding: 0 5px 0 0;" tabindex="99">
        <asp:ImageButton ID="ImgBt1" runat="server" ImageUrl="../Image/On.gif" Width="30" Height="30" OnClientClick="return SystemConfirm(0);" OnClick="ImgBt1_OnClick" ToolTip="คลิ๊กเพื่อปิดระบบ" TabIndex="98" />
        <asp:ImageButton ID="ImgBt2" runat="server" ImageUrl="../Image/Off.gif" Width="30" Height="30" OnClientClick="return SystemConfirm(1);" OnClick="ImgBt2_OnClick" ToolTip="คลิ๊กเพื่อเปิดระบบ" TabIndex="99" />
    </div>
</div>

