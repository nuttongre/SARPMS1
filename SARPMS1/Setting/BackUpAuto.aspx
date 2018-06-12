<%@ Page Language="C#" MasterPageFile="~/master/MasterNotLogin.master" AutoEventWireup="true"
    CodeFile="BackupAuto.aspx.cs" Inherits="BackupAuto" Title="Backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../scripts/ajax.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ClosePopUp() {
            window.opener.$get(Request('txtid')).value = Request('id');
            var fnc = eval(window.opener.eval('loadPageBackUp'));
            if (fnc) fnc();
            this.close();
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="contentPanel" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblResult" runat="server" />
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    DataBase BackUp
                </div>
                <div class="spaceDiv"></div>
                <div style="float: right">
                    <input id="btYes" type="button" class="btYes" value="      ตกลง" onclick="ClosePopUp();" runat="server" visible="false" />
                </div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="gwbackup" runat="server" Width="100%">
                        <Columns>
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
                    </Control:DataGridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
