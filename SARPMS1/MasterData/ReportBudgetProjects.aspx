<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportBudgetProjects.aspx.cs" Inherits="ReportBudgetProjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function getPopUp(inx, id) {
            if (inx == 1) {
                dialogBox.show('../PopUp/PopUpActivityDetail.aspx?id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true);
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
                    งบประมาณคงเหลือโครงการ
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหาโครงการ / กิจกรรม</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblYear" class="spantxt">ปีงบประมาณ : </span>
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
                                <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged" Width="500px">
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
                                <span class="spantxt">คำค้นหา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                    CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                    ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="SearchTotal">
                            <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                                style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                        </div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server" ShowFooter="true" OnRowDataBound="dgSummary_RowDataBound" PageSize="50">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                <FooterTemplate>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ชื่อโครงการ / กิจกรรม">
                                <ItemTemplate>
                                    <%# PjOrAcName(Eval("AcCode").ToString(), Eval("FullName").ToString())%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="30%" />
                                <FooterTemplate>
                                    รวม :
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="หน่วยงาน">
                                <ItemTemplate>
                                    <%# Eval("DeptName").ToString()%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบประมาณที่ตั้ง">
                                <ItemTemplate>
                                    <%# GetTotalAmount1(decimal.Parse(Eval("TotalAmount1").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount1().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบประมาณที่ใช้ไป">
                                <ItemTemplate>
                                    <%# GetTotalAmount2(decimal.Parse(Eval("TotalAmount2").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount2().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบประมาณคงเหลือ">
                                <ItemTemplate>
                                    <%# GetTotalAmount3(decimal.Parse(Eval("TotalBalance").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount3().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                    <div id="divTotal" runat="server" class="footerTotal">
                        รวมงบประมาณตั้งไว้ทั้งหมด : <span id="ToltalBudget" class="lblTotal1" runat="server"></span>บาท <span style="padding-left: 50px;">รวมงบประมาณใช้จริงทั้งหมด : </span><span id="ToltalBudget2" class="lblTotal2" runat="server"></span> บาท <span style="padding-left: 50px;">รวมงบคงเหลือทั้งหมด : </span><span id="TotalBalance" class="lblTotal3" runat="server"></span> บาท
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
