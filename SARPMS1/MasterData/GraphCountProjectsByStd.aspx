<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="GraphCountProjectsByStd.aspx.cs" Inherits="GraphCountProjectsByStd" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function printRpt(mode, type) {
            var yearb = $get("<%=ddlYearB.ClientID%>").value;
            var graphtype = $get("<%=ddlType.ClientID%>").selectedIndex;

            window.open('../GtReport/Viewer.aspx?rpt=42&yearB=' + yearb + '&rpttype=' + type + '&graphtype=' + graphtype);
        }
        function getPopUp(inx, id) {
            if (inx == 1) {
                dialogBox.show('../PopUp/PopUpActivityPresent.aspx?id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true, 'yes');
            }
        }
    </script>

    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="headTable">
                    กราฟจำนวนโครงการตามมาตรฐาน / ตัวบ่งชี้
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการแสดงผล</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ประเภทกราฟ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlType" CssClass="ddlSearch" Width="150px" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlYearB" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow" style="display:none;">
                            <div class="SearchtxtF">
                                <span class="spantxt">พิมพ์กราฟ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="spaceDiv"></div>
                <div class="centerDiv">
                    <div id="divGraph0" class="divGraph" style="border: solid 5px #949494; height: 500px; width:47%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            กราฟจำนวนโครงการตามมาตรฐาน
                        </div>
                        <div>
                            <div id="graphPnl0" runat="server"></div>
                        </div>
                    </div>
                    <div id="divGraph1" class="divGraph" style="border: solid 5px #949494; height: 500px; width:47%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            กราฟจำนวนโครงการตามตัวบ่งชี้
                        </div>
                        <div>
                            <div id="graphPnl1" runat="server"></div>
                        </div>
                    </div>
                    <div class="divGraph" style="border: solid 5px #949494; height:auto; width:98%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            ตารางแสดงโครงการตามมาตรฐาน / ตัวบ่งชี้
                        </div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" ShowFooter="true" PageSize="50">
                                <Columns>
                                    <Control:TemplateField HeaderText="ที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="มาตรฐาน" DataField="SName">
                                        <ItemStyle Width="6%" HorizontalAlign="Center" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="ตัวบ่งชี้" DataField="SdName">
                                        <ItemStyle Width="6%" HorizontalAlign="Center" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ชื่อโครงการ">
                                        <ItemTemplate>
                                            <%#Eval("ProjectsName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="20%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ช่วงวันที่">
                                        <ItemTemplate>
                                            <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                        </ItemTemplate>
                                        <ItemStyle Width="15%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="ผู้สร้าง" DataField="EmpName">
                                        <ItemStyle Width="15%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="คุณภาพโครงการ">
                                        <ItemTemplate>
                                            <%# getQuality(Eval("Quality")) %> %
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
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
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
