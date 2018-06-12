<%@ Page Title="" Language="C#" MasterPageFile="~/master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Backup.aspx.cs" Inherits="Tools_Backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="contentPanel" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblResult" runat="server" />
            <div class="toolbar">
                <asp:LinkButton ID="btnBackup" runat="server" OnClick="btnBackup_Click" OnClientClick="return confirm('คุณต้องการสำรองข้อมูลใช่หรือไม่');"><img src="../Image/bt_BackUpDB.png" alt="" /> Backup Database</asp:LinkButton>

                <asp:LinkButton ID="btnRestore" runat="server" OnClick="btnRestore_Click" OnClientClick="return confirm('คุณต้องการนำข้อมูลเก่ามาใช่หรือไม่');"><img src="../Image/bt_RestoreDB.png" alt="" /> Restore Database</asp:LinkButton>

                <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" OnClientClick="return confirm('คุณต้องการลบรายการใช่หรือไม่');"><img src="../Image/bt_DelDB.png" alt="" /> ลบรายการ</asp:LinkButton>
            </div>
            <asp:GridView ID="gridContent" runat="server" AutoGenerateColumns="false" CssClass="gridview" HeaderStyle-CssClass="gridview_header" RowStyle-CssClass="gridview_rowitem" AlternatingRowStyle-CssClass="gridview_rowalt" SelectedRowStyle-CssClass="gridview_rowselected">
                <Columns>
                    <Control:TemplateField ItemStyle-Width="20px">
                        <ItemTemplate>
                            <input name="rdoItem" type="radio" value="<%#Container.DataItem%>" />
                        </ItemTemplate>
                    </Control:TemplateField>
                    <Control:TemplateField HeaderText="ลำดับ">
                        <ItemTemplate>
                            <%#Container.DisplayIndex+1%>
                        </ItemTemplate>
                    </Control:TemplateField>
                    <Control:TemplateField HeaderText="ชื่อ">
                        <ItemTemplate>
                            <%#FileName(Container.DataItem)%>
                        </ItemTemplate>
                    </Control:TemplateField>
                    <Control:TemplateField HeaderText="ขนาด">
                        <ItemTemplate>
                            <%#FileSize(Container.DataItem)%>
                        </ItemTemplate>
                    </Control:TemplateField>
                    <Control:TemplateField HeaderText="วันที่สร้าง">
                        <ItemTemplate>
                            <%#CreateDate(Container.DataItem)%>
                        </ItemTemplate>
                    </Control:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
