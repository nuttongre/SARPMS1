<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpActivityPresent.aspx.cs" Inherits="PopUpActivityPresent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

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
                        <div style="float: left; padding:0px 10px;"><span class="spantxt">ปีการศึกษา : </span></div>
                        <div style="float: left;">
                            <asp:Label ID="lblYearB" CssClass="spantxt3" runat="server"></asp:Label>
                        </div>
                        <div style="float: left; padding:0px 10px;"><span class="spantxt">ปีงบประมาณ : </span></div>
                        <div style="float: left;">
                            <asp:Label ID="lblBudgetYear" CssClass="spantxt3" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">วันที่เริ่มกิจกรรม : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="txtSDay" CssClass="spantxt4" runat="server"></asp:Label>
                        <span class="spantxt">วันที่สิ้นสุดกิจกรรม : </span>
                        <asp:Label ID="txtEDay" CssClass="spantxt4" runat="server"></asp:Label>
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
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">งบประมาณ : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Label ID="txtTotalAmount" CssClass="spantxt5" runat="server"></asp:Label>&nbsp;<span
                            class="spantxt3">บาท</span>
                    </div>
                </div>
                <div class="inputrowH">
                    <div class="divF_Head">
                        <span class="spantxt">ตัวชี้วัด : </span>
                    </div>
                    <div class="divB_Head">
                        <asp:Repeater ID="rptIncicators2" runat="server">
                            <ItemTemplate>
                                <div style="float: left; width: 100%;">
                                    <span class="spantxt3"><%#Container.ItemIndex + 1 %>.<%#Eval("IndicatorsName2")%></span>
                                </div>
                                <div class="inputrowH">
                                    <div style="float: left;">
                                        <span class="spantxt4" style="padding: 0 0 0 20px;">ตัววัด :<%#Eval("txtWeightType")%></span>
                                    </div>
                                    <div style="float: left; padding: 0 0 0 20px;">
                                        <span class="spantxt">:- </span>
                                    </div>
                                    <div style="float: left;padding:0px 10px;">
                                        <span class="spantxt4">จากทั้งหมด : <%#Convert.ToDecimal(Eval("OffAll")).ToString("#,##0.00")%></span>
                                    </div>
                                    <div style="float: left;padding:0px 10px;">
                                        <span class="spantxt4">เกณฑ์ที่ผ่าน : <%#Convert.ToDecimal(Eval("Weight")).ToString("#,##0.00")%>&nbsp;<%#(Eval("txtWeightType").ToString() == "%") ? "%" : ""%>
                                    </div>
                                </div>
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
