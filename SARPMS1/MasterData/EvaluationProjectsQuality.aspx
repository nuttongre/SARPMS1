<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="EvaluationProjectsQuality.aspx.cs" Inherits="EvaluationProjectsQuality" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../scripts/Page.js"></script>

    <script type="text/javascript">
        function EditItem(id) {
            location.href = "EvaluationProjectsQuality.aspx?mode=2&id=" + id;
        }
        function Cancel() {
            location.href = "EvaluationProjectsQuality.aspx";
        }
        function CktxtExamScore(obj) {
            var fullScore = 100;
            if (parseFloat(obj.value) > fullScore) {
                obj.value = fullScore;
            }
            if (parseFloat(obj.value) < 0) {
                obj.value = "0";
            }
        }
        function ckSuccess() {
            $("div.divSuccess").show(200).delay(800).fadeOut(400);
        }
        function SaveData(i) {
            //console.log($("[id^=txtExamScore" + i + "]").val());
            //console.log($("[id^=hdfExamScore" + i + "]").val());
            //return;
            $.ajax({
                type: "POST",
                url: page.getWebMethodUrl("SaveQuality"),
                cache: false,
                data: "{'ProjectsCode':'" + $("[id^=hdfProjectsCode" + i + "]").val() + "','Quality':'" + $("[id^=txtQuality" + i + "]").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    ckSuccess();
                    //alert(msg.d);
                }
            });
        }
        function Cktxt(m, a) {
            var ck = 0;
            var txtConclusion = $get("<%=txtConclusion.ClientID%>");
            var ErrorConclusion = $get("ErrorConclusion");
            var txtPerformance = $get("<%=txtPerformance.ClientID%>");
            var ErrorPerformance = $get("ErrorPerformance");
            var txtProblem = $get("<%=txtProblem.ClientID%>");
            var ErrorProblem = $get("ErrorProblem");
            var txtSolutions = $get("<%=txtSolutions.ClientID%>");
            var ErrorSolutions = $get("ErrorSolutions");

            ck += ckTxtNull(m, txtSolutions, ErrorSolutions);
            ck += ckTxtNull(m, txtProblem, ErrorProblem);
            ck += ckTxtNull(m, txtPerformance, ErrorPerformance);
            ck += ckTxtNull(m, txtConclusion, ErrorConclusion);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
        function printRpt(mode, type, id) {
            var ckSing = $get("<%=cbNotSign.ClientID%>").checked;
            var ckLogo = $get("<%=cbNotLogo.ClientID%>").checked;
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type + "&ckSign=" + ckSing + "&ckLogo=" + ckLogo);
        }
    </script>
    <style type="text/css">
        .txtBoxlblnone2 {
            border: none 0px #FFFFFF;
            color: #424242;
            font-weight: bold;
            font-size: medium;
            width: 200px;
            text-align: right;
        }

        .SignatureImage {
            vertical-align: bottom;
            border: none;
        }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="divSuccess">บันทึกเรียบร้อย...</div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    ประเมินคุณภาพโครงการ
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาโครงการ</span>
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
                                <%--<div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">กลยุทธ์ : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearch2" Width="500px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearch2_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>--%>
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
                        <div class="ckSign">
                                <asp:CheckBox ID="cbNotSign" runat="server" Text=" เลือกให้รายงานไม่มีส่วนเซ็นชื่อ" />
                                <asp:CheckBox ID="cbNotLogo" runat="server" Text=" เลือกให้รายงานไม่แสดงโลโก้" />
                            </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" ShowFooter="true" PageSize="30">
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
                                            <%# checkedit(Eval("ProjectsCode").ToString(), Eval("EmpID").ToString(), Eval("ProjectsName").ToString(), Eval("AcTotal"), Eval("AcFinal"))%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="25%" />
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
                                        <ItemStyle HorizontalAlign="Right" Width="9%" />
                                        <FooterTemplate>
                                            <%# GetTotalBudget().ToString("N2")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="กิจกรรมทั้งหมด">
                                        <HeaderStyle Font-Size="14px" />
                                        <ItemTemplate>
                                            <%# Eval("AcTotal")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="กิจกรรมที่แล้วเสร็จ">
                                        <HeaderStyle Font-Size="13px" />
                                        <ItemTemplate>
                                            <%# Eval("AcFinal")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="ผู้สร้าง" DataField="EmpName">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" Font-Size="12" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="10%" HorizontalAlign="Left" Font-Size="12" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="คุณภาพโครงการ">
                                        <HeaderStyle Font-Size="14px" />
                                        <ItemTemplate>
                                            <input id="hdfProjectsCode<%# Container.DataItemIndex%>" type="hidden" value="<%#Eval("ProjectsCode").ToString() %>" />
                                            <%# getPjQuality(Container.DataItemIndex, Eval("ProjectsCode"), Eval("Quality"), Eval("Conclusion")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ใบสรุป">
                                        <HeaderStyle Font-Size="14px" />
                                        <ItemTemplate>
                                            <%# checkapprove(Eval("ProjectsCode").ToString(), Eval("Conclusion"))%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="7%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="footerTotal" style="display: none;">
                                รวมงบประมาณทั้งหมด : <span id="ToltalBudget" class="lblTotal1" runat="server"></span>บาท
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                    <asp:View ID="edit" runat="server">
                        <div id="table1" class="PageManageDiv">
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="lblYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearS" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearS_SelectedIndexChanged" Visible="false">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblYearS" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div id="divProjectRegistration" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <span class="spantxt">ทะเบียนโครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtProjectRegistration" runat="server" Text=""></asp:Label>
                                    <%--<asp:TextBox CssClass="txtBoxL" ID="txtProjectRegistration" runat="server" MaxLength="20" Width="200px"></asp:TextBox>--%>
                                    <%--<span class="ColorRed">*</span> <span id="ErrorProjectRegistration" class="ErrorMsg">กรุณาป้อนทะเบียนโครงการ</span>--%>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">IO Code : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtIOCode" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtProjects" runat="server" Text=""></asp:Label>
                                    <asp:HiddenField ID="hdfMainSubDeptCode" runat="server" />
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประเภทโครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:RadioButtonList ID="rbtlProjectType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbtlProjectType_SelectedIndexChanged" RepeatColumns="4"></asp:RadioButtonList>
                                    <asp:RadioButtonList ID="rbtlSubProjectType" runat="server" RepeatColumns="4"></asp:RadioButtonList>
                                </div>
                            </div>
                            <div id="divStrategic" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblStrategic" CssClass="spantxt" runat="server" Text="ยุทธศาสตร์ : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblStrategic" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div id="divIdentityName2" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblIdentityName2" CssClass="spantxt" runat="server" Text="อัตลักษณ์ : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblIdentityName2" RepeatColumns="5" runat="server">
                                    </asp:CheckBoxList>
                                    <asp:Label ID="lblErrorIdentityName2" runat="server" Text="ต้องเลือกอัตลักษณ์" ForeColor="Red" Visible="false"></asp:Label>
                                    <asp:TextBox CssClass="txtBoxL" ID="txtIdentityName2" runat="server" Width="600px" Visible="false"></asp:TextBox>
                                </div>
                            </div>
                            <div id="divIdentityName" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblIdentityName" CssClass="spantxt" runat="server" Text="เอกลักษณ์ : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtIdentityName" runat="server" Width="600px" Visible="false"></asp:TextBox>
                                </div>
                            </div>
                            <div id="divStrategies" class="inputrowH" runat="server" visible="false">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ระดับองค์กร : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblStrategies" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cblStrategies_SelectedIndexChanged">
                                    </asp:CheckBoxList>
                                    <asp:Label ID="lblErrorStrategies" runat="server" Text="ต้องเลือกกลยุทธ์" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div id="divStrategicPlan" class="inputrowH" runat="server" visible="false">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ระดับแผนงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtStrategicPlan" runat="server" Text=""></asp:Label>
                                    <asp:DropDownList CssClass="ddl" ID="ddlStrategicPlan" Width="600px" runat="server" Visible="false">
                                    </asp:DropDownList>
                                    <asp:CheckBoxList ID="cblStrategicPlan" runat="server" Visible="false">
                                    </asp:CheckBoxList>
                                    <asp:Label ID="lblErrorStrategicPlan" runat="server" Text="ต้องเลือกกลยุทธ์" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div id="divCorporateStrategy" class="inputrowH" runat="server" visible="false">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวชี้วัดตามกลยุทธ์องค์กร KPI : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblCorporateStrategy" runat="server">
                                    </asp:CheckBoxList>
                                    <asp:Label ID="lblErrorCorporateStrategy" runat="server" Text="ต้องเลือก KPI" ForeColor="Red" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div id="divStrategicObjectives" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblStrategicObjectives" CssClass="spantxt" runat="server" Text="วัตถุประสงค์เชิงกลยุทธ์ :  " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblStrategicObjectives" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div id="divStandardNation" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblStandardNation" CssClass="spantxt" runat="server" Text="มาตรฐานการศึกษาชาติ : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblStandardNation" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div id="divStandardMinistry" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblStandardMinistry" CssClass="spantxt" runat="server" Text="มาตรฐานตามกฎกระทรวง : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblStandardMinistry" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="inputrowH">
                                    <div class="divF_Head">
                                        <span class="spantxt">หลักการและเหตุผล : </span>
                                    </div>
                                    <div class="divB_Head">
                                        <asp:TextBox CssClass="txtBoxNoBorder" ID="txtProjectsDetail" runat="server" Width="600px"
                                            TextMode="MultiLine" Height="80px" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วัตถุประสงค์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNoBorder" ID="txtPurpose" runat="server" Width="600px" TextMode="MultiLine"
                                        Height="80px" ReadOnly="true"></asp:TextBox>
                                    <div class="inputrowH" style="display: none;">
                                        <div class="divF_Head" style="width: 10%;">
                                            <span class="spantxt">ผลผลิต (outputs)</span>
                                        </div>
                                        <div class="divB_Head">
                                        </div>
                                    </div>
                                    <div class="inputrowH" style="display: none;">
                                        <div class="divF_Head" style="width: 10%;">
                                            <span class="spantxt">ผลลัพธ์ (outcomes)</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtPurpose2" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                            <span class="ColorRed">*</span> <span id="ErrorPurpose2" class="ErrorMsg">กรุณาป้อนวัตถุประสงค์</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวชี้วัด / เป้าหมาย / การวัดและประเมินผลความสำเร็จ : </span>
                                </div>
                                <div class="divB_Head">
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <span class="spantxt">เชิงปริมาณ</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxNoBorder" ID="txtTarget" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <span class="spantxt">เชิงคุณภาพ</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxNoBorder" ID="txtTarget2" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="inputrowH">
                                    <div class="divF_Head">
                                        <span class="spantxt">เครื่องมือที่ใช้ : </span>
                                    </div>
                                    <div class="divB_Head">
                                        <asp:TextBox CssClass="txtBoxNoBorder" ID="txtEvaTool" runat="server" Width="600px"
                                            TextMode="MultiLine" Height="80px" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ระยะเวลาดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtPeriod1" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่ดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtSDay" runat="server" Text=""></asp:Label>
                                    <span class="spantxt">ถึงวันที่</span>
                                    <asp:Label ID="txtEDay" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">สถานที่ดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtPlace" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผู้รับผิดชอบโครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:HiddenField ID="hdfCreateUser" runat="server" />
                                    <asp:Label ID="txtResponsibleName" runat="server" Text=""></asp:Label>
                                    <span class="spantxt">ตำแหน่ง : </span>
                                    <asp:Label ID="txtResponsiblePosition" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงาน :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlDept" runat="server" Width="330" AutoPostBack="true" OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblDept" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงานที่เกี่ยวข้อง :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlDeptJoin" runat="server" Width="330">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblDeptJoin" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH" style="display: none;">
                                <div class="divF_Head">
                                    <span class="spantxt">ลำดับที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum" ID="txtSort" runat="server" onkeypress="return KeyNumber(event);"
                                        Width="50px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">บทสรุปโครงการ / กิจกรรม :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtConclusion" runat="server" Width="600px"
                                        TextMode="MultiLine" Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorConclusion" class="ErrorMsg">กรุณาป้อนบทสรุปโครงการ / กิจกรรม</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผลการดำเนินงานที่ได้รับ / ผลสัมฤทธิ์ :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtPerformance" runat="server" Width="600px"
                                        TextMode="MultiLine" Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorPerformance" class="ErrorMsg">กรุณาป้อนผลการดำเนินงานที่ได้รับ / ผลสัมฤทธิ์</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปัญหาและอุปสรรค :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtProblem" runat="server" Width="600px"
                                        TextMode="MultiLine" Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorProblem" class="ErrorMsg">กรุณาป้อนปัญหาและอุปสรรค</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">แนวทางการแก้ไข :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtSolutions" runat="server" Width="600px"
                                        TextMode="MultiLine" Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorSolutions" class="ErrorMsg">กรุณาป้อนแนวทางการแก้ไข</span>
                                </div>
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
                                <asp:Label ID="lblApprove" runat="server" CssClass="spantxt4"></asp:Label><br />
                                <asp:Label ID="lblComment" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <div class="classButton">
                                    <div class="classBtSave">
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                            OnClientClick="return Cktxt(1, 2);" ToolTip="บันทึกโครงการนี้" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกโครงการนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
