<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpAlertActivity.aspx.cs" Inherits="PopUpAlertActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>

    <script type="text/javascript">
        function getPopUpActivity(id) {
            dialogBox.show('../PopUp/PopUpActivityPresent.aspx?mode=2&id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true);
        }
        function getPopUpActivityDetail(id) {
            dialogBox.show('../PopUp/ActivityDetail.aspx?acid=' + id, 'รายละเอียดการทำกิจกรรม', '1000', '600', '#000', true);
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="PageManageDiv">
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหากิจกรรม</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow" style="height:auto; padding-bottom:10px;">
                            <div class="SearchtxtF" style="width:15%;">
                                <span class="spantxt">สถานะ : </span>
                            </div>
                            <div class="SearchF" style="height:auto; width:83%;">
                                <asp:RadioButtonList ID="rbtlStatus" runat="server" RepeatColumns="3" AutoPostBack="true"
                                    ForeColor="Navy" OnSelectedIndexChanged="rbtlStatus_OnSelectedIndexChanged">
                                </asp:RadioButtonList>
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
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ผู้รับผิดชอบ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged" Width="300px">
                                </asp:DropDownList>
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
                <div id="divGraph1" class="divGraph" style="border: solid 5px #949494; width: 47%; height: 355px;">
                    <div class="spaceDiv"></div>
                    <div class="divSpntxtHeadGraph">
                        <img src="../Image/Icon/IconGraph.png" />
                        กราฟจำนวนกิจกรรมตามสถานะต่างๆ
                    </div>
                    <div class="divFrameGraph">
                        <div id="graphPnl1" runat="server"></div>
                    </div>
                </div>
                <div id="divGraph2" class="divGraph" style="border: solid 5px #21a9c1; width: 47%; height: 355px;">
                    <div class="spaceDiv"></div>
                    <div class="divSpntxtHeadGraph">
                        <img src="../Image/Icon/IconGraph.png" />
                        กราฟจำนวนกิจกรรมตามสถานะต่างๆ
                    </div>
                    <div class="divFrameGraph">
                        <div id="graphPnl2" runat="server"></div>
                    </div>
                </div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <div style="text-align: center;">
                        <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound"
                            Width="100%" ShowFooter="true">
                            <Columns>
                                <Control:TemplateField HeaderText="ที่">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" HorizontalAlign="Center" />
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <a href="../PopUp/ActivityDetail.aspx?acid=<%#Eval("ActivityCode")%>" target="_blank">
                                            <img style="border: none; cursor: pointer;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                                src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png' /></a>
                                    </ItemTemplate>
                                    <ItemStyle Width="4%" />
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="ติดตาม" SortExpression="ActivityStatus">
                                        <ItemTemplate>
                                            <%# getActivityStatus(Eval("ActivityStatus").ToString()) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                    <ItemTemplate>
                                        <a href="../PopUp/PopUpActivityPresent.aspx?mode=2&id=<%#Eval("ActivityCode")%>"
                                            id="LinkOld" target="_blank">
                                            <%#Eval("ActivityName")%></a>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="23%" />
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                    <ItemStyle Width="17%" HorizontalAlign="Left" />
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:BoundField>
                                <Control:TemplateField HeaderText="งบตั้งไว้">
                                    <ItemTemplate>
                                        <%# GetTotalAmount1(decimal.Parse(Eval("TotalAmount").ToString())).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="11%" />
                                    <FooterTemplate>
                                        <%# GetSumTotalAmount1().ToString("N2")%>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="งบใช้ไป">
                                    <ItemTemplate>
                                        <%# GetTotalAmount2(decimal.Parse(Eval("TotalAmount2").ToString())).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="11%" />
                                    <FooterTemplate>
                                        <%# GetSumTotalAmount2().ToString("N2")%>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="งบคงเหลือ">
                                    <ItemTemplate>
                                        <%# GetTotalAmount3(decimal.Parse(Eval("TotalBalance").ToString())).ToString("N2")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="11%" />
                                    <FooterTemplate>
                                        <%# GetSumTotalAmount3().ToString("N2")%>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                                <Control:TemplateField HeaderText="วันที่ดำเนินการ" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                    </ItemTemplate>
                                    <ItemStyle Width="18%" HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                        BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                </Control:TemplateField>
                            </Columns>
                        </Control:DataGridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
