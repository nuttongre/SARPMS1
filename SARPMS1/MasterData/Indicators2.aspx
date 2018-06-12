<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Indicators2.aspx.cs" Inherits="Indicators2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "Indicators2.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "Indicators2.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "Indicators2.aspx?mode=3&id=" + id;
        }
        function gotoItem(id) {
            location.href = "Evaluation.aspx?mode=1&id=" + id;
        }
        function Cancel() {
            location.href = "Indicators2.aspx";
        }
        function printRpt(mode, type, id) {
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type);
        }
        function Cktxt(m) {
            var ck = 0;
            <%--var ddlStrategies = $get("<%=ddlStrategies.ClientID%>");
            var ErrorStrategies = $get("ErrorStrategies");--%>
            var ddlProjects = $get("<%=ddlProjects.ClientID%>");
            var ErrorProjects = $get("ErrorProjects");
            var ddlActivity = $get("<%=ddlActivity.ClientID%>");
            var ErrorActivity = $get("ErrorActivity");
            var txtIndicators2 = $get("<%=txtIndicators2.ClientID%>");
            var ErrorIndicators2 = $get("ErrorIndicators2");
            var txtEvaAssessment = $get("<%=txtEvaAssessment.ClientID%>");
            var ErrorEvaAssessment = $get("ErrorEvaAssessment");
            var txtEvaTool = $get("<%=txtEvaTool.ClientID%>");
            var ErrorEvaTool = $get("ErrorEvaTool");
            var txtWeight = $get("<%=txtWeight.ClientID%>");
            var ErrorWeight = $get("ErrorWeight");
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");

            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckTxtNull(m, txtWeight, ErrorWeight);
            ck += ckTxtNull(m, txtEvaTool, ErrorEvaTool);
            ck += ckTxtNull(m, txtEvaAssessment, ErrorEvaAssessment);
            ck += ckTxtNull(m, txtIndicators2, ErrorIndicators2);
            ck += ckDdlNull(m, ddlActivity, ErrorActivity);
            ck += ckDdlNull(m, ddlProjects, ErrorProjects);
            //ck += ckDdlNull(m, ddlStrategies, ErrorStrategies);

            if (ck > 0) {
                return false;
            }
            else {
                return CktxtAll();
                //return true;
            }
        }
        function CktxtAll() {
            if ($get("<%=txtAll.ClientID%>").value == "0") {
                $get("ErrorAll").style.display = "block";
                return false;
            }
            else {
                $get("ErrorAll").style.display = "none";
                return true;
            }
        }
        function CkNum() {
            var txtAll = $get("<%=txtAll.ClientID%>");
            var txtWeight = $get("<%=txtWeight.ClientID%>");

            $get("<%=txtAll.ClientID%>").value = (txtAll.value == "") ? "0" : txtAll.value.comma();
            $get("<%=txtWeight.ClientID%>").value = (txtWeight.value == "") ? "0" : txtWeight.value.comma();
        }
        function Calculate(mode) {
            var txtAll = parseFloat($get("<%=txtAll.ClientID%>").value.replace(/,/g, ''));
            var txtWeight = parseFloat($get("<%=txtWeight.ClientID%>").value.replace(/,/g, ''));
            var txtEqual = parseFloat($get("txtEqual").value.replace(/,/g, ''));

            if (txtAll == 0) {
                txtAll = 1;
            }
            if (mode == 0) {
                $get("txtEqual").value = ((txtWeight * 100) / txtAll).toFixed(2);
            }
            else {
                $get("<%=txtWeight.ClientID%>").value = ((txtEqual * txtAll) / 100).comma();
        }
    }
    function ckRate() {
        var txtAll = parseFloat($get("<%=txtAll.ClientID%>").value.replace(/,/g, ''));
            var txtWeight = parseFloat($get("<%=txtWeight.ClientID%>").value.replace(/,/g, ''));

            if (txtWeight > txtAll) {
                var str = "เกณฑ์ที่ผ่าน  ไม่สามาถมากกว่าจำนวนทั้งหมดได้ !!!";
                var ratetype = $get("<%=ddlRateType.ClientID%>").selectedIndex;
                if (ratetype != 0) {
                    str = "คะแนนที่ผ่าน  ไม่สามาถมากกว่าคะแนนเต็มได้ !!!";
                }
                alert(str);
                $get("<%=txtWeight.ClientID%>").value = "0";
                Calculate(0);
                return;
            }
        }
        function ckRateType(mode) {
            var ratetype = $get("<%=ddlRateType.ClientID%>").selectedIndex;
            if (ratetype == 0) {
                $get('spnAll').innerHTML = "จำนวนทั้งหมด : ";
                $get("<%=txtAll.ClientID%>").disabled = false;
                $get('spnWeight').innerHTML = "เกณฑ์ที่ผ่าน :";

                if (mode == 0) {
                    $get("<%=txtAll.ClientID%>").value = "0";
                    $get("<%=txtWeight.ClientID%>").value = "0";
                    $get("txtEqual").value = "50";
                }
            }
            else {
                $get('spnAll').innerHTML = "คะแนนเต็ม / เกรด : ";
                $get("<%=txtAll.ClientID%>").value = "5";
                $get("<%=txtAll.ClientID%>").disabled = true;
                $get('spnWeight').innerHTML = "คะแนน / เกรดที่ผ่าน :";

                if (mode == 0) {
                    $get("<%=txtWeight.ClientID%>").value = "2";
                    Calculate(0);
                }
            }
            CktxtAll();
        }
        function ckRateDetail() {
            var ratetype = $get("<%=ddlRateType.ClientID%>").selectedIndex;
            if (ratetype != 0) {
                $get("RateDetail").style.display = "block";
            }
            else {
                $get("RateDetail").style.display = "none";
            }
        }
       <%-- function getPopUpIndicators() {
            var id = $get("<%=ddlStrategies.ClientID%>").value;
            if (id != '') {
                dialogBox.show('../PopUp/PopUpIndicators.aspx?type=r&id=' + id + '&indname=' + $get('<%=txtIndicators2.ClientID %>').id, 'ตัวชี้วัด', '800', '500', '#000', true, 'yes');
            }
            else {
                alert("กรุณาเลือกกลยุทธ์ก่อนเรียกดูข้อมูล");
                $get("<%=ddlStrategies.ClientID%>").focus();
            }
        }--%>
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
                    กำหนดตัวชี้วัด
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาตัวชี้วัด</span>
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
                                        <span class="spantxt">กิจกรรม : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearch1" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearch1_SelectedIndexChanged" Width="500px">
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
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">คำค้นหา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
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
                            <div class="btAddDiv">
                                <input type="button" class="btAdd" onclick="AddItem();" value="      สร้างตัวชี้วัดใหม่" title="สร้างตัวชี้วัดใหม่" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" PageSize="20">
                                <Columns>
                                    <Control:TemplateField HeaderText="ลำดับที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ตัวชี้วัด">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("Indicators2Code")%>');"><%# Eval("IndicatorsName2") %></a>
                                        </ItemTemplate>
                                        <ItemStyle Width="53%" HorizontalAlign="Left" />
                                    </Control:TemplateField>
                                    <%--<Control:BoundField HeaderText="ประเมินแบบ" DataField="RateType">
                                        <ItemStyle Width="8%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="ตัววัด" DataField="WeightType">
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </Control:BoundField>--%>
                                    <Control:BoundField HeaderText="จำนวนทั้งหมด" DataField="OffAll" DataFormatString="{0:n0}">
                                        <ItemStyle Width="8%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="เกณฑ์ที่ผ่าน" DataField="Weight" DataFormatString="{0:n0}">
                                        <ItemStyle Width="8%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="เทียบเท่า" DataField="ckPercen">
                                        <ItemStyle Width="6%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("Indicators2Code")%>');">
                                                <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("Indicators2Code") %>');">
                                                <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ทำต่อ">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="gotoItem('<%#Eval("Indicators2Code") %>');">
                                                <img style="border: 0; cursor: pointer;" title="เชื่อมโยงตัวบ่งชี้ภายใต้ตัวชี้วัดนี้" src="../Image/goto.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
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
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearB_OnSelectedChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <%--<div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlStrategies" Width="600px" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlStrategies_OnSelectedChanged" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorStrategies" class="ErrorMsg">เลือกกลยุทธ</span>
                                </div>
                            </div>--%>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlProjects" Width="600px" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlProjects_OnSelectedChanged" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorProjects" class="ErrorMsg">เลือกโครงการ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlActivity" Width="600px" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlActivity_OnSelectedChanged" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorActivity" class="ErrorMsg">เลือกกิจกรรม</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">รายละเอียดกิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtActivityDetail" CssClass="spantxt4" runat="server" Width="600px"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประเภท : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblType" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ภาคเรียนที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblTerm" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปีงบประมาณ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblBudgetYear" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">งบประมาณ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtTotalAmount" CssClass="spantxt2 spantxt5" runat="server"></asp:Label>&nbsp;<span
                                        class="spantxt2 spantxt3">บาท</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblDepartment" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผู้รับผิดชอบ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblEmpName" runat="server" CssClass="spantxt2 spantxt4"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่เริ่มกิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtSDay" CssClass="spantxt2 spantxt4" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่สิ้นสุดกิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="txtEDay" CssClass="spantxt2 spantxt4" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวชี้วัด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtIndicators2" Width="600px" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span><%--<img src="../image/look.png" title="เรียกดูตัวชี้วัดความสำเร็จ" style="cursor: pointer; vertical-align: bottom;"
                                        onclick="getPopUpIndicators();" />--%><span id="ErrorIndicators2" class="ErrorMsg">กรุณาป้อนตัวชี้วัด</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วิธีการประเมิน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtEvaAssessment" Width="600px" runat="server" TextMode="MultiLine" Height="50"></asp:TextBox>
                                    <span class="ColorRed">*</span><span id="ErrorEvaAssessment" class="ErrorMsg">กรุณาป้อนวิธีการประเมิน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">เครื่องมือที่วัด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtEvaTool" Width="600px" runat="server" TextMode="MultiLine" Height="50"></asp:TextBox>
                                    <span class="ColorRed">*</span><span id="ErrorEvaTool" class="ErrorMsg">กรุณาป้อนเครื่องมือที่วัด</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประเมินแบบ : </span>
                                </div>
                                <div class="divB_Head">
                                    <div style="float: left">
                                        <asp:DropDownList ID="ddlRateType" CssClass="ddl" runat="server">
                                            <asp:ListItem Text="เชิงปริมาณ" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="เชิงคุณภาพ" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <span id="RateDetail" style="display: none; float: left; margin-left: 15px;">คะแนนเกณฑ์  :  1 = ปรับปรุง, 2 = พอใช้, 3 = ดี, 4 = ดีมาก, 5 = ดีเยี่ยม</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="spnAll" class="spantxt">จำนวนทั้งหมด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum" ID="txtAll" Width="100px" onkeypress="return KeyNumber(event);" runat="server" Text="0"
                                        onclick="SelecttxtAll(this);" onkeyup="txtZero(this,0);" onblur="txtZero(this,0);"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorAll" class="ErrorMsg">จำนวนทั้งหมดห้ามเป็น 0</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="spnWeight" class="spantxt">คะแนน / เกรดที่ผ่าน :</span>
                                </div>
                                <div class="divB_Head">
                                    <div style="float: left;">
                                        <span id="lblWeight1" class="spantxt2 spantxt3"></span>
                                        <asp:TextBox CssClass="txtBoxNum" ID="txtWeight" MaxLength="15" Width="100px" onkeypress="return KeyNumber(event);"
                                            runat="server" Text="50" onkeyup="Calculate(0);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0);"></asp:TextBox>
                                    </div>
                                    <div style="float: left; padding: 0 5px;"><span id="spnEqual" class="spantxt2 spantxt3">เทียบเท่า : </span></div>
                                    <div id="divEqual" style="float: left;">
                                        <input id="txtEqual" type="text" class="txtBoxNum" maxlength="8" style="width: 50px;" value="50" onkeypress="return KeyNumber(event);" onkeyup="Calculate(1);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0);" />
                                    </div>
                                    <div style="float: left; padding: 0 5px;"><span id="spnEqual2" class="spantxt2 spantxt3"></span>% </div>
                                    <div style="float: left;"><span class="ColorRed">*</span><span style="color: gray; font-size: 16px;"> ของเกณฑ์ผ่านที่ 50 %</span></div>
                                    <div style="float: left;"><span id="ErrorWeight" class="ErrorMsg">กรุณาป้อนเกณฑ์ที่ผ่าน</span></div>
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
                                <asp:Label ID="lblCreate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="centerDiv">
                                <asp:Label ID="lblUpdate" runat="server" CssClass="spantxt4"></asp:Label>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <div class="classButton">
                                    <div class="classBtSave">
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                            OnClientClick="return Cktxt(1);" ToolTip="บันทึกตัวชี้วัดนี้" />
                                        <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างตัวชี้วัดใหม่"
                                            OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกตัวชี้วัดนี้และสร้างตัวชี้วัดใหม่" />
                                        <asp:Button ID="btSaveAndGo" CssClass="btYesAndGo" runat="server" Text="       บันทึกและเชื่อมโยงตัวบ่งชี้"
                                            OnClick="btSaveAndGo_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกตัวชี้วัดนี้และเชื่อมโยงตัวบ่งชี้" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกตัวชี้วัดนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server" Visible="false">
                                    <Columns>
                                        <Control:BoundField HeaderText="ตัวชี้วัด" DataField="IndicatorsName2">
                                            <ItemStyle Width="70%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <%--<Control:BoundField HeaderText="ตัววัด" DataField="WeightType">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>--%>
                                        <Control:BoundField HeaderText="จำนวนทั้งหมด" DataField="OffAll" DataFormatString="{0:n0}">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="เกณฑ์ที่ผ่าน" DataField="Weight" DataFormatString="{0:n0}">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="เทียบเท่า" DataField="ckPercen">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
