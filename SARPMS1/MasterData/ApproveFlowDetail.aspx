<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ApproveFlowDetail.aspx.cs" Inherits="ApproveFlowDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "ApproveFlowDetail.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "ApproveFlowDetail.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "ApproveFlowDetail.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "ApproveFlowDetail.aspx";
        }
        function Cktxt(m) {
            var ck = 0;
            var ddlApproveStep = $get("<%=ddlApproveStep.ClientID%>");
            var ErrorApproveStep = $get("ErrorApproveStep");
            var ddlUserRole = $get("<%=ddlUserRole.ClientID%>");
            var ErrorUserRole = $get("ErrorUserRole");
            var ddlPosition = $get("<%=ddlPosition.ClientID%>");
            var ErrorApprovePosition = $get("ErrorApprovePosition");
            var ddlApproveFlow = $get("<%=ddlApproveFlow.ClientID%>");
            var ErrorApproveFlow = $get("ErrorApproveFlow");
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");

            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckDdlNull(m, ddlPosition, ErrorPosition);
            ck += ckDdlNull(m, ddlUserRole, ErrorUserRole);
            ck += ckDdlNull(m, ddlApproveStep, ErrorApproveStep);
            ck += ckDdlNull(m, ddlApproveFlow, ErrorApproveFlow);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
        function deleteImg() {
            if (confirm('ต้องการลบภาพนี้ ใช่หรือไม่')) {
                return true;
            }
            else {
                return false;
            }
        }
        function ckUpload() {
            var fiUpload = document.getElementById("<%=fiUpload.ClientID%>").value;
            if (fiUpload == "") {
                alert("กรุณาเลือกไฟล์");
                return;
            }
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="pageDiv">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="headTable">
            ลำดับขั้นตอนการอนุมัติ
        </div>
        <div class="spaceDiv"></div>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="view" runat="server">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหารายการ</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานรอง : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged" Width="330">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">คำค้นหา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:TextBox CssClass="txtSearch txt300" ID="txtSearch" runat="server"></asp:TextBox><asp:Button
                                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
                                    </div>
                                </div>
                                <%--<div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">พิมพ์รายงาน : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                                    </div>
                                </div>--%>
                                <div class="spaceDiv"></div>
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
                            <div class="btAddDiv">
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" Text="       สร้างรายการใหม่" OnClientClick="AddItem();"
                                    ToolTip="สร้างรายการใหม่" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" PageSize="30">
                                <Columns>
                                    <Control:BoundField HeaderText="ลำดับที่" DataField="Sort">
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ขั้นตอน">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("ApproveFlowDetailID").ToString(), Eval("ApproveStepName").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ตำแหน่ง">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("ApproveFlowDetailID").ToString(), Eval("ApprovePositionName").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="30%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="กลุ่มผู้ใช้งาน">
                                        <ItemTemplate>
                                            <%# Eval("UserRoleName").ToString() %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ตัวเช็คค่า">
                                        <ItemTemplate>
                                            <%# Eval("ckStatus").ToString() %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("ApproveFlowDetailID") %>');">
                                                <img alt="" style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("ApproveFlowDetailID") %>');">
                                                <img alt="" style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:View>
            <asp:View ID="edit" runat="server">
                <div id="table1" class="PageManageDiv">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงานรอง : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:HiddenField ID="hdfApproveFlowDetailID" runat="server" />
                                    <asp:DropDownList ID="ddlApproveFlow" CssClass="ddl txt300" runat="server" OnSelectedIndexChanged="ddlApproveFlow_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorApproveFlow" class="ErrorMsg">กรุณาเลือก Flow การอนุมัติ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ขั้นตอน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlApproveStep" CssClass="ddl txt300" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorApproveStep" class="ErrorMsg">กรุณาเลือกขั้นตอน</span>
                                </div>
                            </div>
                            <div class="inputrowH" style="height: auto;">
                                <div class="divF_Head">
                                    <span class="spantxt">กลุ่มผู้ใช้ :</span>
                                </div>
                                <div class="divB_Head" style="height: auto;">
                                    <asp:DropDownList CssClass="ddl" ID="ddlUserRole" runat="server" Width="300" AutoPostBack="true" OnSelectedIndexChanged="ddlUserRole_OnSelectedIndexChanged">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorUserRole" class="ErrorMsg">กรุณาเลือกกลุ่มผู้ใช้</span>
                                </div>
                            </div>
                            <div class="inputrowH" style="height: auto;">
                                <div class="divF_Head">
                                    <span class="spantxt">ตำแหน่ง :</span>
                                </div>
                                <div class="divB_Head" style="height: auto;">
                                    <asp:DropDownList CssClass="ddl" ID="ddlPosition" runat="server" Width="300">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorPosition" class="ErrorMsg">กรุณาเลือกตำแหน่ง</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">จำนวนงบประมาณเกิน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtBudgetLimit" CssClass="txtBoxNum txt100" onkeypress="return KeyNumber(event);" MaxLength="10" runat="server" Text="0"></asp:TextBox>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorBudgetLimit" class="ErrorMsg">กรุณาป้อนจำนวนงบประมาณเกิน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวเช็คสถานะ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlckStatus" CssClass="ddl" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">รูปลายเซ็นต์</span>
                                </div>
                                <div class="divB_Head">
                                    <div style="float: left; width: 100px; height: 75px;">
                                        <div style="float: right;">
                                            <asp:ImageButton ID="ImgBt" ImageUrl="../Image/delete.gif" runat="server" ToolTip="ลบภาพนี้" OnClick="DeleteImg" OnClientClick="return deleteImg();" />
                                        </div>
                                        <div style="float: left; border: dotted 2px gray; float: left; width: 71px; height: 71px; padding: 3px 3px;">
                                            <asp:Image ID="imgPicture" Width="71" Height="71" runat="server" />
                                        </div>
                                    </div>
                                    <div style="float: left; padding-left: 100px;">
                                        <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                                    </div>
                                    <div class="clear"></div>
                                    <div style="float: left; color: gray; margin-left: 90px; font-size: 5px;">ขนาดไฟล์รูปที่แนะนำ 70 x 70 pixel</div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="inputrowH">
                        <div class="divF_Head"></div>
                        <div class="divB_Head">
                            <asp:FileUpload ID="fiUpload" runat="server" CssClass="txtBox"></asp:FileUpload>
                            <%--<input id="btnUpload" type="button" class="btUpload" onserverclick="btnUpload_OnClick" onclick="ckUpload();" value="      Upload" runat="server" />--%>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ลำดับที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtSort" CssClass="txtBoxNum txt50" Width="70px" MaxLength="2" runat="server" onkeypress="return KeyNumber(event);"></asp:TextBox>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
                                </div>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Label ID="lblCreate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="centerDiv">
                                <asp:Label ID="lblUpdate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="spaceDiv"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="centerDiv">
                        <div class="classButton">
                            <div class="classBtSave">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                    OnClientClick="return Cktxt(1);" ToolTip="บันทึกรายการนี้" />
                                <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างรายการใหม่"
                                    OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกรายการนี้และสร้างรายการใหม่" />
                            </div>
                            <div class="classBtCancel">
                                <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึก" onclick="Cancel();" />
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server" Visible="false">
                                    <Columns>
                                        <Control:BoundField HeaderText="รายการที่" DataField="Sort">
                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="ตำแหน่ง" DataField="ApprovePositionName">
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="กลุ่มผู้ใช้" DataField="UserRoleName">
                                            <ItemStyle Width="45%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
