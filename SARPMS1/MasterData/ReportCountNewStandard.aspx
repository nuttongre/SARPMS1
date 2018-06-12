<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="ReportCountNewStandard.aspx.cs"
    Inherits="ReportCountNewStandard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../CSS/CountAct.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function popup(id, syear) {
            dialogBox.show('../PopUp/PopUpCountProjectsByKSN.aspx?mode=P8&id=' + id + '&syear=' + syear, 'รายชื่อโครงการ', '1000', '500', '#000', true, true);
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
                    จำนวนโครงการตามมาตรฐาน
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการค้นหา</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="Span1" runat="server" class="spantxt">รูปแบบการแสดงผล : </span>
                            </div>
                            <div class="SearchF">
                                <asp:RadioButtonList ID="rbtlStatus" runat="server" RepeatColumns="2" AutoPostBack="true" OnSelectedIndexChanged="rbtlStatus_SelectedIndexChanged"></asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlYearB_OnSelectedChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div id="divddlGraph" class="inputrow" runat="server">
                            <div class="SearchtxtF">
                                <span class="spantxt">ประเภทกราฟ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlType" CssClass="ddlSearch" Width="150px" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div id="divText" runat="server">
                    <div style="float: right;">
                        <span style="font-weight: bold; font-size: 12pt; color: Black;">จำนวนโครงการ</span>
                    </div>
                    <div class="spaceDiv"></div>
                    <div id="actoutside">
                        <ul class="ulStandard">
                            <asp:Repeater ID="rptStandard" runat="server">
                                <ItemTemplate>
                                    <li class="<%#Eval("CountAc").ToString() == "0" ? "imgR" : "imgG" %>">
                                        <div style="width: 98%;">
                                            <span class="<%#Eval("CountAc").ToString() == "0" ? "spantxtCountRed" : "spantxtCountNormal" %>"
                                                title="<%#Eval("CountAc")%>" onclick="popup('<%#Eval("StandardCode") %>', '<%# ddlYearB.SelectedValue %>');">
                                                <%#Eval("CountAc")%></span>
                                            <span class="spantxtStandardAct" title="<%#Eval("StandardName") %>">
                                                <%#Eval("FullStandardName") %></span>
                                            <hr />
                                            <br />
                                        </div>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                <div id="divGraph" runat="server">
                    <div class="spaceDiv"></div>
                    <div class="centerDiv">
                        <div id="graphPnl" runat="server"></div>
                        <%--<div style="position: absolute; left: 0; top: 92px; width: 100%; height: 17px; z-index: 0; background-color: #fff; border-top: solid 1px #aaa; border-left: solid 1px #aaa; border-right: solid 1px #aaa;"></div>--%>
                        <%--<div style="position: absolute; left: 338; top: 20; width: 70%; height: 17px; z-index: 0;
                            background-color: #fff; border-top: solid 1px #fff;">
                        </div>--%>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
