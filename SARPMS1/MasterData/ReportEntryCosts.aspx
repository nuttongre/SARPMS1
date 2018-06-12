<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportEntryCosts.aspx.cs" Inherits="ReportEntryCosts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function printRpt(mode, type) {
            var yearb = $get("<%=ddlSearchYear.ClientID%>").value;
            var pjid = $get("<%=ddlSearch.ClientID%>").value;
            var deptid = $get("<%=ddlSearchDept.ClientID%>").value;
            var yearmode = 0;
            var ck;

            if ($get("<%=rbtreport1.ClientID%>").checked == true)
            { ck = 1; }
            if ($get("<%=rbtreport2.ClientID%>").checked == true)
            { ck = 2; }

            <%--if ($get("<%=rbtBudgetYear.ClientID%>").checked == true) {
                yearmode = 1;
            }--%>
            if (ck == 1) {
                window.open('../GtReport/Viewer.aspx?rpt=29&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&rpttype=' + type);
            }
            if (ck == 2) {
                window.open('../GtReport/Viewer.aspx?rpt=45&bgyear=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&rpttype=' + type + '&yearmode=' + yearmode);
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
                    รายงานรายละเอียดแผนการใช้จ่ายเงิน
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการเรียกดู</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <%--<div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ประเภทปี : </span>
                            </div>
                            <div class="SearchF">
                                <asp:RadioButton ID="rbtStudyYear" CssClass="spantxt2" Text=" ปีการศึกษา" GroupName="rbt" Checked="true" runat="server" AutoPostBack="true" OnCheckedChanged="rbtYearType" />
                                <asp:RadioButton ID="rbtBudgetYear" CssClass="spantxt2" Text=" ปีงบประมาณ" GroupName="rbt" runat="server" AutoPostBack="true" OnCheckedChanged="rbtYearType" /> 
                            </div>
                        </div>--%>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                            </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">โครงการ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" Width="500px">
                                            </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">หน่วยงานหลัก : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainDept" Width="500px" runat="server"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainDept_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">หน่วยงานรอง : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainSubDept" Width="500px" runat="server"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainSubDept_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">หน่วยงาน : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchDept" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchDept_SelectedIndexChanged" Width="500px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow" style="height:auto;">
                            <div class="SearchtxtF">
                                <span class="spantxt">รูปแบบรายงาน : </span>
                            </div>
                            <div class="SearchF" style="height:auto;">
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport1" runat="server" Text=" รายงานรายละเอียดแผนการใช้จ่ายเงิน"
                                        GroupName="rpt" Checked="true" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport2" runat="server" Text=" รายงานรายละเอียดการใช้จ่ายเงินตามหน่วยงาน จำแนกตามโครงการ/กิจกรรม"
                                        GroupName="rpt" />
                                </div>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
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
