<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="RptBudgetProjects.aspx.cs" Inherits="RptBudgetProjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function printRpt(mode, type) {
            var yearb = $get("<%=ddlSearchYear.ClientID%>").value;
            var pjid = $get("<%=ddlSearch.ClientID%>").value;
            var deptid = $get("<%=ddlSearchDept.ClientID%>").value;
            var yearmode = 0;

            <%--if ($get("<%=rbtBudgetYear.ClientID%>").checked == true) {
                yearmode = 1;
            }--%>

            if ($get("<%=ddlSearchDept.ClientID%>").selectedIndex == 0) {
                if ($get("<%=rbtType1.ClientID%>").checked) {
                if ($get("<%=cbDetail.ClientID%>").checked) {
                        window.open('../GtReport/Viewer.aspx?rpt=14&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=1' + '&rpttype=' + type);
                    }
                    else {
                        window.open('../GtReport/Viewer.aspx?rpt=14&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=0' + '&rpttype=' + type);
                    }
                }
                else {
                    if ($get("<%=cbDetail.ClientID%>").checked) {
                        window.open('../GtReport/Viewer.aspx?rpt=17&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=1' + '&rpttype=' + type);
                    }
                    else {
                        window.open('../GtReport/Viewer.aspx?rpt=17&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=0' + '&rpttype=' + type);
                    }
                }
            }
            else {
                if ($get("<%=cbDetail.ClientID%>").checked) {
                window.open('../GtReport/Viewer.aspx?rpt=14&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=1' + '&rpttype=' + type);
            }
            else {
                window.open('../GtReport/Viewer.aspx?rpt=14&yearB=' + yearb + '&id=' + pjid + '&deptid=' + deptid + '&yearmode=' + yearmode + '&ckmode=0' + '&rpttype=' + type);
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
                    รายงานงบประมาณคงเหลือโครงการ
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
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblType" class="spantxt">เลือกดูแบบ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:RadioButton ID="rbtType1" runat="server" Text="แบบโครงการเป็นหลัก" GroupName="rdo" Checked="true" ToolTip="ดูรายงานแบบโครงการเป็นหลัก" />
                                <asp:RadioButton ID="rbtType2" runat="server" Text="แบบหน่วยงานเป็นหลัก" GroupName="rdo" ToolTip="ดูรายงานแบบหน่วยงานเป็นหลัก" />
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="Span1" class="spantxt">รายละเอียดกิจกรรม : </span>
                            </div>
                            <div class="SearchF">
                                <asp:CheckBox ID="cbDetail" Text="เลือกเพื่อดูรายละเอียดกิจกรรม" ToolTip="เลือกเพื่อดูรายละเอียดกิจกรรม" runat="server" />
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
