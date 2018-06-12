<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true" CodeFile="testSesService.aspx.cs" Inherits="Test_testSesService" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="AutoComplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <asp:DropDownList ID="ddlStrategies" CssClass="ddl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStrategies_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlProject" CssClass="ddl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlActivity" CssClass="ddl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlActivity_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlActivityDetail" CssClass="ddl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlActivityDetail_SelectedIndexChanged"></asp:DropDownList>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridViewBudget" runat="server" Width="100%" AutoGenerateColumns="False"
                        PageSize="300">
                        <Columns>
                            <Control:TemplateField HeaderText="ที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="รายการ">
                                <ItemTemplate>
                                    <%#Eval("ListName")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="17%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="จำนวน / หน่วย">
                                <ItemTemplate>
                                    <span class="spantxt2"><%# Convert.ToInt32(Eval("aAmount")).ToString("#,##0") %> <%# Eval("TotalP") %></span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ราคา / หน่วย">
                                <ItemTemplate>
                                    <span class="spantxt2"><%# Convert.ToInt32(Eval("aCost")).ToString("#,##0") %></span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="8%" />
                            </Control:TemplateField>
                            <Control:BoundField DataField="BudgetTypeName" HeaderText="ประเภทของเงิน" SortExpression="">
                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                            </Control:BoundField>
                        </Columns>
                    </Control:DataGridView>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

