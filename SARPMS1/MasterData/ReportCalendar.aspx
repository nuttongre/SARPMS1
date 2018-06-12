<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="ReportCalendar.aspx.cs"
    Inherits="ReportCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

    function PrintReport()
    {
        var yearb = document.getElementById("<%=ddlYearB.ClientID%>").value;   
        var monthB = document.getElementById("<%=ddlMonth.ClientID%>").value;
        var deptid = document.getElementById("<%=ddlSearchDept.ClientID%>").value;
        var empid = document.getElementById("<%=ddlSearchEmp.ClientID%>").value;    
        
        window.open('../GtReport/Viewer.aspx?rpt=27&yearB='+yearb+'&deptid='+deptid+'&empid='+empid+'&monthB='+monthB);
    }
    </script>

    <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
        <div>
            <asp:Image ID="Img1" runat="server" Visible="false" />
        </div>
        <div>
            <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
        </div>
        <div class="headTable"  style="margin: 4px 2px 2px 2px;">
            <p> ปฏิทินปฏิบัติงาน</p>
        </div>
        <br />
        <div style="min-height: 30px; width: 100%;">
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
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="SearchB">
                                </td>
                                <td class="SearchtxtF">
                                    <span class="spantxt">เดือน : </span>
                                </td>
                                <td class="SearchF">
                                    <asp:DropDownList ID="ddlMonth" CssClass="ddlSearch" runat="server" Width="350px" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
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
                                    <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" Width="350px" AutoPostBack="true" OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged">
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
                <tr>
                    <td colspan="2" style="text-align: center; width: 100%;">
                        <Control:DataGridView ID="GridView1" runat="server">
                            <Columns>
                                <Control:TemplateField HeaderText="ลำดับที่">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="วันที่">
                                    <ItemTemplate>
                                        <%# Convert.ToDateTime(Eval("SDate")).ToString("dd/MM/yyyy") + " - " + Convert.ToDateTime(Eval("EDate")).ToString("dd/MM/yyyy") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20%" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="กิจกรรม">
                                    <ItemTemplate>
                                        <%#Eval("ActivityName") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35%" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="หน่วยงาน">
                                    <ItemTemplate>
                                        <%#Eval("DeptName") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="ผู้รับผิดชอบ">
                                    <ItemTemplate>
                                        <%#Eval("EmpName") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                </Control:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Right" />
                        </Control:DataGridView>
                    </td>
                </tr>
            </table>
        </div>
    </ajax:AjaxPanel>
</asp:Content>
