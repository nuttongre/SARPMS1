<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="EmpByDepartmentView.aspx.cs" Inherits="EmpByDepartmentView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    แสดงผู้ใช้ระบบตามหน่วยงาน
                </div>
                <div style="float: left;">
                    <img id="ImgBack" src="../Image/ImgBack2.gif" class="imgback" onclick="location.href='Department.aspx'"
                        onmouseover="GetPic(this, 1);" onmouseout="GetPic(this, 2);" />
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหาผู้ใช้ตามหน่วยงาน</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">เลือกหน่วยงาน :</span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="True" CssClass="ddlSearch"
                                    OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" Width="350px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">คำค้นหา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                    CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                    ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="SearchTotal">
                            <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                                style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </Control:TemplateField>
                            <Control:BoundField DataField="UserName" HeaderText="UserName">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField DataField="EmpName" HeaderText="ชื่อ">
                                <ItemStyle Width="40%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField DataField="UserRoleName" HeaderText="กลุ่มผู้ใช้">
                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                            </Control:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
