<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Income.aspx.cs" Inherits="Income" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "Income.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "Income.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "Income.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "Income.aspx";
        }
        function printRpt(mode, type, id) {
            var ID;
            if (id == "") {
                ID = $get("<%=lblInComeCode.ClientID%>").innerHTML;
            }
            else {
                ID = id;
            }
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + ID + "&rpttype=" + type);
        }
        function SumTotal() {
            var P1 = $get("<%=txtP1.ClientID%>").value.replace(/,/g, '');
            var P2 = $get("<%=txtP2.ClientID%>").value.replace(/,/g, '');
            var P3 = $get("<%=txtP3.ClientID%>").value.replace(/,/g, '');

            var Pb1 = $get("<%=txtPb1.ClientID%>").value.replace(/,/g, '');
            var Pb2 = $get("<%=txtPb2.ClientID%>").value.replace(/,/g, '');
            var Pb3 = $get("<%=txtPb3.ClientID%>").value.replace(/,/g, '');

            $get("lblSumP1").innerHTML = (parseFloat(P1) * parseFloat(Pb1)).comma();
            $get("lblSumP2").innerHTML = (parseFloat(P2) * parseFloat(Pb2)).comma();
            $get("lblSumP3").innerHTML = (parseFloat(P3) * parseFloat(Pb3)).comma();
            $get("lblTotalP").innerHTML = (parseFloat(P1) + parseFloat(P2) + parseFloat(P3)).comma();
            $get("lblTotalAmountP").innerHTML = ((parseFloat(P1) * parseFloat(Pb1)) + (parseFloat(P2) * parseFloat(Pb2)) + (parseFloat(P3) * parseFloat(Pb3))).comma();

            var ClassP1 = $get("<%=txtClassP1.ClientID%>").value.replace(/,/g, '');
            var ClassP2 = $get("<%=txtClassP2.ClientID%>").value.replace(/,/g, '');
            var ClassP3 = $get("<%=txtClassP3.ClientID%>").value.replace(/,/g, '');
            $get("lblTotalClassP").innerHTML = (parseFloat(ClassP1) + parseFloat(ClassP2) + parseFloat(ClassP3)).comma();

            var M1 = $get("<%=txtM1.ClientID%>").value.replace(/,/g, '');
            var M2 = $get("<%=txtM2.ClientID%>").value.replace(/,/g, '');
            var M3 = $get("<%=txtM3.ClientID%>").value.replace(/,/g, '');

            var Mb1 = $get("<%=txtMb1.ClientID%>").value.replace(/,/g, '');
            var Mb2 = $get("<%=txtMb2.ClientID%>").value.replace(/,/g, '');
            var Mb3 = $get("<%=txtMb3.ClientID%>").value.replace(/,/g, '');

            $get("lblSumM1").innerHTML = (parseFloat(M1) * parseFloat(Mb1)).comma();
            $get("lblSumM2").innerHTML = (parseFloat(M2) * parseFloat(Mb2)).comma();
            $get("lblSumM3").innerHTML = (parseFloat(M3) * parseFloat(Mb3)).comma();

            $get("lblTotalM").innerHTML = (parseFloat(M1) + parseFloat(M2) + parseFloat(M3)).comma();
            $get("lblTotalAmountM").innerHTML = ((parseFloat(M1) * parseFloat(Mb1)) + (parseFloat(M2) * parseFloat(Mb2)) + (parseFloat(M3) * parseFloat(Mb3))).comma();

            var ClassM1 = $get("<%=txtClassM1.ClientID%>").value.replace(/,/g, '');
            var ClassM2 = $get("<%=txtClassM2.ClientID%>").value.replace(/,/g, '');
            var ClassM3 = $get("<%=txtClassM3.ClientID%>").value.replace(/,/g, '');
            $get("lblTotalClassM").innerHTML = (parseFloat(ClassM1) + parseFloat(ClassM2) + parseFloat(ClassM3)).comma();

            var Ma = $get("<%=txtMa.ClientID%>").value.replace(/,/g, '');
            var TotalAmountP = $get("lblTotalAmountP").innerHTML.replace(/,/g, '');
            var TotalAmountM = $get("lblTotalAmountM").innerHTML.replace(/,/g, '');
            var TotalSubsidies = parseFloat(TotalAmountP) + parseFloat(TotalAmountM);
            var TotalAmount = parseFloat(Ma) + parseFloat(TotalAmountP) + parseFloat(TotalAmountM);
            $get("<%=txtSubsidies.ClientID%>").value = TotalSubsidies.comma();
            $get("<%=lblSubsidiesTotal.ClientID%>").innerHTML = TotalAmount.comma();

            var Subsidies = $get("<%=txtSubsidies.ClientID%>").value.replace(/,/g, '');

            var MaRevenue = $get("<%=txtMaRevenue.ClientID%>").value.replace(/,/g, '');
            var Revenue = $get("<%=txtRevenue.ClientID%>").value.replace(/,/g, '');
            var TotalRevenue = parseFloat(MaRevenue) + parseFloat(Revenue);
            $get("<%=lblRevenueTotal.ClientID%>").innerHTML = TotalRevenue.comma();

            var MaFree = $get("<%=txtMaFree.ClientID%>").value.replace(/,/g, '');
            var Free = $get("<%=txtFree.ClientID%>").value.replace(/,/g, '');
            var TotalFree = parseFloat(MaFree) + parseFloat(Free);
            $get("<%=lblFreeTotal.ClientID%>").innerHTML = TotalFree.comma();

            var MaReserve = $get("<%=txtMaReserve.ClientID%>").value.replace(/,/g, '');
            var Reserve = $get("<%=txtReserve.ClientID%>").value.replace(/,/g, '');
            var TotalReserve = parseFloat(MaReserve) + parseFloat(Reserve);
            $get("<%=lblReserveTotal.ClientID%>").innerHTML = TotalReserve.comma();

            var MaOther = $get("<%=txtMaOther.ClientID%>").value.replace(/,/g, '');
            var Other = $get("<%=txtOther.ClientID%>").value.replace(/,/g, '');
            var TotalOther = parseFloat(MaOther) + parseFloat(Other);
            $get("<%=lblOtherTotal.ClientID%>").innerHTML = TotalOther.comma();

            $get("lblTotalMa").innerHTML = (parseFloat(Ma) + parseFloat(MaRevenue) + parseFloat(MaFree) + parseFloat(MaReserve) + parseFloat(MaOther)).comma();
            $get("lblTotalMoney").innerHTML = (parseFloat(Subsidies) + parseFloat(Revenue) + parseFloat(Free) + parseFloat(Reserve) + parseFloat(Other)).comma();
            $get("lblTotalAmount").innerHTML = (parseFloat(TotalAmount) + parseFloat(TotalRevenue) + parseFloat(TotalFree) + parseFloat(TotalReserve) + parseFloat(TotalOther)).comma();
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
                    เงินรายรับของสถานศึกษา
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาเงินรายรับของสถานศึกษา</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">ปีการศึกษา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
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
                                        <asp:TextBox CssClass="txtSearch txt300" ID="txtSearch" runat="server"></asp:TextBox><asp:Button
                                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา"
                                            Text="  " />
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
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="btAddDiv">
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" OnClientClick="AddItem();"
                                    Text="       สร้างรายการใหม่" ToolTip="สร้างรายการใหม่" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" PageSize="50" ShowFooter="true">
                                <Columns>
                                    <Control:TemplateField HeaderText="หน่วยงาน">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("IncomeCode") %>');"><%# Eval("DeptName") %></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="18%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบอุดหนุน">
                                        <ItemTemplate>
                                            <%# getSubsidies(Eval("Subsidies")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalSubsidies() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="เงินวิทยาลัย">
                                        <ItemTemplate>
                                            <%# getRevenue(Eval("Revenue")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalRevenue() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="15 ปี">
                                        <ItemTemplate>
                                            <%# getFree(Eval("Free")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalFree() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="CPALL">
                                        <ItemTemplate>
                                            <%# getReserve(Eval("Reserve")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalReserve() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="เงินอื่น ๆ">
                                        <ItemTemplate>
                                            <%# getOther(Eval("Other")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalOther() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="รวมรายรับ">
                                        <ItemTemplate>
                                            <%# getSumAmount(Eval("TotalAmount")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# getTotalAmount() %>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="รายรับ">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(34,'w','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายรับของสถานศึกษา แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(34,'e','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายรับของสถานศึกษา แบบเอกสาร Excel" src="../Image/ExcelIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(34,'p','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายรับของสถานศึกษา แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <%--<Control:TemplateField HeaderText="อนุบาล">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(20,'w','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นอนุบาล แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(20,'e','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นอนุบาล แบบเอกสาร Word" src="../Image/ExcelIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(20,'p','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นอนุบาล แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>--%>
                                    <Control:TemplateField HeaderText="ปวช.">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(18,'w','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวช. แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(18,'e','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวช. แบบเอกสาร Word" src="../Image/ExcelIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(18,'p','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวช. แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ปวส.">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(19,'w','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวส. แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(19,'e','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวส. แบบเอกสาร Word" src="../Image/ExcelIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(19,'p','<%#Eval("IncomeCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="รายงานเงินรายหัวชั้นปวส. แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("IncomeCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <%# checkDelete(Eval("IncomeCode"), Eval("DeptCode")) %>
                                            <%--<a href="javascript:deleteItem('<%#Eval("IncomeCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>--%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                    <asp:View ID="edit" runat="server">
                        <div id="table1" class="PageManageDiv">
                            <div class="inputrowH">
                                <div class="divF_Head" style="width: 50%;">
                                    <span class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head" style="width: 45%;">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv" style="display:none;">
                                <asp:Literal ID="linkReport1" runat="server"></asp:Literal>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <table width="100%" style="border: solid 2px Black;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td rowspan="2" class="IncomeHead" style="width: 20%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">ห้อง</span>
                                        </td>
                                        <td colspan="7" class="IncomeHead" style="width: 80%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">ระดับ ปวช.</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวช.1</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวช.2</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวช.3</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">รวมทั้งสิ้น</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">จำนวนห้อง</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassP1" maxlength="2" name="txtClassP1" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassP2" maxlength="2" name="txtClassP2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassP3" maxlength="2" name="txtClassP3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalClassP" class="spantxt2">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">จำนวนนักเรียน</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtP1" maxlength="5" name="txtP1" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtP2" maxlength="5" name="txtP2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtP3" maxlength="5" name="txtP3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalP" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">เงินรายหัว</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtPb1" maxlength="5" name="" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtPb2" maxlength="5" name="txtPb2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtPb3" maxlength="5" name="txtPb3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">เป็นเงินปีงบประมาณ</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumP1" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumP2" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumP3" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalAmountP" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Literal ID="linkReport2" runat="server"></asp:Literal>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <table width="100%" style="border: solid 2px Black;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td rowspan="2" class="IncomeHead" style="width: 20%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">ห้อง</span>
                                        </td>
                                        <td colspan="7" class="IncomeHead" style="width: 80%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">ระดับ ปวส.</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวส.1</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวส.2</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ปวส.3</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">รวมทั้งสิ้น</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">จำนวนห้อง</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassM1" maxlength="2" name="txtClassM1" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassM2" maxlength="2" name="txtClassM2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtClassM3" maxlength="2" name="txtClassM3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalClassM" class="spantxt2">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">จำนวนนักเรียน</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtM1" maxlength="5" name="txtM1" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtM2" maxlength="5" name="txtM2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtM3" maxlength="5" name="txtM3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalM" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">เงินรายหัว</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtMb1" maxlength="5" name="txtMb1" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtMb2" maxlength="5" name="txtMb2" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeDetail">
                                            <input id="txtMb3" maxlength="5" name="txtMb3" type="text" runat="server" class="txtBoxNum" onkeypress="return KeyNumber(event);" style="width: 100px;" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" value="0" />
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">-</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">เป็นเงินปีงบประมาณ</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumM1" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumM2" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSumM3" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalAmountM" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Literal ID="linkReport3" runat="server"></asp:Literal>
                            </div>
                            <div class="spaceDiv"></div>
                            <div>
                                <asp:Label ID="lblInComeCode" runat="server" Text="Label" ForeColor="White" Font-Size="0"></asp:Label>
                            </div>
                            <div class="centerDiv">
                                <table width="100%" style="border: solid 2px Black;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td rowspan="2" class="IncomeHead" style="width: 30%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">ประเภทงบประมาณ</span>
                                        </td>
                                        <td colspan="3" class="IncomeHead" style="width: 70%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                            <span class="spantxt2">งบประมาณ</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ยอดยกมา</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">จำนวนเงิน</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">รวมทั้งสิ้น</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">งบอุดหนุน</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtMa" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtSubsidies" CssClass="txtBoxNum txtBoxNotType txt100" MaxLength="9"
                                                onchange="txtComma(this);"
                                                Text="0" onkeypress="return false;" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblSubsidiesTotal" runat="server" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">วิทยาลัย</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtMaRevenue" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtRevenue" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblRevenueTotal" runat="server" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">15 ปี</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtMaFree" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtFree" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblFreeTotal" runat="server" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">CPALL</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtMaReserve" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtReserve" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblReserveTotal" runat="server" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeDetail">
                                            <span class="spantxt2">เงินอื่น ๆ</span>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtMaOther" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeDetail">
                                            <asp:TextBox ID="txtOther" CssClass="txtBoxNum txt100" MaxLength="9" onkeyup="SumTotal();"
                                                onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();"
                                                Text="0" onkeypress="return KeyNumber(event);" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblOtherTotal" runat="server" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="IncomeHead">
                                            <span class="spantxt2">ยอดรวมรายรับทั้งหมด</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalMa" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalMoney" class="spantxt2">0.00</span>
                                        </td>
                                        <td class="IncomeHead">
                                            <span id="lblTotalAmount" class="spantxt2">0.00</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Label ID="lblCreate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="centerDiv">
                                <asp:Label ID="lblUpdate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <div class="classButton">
                                    <div class="classBtSave">
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                            ToolTip="บันทึกรายการนี้" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกรายการนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
