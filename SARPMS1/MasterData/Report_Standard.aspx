<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Report_Standard.aspx.cs" Inherits="Report_Standard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function PrintReport()
    {
        var bgyear = document.getElementById("<%=ddlYearB.ClientID%>").value;
        var ck;
        
        (document.getElementById("<%=rbtreport1.ClientID%>").checked == true) ? ck = 1: ck = 2;

        window.open('../GtReport/Viewer.aspx?rpt=1&bgyear=' + bgyear +'&ck=' + ck);
    }
    </script>

    <table style="width: 100%;">
        <tr>
            <td colspan="2" class="headTable">
                <strong>รายงานเกณฑ์การประเมินตามมาตรฐาน</strong>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%">
                <table id="TableSearch" width="100%">
                    <tr>
                        <td colspan="2" align="right">
                            <asp:Button ID="btPrint" CssClass="btPrint" runat="server" ToolTip="พิมพ์รายงาน"
                                OnClick="btPrint_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">ปีการศึกษา : </span>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="ddl" ID="ddlYearB" Width="70px" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">รูปแบบรายงาน : </span>
                        </td>
                        <td>
                            <asp:RadioButton ID="rbtreport1" runat="server" Text="รายงานเกณฑ์การประเมินตามมาตรฐาน" GroupName="rpt" Checked="true" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            
                        </td>
                        <td>
                            <asp:RadioButton ID="rbtreport2" runat="server" Text="สรุปผลการประเมินคุณภาพในสถานสถานศึกษา" GroupName="rpt" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
