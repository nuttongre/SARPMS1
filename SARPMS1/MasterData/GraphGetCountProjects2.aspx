<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="GraphGetCountProjects2.aspx.cs" Inherits="GraphGetCountProjects2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>
    <script src="../scripts/Frameworks.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            window.onbeforeunload = function () {
                $.ajax({
                    type: "POST",
                    url: window.location.pathname.match(/([^/]*)\.[^.]*$/)[0] + "/RemoveHttpContext",
                    cache: false,
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {
                    }
                });
            };
        });
        function printRpt(mode, type) {
            var YearB = $get("<%=ddlSearchYear.ClientID%>").value;
            var typeID = $("[id$='rbtType']").find(":checked").val();
            var MonthB = "";
            var Quarter = "";
            if (typeID == 0) {
                MonthB = $get("<%=ddlMonth.ClientID%>").value;
            }
            else {
                Quarter = $get("<%=ddlQuarter.ClientID%>").value;
            }
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&rpttype=" + type + "&monthB=" + MonthB + "&quarter=" + Quarter + "&yearB=" + YearB + "&ckLogo=false");
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="pageDiv">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    กราฟเปรียบเทียบโครงการตามแผนงานกับโครงการที่ดำเนินการเสร็จเรียบร้อย
                </div>
                <div class="spaceDiv"></div>
                <div class="divMainGraph">
                    <div id="Div1" class="TableSearch">
                        <div class="SearchTable">
                            <div class="SearchHead">
                                <span class="spantxt2 spansize14">เงื่อนไขการค้นหา</span>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span id="lblYear" class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span class="spantxt">เลือกดูแบบ : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:RadioButtonList ID="rbtType" runat="server" RepeatColumns="2" AutoPostBack="true" OnSelectedIndexChanged="rbtType_SelectedIndexChanged"></asp:RadioButtonList>
                                </div>
                            </div>
                            <div id="divMonth" class="inputrow" runat="server">
                                <div class="SearchtxtF">
                                    <span class="spantxt">เดือน : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div id="divQuarter" class="inputrow" runat="server" visible="false">
                                <div class="SearchtxtF">
                                    <span class="spantxt">ไตรมาส : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlQuarter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlQuarter_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span class="spantxt">รายงาน : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:Literal ID="linkReport" runat="server"></asp:Literal>
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
                    <div class="spaceDiv"></div>
                    <div id="divGraph2" class="divGraph" style="width: 99%; height: 500px;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            กราฟเปรียบเทียบโครงการตามแผนงานกับโครงการที่ดำเนินการเสร็จเรียบร้อย
                        </div>
                        <div class="divFrameGraph" style="width: 1000px; height: 400px;">
                            <div id="graphPnl2" runat="server"></div>
                        </div>
                    </div>
                    <div class="spaceDiv"></div>
                    <div class="divGraph" style="width: 99%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            ตารางเปรียบเทียบโครงการตามแผนงานกับโครงการที่ดำเนินการเสร็จเรียบร้อย
                        </div>
                        <div style="margin: 0 auto; width: 99%;">
                            <Control:DataGridView ID="GridView1" runat="server" ShowFooter="true" PageSize="50">
                                <Columns>
                                    <Control:TemplateField HeaderText="หน่วยงาน">
                                        <ItemTemplate>
                                            <%# Eval("Name") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="โครงการตามแผน">
                                        <ItemTemplate>
                                            <%# GetTotalAmount(int.Parse(Eval("data").ToString())).ToString()%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                                        <FooterTemplate>
                                            <%# GetSumTotalAmount().ToString()%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Center" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="โครงการอนุมัติ">
                                        <ItemTemplate>
                                            <%# GetTotalAmount1(int.Parse(Eval("data1").ToString())).ToString()%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                                        <FooterTemplate>
                                            <%# GetSumTotalAmount1().ToString()%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Center" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="% คุณภาพโครงการ">
                                        <ItemTemplate>
                                            <%# GetTotalAmount2(int.Parse(Eval("data2").ToString())).ToString()%> %
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                                        <FooterTemplate>
                                            <%# GetSumTotalAmount2().ToString("#,##0.00")%> %
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Center" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                        </div>
                    </div>
                    <div class="divGraph" style="width: 99%; height: auto;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            ตารางแสดงรายการโครงการ
                        </div>
                        <div class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาโครงการ</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานหลัก : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainDept" Width="300px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainDept_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานรอง : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainSubDept" Width="300px" runat="server"
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
                                            OnSelectedIndexChanged="ddlSearchDept_SelectedIndexChanged" Width="300px">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="spaceDiv"></div>
                            </div>
                        </div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="DataGridView1" runat="server" ShowFooter="true" PageSize="30">
                                <Columns>
                                    <Control:TemplateField HeaderText="ที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="อนุมัติ">
                                        <ItemTemplate>
                                            <%# statusIsApprove(Eval("IsApprove")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อโครงการ">
                                        <ItemTemplate>
                                            <%# Eval("ProjectsName").ToString()%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="22%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบประมาณ">
                                        <ItemTemplate>
                                            <%# GetBudget(Eval("ProjectsCode").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        <FooterTemplate>
                                            <%# GetTotalBudget().ToString("N2")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="วันที่ดำเนินงาน">
                                        <ItemTemplate>
                                           <span style="font-size:10pt;"><%# getProjectDate(Eval("Sdate"), Eval("Edate"))%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="13%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ผู้สร้าง">
                                        <ItemTemplate>
                                            <span style="font-size:12pt;"><%# Eval("EmpName")%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="หน่วยงาน">
                                        <ItemTemplate>
                                            <span style="font-size:12pt;"><%# Eval("DeptName")%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ใบคำขอ" HeaderToolTip="ใบคำขอ">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(56,'w','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงรายการค่าใช้จ่ายตามกิจกรรม แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(56,'e','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงรายการค่าใช้จ่ายตามกิจกรรม แบบเอกสาร Excel" src="../Image/Excel.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(56,'p','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงรายการค่าใช้จ่ายตามกิจกรรม แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="7%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="คุณภาพโครงการ">
                                        <ItemTemplate>
                                            <%# Eval("Quality") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="11%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
