<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ApproveAll.aspx.cs" Inherits="ApproveAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function Cancel() {
            location.href = "SarManage.aspx";
        }
    </script>
    <style type="text/css">
        .Yes {
            background: url(../Image/bt_Yes.gif) no-repeat left center;
            border: 0;
            height: 27px;
            cursor: pointer;
            font-size: large;
            color: #424242;
        }

        .No {
            background: url(../Image/bt_No.gif) no-repeat left center;
            border: 0;
            height: 27px;
            cursor: pointer;
            font-size: large;
            color: #424242;
        }
    </style>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    อนุมัติกิจกรรมทั้งหมด
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหาโครงการ / งาน</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF" style="width: 50%;">
                                <span class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF" style="width: 45%;">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                                </asp:DropDownList>
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
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="อนุมัติ" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img title="<%# (Convert.ToInt32(Eval("ApproveFlag"))== 0?"ยังไม่อนุมัติ":"อนุมัติแล้ว") %>"
                                        src='../Image/<%# (Convert.ToInt32(Eval("ApproveFlag"))== 0?"no":"ok") %>.png' />
                                </ItemTemplate>
                                <ItemStyle Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img style="border: none; cursor: pointer;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                        src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png'
                                        onclick="getPopUp(1, '<%#Eval("ActivityCode")%>')" />
                                </ItemTemplate>
                                <ItemStyle Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                <ItemTemplate>
                                    <%#Eval("ActivityName")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="65%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </Control:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <asp:Button ID="btSave" CssClass="Yes" runat="server" Text="       อนุมัติ" OnClick="btSave_Click"
                        ToolTip="อนุมัติ" />

                    <asp:Button ID="btCancel" CssClass="No" runat="server" Text="       ไม่อนุมัติ"
                        OnClick="btCancel_Click" ToolTip="ไม่อนุมัติ" />
                    <input type="button" class="btNo" value="      ออก" title="ออกไปเมนูหลัก" onclick="Cancel();" />
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
