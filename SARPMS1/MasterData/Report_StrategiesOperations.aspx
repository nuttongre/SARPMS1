<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Report_StrategiesOperations.aspx.cs" Inherits="Report_StrategiesOperations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function printRpt(mode, type) {
            var ck;
            if ($get("<%=rbtreport1.ClientID%>").checked == true)
            { ck = 1; }
            if ($get("<%=rbtreport3.ClientID%>").checked == true)
            { ck = 3; }

            var yearB = $get("<%=ddlYearB.ClientID%>").value;
            var id = $get("<%=ddlStrategies.ClientID%>").value;

            if (ck == 1) {
                window.open('../GtReport/Viewer.aspx?rpt=21&id=' + id + '&yearB=' + yearB + '&rpttype=' + type);
            }
            else {
                if (ck == 3) {
                    window.open('../GtReport/Viewer.aspx?rpt=43&id=' + id + '&yearB=' + yearB + '&rpttype=' + type);
                }
            }
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
                    แบบรายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการเรียกดู</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">กลยุทธ์ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlStrategies" Width="400" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow" style="height:70px;">
                            <div class="SearchtxtF">
                                <span class="spantxt">รูปแบบรายงาน : </span>
                            </div>
                            <div class="SearchF">
                                <div>
                                    <asp:RadioButton ID="rbtreport1" runat="server" Text=" รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา"
                                        GroupName="rpt" Checked="true" />
                                </div>
                                <div>
                                    <asp:RadioButton ID="rbtreport3" runat="server" Text=" รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา แบบที่ 2"
                                        GroupName="rpt" />
                                </div>
                                <%--<div>
                                    <asp:RadioButton ID="rbtreport6" runat="server" Text=" รายงานการดำเนินงานตามกลยุทธ์ของสถานศึกษา แสดงวัตถุประสงค์เชิงกลยุทธ์"
                                        GroupName="rpt" />
                                </div>--%>
                                <%--<div>
                                    <asp:RadioButton ID="rbtreport4" runat="server" Text=" รายงานผลการดำเนินงานตามแผนปฏิบัติการประจำปี"
                                        GroupName="rpt" />
                                </div>--%>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
