<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Report_DevelopLevel.aspx.cs" Inherits="Report_DevelopLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function PrintReport()
    {
        var bgyear = document.getElementById("<%=ddlYearB.ClientID%>").value;
        window.open('../GtReport/Viewer.aspx?rpt=3&bgyear=' + bgyear);
    }
    </script>

    <table style="width: 100%;">
        <tr>
            <td colspan="2" class="headTable">
                <strong>รายงานเกณฑ์การประเมินตามตัวบ่งชี้เทียบกับระดับการพัฒนา</strong>
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
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
