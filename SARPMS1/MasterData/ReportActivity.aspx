<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="ReportActivity.aspx.cs" Inherits="ReportActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function getPopUp(inx, id) {
            if (inx == 1) {
                dialogBox.show('../PopUp/PopUpActivityDetail.aspx?id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true,true);
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
                    สถานะการทำกิจกรรม
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหากิจกรรม</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">กลยุทธ์ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearch2" Width="500px" runat="server"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlSearch2_SelectedIndexChanged">
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
                                <span class="spantxt">เดือน : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchMonth" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchMonth_SelectedIndexChanged" Width="150px">
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
                                <span class="spantxt">ผู้รับผิดชอบ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged" Width="350px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow" style="height: auto; padding-bottom: 10px;">
                            <div class="SearchtxtF" style="width: 20%;">
                                <span class="spantxt">สถานะกิจกรรม : </span>
                            </div>
                            <div class="SearchF" style="height: auto; width: 78%;">
                                <asp:RadioButtonList ID="rbtlStatus" runat="server" RepeatColumns="3" AutoPostBack="true"
                                    ForeColor="Navy" OnSelectedIndexChanged="rbtlStatus_OnSelectedIndexChanged">
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">คำค้นหา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                    CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                    ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" Text="  " />
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
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" ShowFooter="true" PageSize="50">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img style="border: none; cursor: pointer;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                        src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png' onclick="getPopUp(1, '<%#Eval("ActivityCode")%>')" />
                                </ItemTemplate>
                                <ItemStyle Width="5%" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ติดตาม" SortExpression="ActivityStatus">
                                <ItemTemplate>
                                    <%# getActivityStatus(Eval("ActivityStatus").ToString()) %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <%--<Control:BoundField HeaderText="ชื่อโครงการ" DataField="ProjectsName">
                                <ItemStyle Width="28%" HorizontalAlign="Left" />
                            </Control:BoundField>--%>
                            <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                <ItemTemplate>
                                    <a href="javascript:;" id="LinkOld" onclick="getPopUp(1, '<%#Eval("ActivityCode")%>')">
                                        <%#Eval("ActivityName")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="25%" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ช่วงวันที่">
                                <ItemTemplate>
                                    <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                </ItemTemplate>
                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="งบตั้งไว้">
                                <ItemTemplate>
                                    <%# GetTotalAmount1(decimal.Parse(Eval("TotalAmount").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="8%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount1().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบใช้ไป">
                                <ItemTemplate>
                                    <%# GetTotalAmount2(decimal.Parse(Eval("TotalAmount2").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="8%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount2().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="งบคงเหลือ">
                                <ItemTemplate>
                                    <%# GetTotalAmount3(decimal.Parse(Eval("TotalBalance").ToString())).ToString("N2")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" Width="9%" />
                                <FooterTemplate>
                                    <%# GetSumTotalAmount3().ToString("N2")%>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                            </Control:TemplateField>
                            <%--<Control:TemplateField HeaderText="ต้นทุนผลผลิต">
                                <ItemTemplate>
                                    <%# checkStatus(Eval("ActivityCode").ToString())%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                        </Control:TemplateField>--%>
                            <%--<Control:TemplateField HeaderText="รายงาน">
                                <ItemTemplate>
                                    <a href="../GtReport/Viewer.aspx?rpt=11&id=<%#Eval("ActivityCode") %>" target="_blank">
                                        <img style="border: 0; cursor :pointer;" title="เรียกดูรายงาน" src="../Image/reporticon.gif"</a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                        </Control:TemplateField>--%>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
