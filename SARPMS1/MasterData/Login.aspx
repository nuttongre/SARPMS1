<%@ Page Language="C#" MasterPageFile="~/Master/MasterPage.master" AutoEventWireup="true"
    CodeFile="LogIn.aspx.cs" Inherits="LogIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link type="text/css" href="../CSS/login.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="loginBox">
                <div class="mainframe">
                    <div class="imglogo">
                        <asp:Image ID="ImgLogo" runat="server" Width="71px" Height="71px" />
                    </div>
                    <div class="divSchoolName">
                        <span id="lblSchoolName" class="lblSchoolName" runat="server"></span>
                    </div>
                    <div class="clear"></div>
                    <div class="frameLogin">
                        <div class="login">
                            <div class="inputrowH spacelogin">
                                <div class="SearchtxtF">
                                    <span class="loginSpan">ชื่อผู้ใช้ : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:TextBox CssClass="logintxt" ID="txtUserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtUserName"
                                        ErrorMessage="กรุณาป้อนชื่อผู้ใช้" ValidationGroup="Login"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="inputrowH spacelogin">
                                <div class="SearchtxtF">
                                    <span class="loginSpan">รหัสผ่าน : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:TextBox CssClass="logintxt" ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPassword"
                                        ErrorMessage="กรุณาป้อนรหัสผ่าน" ValidationGroup="Login"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="inputrowH spacelogin">
                                <div class="SearchtxtF">
                                </div>
                                <div class="SearchF">
                                    <asp:Button CssClass="btlogin" ID="btLogin" runat="server" OnClick="btLogin_Click"
                                        onmouseover="SearchBt(this,'btlogin2');" onmouseout="SearchBt(this,'btlogin');"
                                        ValidationGroup="Login" ToolTip="คลิ๊กเพื่อเข้าสู่ระบบ" />

                                </div>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                </div>
                                <div class="SearchF">
                                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Text="" Font-Bold="true"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="recomment">
                        <span class="txtRecomment" >โปรแกรมนี้ใช้ได้ใน Browser : 
                        <img src="../Image/Firefox.png" class="imgIE" />
                            FireFox,  
                        <img src="../Image/Chrome.png" class="imgIE" />
                            Chrome,                                     
                        <img src="../Image/ie_logo.png" class="imgIE" />
                            Internet Explorer 11.0 ขึ้นไป 
                        </span>
                    </div>
                    <div>
                        <div class="txtLastUpdateR">
                            <span id="lblLastUpdate" runat="server" class="txtLastUpdate"></span>
                        </div>
                        <div class="txtLastUpdateL">
                            <span id="lblVersion" runat="server" class="txtLastUpdate"></span>
                        </div>
                    </div>
                </div>
                <div class="ruler">
                    <div class="imgruler">
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
