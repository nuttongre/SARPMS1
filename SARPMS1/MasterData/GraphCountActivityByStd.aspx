<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="GraphCountActivityByStd.aspx.cs" Inherits="GraphCountActivityByStd" %>

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
                    กราฟจำนวนกิจกรรมตามมาตรฐาน / ตัวบ่งชี้
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
                            กราฟจำนวนกิจกรรมตามมาตรฐาน
                        </div>
                        <div>
                            <div id="graphPnl0" runat="server"></div>
                        </div>
                    </div>
                    <div id="divGraph1" class="divGraph" style="border: solid 5px #949494; height: 500px; width:47%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            กราฟจำนวนกิจกรรมตามตัวบ่งชี้
                        </div>
                        <div>
                            <div id="graphPnl1" runat="server"></div>
                        </div>
                    </div>
                    <div class="divGraph" style="border: solid 5px #949494; height:auto; width:98%;">
                        <div class="spaceDiv"></div>
                        <div class="divSpntxtHeadGraph">
                            <img src="../Image/Icon/IconGraph.png" />
                            ตารางแสดงกิจกรรมตามมาตรฐาน / ตัวบ่งชี้
                        </div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" ShowFooter="true" PageSize="50">
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
                                    <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="getPopUp(1, '<%#Eval("ActivityCode")%>');">
                                                <img style="border: none; cursor: pointer;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                                    src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png' /></a>
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อโครงการ">
                                        <ItemTemplate>
                                            <%#Eval("ProjectsName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="20%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                        <ItemTemplate>
                                            <%#Eval("ActivityName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="20%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ช่วงวันที่">
                                        <ItemTemplate>
                                            <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                        </ItemTemplate>
                                        <ItemStyle Width="13%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบประมาณ">
                                        <ItemTemplate>
                                            <%# GetBudget(Eval("TotalAmount").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="ผู้สร้าง" DataField="EmpName">
                                        <ItemStyle Width="16%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <%--<Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="11%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>--%>
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
