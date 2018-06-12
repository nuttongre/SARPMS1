<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpActivityDetail.aspx.cs" Inherits="PopUpActivityDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>

    <link href="../CSS/fileupload.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function ckddlDate() {
            jsDateDiff($get("<%=txtSDay.ClientID%>").innerHTML, $get("<%=txtEDay.ClientID%>").innerHTML, $get("datediff1"));
        jsDateDiff($get("<%=txtSDay2.ClientID%>").innerHTML, $get("<%=txtEDay2.ClientID%>").innerHTML, $get("datediff2"));
    }
    function jsDateDiff(st, en, object) {
        var start = new Array(3);
        var end = new Array(3);

        //Thai DateFormat 15/08/2552 - DD/MM/YYYY
        //Split Start -> Date/Month/Year
        start[0] = st.substr(0, 2);
        start[1] = st.substr(3, 2);
        start[2] = st.substr(6, 4);

        //Split End -> Date/Month/Year
        end[0] = en.substr(0, 2);
        end[1] = en.substr(3, 2);
        end[2] = en.substr(6, 4);

        end[1] -= 1;
        start[1] -= 1;

        end[2] -= 543;
        start[2] -= 543;

        StratDate = new Date();
        EndDate = new Date();

        StratDate.setDate(start[0]);
        StratDate.setMonth(start[1]);
        StratDate.setFullYear(start[2]);

        EndDate.setDate(end[0]);
        EndDate.setMonth(end[1]);
        EndDate.setFullYear(end[2])

        var theDate1 = Date.parse(StratDate) / 1000;
        var theDate2 = Date.parse(EndDate) / 1000;
        var diff = (theDate2 - theDate1) / (60 * 60 * 24);
        object.innerHTML = diff + 1;

        cklblDateDiff();
    }
    function cklblDateDiff() {
        var datediff1 = parseInt($get("datediff1").innerHTML);
        var datediff2 = parseInt($get("datediff2").innerHTML);

        if (datediff1 != datediff2) {
            $get("lblCkDateDiff").innerHTML = "ไม่เป็นไปตามระยะเวลา";
            $get("lblCkDateDiff").style.color = "red";
        }
        else {
            $get("lblCkDateDiff").innerHTML = "เป็นไปตามระยะเวลา";
            $get("lblCkDateDiff").style.color = "green";
        }
    }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="Div1" class="PageManageDiv">
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt spantxt2 spansize14">โครงการ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblProjects" CssClass="spantxt3 spantxt2 spansize14" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">กิจกรรม : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="txtActivity" CssClass="spantxt6 spantxt2" runat="server"></asp:Label>
                        <asp:Label ID="txtActivityCode" Font-Size="0" ForeColor="White" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH" style="display:none;">
                    <div class="divF_Head">
                        <span class="spantxt">พันธกิจ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblMission" CssClass="spantxt4" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH" style="display:none;">
                    <div class="divF_Head">
                        <span class="spantxt">เป้าประสงค์ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblGoals" CssClass="spantxt4" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">กลยุทธ์ระดับองค์กร : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblStrategies" CssClass="spantxt6" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH" style="display:none;">
                    <div class="divF_Head">
                        <span class="spantxt">มฐ.การศึกษาชาติ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblStandardNationName" CssClass="spantxt3" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH" style="display:none;">
                    <div class="divF_Head">
                        <span class="spantxt">มฐ.ตามกฎกระทรวง : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblStandardMinistryName" CssClass="spantxt3" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">มาตรฐาน : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblStandard" CssClass="spantxt3" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ตัวบ่งชี้ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblIndicators" CssClass="spantxt3" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">หลักการและเหตุผล : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="lblProjectsDetail" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">วัตถุประสงค์ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="lblPurpose" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">เป้าหมาย : </span>
                    </div>
                    <div class="divB_Head">
                    </div>
                </div>
                <div class="inputrow">
                    <div class="divF_Head">
                        <span class="spantxt">เชิงปริมาณ </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="lblTarget" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">เชิงคุณภาพ</span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="lblTarget2" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">รายละเอียดกิจกรรม : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtActivityDetail" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">การติดตามประเมินผล : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtEvaluation" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ตัวบ่งชี้ความสำเร็จ</span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtEvaIndicators" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">วิธีการประเมิน</span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtEvaAssessment" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">เครื่องมือที่ใช้</span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtEvaTool" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ผลที่คาดว่าจะได้รับ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:TextBox ID="txtExpected" TextMode="MultiLine" ReadOnly="true" Width="660px" Height="100" CssClass="txtBoxNotType spantxt4" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ภาคเรียนที่ : </span>
                    </div>
                    <div class="divB_Head">
                        <div style="float: left;">
                            <asp:Label ID="lblTerm" CssClass="spantxt3" runat="server"></asp:Label>
                        </div>
                        <div style="float: left; padding: 0px 10px;"><span class="spantxt">ปีการศึกษา : </span></div>
                        <div style="float: left;">
                            <asp:Label ID="lblYearB" CssClass="spantxt3" runat="server"></asp:Label>
                        </div>
                        <div style="float: left; padding: 0px 10px;"><span class="spantxt">ปีงบประมาณ : </span></div>
                        <div style="float: left;">
                            <asp:Label ID="lblBudgetYear" CssClass="spantxt3" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">สถานที่ดำเนินการ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblPlace" runat="server" CssClass="spantxt3"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ผู้รับผิดชอบ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblEmpName" runat="server" CssClass="spantxt6"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">หน่วยงาน : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblDepartment" CssClass="spantxt6" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ประเภท : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="lblType" CssClass="spantxt3" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div id="Div2" class="TableSearch" style="width: 100%;">
                    <div class="SearchTable" style="width: 80%;">
                        <div class="SearchHead" style="text-align: center;">
                            <span class="spantxt2 spansize14">รายการงบประมาณ</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="centerDiv" style="margin: 0px 10px;">
                            <Control:DataGridView ID="GridViewBudget" runat="server" Width="98%" AutoGenerateColumns="False"
                                PageSize="20" ShowFooter="true">
                                <Columns>
                                    <Control:TemplateField HeaderText="ที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="รายการ">
                                        <ItemTemplate>
                                            <%#Eval("ListName")%>
                                            <input id="txtEntry<%#Container.DataItemIndex %>" name="txtEntry<%#Container.DataItemIndex %>"
                                                type="hidden" value="<%#Eval("EntryCostsCode") %>" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบประมาณที่ตั้งไว้">
                                        <ItemTemplate>
                                            <%# GetTotalMoney(decimal.Parse(Eval("TotalMoney").ToString())).ToString("#,##0")%>
                                            <input id="txtTm<%#Container.DataItemIndex %>" name="txtTm<%#Container.DataItemIndex %>"
                                                type="hidden" value="<%#Eval("TotalMoney") %>" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="20%" />
                                        <FooterTemplate>
                                            <%# GetSumTotalMoney().ToString("#,##0")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบประมาณที่ใช้จริง">
                                        <ItemTemplate>
                                            <%# GetTotalMoney2(decimal.Parse(Eval("ValueT").ToString())).ToString("#,##0")%>
                                            <input id="txtT<%#Container.DataItemIndex %>" name="txtT<%#Container.DataItemIndex %>"
                                                type="hidden" value="<%#Eval("ValueT") %>" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="20%" />
                                        <FooterTemplate>
                                            <%# GetSumTotalMoney2().ToString("#,##0")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <%--<Control:TemplateField HeaderText="ผลต่าง">
                                                    <ItemTemplate>
                                                        <span id="txtdiff<%#Container.DataItemIndex %>"></span>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    <FooterTemplate>
                                                        <span id="txtTotalDiff"></span>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" 
                                                        BackColor="#BDBDBD" BorderStyle="Solid" BorderColor="Black" BorderWidth="2" />
                                                </Control:TemplateField>--%>
                                    <Control:BoundField DataField="BudgetTypeName" HeaderText="ประเภทของเงิน" SortExpression="">
                                        <ItemStyle Width="40%" HorizontalAlign="Center" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                </Columns>
                            </Control:DataGridView>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div style="float: left; width: 40%;padding-left:30px;">
                            <div id="graphPnl" runat="server"></div>
                        </div>
                        <div style="float: right; width: 40%;padding-right:30px;">
                            <div id="graphPnl1" runat="server"></div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="centerDiv">
                            <asp:Label ID="lblBudget" Font-Bold="true" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div id="Div3" class="TableSearch" style="width: 100%;">
                    <div class="SearchTable" style="width: 80%;">
                        <div class="SearchHead" style="text-align: center;">
                            <span class="spantxt2 spansize14">ระยะเวลา</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv" style="margin: 0px 15px;">
                            <table width="95%" style="border: solid 1px Black;">
                                <tr>
                                    <td style="width: 35%;" class="gradient bgColorGray">
                                        <span class="spantxt2">รายการ</span>
                                    </td>
                                    <td style="width: 25%;" class="gradient bgColorGray">
                                        <span class="spantxt2">วันที่เริ่มกิจกรรม</span>
                                    </td>
                                    <td style="width: 25%;" class="gradient bgColorGray">
                                        <span class="spantxt2">วันที่สิ้นสุดกิจกรรม</span>
                                    </td>
                                    <td style="width: 15%;" class="gradient bgColorGray">
                                        <span class="spantxt2">จำนวนวันที่ใช้</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; padding: 0 0 0 30px;">
                                        <span class="spantxt2">วันที่ประมาณการ</span>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtSDay" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtEDay" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <span id="datediff1" class="spantxt2">0</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; padding: 0 0 0 30px;">
                                        <span class="spantxt2">วันที่ดำเนินการจริง</span>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtSDay2" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtEDay2" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <span id="datediff2" class="spantxt2">0</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="centerDiv">
                            <span id="lblCkDateDiff" class="spantxt2"></span>
                        </div>
                    </div>
                </div>
                <div class="spaceDiv"></div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ตัวชี้วัด : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Repeater ID="rptIncicators2" runat="server" OnItemDataBound="rptIncicators2_ItemDataBound">
                            <ItemTemplate>
                                <span class="spantxt3">
                                    <%#Container.ItemIndex + 1 %>.
                                        <%#Eval("IndicatorsName2")%><span class="spantxt4" style="padding: 0 0 0 20px;">ตัววัด
                                            :
                                            <%#Eval("txtWeightType")%></span></span>
                                <br />
                                <span class="spantxt4" style="padding: 0 0 0 20px;"><span class="spantxt">:- </span>
                                    จากทั้งหมด :
                                        <%#Convert.ToDecimal(Eval("OffAll")).ToString("#,##0.00")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เกณฑ์ที่ผ่าน
                                        :
                                        <%#Convert.ToDecimal(Eval("Weight")).ToString("#,##0.00")%>&nbsp;<%#(Eval("txtWeightType").ToString() == "%") ? "%" : ""%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ผลที่ทำได้
                                        :
                                        <%#Convert.ToDecimal(Eval("OffThat")).ToString("#,##0.00")%></span>
                                <br />
                                <span class="spantxt3" style="padding: 0 0 0 20px;"><span class="spantxt">:- </span>
                                    คิดเป็น :
                                        <%#Convert.ToDecimal(Eval("APercent")).ToString("#,##0.00")%>&nbsp;%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<%#Eval("txtCkCriterion")%>)</span>
                                <br />
                                <div class="inputrowH">
                                    <div class="divF_Head" style="width:20%;">
                                        <span class="spantxt">ไฟล์แนบ : </span>
                                    </div>
                                    <div class="divB_Head">
                                        <div class="framImg" style="width:450px;">
                                            <asp:Repeater ID="rptAttach" runat="server">
                                                <ItemTemplate>
                                                    <div class="showSmallImg">
                                                        <div style="margin: 5px auto; width: 65px; height: 50px;">
                                                            <%# getImgAttatch(Eval("ItemID"), Eval("Title"), Eval("FileType"), Eval("TypeId")) %>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                                <%--<table>
                                    <tr>
                                        <td style="width: 20%; text-align: right; vertical-align: top;">
                                            <span class="spantxt" style="vertical-align: top;">ไฟล์แนบทั้งหมด : </span>
                                        </td>
                                        <td style="border: solid 1px #BDBDBD; min-height: 25px; vertical-align: middle; text-align: left; background-color: #E0F8F7">
                                            <asp:Repeater ID="rptFile" runat="server">
                                                <ItemTemplate>
                                                    <span class="rpt_content"><a target="_blank" href="../AttachFile/<%# Eval("AttachID")%>_<%# Eval("FileName")%>">
                                                        <%# Eval("FileName").ToString() %></a> </span>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </td>
                                    </tr>
                                </table>--%>
                                <br />
                                <br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
