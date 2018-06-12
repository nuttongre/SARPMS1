<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="EditPassword.aspx.cs" Inherits="EditPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function Cancel() {
            location.href = "EmployeeView.aspx";
        }
        function Cktxt(m) {
            var ck = 0;

            var txtOldPassword = $get("<%=txtOldPassword.ClientID%>");
            var ErrorOldPassword = $get("ErrorOldPassword");
            var txtNewPassword = $get("<%=txtNewPassword.ClientID%>");
            var ErrorNewPassword = $get("ErrorNewPassword");
            var txtConfirmPassword = $get("<%=txtConfirmPassword.ClientID%>");
            var ErrorConfirmPassword = $get("ErrorConfirmPassword");

            ck += ckTxtNull(m, txtConfirmPassword, ErrorConfirmPassword);
            ck += ckTxtNull(m, txtNewPassword, ErrorNewPassword);
            ck += ckTxtNull(m, txtOldPassword, ErrorOldPassword);

            if ($get("<%=txtNewPassword.ClientID%>").value != $get("<%=txtConfirmPassword.ClientID%>").value) {
                $get("ErrorPasswordAndConfirm").style.display = "block";
                ck += 1;
            }
            else {
                $get("ErrorPasswordAndConfirm").style.display = "none";
            }

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    แก้ไขรหัสผ่าน
                </div>
                <div class="spaceDiv"></div>
                <div id="table1" class="PageManageDiv">
                    <div class="inputrowH">
                        <div class="divF_Head" style="width:45%;">
                            <span class="spantxt">รหัสผ่านเดิม :</span>
                        </div>
                        <div class="divB_Head" style="width:45%;">
                            <asp:TextBox CssClass="txtBox txt200" ID="txtOldPassword" runat="server" TextMode="Password"
                                MaxLength="20"></asp:TextBox>
                            <span class="ErrorMsg">*</span> <span id="ErrorOldPassword" class="ErrorMsg">กรุณาป้อนรหัสผ่านเดิม</span>
                            <asp:Label ID="lblErrorOldPassword" runat="server" ForeColor="Red" Text="รหัสผ่านเดิมไม่ถูกต้อง"
                                Visible="False"></asp:Label>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head" style="width:45%;">
                            <span class="spantxt">รหัสผ่านใหม่ :</span>
                        </div>
                        <div class="divB_Head" style="width:45%;">
                            <asp:TextBox CssClass="txtBox txt200" ID="txtNewPassword" runat="server" TextMode="Password"
                                MaxLength="20"></asp:TextBox>
                            <span class="ErrorMsg">*</span> <span id="ErrorNewPassword" class="ErrorMsg">กรุณาป้อนรหัสผ่านใหม่</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head" style="width:45%;">
                            <span class="spantxt">รหัสผ่านใหม่อีกครั้ง :</span>
                        </div>
                        <div class="divB_Head" style="width:45%;">
                            <asp:TextBox CssClass="txtBox txt200" ID="txtConfirmPassword" runat="server" TextMode="Password"
                                MaxLength="20"></asp:TextBox>
                            <span class="ErrorMsg">*</span> <span id="ErrorConfirmPassword" class="ErrorMsg">กรุณา
                        ป้อนรหัสผ่านใหม่อีกครั้ง</span>
                            <span id="ErrorPasswordAndConfirm" class="ErrorMsg">รหัสผ่านไม่ถูกต้อง</span>
                        </div>
                    </div>
                    <div class="spaceDiv"></div>
                    <div class="centerDiv">
                        <div class="classButton">
                            <div class="classBtSave">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก"
                                    OnClick="btSave_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกการแก้ไขรหัสผ่าน" />
                            </div>
                            <div class="classBtCancel">
                                <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกการแก้ไขรหัสผ่าน" onclick="Cancel();" />
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
