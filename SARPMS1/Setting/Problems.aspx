<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Problems.aspx.cs" Inherits="Problems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function Cktxt(m) {
            var ck = 0;

            var txtSubject = $get("<%=txtSubject.ClientID%>");
            var ErrorSubject = $get("ErrorSubject");
            var txtProblems = $get("<%=txtProblems.ClientID%>");
            var ErrorProblems = $get("ErrorProblems");
            var txtFrom = $get("<%=txtFrom.ClientID%>");
            var ErrorFrom = $get("ErrorFrom");
            var txtSchoolName = $get("<%=txtSchoolName.ClientID%>");
            var ErrorSchoolName = $get("ErrorSchoolName");
            var txtTel = $get("<%=txtTel.ClientID%>");
            var ErrorTel = $get("ErrorTel");
            var txtEmail = $get("<%=txtEmail.ClientID%>");
            var ErrorEmail = $get("ErrorEmail");

            ck += ckTxtNull(m, txtEmail, ErrorEmail);
            ck += ckTxtNull(m, txtTel, ErrorTel);
            ck += ckTxtNull(m, txtSchoolName, ErrorSchoolName);
            ck += ckTxtNull(m, txtFrom, ErrorFrom);
            ck += ckTxtNull(m, txtProblems, ErrorProblems);
            ck += ckTxtNull(m, txtSubject, ErrorSubject);


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
                    แจ้งปัญหาการใช้งาน
                </div>
                <div class="spaceDiv"></div>
                <div id="table1" class="PageManageDiv">
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">เรื่อง :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtSubject" CssClass="txtBoxL txt400" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorSubject" class="ErrorMsg">กรุณาป้อนเรื่อง</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">ปัญหา :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtProblems" CssClass="txtBoxL txt400" TextMode="MultiLine" Height="200px" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorProblems" class="ErrorMsg">กรุณาป้อนปัญหา</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">ผู้แจ้ง :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtFrom" CssClass="txtBoxL txt400" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorFrom" class="ErrorMsg">กรุณาป้อนผู้แจ้ง</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">โรงเรียน :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtSchoolName" CssClass="txtBoxL txt400" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorSchoolName" class="ErrorMsg">กรุณาป้อนโรงเรียน</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">เบอร์โทร :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtTel" CssClass="txtBoxL txt400" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorTel" class="ErrorMsg">กรุณาป้อนเบอร์โทร</span>
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">E-mail :</span>
                        </div>
                        <div class="divB_Head">
                            <asp:TextBox ID="txtEmail" CssClass="txtBoxL txt400" runat="server"></asp:TextBox>
                            <span class="ColorRed">*</span> <span id="ErrorEmail" class="ErrorMsg">กรุณาป้อน e-mail</span>
                        </div>
                    </div>
                    <div class="spaceDiv"></div>
                    <div class="centerDiv">
                        <div class="classButton">
                            <div class="classBtSave">
                                <asp:Button ID="btSave" CssClass="btYes" Text="       ส่งข้อความ" runat="server" OnClick="btSave_Click"
                                    OnClientClick="return Cktxt(1);" />
                            </div>
                            <div class="classBtCancel">
                                <asp:Button ID="btCancel" CssClass="btNo" Text="       ยกเลิก" runat="server" OnClick="btCancel_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div class="centerDiv">
                        <span style="color: black;">*** กรุณาป้อนข้อมูลให้ครบทุกช่อง  เพื่อการติดต่อกลับจากบริษัท  ขอบคุณครับ ***</span>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
