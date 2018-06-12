<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportRoutine.aspx.cs" Inherits="ReportRoutine" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function printRpt(mode, type) {
            var ck;
            if ($get("<%=rbtreport1.ClientID%>").checked == true)
            { ck = 1; }
            if ($get("<%=rbtreport2.ClientID%>").checked == true)
            { ck = 2; }

            var yearb = document.getElementById("<%=ddlSearchYear.ClientID%>").value;
            var deptid = document.getElementById("<%=ddlSearchDept.ClientID%>").value;

            if (ck == 1) {
                window.open('../GtReport/Viewer.aspx?rpt=30&yearB=' + yearb + '&deptid=' + deptid + '&rpttype=' + type);
            }
            else {
                if (ck == 2) {
                    window.open('../GtReport/Viewer.aspx?rpt=54&yearB=' + yearb + '&deptid=' + deptid + '&rpttype=' + type);
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
                    รายงานงานประจำตามโครงสร้างการบริหารโรงเรียน
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
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">หน่วยงาน : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchDept" CssClass="ddlSearch" runat="server" Width="500px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">รูปแบบรายงาน : </span>
                            </div>
                            <div class="SearchF">
                                <div>
                                    <asp:RadioButton ID="rbtreport1" runat="server" Text=" รายงานงานประจำตามโครงสร้างการบริหารโรงเรียน"
                                        GroupName="rpt" Checked="true" />
                                </div>
                                 <div>
                                    <asp:RadioButton ID="rbtreport2" runat="server" Text=" รายงานแผนปฏิบัติการงานประจำ ตามโครงสร้างการบริหาร"
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
