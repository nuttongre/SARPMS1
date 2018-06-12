<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="ReportCountQACategory.aspx.cs"
    Inherits="ReportCountQACategory" %>
<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <link href="../CSS/CountAct.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function popup(id, syear) {
            dialogBox.show('../PopUp/PopUpCountQACategory.aspx?id=' + id + '&syear=' + syear, 'รายชื่อกิจกรรม', '1000', '500', '#000', true, true);
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
                    จำนวนกิจกรรมตามเกณฑ์รางวัลคุณภาพ
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
                                <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlYearB_OnSelectedChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div style="float: right;">
                    <span style="font-weight: bold; font-size: 12pt; color: Black;">จำนวนกิจกรรม</span>
                </div>
                <div class="spaceDiv"></div>
                <div id="actoutside">
                    <ul class="ulStandard">
                        <asp:Repeater ID="rptQA" runat="server" OnItemDataBound="rptQA_ItemDataBound">
                            <ItemTemplate>
                                <li style="list-style-image: url(../Image/icon/icon1.png)"><span class="spantxtStandardAct" title="<%#Eval("QACategoryName") %>">
                                    <%#Eval("FullQAName") %></span>
                                    <ul class="ulIndicators">
                                        <asp:Repeater ID="rptQASub" runat="server">
                                            <ItemTemplate>
                                                <li class="<%#Eval("CountAc").ToString() == "0" ? "imgR" : "imgG" %>">
                                                    <span class="<%#Eval("CountAc").ToString() == "0" ? "spantxtCountRed" : "spantxtCountNormal" %>"
                                                        title="<%#Eval("CountAc")%>" onclick="popup('<%#Eval("QACategorySubID") %>', '<%# ddlYearB.SelectedValue %>');">
                                                        <%#Eval("CountAc")%></span>
                                                    <span class="spantxtIndicatorsAct" title="<%#Eval("QACategorySubName") %>">
                                                        <%#Eval("FullQASubName") %></span>
                                                    <hr />
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                    <br />
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:content>
