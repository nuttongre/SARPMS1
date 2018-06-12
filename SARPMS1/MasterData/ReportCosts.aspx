<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportCosts.aspx.cs" Inherits="ReportCosts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function PrintReport()
    {
        var bgyear = document.getElementById("<%=ddlYearB.ClientID%>").value;
        var deptid = document.getElementById("<%=ddlSearchDept.ClientID%>").value;
        var empid = document.getElementById("<%=ddlSearchEmp.ClientID%>").value;
        var ck;
        
        if(document.getElementById("<%=rbtreport1.ClientID%>").checked == true) 
        { ck = 1;}
        if(document.getElementById("<%=rbtreport2.ClientID%>").checked == true) 
        { ck = 2;}
       
        
        if (ck == 1) {
            window.open('../GtReport/Viewer.aspx?rpt=39&bgyear=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid);
        }
        if (ck == 2) {
            window.open('../GtReport/Viewer.aspx?rpt=40&bgyear=' + bgyear + '&ck=' + ck + '&deptid=' + deptid + '&empid=' + empid);
        }
    }
    </script>

    <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td colspan="2" class="headTable">
                    <strong>แบบรายงานต้นทุนศูนย์</strong>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <table id="TableSearch" width="100%">
                        <tr>
                            <td colspan="2" style="width: 100%; height: 50px;">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%; text-align: center;">
                                <table width="100%">
                                    <tr>
                                        <td align="center">
                                            <table class="tableSearch">
                                                <tr>
                                                    <td colspan="3" class="headSearch">
                                                        <span class="spantxt2 spansize14">เงื่อนไขการเรียกดู</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 10px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="SearchB">
                                                    </td>
                                                    <td class="SearchtxtF">
                                                        <span class="spantxt">ปีการศึกษา : </span>
                                                    </td>
                                                    <td class="SearchF">
                                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="SearchB">
                                                    </td>
                                                    <td class="SearchtxtF">
                                                        <span class="spantxt">หน่วยงาน : </span>
                                                    </td>
                                                    <td class="SearchF">
                                                        <asp:DropDownList ID="ddlSearchDept" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                                            OnSelectedIndexChanged="ddlSearchDept_SelectedIndexChanged" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="SearchB">
                                                    </td>
                                                    <td class="SearchtxtF">
                                                        <span class="spantxt">ผู้รับผิดชอบ : </span>
                                                    </td>
                                                    <td class="SearchF">
                                                        <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" style="height: 10px;">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 40%">
                                <span class="spantxt">รูปแบบรายงาน : </span>
                            </td>
                            <td>
                                <asp:RadioButton ID="rbtreport1" runat="server" Text=" รายงานต้นทุนกิจกรรมของศูนย์ต้นทุน"
                                    GroupName="rpt" Checked="true" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 40%">
                            </td>
                            <td>
                                <asp:RadioButton ID="rbtreport2" runat="server" Text=" รายงานต้นทุนนักเรียนต่อคนต่อปี"
                                    GroupName="rpt" />
                            </td>
                        </tr>                       
                        <tr>
                            <td colspan="2" style="width: 100%; text-align: center;">
                                <a class="btPrint" onclick="PrintReport();" title="เรียกดูรายงาน">
                                <img src="../Image/bt_print.gif" style="border: none; vertical-align: bottom;" />
                                เรียกดูรายงาน</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ajax:AjaxPanel>
</asp:Content>
