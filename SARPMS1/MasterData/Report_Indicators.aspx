<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Report_Indicators.aspx.cs" Inherits="Report_Indicators" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function printRpt(mode, type) {
            var bgyear = document.getElementById("<%=ddlYearB.ClientID%>").value;
            var deptid = document.getElementById("<%=ddlSearchDept.ClientID%>").value;
            var empid = document.getElementById("<%=ddlSearchEmp.ClientID%>").value;
            var ck;

            if (document.getElementById("<%=rbtreport1.ClientID%>").checked == true)
            { ck = 1; }
            if (document.getElementById("<%=rbtreport2.ClientID%>").checked == true)
            { ck = 2; }
            if (document.getElementById("<%=rbtreport3.ClientID%>").checked == true)
            { ck = 3; }
            if (document.getElementById("<%=rbtreport4.ClientID%>").checked == true)
            { ck = 4; }
            if (document.getElementById("<%=rbtreport6.ClientID%>").checked == true)
            { ck = 6; }
            if (document.getElementById("<%=rbtreport7.ClientID%>").checked == true)
            { ck = 7; }

            if (ck == 1 || ck == 3) {
                window.open('../GtReport/Viewer.aspx?rpt=1&bgyear=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid + '&rpttype=' + type);
            }
            else {
                if (ck == 6) {
                    //window.open('../GtReport/Viewer.aspx?rpt=8&bgyear=' + bgyear );  // ck = 5
                    window.open('../GtReport/Viewer.aspx?rpt=22&bgyear=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid + '&rpttype=' + type);
                }
                else {
                    if (ck == 7) {
                        window.open('../GtReport/Viewer.aspx?rpt=37&yearB=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid + '&rpttype=' + type);
                    }
                    else {
                        window.open('../GtReport/Viewer.aspx?rpt=2&bgyear=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid + '&rpttype=' + type);
                    }
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
                    แบบรายงานผลประเมินตามเกณฑ์
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
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ผู้รับผิดชอบ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged" Width="350px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow" style="height:auto;">
                            <div class="SearchtxtF">
                                <span class="spantxt">รูปแบบรายงาน : </span>
                            </div>
                            <div class="SearchF" style="height:auto;">
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport1" runat="server" Text=" แบบรายงานผลประเมินตามเกณฑ์มาตรฐาน รูปแบบที่ 1"
                                        GroupName="rpt" Checked="true" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport3" runat="server" Text=" แบบรายงานผลประเมินตามเกณฑ์มาตรฐาน รูปแบบที่ 2"
                                        GroupName="rpt" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport2" runat="server" Text=" แบบรายงานผลประเมินตามเกณฑ์ตัวบ่งชี้ รูปแบบที่ 1"
                                        GroupName="rpt" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport4" runat="server" Text=" แบบรายงานผลประเมินตามเกณฑ์ตัวบ่งชี้ รูปแบบที่ 2"
                                        GroupName="rpt" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport6" runat="server" Text=" แบบรายงานผลการดำเนินงานตามมาตรฐานการศึกษาของสถานศึกษา"
                                        GroupName="rpt" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport5" Visible="false" runat="server" Text=" โครงการ/กิจกรรมที่วางแผนดำเนินการ  เพื่อให้บรรลุเป้าหมายการจัดการศึกษา"
                                        GroupName="rpt" />
                                </div>
                                <div style="float: left;">
                                    <asp:RadioButton ID="rbtreport7" runat="server" Text=" รายงานจำนวนกิจกรรมตามตัวบ่งชี้"
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
