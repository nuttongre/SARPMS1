<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="ReportCountActivity.aspx.cs"
    Inherits="ReportCountActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../CSS/CountAct.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function popup(id, syear) {
            dialogBox.show('../PopUp/PopUpActCount.aspx?id=' + id + '&syear=' + syear, 'รายชื่อกิจกรรม', '1000', '500', '#000', true, true);
        }
        function printRpt(mode, type) {
            var yearb = $get("<%=ddlYearB.ClientID%>").value;
            window.open('../GtReport/Viewer.aspx?rpt=37&yearB=' + yearb + '&deptid=&empid=&rpttype=' + type);
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
                    จำนวนกิจกรรมตามตัวบ่งชี้
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
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">พิมพ์ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
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
                        <asp:Repeater ID="rptStandard" runat="server" OnItemDataBound="rptStandard_ItemDataBound">
                            <ItemTemplate>
                                <%# gettxtSideName(Eval("SideName").ToString(), Eval("FullSideName").ToString()) %>
                                <ul class="ulStandard" style="padding-left:20px;"><li class="<%#Eval("CountAc").ToString() == "0" ? "imgRR" : "imgGG" %>">
                                    <span class="<%#Eval("CountAc").ToString() == "0" ? "spantxtCountRed" : "spantxtCountNormal" %>"
                                                        title="<%#Eval("CountAc")%>" onclick="popup('<%#Eval("StandardCode") %>', '<%# ddlYearB.SelectedValue %>');">
                                                        <%#Eval("CountAc")%></span>
                                    <span class="spantxtStandardAct" title="<%#Eval("StandardName") %>">
                                    <%#Eval("FullStandardName") %></span>
                                    <ul class="ulIndicators">
                                        <asp:Repeater ID="rptIndicators" runat="server">
                                            <ItemTemplate>
                                                <li style="list-style-image:url('../Image/MenuStlye/S09.png');">
                                                    <span class="spantxtIndicatorsAct" title="<%#Eval("IndicatorsName") %>">
                                                        <%#Eval("FullIndicatorsName") %></span>
                                                    <hr style="width:98%;" />
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                    <br />
                                </li></ul>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
