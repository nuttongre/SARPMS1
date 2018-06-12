<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ClearAll.aspx.cs" Inherits="ClearAll" %>

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
                    ลบข้อมูลทั้งหมด
                </div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <span class="spantxt">ปีการศึกษา : </span>
                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="centerDiv">
                    <asp:Button ID="btSave" CssClass="No" runat="server" Text="       ลบข้อมูลทั้งหมด" OnClick="btSave_Click" OnClientClick="return ckDelAll();"
                        ToolTip="ลบทั้งหมด" />
                    <input type="button" class="btNo" value="      ออก" title="ออกไปเมนูหลัก" onclick="Cancel();" />
                </div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="จำนวนโครงการ">
                                <ItemTemplate>
                                    <%#Eval("CountProject")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" Width="30%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="จำนวนกิจกรรม">
                                <ItemTemplate>
                                    <%#Eval("CountActivity")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" Width="30%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="จำนวนตัวชี้วัด">
                                <ItemTemplate>
                                    <%#Eval("CountIndicators")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="center" Width="30%" />
                            </Control:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
