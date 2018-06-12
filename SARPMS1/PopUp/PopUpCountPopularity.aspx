<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpCountPopularity.aspx.cs" Inherits="PopUpCountPopularity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server">
                        <Columns>
                            <Control:TemplateField HeaderText="ที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="5%" HorizontalAlign="Left" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ชื่อโครงการ">
                                <ItemTemplate>
                                        <%#Eval("ProjectsName")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="80%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบตั้งไว้">
                                <ItemTemplate>
                                    <%# Convert.ToDecimal(Eval("SetBudget").ToString()).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                            </Control:TemplateField>
                        </Columns>
                    </Control:DataGridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
