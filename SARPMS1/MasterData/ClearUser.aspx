<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ClearUser.aspx.cs" Inherits="ClearUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function ckDelAll() {
            if (confirm('ต้องการลบรายการทั้งหมด ใช่หรือไม่ คำเตือน เป็นการลบข้อมูลจริงทั้งหมดจะไม่สามารถนำกลับมาได้อีก !!!')) {
                return true;
            }
            else {
                return false;
            }
        }
        function Cancel() {
            location.href = "SarManage.aspx";
        }
    </script>
    <style type="text/css">
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
                    ลบรายชื่อผู้ใช้งาน
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ลบรายชื่อผู้ใช้งาน</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="SearchTotal">
                            <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                                style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <asp:Button ID="btSave" CssClass="No" runat="server" Text="       ลบรายชื่อ" OnClick="btSave_Click" OnClientClick="return ckDelAll();"
                        ToolTip="ลบรายชื่อ" />
                    <input type="button" class="btNo" value="      ออก" title="ออกไปเมนูหลัก" onclick="Cancel();" />
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server" PageSize="20">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:BoundField DataField="UserName" HeaderText="UserName">
                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="ชื่อ">
                                <ItemTemplate>
                                        <%#Eval("EmpName") %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                            </Control:TemplateField>
                            <Control:BoundField DataField="DeptName" HeaderText="หน่วยงาน" SortExpression="DeptName">
                                <ItemStyle Width="25%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField DataField="UserRoleName" HeaderText="กลุ่มผู้ใช้" SortExpression="DeptName">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </Control:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
