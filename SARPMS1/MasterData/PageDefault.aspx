<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="PageDefault.aspx.cs"
    Inherits="PageDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../CSS/slider.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/flexslider.css" rel="stylesheet" type="text/css" />

    <script defer src="../scripts/jquery.flexslider.js" type="text/javascript"></script>
    <script src="../scripts/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../scripts/FusionCharts.js" type="text/javascript"></script>

    <script type="text/javascript">
        function AlertActivity() {
            dialogBox.show('../PopUp/PopUpAlertActivity.aspx', 'แจ้งสถานะกิจกรรม', '1200', '500', '#000', true, 'yes');
        }
        $(window).load(function () {
            $('.flexslider').flexslider({
                animation: "slide"
            });
        });
        function PopUpUplodeImage() {
            dialogBox.show('../PopUp/PopUpUploadImageSlider.aspx', 'แนบไฟล์รูป', '1000', '400', '#000', true, 'yes');
        }

        function getPopUpActivity(id) {
            dialogBox.show('../PopUp/PopUpActivityPresent.aspx?mode=2&id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true);
        }
        function getPopUpActivityDetail(id) {
            dialogBox.show('../PopUp/ActivityDetail.aspx?acid=' + id, 'รายละเอียดการทำกิจกรรม', '1000', '600', '#000', true);
        }
    </script>

    <%--<meta http-equiv="refresh" content="100;URL=../MasterData/ReportTreeView.aspx?ck=1" />--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="centerDiv" style="text-align: center; background-color: White; width: 99%; float: left; height: auto;">
                <div style="float: left; padding: 10px 0 0 20px;">
                    <asp:Image ID="Image1" runat="server" ImageUrl="../Image/megaphone.gif" ToolTip="ประกาศ" Width="33px" />
                </div>
                <div style="float: left; padding: 15px 0 0 15px; background-color: White; width: 90%;">
                    <marquee><span ID="lblComment" runat="server" class="spantxthead" style="color:#41a0a0; font-size:16pt; font-weight:bold;"></span></marquee>
                </div>
                <div style="background-color: White;">
                    <asp:LinkButton ID="lbtUpdateComment" runat="server" OnClick="lbtUpdateComment_OnClick" ForeColor="Gray">ประกาศ</asp:LinkButton>
                </div>
                <div class="spaceDiv"></div>
                <div style="float: left; width: 100%; text-align: center;">
                    <span id="spnAlertRenew" runat="server" style="color: red; font-size: 16pt; font-weight: bold;"></span>
                </div>
                <div class="centerDiv" style="background-color: White;">
                    <asp:TextBox ID="txtComment" CssClass="txtBox" Width="550" MaxLength="500" runat="server" Visible="false"></asp:TextBox>
                    <asp:Button ID="btSave" runat="server" Text="บันทึก" CssClass="btYesCm" Visible="false" OnClick="btSave_OnClick" /><asp:Button ID="btCancel"
                        runat="server" Text="ยกเลิก" CssClass="btNoCm" Visible="false" OnClick="btCancel_OnClick" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="clear"></div>
    <div style="float:left; text-align: center; width: 100%; height:auto; padding: 30px 0 0 0; background-color:#f2f2f2; border-radius:10px;">
            <div class="centerDiv">
                <span style="font-size: 20pt; font-weight: bold; color: #272727;">
                    <%=ConfigurationManager.AppSettings["ProjectName"] + " V." + Star.VersionControl.Versions.ProductVersion%></span><br />
                <br />
                <span style="font-size: 18pt; font-weight: bold; color: #272727;">ยินดีต้อนรับ</span>
                <div style="padding: 30px 0 0 0;">
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <img src="<%#Eval("LogoPath")%>" class="<%#(Eval("LogoPath").ToString()==""?"dpnone":"")%>" /><br />
                            <span style="font-size: 16pt; font-weight: bold; color: Navy;"><%#Eval("SchoolName")%></span><br />
                            <br />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        <div class="clear"></div>
        <div class="spaceDiv"></div>
        <div class="spaceDiv"></div>
        <%--<div style="text-align: center;">
            <br />
            <img src="../Image/loading.gif" /><br />
        </div>--%>
        <%--<center>
            <div style="width: 50px; text-align: left; color: Black; font-weight: bold;">
                Loading<span id="loading"></span>
            </div>
        </center>--%>.
        <div id="divGraph1" class="divGraph" style="border: solid 5px #f9b806; width: 47%; height: 440px; background: url(../Image/OpacityBG.png) repeat bottom;">
            <div class="spaceDiv"></div>
            <div style="text-align: center; padding: 30px 0 0 0;">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <%--<img src="<%#Eval("LogoPath")%>" class="<%#(Eval("LogoPath").ToString()==""?"dpnone":"")%>" /><br />--%>
                        <span style="font-size: 22pt; font-weight: bold; color: Navy;"><%#Eval("SchoolName")%></span><br />
                        <br /><br />
                        <span class="spantxt2" style="font-size:20px;">วิสัยทัศน์</span><br />
                        <span class="spantxt4" style="font-size:18px;"><%#Eval("Vision")%></span><br />
                        <br />
                        <span class="spantxt2" style="font-size:20px;">ปรัชญา</span><br />
                        <span class="spantxt4" style="font-size:18px;"><%#Eval("Philosophy")%></span><br />
                        <br />
                        <span class="spantxt2" style="font-size:20px;">เอกลักษณ์</span><br />
                        <span class="spantxt4" style="font-size:18px;"><%#Eval("IdentityName")%></span><br />
                        <br />
                        <span class="spantxt2" style="font-size:20px;">อัตลักษณ์</span><br />
                        <span class="spantxt4" style="font-size:18px;"><%#Eval("IdentityName2")%></span><br />
                        <br />
                        <span class="spantxt2" style="font-size:20px;">คุณธรรมอัตลักษณ์</span><br />
                        <span class="spantxt4" style="font-size:18px;"><%#Eval("Slogan")%></span>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="spaceDiv"></div>
            <div class="spaceDiv"></div>
        </div>
        <div id="divGraph2" class="divGraph" style="border: solid 5px #21a9c1; width: 47%; height: 440px; background: url(../Image/OpacityBG.png) repeat bottom;">
            <div class="spaceDiv"></div>
            <div class="divSpntxtHeadGraph">
                <img src="../Image/Icon/IconGraph.png" />
                รูปภาพกิจกรรม
            </div>
            <div class="divFrameGraph">
                <div id="Div1" style="width: 99%; overflow: hidden;">
                    <div class="flexslider" style="width: 500px; height: 300px;">
                        <ul class="slides">
                            <asp:Repeater ID="rptImageSlider" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <img src="../AttachFile/<%# genImage(Eval("ItemID"), Eval("Title")) %>" width="500" height="300" />
                                        <p class="flex-caption"><%# genStr(Eval("Title")) %></p>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div id="divSetImg" runat="server" style="float: right; padding-top: 35px; padding-right: 10px; color: white;">
                <a href="javascript:;" onclick="PopUpUplodeImage()">
                    <img src="../image/MenuStlye/S0.png" />
                    ปรับเปลี่ยนรูป</a>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div id="divGraph6" class="divGraph" style="border: solid 5px #e29427; width: 97%; height: auto; background: url(../Image/OpacityBG.png) repeat bottom;">
                    <div class="spaceDiv"></div>
                    <div class="spaceDiv"></div>
                    <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาโครงการรออนุมัติ</span>
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
                                        <span class="spantxt">หน่วยงานหลัก : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainDept2" Width="500px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainDept2_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานรอง : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainSubDept2" Width="500px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainSubDept2_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงาน : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearchDept2" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchDept2_SelectedIndexChanged" Width="500px">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">ผู้รับผิดชอบ : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearchEmp2" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchEmp2_SelectedIndexChanged" Width="350px">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="spaceDiv"></div>
                                <div class="SearchTotal">
                                    <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal2" class="spantxt"
                                        style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                                </div>
                                <div class="spaceDiv"></div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="DataGridView1" runat="server" ShowFooter="true" PageSize="50">
                                <Columns>
                                    <Control:TemplateField HeaderText="ที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="สถานะ">
                                        <ItemTemplate>
                                            <%# GetstatusIsApprove(Eval("ProjectsCode"), Eval("IsWait")) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
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
                                    <Control:TemplateField HeaderText="ทะเบียน คก.">
                                        <ItemTemplate>
                                            <%# Eval("ProjectRegistration").ToString() %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อโครงการ">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("ProjectsCode").ToString(), Eval("EmpID").ToString(), Eval("ProjectsName").ToString())%>
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
                                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        <FooterTemplate>
                                            <%# GetTotalBudget().ToString("N2")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="ผู้สร้าง" DataField="EmpName">
                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    <div class="spaceDiv"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div id="divGraph3" class="divGraph" style="border: solid 5px #bc202d; width: 97%; height: auto; background: url(../Image/OpacityBG.png) repeat bottom;">
                    <div class="spaceDiv"></div>
                    <div class="spaceDiv"></div>
                    <div class="TableSearch">
                        <div class="SearchTable">
                            <div class="SearchHead">
                                <span class="spantxt2 spansize14">ค้นหากิจกรรม</span>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="inputrow" style="height: auto; padding-bottom: 10px;">
                                <div class="SearchtxtF" style="width: 15%;">
                                    <span class="spantxt">สถานะ : </span>
                                </div>
                                <div class="SearchF" style="height: auto; width: 83%;">
                                    <asp:RadioButtonList ID="rbtlStatus" runat="server" RepeatColumns="3" AutoPostBack="true"
                                        ForeColor="Navy" OnSelectedIndexChanged="rbtlStatus_OnSelectedIndexChanged">
                                    </asp:RadioButtonList>
                                </div>
                            </div>
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
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
                <div id="divGraph4" class="divGraph" style="border: solid 5px #949494; width: 47%; height: 355px;">
                    <div class="spaceDiv"></div>
                    <div class="divSpntxtHeadGraph">
                        <img src="../Image/Icon/IconGraph.png" />
                        กราฟจำนวนกิจกรรมตามสถานะต่างๆ
                    </div>
                    <div class="divFrameGraph">
                        <div id="graphPnl1" runat="server"></div>
                    </div>
                </div>
                <div id="divGraph5" class="divGraph" style="border: solid 5px #47bb98; width: 47%; height: 355px;">
                    <div class="spaceDiv"></div>
                    <div class="divSpntxtHeadGraph">
                        <img src="../Image/Icon/IconGraph.png" />
                        กราฟจำนวนกิจกรรมตามสถานะต่างๆ
                    </div>
                    <div class="divFrameGraph">
                        <div id="graphPnl2" runat="server"></div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
