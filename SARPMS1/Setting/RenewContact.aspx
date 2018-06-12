<%@ Page Language="C#" MasterPageFile="~/master/MasterNotLogin.master" AutoEventWireup="true"
    CodeFile="RenewContact.aspx.cs" Inherits="RenewContact" Title="Backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../scripts/ajax.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ClosePopUp() {
            window.opener.$get(Request('txtid')).value = Request('id');
            var fnc = eval(window.opener.eval('loadPageBackUp'));
            if (fnc) fnc();
            this.close();
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="contentPanel" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblResult" runat="server" />
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    ต่อสัญญาเช่า Server
                </div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    วันที่หมดอายุ : <asp:Label ID="lblExpDate" runat="server"></asp:Label>
                    <div class="spaceDiv"></div>
                    <div style="width:140px; margin:0 auto;">
                    <asp:RadioButtonList ID="rbtlRenew" runat="server" RepeatColumns="2" Enabled="false"></asp:RadioButtonList></div>
                </div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <div class="classButton">
                        <div class="classBtSave">
                            <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                OnClientClick="return Cktxt(1);" ToolTip="บันทึก" />
                        </div>
                        <div class="classBtCancel">
                            <input type="button" class="btNo" value="      ไม่บันทึก / ปิดหน้านี้" title="ไม่บันทึก / ปิดหน้านี้" onclick="ClosePopUp();" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
