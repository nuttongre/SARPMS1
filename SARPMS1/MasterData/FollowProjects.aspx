<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="FollowProjects.aspx.cs" Inherits="FollowProjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function EditItem(id) {
            location.href = "FollowProjects.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "FollowProjects.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "FollowProjects.aspx";
        }
        function printRpt(mode, type, id) {
            var ckSing = $get("<%=cbNotSign.ClientID%>").checked;
            var ckLogo = $get("<%=cbNotLogo.ClientID%>").checked;
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type + "&ckSign=" + ckSing + "&ckLogo=" + ckLogo);
        }
        function Cktxt(m, a) {
            var ck = 0;
            var txtProjectsDetail = $get("<%=txtProjectsDetail.ClientID%>");
            var ErrorProjectsDetail = $get("ErrorProjectsDetail");
            var txtProjects = $get("<%=txtProjects.ClientID%>");
            var ErrorProjects = $get("ErrorProjects");
            var txtPurpose = $get("<%=txtPurpose.ClientID%>");
            var ErrorPurpose = $get("ErrorPurpose");
            var txtPurpose2 = $get("<%=txtPurpose2.ClientID%>");
            var ErrorPurpose2 = $get("ErrorPurpose2");
            var txtTarget = $get("<%=txtTarget.ClientID%>");
            var ErrorTarget = $get("ErrorTarget");
            var txtTarget2 = $get("<%=txtTarget2.ClientID%>");
            var ErrorTarget2 = $get("ErrorTarget2");
            var txtPeriod1 = $get("<%=txtPeriod1.ClientID%>");
            var ErrorPeriod1 = $get("ErrorPeriod1");
            var txtResponsibleName = $get("<%=txtResponsibleName.ClientID%>");
            var txtResponsiblePosition = $get("<%=txtResponsiblePosition.ClientID%>");
            var ErrorResponsible = $get("ErrorResponsible");
            var ErrorApproval = $get("ErrorApproval");
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");
            var txtPlace = $get("<%=txtPlace.ClientID%>");
            var ErrorPlace = $get("ErrorPlace");
            var txtProjectRegistration = $get("<%=txtProjectRegistration.ClientID%>");
            var ErrorProjectRegistration = $get("ErrorProjectRegistration");
            var txtIOCode = $get("<%=txtIOCode.ClientID%>");
            var ErrorIOCode = $get("ErrorIOCode");

            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckTxtNull(m, txtResponsiblePosition, ErrorResponsible);
            ck += ckTxtNull(m, txtResponsibleName, ErrorResponsible);
            ck += ckTxtNull(m, txtPeriod1, ErrorPeriod1);
            ck += ckTxtNull(m, txtPlace, ErrorPlace);
            ck += ckTxtNull(m, txtTarget2, ErrorTarget2);
            ck += ckTxtNull(m, txtTarget, ErrorTarget);
            //ck += ckTxtNull(m, txtPurpose2, ErrorPurpose2);
            ck += ckTxtNull(m, txtPurpose, ErrorPurpose);
            ck += ckTxtNull(m, txtProjectsDetail, ErrorProjectsDetail);
            ck += ckTxtNull(m, txtProjects, ErrorProjects);
            ck += ckTxtNull(m, txtIOCode, ErrorIOCode);
            ck += ckTxtNull(m, txtProjectRegistration, ErrorProjectRegistration);

            if (ck > 0) {
                return false;
            }
            else {
                if (a < 2) {
                    return confirmApprove(a);
                }
                else {
                    return true;
                }
            }
        }
        function confirmApprove(mode)
        {
            if (mode == 1) {
                if (confirm('ต้องการอนุมัติโครงการนี้ใช่หรือไม่?')) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                if (confirm('ต้องการไม่ อนุมัติโครงการนี้ใช่หรือไม่?')) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        function Cktxt2(m) {
            var ck = 0;
            var ddlCreateUser = $get("<%=ddlCreateUser.ClientID%>");
            var ErrorCreateUser = $get("ErrorCreateUser");
            ck += ckDdlNull(m, ddlCreateUser, ErrorCreateUser);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
        function ckddlDate(mode) {
            if (mode == 1) {
                var d2 = $get("<%=ddlSDay.ClientID%>").value;
                var m2 = $get("<%=ddlSMonth.ClientID%>").value;
                var y2 = $get("<%=ddlSYear.ClientID%>").value;
                ckDatetimeDDL(d2, m2, y2, $get("<%=ddlSDay.ClientID%>"));

                var d = $get("<%=ddlSDay.ClientID%>").value;
                var m = $get("<%=ddlSMonth.ClientID%>").value;
                var y = $get("<%=ddlSYear.ClientID%>").value;
                $get("<%=txtSDay.ClientID%>").value = d + '/' + m + '/' + y;
            }
            if (mode == 2) {
                var d2 = $get("<%=ddlEDay.ClientID%>").value;
                var m2 = $get("<%=ddlEMonth.ClientID%>").value;
                var y2 = $get("<%=ddlEYear.ClientID%>").value;
                ckDatetimeDDL(d2, m2, y2, $get("<%=ddlEDay.ClientID%>"));

                var d = $get("<%=ddlEDay.ClientID%>").value;
                var m = $get("<%=ddlEMonth.ClientID%>").value;
                var y = $get("<%=ddlEYear.ClientID%>").value;
                $get("<%=txtEDay.ClientID%>").value = d + '/' + m + '/' + y;
            }
            //$get("<%=txtPeriod1.ClientID%>").value = $get("<%=txtSDay.ClientID%>").value + ' ถึง ' + $get("<%=txtEDay.ClientID%>").value;
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
        vertical-align:bottom; 
        border:none;
        }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    ติดตามโครงการ
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
                            <div class="ckSign">
                                <asp:CheckBox ID="cbNotSign" runat="server" Text=" เลือกให้รายงานไม่มีส่วนเซ็นชื่อ" />
                                <asp:CheckBox ID="cbNotLogo" runat="server" Text=" เลือกให้รายงานไม่แสดงโลโก้" />
                            </div>
                            <div class="spaceDiv"></div>
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
                                    <Control:TemplateField HeaderText="สถานะ">
                                        <ItemTemplate>
                                            <%# GetstatusIsApprove(Eval("ProjectsCode"), Eval("IsWait"), Eval("EmpName")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="9%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="อนุมัติ">
                                        <ItemTemplate>
                                            <%# statusIsApprove(Eval("IsApprove")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="4%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อโครงการ">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("ProjectsCode").ToString(), Eval("EmpID").ToString(), Eval("ProjectsName").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="20%" />
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
                                        <ItemStyle HorizontalAlign="Right" Width="8%" />
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
                                    <Control:BoundField HeaderText="ผู้สร้าง" DataField="EmpName">
                                        <ItemStyle Width="13%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="13%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ใบคำขอ1">
                                        <ItemTemplate>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("W") %> onclick="printRpt(12,'w','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงกิจกรรม แบบเอกสาร Word" src="../Image/WordIcon.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("E") %> onclick="printRpt(12,'e','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงกิจกรรม แบบเอกสาร Excel" src="../Image/Excel.png" /></a>
                                            <a href="javascript:;" <%# new BTC().getLinkReportWEP("P") %> onclick="printRpt(12,'p','<%#Eval("ProjectsCode")%>');">
                                                <img style="border: 0; cursor: pointer;" title="เรียกดูใบคำขอโครงการ แสดงกิจกรรม แบบเอกสาร PDF" src="../Image/PdfIcon.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="7%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ใบคำขอ2" HeaderToolTip="ใบคำขอที่ 2">
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
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("ProjectsCode").ToString(), Eval("EmpID").ToString(), "")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <%# checkdelete(Eval("ProjectsCode").ToString(), Eval("EmpID").ToString(), Eval("IsApprove"))%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="3%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="footerTotal">
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
                                        OnSelectedIndexChanged="ddlYearS_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ทะเบียนโครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtProjectRegistration" runat="server" MaxLength="20" Width="200px"></asp:TextBox>
                                    <span class="spantxt">IO Code : </span>
                                    <asp:TextBox CssClass="txtBoxL" ID="txtIOCode" runat="server" MaxLength="20" Width="200px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorProjectRegistration" class="ErrorMsg">กรุณาป้อนทะเบียนโครงการ</span><span id="ErrorIOCode" class="ErrorMsg">กรุณาป้อน IO Code</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtProjects" runat="server" MaxLength="300" Width="600px"></asp:TextBox>
                                    <asp:HiddenField ID="hdfMainSubDeptCode" runat="server" />
                                    <span class="ColorRed">*</span> <span id="ErrorProjects" class="ErrorMsg">กรุณาป้อนโครงการ/งาน</span>
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
                                </div>
                            </div>
                            <div id="divStrategicPlan" class="inputrowH" runat="server" visible="false">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ระดับแผนงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlStrategicPlan" Width="600px" runat="server" Visible="false">
                                    </asp:DropDownList>
                                    <asp:CheckBoxList ID="cblStrategicPlan" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <div id="divCorporateStrategy" class="inputrowH" runat="server" visible="false">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวชี้วัดตามกลยุทธ์องค์กร KPI : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:CheckBoxList ID="cblCorporateStrategy" runat="server">
                                    </asp:CheckBoxList>
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
                                        <asp:TextBox CssClass="txtBoxL" ID="txtProjectsDetail" runat="server" Width="600px"
                                            TextMode="MultiLine" Height="80px"></asp:TextBox>
                                        <span class="ColorRed">*</span> <span id="ErrorProjectsDetail" class="ErrorMsg">กรุณาป้อนหลักการและเหตุผล</span>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วัตถุประสงค์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtPurpose" runat="server" Width="600px" TextMode="MultiLine"
                                        Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorPurpose" class="ErrorMsg">กรุณาป้อนวัตถุประสงค์</span>
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
                                            <asp:TextBox CssClass="txtBoxL" ID="txtTarget" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                            <span class="ColorRed">*</span> <span id="ErrorTarget" class="ErrorMsg">กรุณาป้อนเป้าหมายเชิงปริมาณ</span>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <span class="spantxt">เชิงคุณภาพ</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtTarget2" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                            <span class="ColorRed">*</span> <span id="ErrorTarget2" class="ErrorMsg">กรุณาป้อนเป้าหมายเชิงคุณภาพ</span>
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
                                        <asp:TextBox CssClass="txtBoxL" ID="txtEvaTool" runat="server" Width="600px"
                                            TextMode="MultiLine" Height="80px"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ระยะเวลาดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtPeriod1" runat="server" Width="600px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorPeriod1" class="ErrorMsg">กรุณาป้อนระยะเวลา</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่ดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlSDay" CssClass="ddl" runat="server">
                                    </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlSMonth" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlSYear" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    <asp:TextBox ID="txtSDay" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                    <span class="spantxt">ถึงวันที่</span>
                                    <asp:DropDownList ID="ddlEDay" CssClass="ddl" runat="server">
                                    </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlEMonth" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlEYear" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    <asp:TextBox ID="txtEDay" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">สถานที่ดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtPlace" runat="server" Width="600px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorPlace" class="ErrorMsg">กรุณาป้อนสถานที่ดำเนินงาน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <%--<span class="spantxt">ผู้รับผิดชอบโครงการ : </span>--%>
                                    <asp:TextBox ID="spnResponsibleName" CssClass="txtBoxlblnone2" Width="200px" AutoPostBack="true" OnTextChanged="spnResponsibleName_TextChanged" runat="server"></asp:TextBox><span class="spantxt"> : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:HiddenField ID="hdfCreateUser" runat="server" />
                                    <asp:TextBox CssClass="txtBoxL" ID="txtResponsibleName" runat="server" Width="250px"></asp:TextBox>
                                    <span class="spantxt">ตำแหน่ง : </span>
                                    <asp:TextBox CssClass="txtBoxL" ID="txtResponsiblePosition" runat="server" Width="270px"></asp:TextBox>
                                    <span class="ColorRed">*</span><span id="ErrorResponsible" class="ErrorMsg">กรุณาป้อนข้อมูลผู้รับผิดชอบโครงการ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงาน :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlDept" runat="server" Width="330" AutoPostBack="true" OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorDepartment" class="ErrorMsg">กรุณาเลือกหน่วยงาน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงานที่เกี่ยวข้อง :</span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlDeptJoin" runat="server" Width="330">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ลำดับที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum" ID="txtSort" runat="server" onkeypress="return KeyNumber(event);"
                                        Width="50px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
                                </div>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Label ID="lblCreate" runat="server" CssClass="spantxt4"></asp:Label>&nbsp;<asp:LinkButton ID="lbtEditCreate" runat="server" Visible="false" OnClick="lbtEditCreate_Click">แก้ไข</asp:LinkButton>
                            </div>
                            <div id="divSearchCreateUser" runat="server" class="centerDiv" style="min-height: 25px;" visible="false">
                                <asp:TextBox ID="txtSearchCreateUser" CssClass="txtSearch" runat="server" Width="200"></asp:TextBox><asp:Button CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                    ID="btSearchCreateUser" runat="server" OnClick="btSearchCreateUser_Click" ToolTip="คลิ๊กเพื่อค้นหา" Text="  " />
                            </div>
                            <div id="divddlCreateUser" runat="server" class="centerDiv" style="min-height: 30px;" visible="false">
                                <asp:DropDownList ID="ddlCreateUser" CssClass="ddl" runat="server"></asp:DropDownList><span id="ErrorCreateUser" class="ErrorMsg">เลือกผู้รับผิดชอบโครงการ</span>
                            </div>
                            <div id="divbtnEditCreate" runat="server" class="centerDiv" style="min-height: 25px;" visible="false">
                                <asp:Button ID="btnEditCreate" runat="server" Text="บันทึก" OnClientClick="return Cktxt2(1);" OnClick="btnEditCreate_Click" /><asp:Button ID="btnCancelCreate" runat="server" Text="ยกเลิก" OnClick="btnCancelCreate_Click" />
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
                                        <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างโครงการใหม่"
                                            OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1, 2);" ToolTip="บันทึกโครงการนี้และสร้างโครงการใหม่" />
                                        <asp:Button ID="btSaveAndGo" CssClass="btYesAndGo" runat="server" Text="       บันทึกและสร้างกิจกรรมต่อ"
                                            OnClick="btSaveAndGo_Click" OnClientClick="return Cktxt(1, 2);" ToolTip="บันทึกโครงการนี้และสร้างกิจกรรมต่อ" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกโครงการนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server" Visible="false">
                                    <Columns>
                                        <Control:TemplateField HeaderText="ลำดับที่">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        </Control:TemplateField>
                                        <Control:BoundField HeaderText="ชื่อโครงการ" DataField="ProjectsName">
                                            <ItemStyle Width="80%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <%--<Control:BoundField HeaderText="งบประมาณ" DataField="TotalAmount" DataFormatString="{0:n2}">
                                            <ItemStyle Width="15%" HorizontalAlign="Right" />
                                        </Control:BoundField>--%>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="spaceDiv"></div>
                            <div id="divApprove" class="TableSearch" runat="server" visible="false">
                                <div class="SearchTable" style="width:1000px;">
                                    <div class="SearchHead">
                                        <span class="spantxt2 spansize14">ลงนาม / อนุมัติโครงการ</span>
                                    </div>
                                    <div class="spaceDiv"></div>
                                    <Control:DataGridView ID="gridApproveFlow" runat="server">
                                        <Columns>
                                            <Control:TemplateField HeaderText="ที่">
                                                <ItemTemplate>
                                                    <%# Eval("StepNo").ToString() %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="2%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="หน้าที่รับผิดชอบ">
                                                <ItemTemplate>
                                                    <%# Eval("ApproveStepName").ToString() %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="ผู้รับผิดชอบ">
                                                <ItemTemplate>
                                                    <%# Eval("EmpName").ToString() %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="ตำแหน่ง">
                                                <ItemTemplate>
                                                    <%# Eval("ApprovePositionName").ToString() %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="20%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="สถานะ">
                                                <ItemTemplate>
                                                    <%# statusIsApprove(Eval("IsApprove2")) %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="วันที่อนุมัติ">
                                                <ItemTemplate>
                                                    <%# DateIsApprove(Eval("CreateDate")) %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="ความคิดเห็น">
                                                <ItemTemplate>
                                                    <span style="font-size:12px;"><%# strComment(Eval("Comment")) %></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="13%" />
                                            </Control:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" />
                                    </Control:DataGridView>
                                    <div class="spaceDiv"></div>
                                    <div class="centerDiv">
                                        <div id="divBtApprove" class="classButton" runat="server" visible="false">
                                            <asp:TextBox ID="txtComment" TextMode="MultiLine" Height="50" Width="300" placeholder="ลงความคิดเห็น" runat="server"></asp:TextBox>
                                            <div class="spaceDiv"></div>
                                            <span>รหัสผ่าน : </span><asp:TextBox ID="txtPassword" CssClass="txtBoxL" Width="150" TextMode="Password" placeholder="รหัสผ่าน" runat="server"></asp:TextBox> <asp:Label ID="lblErrorPassword" runat="server" Visible="false" Text="รหัสผ่านไม่ถูกต้อง" ForeColor="Red"></asp:Label>
                                            <div class="spaceDiv"></div>
                                            <div class="classBtSave">
                                                <asp:Button ID="btApprove" CssClass="btApproveProject" runat="server" Text="     อนุมัติ" OnClick="btApprove_Click"
                                                    OnClientClick="return Cktxt(1, 1);" ToolTip="อนุมัติโครงการ" />
                                            </div>
                                            <div class="classBtCancel">
                                                <asp:Button ID="btUnApprove" CssClass="btUnApproveProject" runat="server" Text="     ไม่อนุมัติ" OnClick="btUnApprove_Click"
                                                    OnClientClick="return Cktxt(1, 0);" ToolTip="ไม่อนุมัติโครงการ" />
                                            </div>
                                            <div class="spaceDiv"></div>
                                        </div>
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
