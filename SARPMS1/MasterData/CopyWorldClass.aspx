<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="CopyWorldClass.aspx.cs" Inherits="CopyWorldClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function Cancel() {
            location.href = "CopyWorldClass.aspx";
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
                    คัดลอกด้าน/มาตรฐานเกณฑ์โรงเรียนมาตรฐานสากล
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">คัดลอก</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF" style="width: 50%;">
                                        <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                    </div>
                                    <div class="SearchF" style="width: 30%;">
                                        <asp:TextBox ID="txtNextYear" CssClass="txtBox txtBoxNoBorder spantxt2" Width="60" ReadOnly="true"
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="centerDiv" style="padding: 15px 0px;">
                                    <span style="color: #2b2a2a; font-size: 16pt; font-weight: bold;">คัดลอกจาก</span>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF" style="width: 50%;">
                                        <span id="lblYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                    </div>
                                    <div class="SearchF" style="width: 30%;">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="centerDiv">
                                    <div class="classButton">
                                        <div class="classBtSave">
                                            <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       คัดลอก" OnClick="btSave_Click"
                                                ToolTip="คัดลอกด้าน/มาตรฐานสากล" />
                                        </div>
                                        <div class="classBtCancel">
                                            <input type="button" class="btNo" value="      ไม่คัดลอก" title="ไม่คัดลอกด้าน/มาตรฐานสากล" onclick="Cancel();" />
                                        </div>
                                    </div>
                                </div>
                                <div class="clear"></div>
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
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server">
                                <Columns>
                                    <Control:BoundField HeaderText="ปี" DataField="StudyYear">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="ด้านมาตรฐานสากล" DataField="WorldClassSide">
                                        <ItemStyle Width="45%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="มาตรฐานสากล" DataField="WorldClassStandard">
                                        <ItemStyle Width="45%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
