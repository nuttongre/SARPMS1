<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="SarManage.aspx.cs" Inherits="SarManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function ckPassword() {
            if (document.getElementById("<%=txtPassword.ClientID%>").value == "") {
                document.getElementById("ErrorPassword").style.display = "block";
                return false;
            }
            else {
                document.getElementById("ErrorPassword").style.display = "none";
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
                    ตั้งค่าสำหรับเจ้าหน้าที่
                </div>
                <div class="spaceDiv"></div>
                <div id="table" class="PageManageDiv">
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">ป้อนรหัสผ่านสำหรับเจ้าหน้าที่ : </span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox CssClass="logintxt" TextMode="Password" ID="txtPassword"
                                runat="server"></asp:TextBox>&nbsp;
                            <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       ตกลง" OnClick="btSave_Click" OnClientClick="return ckPassword();" ToolTip="ตกลง" />
                            <span id="ErrorPassword" class="ErrorMsg">กรุณาป้อนรหัสผ่าน</span>
                            <asp:Label ID="lblCkPassword" ForeColor="Red" runat="server" Visible="false" Text="รหัสผ่านไม่ถูกต้อง (หน้านี้ใช้ได้เฉพาะเจ้าหน้าที่เท่านั้น)"></asp:Label>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div id="tblMenu" class="SearchTable" runat="server" visible="false">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เมนูจัดการต่าง ๆ</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link4" runat="server">
                                    <img src="../Image/MenuStlye/S0.png" style="border: none; padding-right: 5px;" />
                                    ตั้งค่าระบบ</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link1" runat="server">
                                    <img src="../Image/MenuStlye/S4.png" style="border: none; padding-right: 5px;" />
                                    รายชื่อโรงเรียนที่ติดตั้งระบบ</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link2" runat="server">
                                    <img src="../Image/MenuStlye/S7.png" style="border: none; padding-right: 5px;" />
                                    อนุมัติกิจกรรมทั้งหมด</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link5" runat="server">
                                    <img src="../Image/MenuStlye/S2.png" style="border: none; padding-right: 5px;" />
                                    ลบรายการทั้งหมด</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link6" runat="server">
                                    <img src="../Image/MenuStlye/delete.gif" style="border: none; padding-right: 5px;" />
                                    ลบรายชื่อผู้ใช้งาน</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link7" runat="server">
                                    <img src="../Image/MenuStlye/S001.png" style="border: none; padding-right: 5px;" />
                                    ลบตัวชี้วัดที่ค้าง</a>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <a id="Link3" runat="server">
                                    <img src="../Image/MenuStlye/S07.gif" style="border: none; padding-right: 5px;" />
                                    จัดการสิทธิ์เมนู</a>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
