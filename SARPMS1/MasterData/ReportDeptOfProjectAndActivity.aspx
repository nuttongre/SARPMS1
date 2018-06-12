<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportDeptOfProjectAndActivity.aspx.cs" Inherits="ReportDeptOfProjectAndActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function printRpt(mode, type) {
            var yearb = document.getElementById("<%=ddlYearB.ClientID%>").value;
            var yeartype = 0;
            
            if (document.getElementById("<%=rbtBudgetYear.ClientID%>").checked == true) {
                yeartype = 1;
            }
            window.open('../GtReport/Viewer.aspx?rpt=45&bgyear=' + yearb + '&rpttype=' + type + '&yeartype=' + yeartype);
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
                    รายงานจำนวนโครงการ / กิจกรรมตามหน่วยงาน
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
                                <span class="spantxt">ปี : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch spantxt2" ID="ddlYearB" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">เลือกดูรายงานแบบ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:RadioButton ID="rbtStudyYear" CssClass="spantxt2" Text=" ปีการศึกษา" GroupName="rbt" Checked="true" runat="server" />
                                <asp:RadioButton ID="rbtBudgetYear" CssClass="spantxt2" Text=" ปีงบประมาณ" GroupName="rbt" runat="server" />
                            </div>
                        </div>
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
