<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="GraphBudget.aspx.cs" Inherits="GraphBudget" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="headTable">
                    กราฟงบประมาณในแต่ละปี
                </div>
                <div class="spaceDiv"></div>
                <%--<div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการแสดงผล</span>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>--%>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <div id="divGraph1" class="divGraph" style="border: solid 5px #949494; height: 500px; width: 98%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            กราฟงบประมาณในแต่ละปี
                        </div>
                        <div>
                            <div id="graphPnl1" runat="server"></div>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
