<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpActivity.aspx.cs" Inherits="PopUpActivity" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../scripts/FusionCharts.js"></script>
    <script type="text/javascript">
        function AddItem() {
            location.href = "PopUpActivity.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "PopUpActivity.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "PopUpActivity.aspx?mode=3&id=" + id;
        }
        function gotoItem(id) {
            location.href = "Indicators2.aspx?mode=1&id=" + id;
        }
        function Cancel() {
            parent.loadDetail(); parent.dialogBox.close();
        }
        function printRpt(mode, type, id) {
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type);
        }
        function getPopUp(inx, id)
        {
            if (inx == 1) {
                dialogBox.show('../PopUp/PopUpActivityPresent.aspx?id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true, 'yes');
            }
        }
        function getPopUpIndicators() {
            var id = $get("<%=ddlStrategies.ClientID%>").value;
            if (id != '') {
                dialogBox.show('../PopUp/PopUpIndicators.aspx?type=c&id=' + id + '&indname=' + $get('<%=txtEvaIndicators.ClientID %>').id, 'ตัวชี้วัด', '670', '400', '#000', true, 'yes');
            }
            else {
                alert("กรุณาเลือกกลยุทธ์ก่อนเรียกดูข้อมูล");
                $get("<%=ddlStrategies.ClientID%>").focus();
            }
        }
    function getPopUpUserList(id)
    {
        var tag = document.getElementsByTagName('input');
        for(var j=0;j<tag.length;j++)
        {
            if(tag[j].checked)type=tag[j].value;
        }
        var mode = getQuerystring('mode');
        var acid = getQuerystring('id');
        dialogBox.show('../PopUp/PopUpUserList.aspx?mode=' +  mode + '&acid='+ acid + '&name=' + $get('<%=txtEmp.ClientID %>').id + '&id=' + $get('<%=userid.ClientID %>').id + '&deptname=' + $get('<%=txtDepartment.ClientID%>').id + '&deptid=' + $get('<%=JId.ClientID %>').id,'ผู้รับผิดชอบ','600','450','#000',true, 'yes');
    }
    function getPopUpSubDeptList()
    {
        var tag = document.getElementsByTagName('input');
        for(var j=0;j<tag.length;j++)
        {
            if(tag[j].checked)type=tag[j].value;
        }
        var mode = getQuerystring('mode');
        var acid = getQuerystring('id');
        dialogBox.show('../PopUp/PopUpSubDeptList.aspx?mode=' +  mode + '&acid='+ acid + '&deptid=' + $get('<%=JId.ClientID%>').value + '&subdeptname=' + $get('<%=txtSubDept.ClientID %>').id + '&subdeptid=' + $get('<%=SubDeptid.ClientID %>').id ,'หน่วยงานย่อย','600','450','#000',true, 'yes');
        }
        function ckSubDept()
        {
            if($get("<%=JId.ClientID %>").value == "")
            {
                alert("กรุณาเลือกผู้รับผิดชอบก่อน");
                return false;
            }
            else
            {
                getPopUpSubDeptList();
                return true;
            }
        }
        function ApproveBudget()
        {
            if(confirm('ต้องการกันเงินสำหรับกิจกรรมนี้ ใช่หรือไม่ ?'))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        function Cktxt(m) {
            var ck = 0;
            var ddlStrategies = $get("<%=ddlStrategies.ClientID%>");
            var ErrorStrategies = $get("ErrorStrategies");
            var ddlProjects = $get("<%=ddlProjects.ClientID%>");
            var ErrorProjects = $get("ErrorProjects");
            var txtActivity = $get("<%=txtActivity.ClientID%>");
            var ErrorActivity = $get("ErrorActivity");
            var txtEmp = $get("<%=txtEmp.ClientID%>");
            var ErrorEmp = $get("ErrorEmp");
            var txtDepartment = $get("<%=txtDepartment.ClientID%>");
            var ErrorDepartment = $get("ErrorDepartment");
            var txtActivityDetail = $get("<%=txtActivityDetail.ClientID%>");
            var ErrorActivityDetail = $get("ErrorActivityDetail");
            var txtPurpose = $get("<%=txtPurpose.ClientID%>");
            var ErrorPurpose = $get("ErrorPurpose");
            var txtTarget = $get("<%=txtTarget.ClientID%>");
            var ErrorTarget = $get("ErrorTarget");
            var txtTarget2 = $get("<%=txtTarget2.ClientID%>");
            var ErrorTarget2 = $get("ErrorTarget2");
            var txtExpected = $get("<%=txtExpected.ClientID%>");
            var ErrorExpected = $get("ErrorExpected");
            var txtPlace = $get("<%=txtPlace.ClientID%>");
            var ErrorPlace = $get("ErrorPlace");    
            var txtAlertDay = $get("<%=txtAlertDay.ClientID%>");
            var ErrorAlertDay = $get("ErrorAlertDay");                
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");
           
            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckTxtNull(m, txtAlertDay, ErrorAlertDay);
            ck += ckTxtNull(m, txtPlace, ErrorPlace);
            ck += ckTxtNull(m, txtExpected, ErrorExpected);
            ck += ckTxtNull(m, txtTarget2, ErrorTarget2);
            ck += ckTxtNull(m, txtTarget, ErrorTarget);
            ck += ckTxtNull(m, txtPurpose, ErrorPurpose);
            ck += ckTxtNull(m, txtActivityDetail, ErrorActivityDetail);
            ck += ckTxtNull(m, txtDepartment, ErrorDepartment);
            ck += ckTxtNull(m, txtEmp, ErrorEmp);
            ck += ckTxtNull(m, txtActivity, ErrorActivity);
            ck += ckDdlNull(m, ddlProjects, ErrorProjects);
            ck += ckDdlNull(m, ddlStrategies, ErrorStrategies);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
    function CkYear()
    {
        var term = $get("<%=ddlTerm.ClientID%>").value;
        var yearb = parseInt($get("<%=ddlYearB.ClientID%>").value);
        var lblckYearType = parseInt($get("<%=lblckYearType.ClientID%>").innerHTML);

        $get("<%=txtYearB.ClientID%>").value = yearb;
        
        if (lblckYearType == 0) {
            if (term == "2" || term == "2-1") {
                $get("<%=txtBudgetYear.ClientID%>").value = yearb + 1;
            }
            else {
                $get("<%=txtBudgetYear.ClientID%>").value = yearb;
            }
        }
        if (lblckYearType == 1) {
            if (term == "2" || term == "2-1") {
                $get("<%=txtBudgetYear.ClientID%>").value = yearb - 1;
            }
            else {
                $get("<%=txtBudgetYear.ClientID%>").value = yearb;
            }
        }
    }
    function SumTotal() 
    {
        var TotalAmount = 0;
        var Total = 0;              
        //var txtP = $get("<%=txtP.ClientID%>").value.replace(/,/g, '');
        var txtD = $get("<%=txtD.ClientID%>").value.replace(/,/g, '');
        var txtG = $get("<%=txtG.ClientID%>").value.replace(/,/g, '');
                                                    
        $get("<%=lblTotal.ClientID%>").innerHTML = (parseFloat(txtD) * parseFloat(txtG)).comma();
    }
    function AlertDayNull()
    {
        var AlertDay = $get("<%=txtAlertDay.ClientID%>");   
        $get("<%=txtAlertDay.ClientID%>").value=(AlertDay.value == "")? "0" : AlertDay.value;
    }
    function ckddlDate(mode)
    {
        if (mode == 1)
        {
           var d2 = $get("<%=ddlSDay.ClientID%>").value;
           var m2 = $get("<%=ddlSMonth.ClientID%>").value;
           var y2 = $get("<%=ddlSYear.ClientID%>").value;
           ckDatetimeDDL(d2, m2, y2, $get("<%=ddlSDay.ClientID%>"));
           
           var d = $get("<%=ddlSDay.ClientID%>").value;
           var m = $get("<%=ddlSMonth.ClientID%>").value;
           var y = $get("<%=ddlSYear.ClientID%>").value;
           $get("<%=txtSDay.ClientID%>").value = d + '/' + m + '/' + y;
       }
       if (mode == 2)
       {
           var d2 = $get("<%=ddlEDay.ClientID%>").value;
            var m2 = $get("<%=ddlEMonth.ClientID%>").value;
            var y2 = $get("<%=ddlEYear.ClientID%>").value;
            ckDatetimeDDL(d2, m2, y2, $get("<%=ddlEDay.ClientID%>"));
           
            var d = $get("<%=ddlEDay.ClientID%>").value;
            var m = $get("<%=ddlEMonth.ClientID%>").value;
            var y = $get("<%=ddlEYear.ClientID%>").value;
            $get("<%=txtEDay.ClientID%>").value = d + '/' + m + '/' + y;
        }
        $get("<%=txtPeriod1.ClientID%>").value = $get("<%=txtSDay.ClientID%>").value + ' ถึง ' + $get("<%=txtEDay.ClientID%>").value;
    }
    function ckddlRealDate(mode)
    {
        if (mode == 1)
        {
            var d2 = $get("<%=ddlRealSDay.ClientID%>").value;
                var m2 = $get("<%=ddlRealSMonth.ClientID%>").value;
                var y2 = $get("<%=ddlRealSYear.ClientID%>").value;
                ckDatetimeDDL(d2, m2, y2, $get("<%=ddlRealSDay.ClientID%>"));
           
                var d = $get("<%=ddlRealSDay.ClientID%>").value;
                var m = $get("<%=ddlRealSMonth.ClientID%>").value;
                var y = $get("<%=ddlRealSYear.ClientID%>").value;
                $get("<%=txtRealSDate.ClientID%>").value = d + '/' + m + '/' + y;
            }
            if (mode == 2)
            {
                var d2 = $get("<%=ddlRealEDay.ClientID%>").value;
           var m2 = $get("<%=ddlRealEMonth.ClientID%>").value;
           var y2 = $get("<%=ddlRealEYear.ClientID%>").value;
           ckDatetimeDDL(d2, m2, y2, $get("<%=ddlRealEDay.ClientID%>"));
           
           var d = $get("<%=ddlRealEDay.ClientID%>").value;
           var m = $get("<%=ddlRealEMonth.ClientID%>").value;
           var y = $get("<%=ddlRealEYear.ClientID%>").value;
           $get("<%=txtRealEDate.ClientID%>").value = d + '/' + m + '/' + y;
       }
       $get("<%=txtPeriod2.ClientID%>").value = $get("<%=txtRealSDate.ClientID%>").value + ' ถึง ' + $get("<%=txtRealEDate.ClientID%>").value;
        }
        function cktxtBudgetType()
        {
            if($get("<%=ddlBudgetType.ClientID%>").selectedIndex == 3)
        {
            $get("spnBudgetType").style.display = "block";
            $get("<%=txtBudgetType.ClientID%>").style.display = "block";
        }
        else
        {
            $get("spnBudgetType").style.display = "none";
            $get("<%=txtBudgetType.ClientID%>").style.display = "none";
            $get("<%=txtBudgetType.ClientID%>").value = "";
        }
    }
    function ckAddBudget()
    {
        if($get("<%=txtListName.ClientID%>").value == "")
        {
            $get("ErrorAddBudget").style.display = "block";
            return false;
        }
        else
        {
            $get("ErrorAddBudget").style.display = "none";
            return true;
        }
    }
    function editmodeBg(id)
    {
        var ListName = $get("spnListName"+id).innerHTML;
        var EntryCostsCode = $get("spnEntryCostsCode"+id).innerHTML;
        var BudgetType = $get("spnBudgetTypeCode"+id).innerHTML;
        var BudgetTypeName = $get("spnBudgetTypeName"+id).innerHTML;
        var TotalP = $get("spnTotalP"+id).innerHTML;
        var TotalD = $get("spnTotalD"+id).innerHTML;
        var TotalG = $get("spnTotalG"+id).innerHTML;
                
        $get("<%=txtid.ClientID%>").value = id;
        $get("<%=txtListName.ClientID%>").value = Trim(ListName);
        $get("<%=ddlEntryCosts.ClientID%>").value = Trim(EntryCostsCode);
        $get("<%=ddlBudgetType.ClientID%>").value = Trim(BudgetType);
        $get("<%=txtBudgetType.ClientID%>").value = CutBracket(Trim(BudgetTypeName)).substring(8);
        $get("<%=txtP.ClientID%>").value = Trim(TotalP);
        $get("<%=txtD.ClientID%>").value = Trim(TotalD);
        $get("<%=txtG.ClientID%>").value = Trim(TotalG);
        SumTotal();
        cktxtBudgetType();
    }
    function ckAddOperation2()
    {
        if($get("<%=txtOperation2.ClientID%>").value == "")
        {
            $get("ErrorOperation2").style.display = "block";
            return false;
        }
        else
        {
            $get("ErrorOperation2").style.display = "none";
            return true;
        }
    }
    function editmode(id)
    {
        var OperationName = $get("spnOperation"+id).innerHTML;
        var Budget = $get("spnBudget"+id).innerHTML;
        
        $get("<%=txtid2.ClientID%>").value = id;
        $get("<%=txtOperation2.ClientID%>").value = Trim(OperationName);
        $get("<%=txtBudget2.ClientID%>").value = Trim(Budget);
    }
        function PopUpClose() {
            parent.loadDetail();
            parent.dialogBox.close();
            //window.parent.document.location.reload();
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="AutoComplete.asmx" />

        </Services>
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>

            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    แก้ไขกิจกรรม
                </div>
                <div style="float:right; padding-right:20px;">
                    <input type="button" class="btNo" value="      ออก" title="ออก" onclick="Cancel();" />
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหากิจกรรม</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">ปีการศึกษา : </span>
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
                                            OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged" Width="250px">
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
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา"
                                            Text="  " />
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
                                <input type="button" class="btAdd" onclick="AddItem();" value="      สร้างกิจกรรมใหม่" title="สร้างกิจกรรมใหม่" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" ShowFooter="true" PageSize="20">
                                <Columns>
                                    <Control:TemplateField HeaderText="ลำดับที่">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="อนุมัติ" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img title="<%# (Convert.ToInt32(Eval("ApproveFlag"))== 0?"ยังไม่อนุมัติ":"อนุมัติแล้ว") %>"
                                                src='../Image/<%# (Convert.ToInt32(Eval("ApproveFlag"))== 0?"no":"ok") %>.png' />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                        <FooterTemplate>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ความสมบูรณ์" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# GenConnection(Convert.ToInt32(Eval("ConnectInd")), Convert.ToInt32(Eval("ConnectEva"))) %>
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img style="border: none; cursor: pointer;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                                src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png'
                                                onclick="getPopUp(1, '<%#Eval("ActivityCode")%>')" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("ActivityCode") %>');">
                                                <%#Eval("ActivityName")%></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
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
                                    <Control:TemplateField HeaderText="เทอม">
                                        <ItemTemplate>
                                            <%# Eval("Term").ToString() %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="7%" />
                                        <FooterTemplate>
                                            รวม :
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="งบประมาณ">
                                        <ItemTemplate>
                                            <%# GetBudget(decimal.Parse(Eval("TotalAmount").ToString())).ToString("N2")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        <ItemStyle Width="8%" />
                                        <FooterTemplate>
                                            <%# GetTotalBudget().ToString("N2")%>
                                        </FooterTemplate>
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                        <ItemStyle Width="15%" HorizontalAlign="Left" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ใบคำขอ">
                                        <ItemTemplate>
                                            <%# checkapprove(Eval("ActivityCode").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="6%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("ActivityCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("ActivityCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
                                            BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ทำต่อ">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="gotoItem('<%#Eval("ActivityCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="สร้างตัวชี้วัดใหม่ภายใต้กิจกรรมนี้"
                                                    src="../Image/goto.png" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                        <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="13pt"
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
                                    <span class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearB_OnSelectedChanged">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblckYearType" runat="server" Width="0px" ForeColor="White" ></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlStrategies" Width="600px" OnSelectedIndexChanged="ddlStrategies_OnSelectedChanged"
                                        AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorStrategies" class="ErrorMsg">เลือกกลยุทธ์</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlProjects" Width="600px" OnSelectedIndexChanged="ddlProjects_OnSelectedChanged"
                                        AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorProjects" class="ErrorMsg">เลือกโครงการ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtActivity" runat="server" Width="600px" MaxLength="200"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorActivity" class="ErrorMsg">กรุณาป้อนกิจกรรม</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผู้รับผิดชอบ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtEmp" CssClass="txtReadOnly" onkeypress="return false" runat="server"
                                        Width="600" />
                                    <span class="ColorRed">*</span>&nbsp;
                                <img src="../image/user.gif" style="cursor: pointer;" title="คลิ๊กเพื่อเลือกผู้รับผิดชอบ"
                                    onclick="getPopUpUserList();" />
                                    <span id="ErrorEmp" class="ErrorMsg">เลือกผู้รับผิดชอบ</span>
                                    <asp:HiddenField ID="userid" runat="server" />
                                    <asp:HiddenField ID="JId" runat="server" />
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtDepartment" CssClass="txtReadOnly" onkeypress="return false"
                                        runat="server" Width="600" /><asp:Button ID="btSearchDept" CssClass="btNone" OnClick="SearchDept_Click"
                                            runat="server" />
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorDepartment" class="ErrorMsg">เลือกหน่วยงาน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงานย่อย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtSubDept" CssClass="txtReadOnly" onkeypress="return false" runat="server"
                                        Width="600" />
                                    <img src="../image/dept.png" style="cursor: pointer;" title="คลิ๊กเพื่อเลือกหน่วยงานย่อย"
                                        onclick="return ckSubDept();" />
                                    <asp:HiddenField ID="SubDeptid" runat="server" />
                                </div>
                            </div>
                            <div id="divIdentityName2" class="inputrowH" runat="server">
                                <div class="divF_Head">
                                    <asp:Label ID="lblIdentityName2" CssClass="spantxt" runat="server" Text="อัตลักษณ์ : " Visible="false"></asp:Label>
                                </div>
                                <div class="divB_Head">
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
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หลักการและเหตุผล : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtActivityDetail" runat="server" TextMode="MultiLine"
                                        Height="50px" Width="600px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorActivityDetail" class="ErrorMsg">กรุณาป้อนรายละเอียดกิจกรรม</span>
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
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">เป้าหมาย : </span>
                                </div>
                                <div class="divB_Head">
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <asp:TextBox ID="lblTarget1" CssClass="txtBoxlblnone" Width="100px" Height="50px" TextMode="MultiLine" AutoPostBack="true" OnTextChanged="lblTarget1_TextChanged" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtTarget" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                            <span class="ColorRed">*</span> <span id="ErrorTarget" class="ErrorMsg">กรุณาป้อนเป้าหมายเชิงปริมาณ</span>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <asp:TextBox ID="lblTarget2" CssClass="txtBoxlblnone" Width="100px" Height="50px" TextMode="MultiLine" AutoPostBack="true" OnTextChanged="lblTarget2_TextChanged" runat="server"></asp:TextBox>
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
                                <div class="divF_Head">
                                    <span class="spantxt">ภาคเรียนที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlTerm" Width="55" runat="server">
                                    </asp:DropDownList>
                                    /
                                <asp:TextBox ID="txtYearB" runat="server" CssClass="txtBoxNum" Width="50" onkeypress="return false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปีงบประมาณ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtBudgetYear" runat="server" CssClass="txtBoxNum" Width="50" onkeypress="return false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประเภท : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:RadioButtonList ID="rbtlType" RepeatColumns="2" runat="server">
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่ทำแผนกิจกรรม : </span>
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
                                    <span class="spantxt">( ติดตามงาน )</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">จำนวนวันเตือนก่อนถึงกำหนด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum" ID="txtAlertDay" MaxLength="2" runat="server" onkeypress="return KeyNumber(event);"
                                        Width="50px" Text="0"></asp:TextBox>
                                    <span class="ColorRed">*</span><span>ถ้าไม่ต้องการเตือนให้ใส่ 0</span><span id="ErrorAlertDay"
                                        class="ErrorMsg">กรุณาป้อนจำนวนวันที่เตือน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                </div>
                                <div class="divB_Head">
                                    <asp:Button ID="btEditDate" CssClass="btEditDate" runat="server" Text="       แก้ไขวันที่ทำแผนกิจกรรม"
                                        OnClick="btEditDate_Click" ToolTip="แก้ไขวันที่ทำแผนกิจกรรมเริ่มต้น - สิ้นสุด" />
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                </div>
                                <div class="divB_Head">
                                    <asp:Button ID="btSaveEditDate" CssClass="btYes" runat="server" Text="       บันทึกการแก้ไขวันที่"
                                        OnClick="btSaveEditDate_Click" ToolTip="บันทึกการแก้ไขวันที่" Visible="false" />
                                    <asp:Button ID="btCancelEdit2" CssClass="btNo" runat="server" Text="       ไม่บันทึกการแก้ไข"
                                        OnClick="btCancelEdit_Click" ToolTip="ไม่บันทึกการแก้ไข" Visible="false" />
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <asp:Label ID="lblLogDate" runat="server" CssClass="spantxt4"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:Repeater ID="rptLogEditDate" runat="server">
                                        <HeaderTemplate>
                                            <hr />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <span class="spantxt4">
                                                <%#Eval("LogDateName")%></span>
                                            <br />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <hr />
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่ปฏิบัติกิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlRealSDay" CssClass="ddl" runat="server">
                                    </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlRealSMonth" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlRealSYear" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    <asp:TextBox ID="txtRealSDate" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                    <span class="spantxt">ถึงวันที่</span>
                                    <asp:DropDownList ID="ddlRealEDay" CssClass="ddl" runat="server">
                                    </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlRealEMonth" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    /
                                <asp:DropDownList ID="ddlRealEYear" CssClass="ddl" runat="server">
                                </asp:DropDownList>
                                    <asp:TextBox ID="txtRealEDate" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                    <span class="spantxt">( ปฏิทินปฏิบัติงาน )</span>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="TableSearch" >
                                <div class="SearchTable" style="width:90%;">
                                    <div class="SearchHead HeadCenter">
                                        <span class="spantxt2">-- ขั้นตอนการดำเนินงาน --</span>
                                    </div>
                                    <div class="spaceDiv"></div>
                                    <div class="gridViewDiv">
                                        <table width="100%" style="border: solid 1px gray;" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="cutbudget cutbudgetBg" style="width: 50%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                                    <span class="spantxt2">การดำเนินงาน</span>
                                                </td>
                                                <td class="cutbudget cutbudgetBg" style="width: 15%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                                    <span class="spantxt2">ระยะเวลา</span>
                                                </td>
                                                <td class="cutbudget cutbudgetBg" style="width: 20%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                                    <span class="spantxt2">สถานที่</span>
                                                </td>
                                                <td class="cutbudget cutbudgetBg" style="width: 15%; background: url(../Image/MenuStlye/mainbk.png) repeat-x left top; background-color: #313638;">
                                                    <span class="spantxt2">ผู้รับผิดชอบ</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-bottom: none; text-align: left;">
                                                    <span class="spantxt2">(P) ขั้นเตรียมการ</span>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtOperation1" runat="server" Width="400px" TextMode="MultiLine"
                                                        Height="70px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPeriod1" runat="server" Width="130px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPlace1" runat="server" Width="180px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtEmp1" runat="server" Width="180px" MaxLength="200" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; text-align: left;">
                                                    <br />
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-bottom: none; text-align: left;">
                                                    <br />
                                                    <span class="spantxt2">(D) ขั้นดำเนินการ</span>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; border-bottom: none;">
                                                    <span class="spantxt">รายการ :</span><asp:TextBox CssClass="txtBoxL" ID="txtOperation2"
                                                        runat="server" Width="350px"></asp:TextBox>
                                                    <asp:TextBox CssClass="txtBoxnone" ID="txtid2" runat="server" Width="0px"></asp:TextBox>
                                                    <span id="ErrorOperation2" class="ErrorMsg">กรุณาป้อนการดำเนินงาน</span><br />
                                                    <span class="spantxt">งบดำเนินงาน :</span><asp:TextBox CssClass="txtBoxNum" ID="txtBudget2"
                                                        onkeypress="return KeyNumber(event);" runat="server" Text="0" onchange="txtComma(this);"
                                                        onclick="SelecttxtAll(this);" onblur="txtZero(this,0);" Width="100px"></asp:TextBox>
                                                    <asp:Button ID="btaddOperation2" CssClass="btAdd" runat="server" OnClientClick="return ckAddOperation2();"
                                                        OnClick="btaddOperation2_Click" Text="      เพิ่มรายการ" ToolTip="เพิ่มรายการใหม่" />
                                                    <br />
                                                    <asp:Label ID="lblckOperation2" runat="server" Text="ชื่อรายการซ้ำ" ForeColor="Red"
                                                        Visible="false"></asp:Label>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPeriod2" runat="server" Width="130px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPlace2" runat="server" Width="180px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtEmp2" runat="server" Width="180px" MaxLength="200" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; border-bottom: none; text-align: left;" align="left">
                                                    <asp:Button ID="btDelOperation2" CssClass="btDelete" runat="server" Visible="false"
                                                        OnClick="btDelOperation2_Click" />
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 40%; border: solid 1px Gray; border-top: none; border-bottom: none; text-align: center;">
                                                    <Control:DataGridView ID="GridViewOperation2" runat="server" AutoGenerateCheckList="true"
                                                        Width="100%" AutoGenerateColumns="False" PageSize="20" ShowFooter="true">
                                                        <Columns>
                                                            <Control:TemplateField HeaderText="การดำเนินงาน">
                                                                <ItemTemplate>
                                                                    <span id="spnOperation<%#Container.DataItemIndex %>">
                                                                        <%# Eval("Operation2").ToString()%></span>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" Width="65%" />
                                                                <FooterTemplate>
                                                                    รวม :
                                                                </FooterTemplate>
                                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                                                    BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                            </Control:TemplateField>
                                                            <Control:TemplateField HeaderText="งบดำเนินงาน">
                                                                <ItemTemplate>
                                                                    <span id="spnBudget<%#Container.DataItemIndex %>">
                                                                        <%# GetTotalMoneyOperation(decimal.Parse(Eval("Budget2").ToString())).ToString("N2")%></span>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right" Width="30%" />
                                                                <FooterTemplate>
                                                                    <%# GetSumTotalMoneyOperation().ToString("N2")%>
                                                                </FooterTemplate>
                                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                                                    BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                            </Control:TemplateField>
                                                            <Control:TemplateField HeaderText="แก้ไข">
                                                                <ItemTemplate>
                                                                    <img src="../Image/edit.gif" style="cursor:pointer;" onclick="editmode('<%#Container.DataItemIndex %>');" title="เลือกเพื่อแก้ไข" alt="เลือกเพื่อแก้ไข" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt" BackColor="#cecece"
                                                                    BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                            </Control:TemplateField>
                                                        </Columns>
                                                    </Control:DataGridView>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; text-align: left;">
                                                    <br />
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-bottom: none; text-align: left;">
                                                    <br />
                                                    <span class="spantxt2">(C) ขั้นติดตามประเมินผล</span>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtOperation3" runat="server" Width="400px" TextMode="MultiLine"
                                                        Height="70px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPeriod3" runat="server" Width="130px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtPlace3" runat="server" Width="180px" MaxLength="150" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtEmp3" runat="server" Width="180px" MaxLength="200" TextMode="MultiLine"
                                                        Height="50px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; text-align: left;">
                                                    <br />
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-bottom: none; text-align: left;">
                                                    <br />
                                                    <span class="spantxt2">(A) ขั้นปรับปรุงแก้ไข</span>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-bottom: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; border-bottom: none;">
                                                    <asp:TextBox CssClass="txtBoxL" ID="txtSolutions" runat="server" Width="400px" TextMode="MultiLine"
                                                        Height="70px"></asp:TextBox>
                                                    <%--<span class="ColorRed">*</span>--%>
                                                    <span id="Span1" class="ErrorMsg">กรุณาป้อนการปรับปรุงแก้ไข</span>
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none; border-bottom: none;"></td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none; border-bottom: none;"></td>
                                            </tr>
                                            <tr>
                                                <td class="cutbudget3" style="width: 40%; border-top: none; text-align: left;">
                                                    <br />
                                                </td>
                                                <td class="cutbudget3" style="width: 15%; border-top: none;"></td>
                                                <td class="cutbudget3" style="width: 20%; border-top: none;"></td>
                                                <td class="cutbudget2" style="width: 15%; border-top: none;"></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="spaceDiv"></div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">การติดตามประเมินผล :</span>
                                </div>
                                <div class="divB_Head">
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 15%;">
                                            <span class="spantxtSmall">การประเมินผล :</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtEvaluation" runat="server" Width="450px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 15%;">
                                            <span class="spantxtSmall">ตัวชี้วัดความสำเร็จ :</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtEvaIndicators" runat="server" Width="450px"
                                                TextMode="MultiLine" Height="100px"></asp:TextBox>
                                            <img src="../image/look.png" style="cursor: pointer;" title="คลิ๊กเพื่อเลือกตัวชี้วัดความสำเร็จ"
                                                onclick="getPopUpIndicators();" />
                                            <asp:Button ID="btSearchInd" CssClass="btNone" OnClick="btSearchInd_Click"
                                            runat="server" />
                                            <asp:HiddenField ID="hdfEvaIndicators" runat="server" />
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 15%;">
                                            <span class="spantxtSmall">วิธีการประเมิน :</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtEvaAssessment" runat="server" Width="450px"
                                                TextMode="MultiLine" Height="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 15%;">
                                            <span class="spantxtSmall">เครื่องมือที่ใช้ :</span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxL" ID="txtEvaTool" runat="server" Width="450px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผลที่คาดว่าจะได้รับ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtExpected" runat="server" Width="600px" TextMode="MultiLine"
                                        Height="80px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorExpected" class="ErrorMsg">กรุณาป้อนผลที่คาดว่าจะได้รับ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">สถานที่ดำเนินการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL" ID="txtPlace" runat="server" MaxLength="200" Width="600px"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorPlace" class="ErrorMsg">กรุณาป้อนสถานที่ดำเนินการ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปริมาณผลผลิต/ผลลัพธ์ที่คาดหวัง : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum" ID="txtVolumeExpect" onkeypress="return KeyNumber(event);" Text="0"
                                        onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0);" runat="server" Width="100px"></asp:TextBox>
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
                            <div class="inputrowH">
                                <div class="divF_Head">
                                </div>
                                <div class="divB_Head">
                                    <asp:Button ID="btEditBudget" CssClass="btEditBudget" runat="server" Text="       แก้ไขงบประมาณ"
                                        OnClick="btEditBudget_Click" ToolTip="แก้ไขงบประมาณ" />
                                    <asp:Button ID="btApproveBudget" CssClass="btYes" runat="server" Text="       กันเงินรออนุมัติ"
                                        OnClick="btApproveBudget_Click" OnClientClick="return ApproveBudget();" ToolTip="อนุมัติกิจกรรมนี้" Visible="false" />
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblAlertApprove" runat="server" ForeColor="Red" Text="*** กิจกรรมนี้ได้ถูกอนุมัติแล้ว  ถ้าต้องการแก้ไขวันที่ดำเนินการหรือแก้ไขงบประมาณ  กรุณาติดต่อฝ่ายแผนงาน"
                                        Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <asp:Label ID="lblLogBudget" runat="server" CssClass="spantxt4"></asp:Label>
                                </div>
                                <div class="divB_Head">
                                    <asp:Repeater ID="rptLogEditBudget" runat="server">
                                        <HeaderTemplate>
                                            <hr />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <span class="spantxt4">
                                                <%#Eval("LogBudgetName")%></span>
                                            <br />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <hr />
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div id="Div2" class="TableSearch">
                                <div class="SearchTable" style="width: 90%; height:auto;">
                                    <div class="SearchHead HeadCenter">
                                        <span class="spantxt2">รายการค่าใช้จ่าย</span>
                                    </div>
                                    <div class="spaceDiv"></div>
                                    <div class="inputrowH">
                                        <div class="divF_Head">
                                            <span class="spantxt">รายการ : </span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox ID="txtListName" CssClass="txtBoxL" Width="250" runat="server"></asp:TextBox>
                                            <span class="ColorRed">*</span> <span id="ErrorAddBudget" class="ErrorMsg">กรุณาป้อนรายการ</span>
                                            <asp:TextBox CssClass="txtBoxnone" ID="txtid" runat="server" Width="0px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head">
                                            <span class="spantxt">หมวดค่าใช้จ่าย : </span>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:DropDownList ID="ddlEntryCosts" CssClass="ddl" Width="250" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head">
                                            <span class="spantxt">ประเภท : </span>
                                        </div>
                                        <div class="divB_Head">
                                            <div style="float: left;">
                                                <asp:DropDownList ID="ddlBudgetType" CssClass="ddl" Width="250" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;"><span id="spnBudgetType" class="spantxt dpnone">ระบุ : </span></div>
                                            <div style="float: left;">
                                                <asp:TextBox ID="txtBudgetType" CssClass="txtBoxL dpnone" runat="server"></asp:TextBox>
                                                <cc1:AutoCompleteExtender runat="server" ID="AutoCompleteExtender1" TargetControlID="txtBudgetType"
                                                    ServicePath="~/AutoComplete.asmx" ServiceMethod="GetBudgetType" MinimumPrefixLength="1"
                                                    CompletionInterval="5" CompletionSetCount="20" EnableCaching="true">
                                                </cc1:AutoCompleteExtender>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="div_Head">
                                            <div style="float: left; padding: 0px 10px;">
                                                <span class="spantxt">หน่วยนับ : </span>
                                            </div>
                                            <div style="float: left;">
                                                <asp:TextBox ID="txtP" CssClass="txtBoxL txt80" runat="server"></asp:TextBox>
                                                <cc1:AutoCompleteExtender runat="server" ID="autoComplete2" TargetControlID="txtP"
                                                    ServicePath="~/AutoComplete.asmx" ServiceMethod="GetUnitInfo" MinimumPrefixLength="1"
                                                    CompletionInterval="5" CompletionSetCount="20" EnableCaching="true">
                                                </cc1:AutoCompleteExtender>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;">
                                                <span class="spantxt">จำนวนหน่วย : </span>
                                            </div>
                                            <div style="float: left;">
                                                <asp:TextBox ID="txtD" CssClass="txtBoxNum txt80" onkeyup="SumTotal();" onchange="txtComma(this);"
                                                    onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" Text="0" onkeypress="return KeyNumber(event);"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;">
                                                <span class="spantxt">ราคาต่อหน่วย : </span>
                                            </div>
                                            <div style="float: left;">
                                                <asp:TextBox ID="txtG" CssClass="txtBoxNum txt80" onkeyup="SumTotal();" onchange="txtComma(this);"
                                                    onclick="SelecttxtAll(this);" onblur="txtZero(this,0); SumTotal();" Text="0" onkeypress="return KeyNumber(event);"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;">
                                                <span class="spantxt">รวมเงิน : </span>
                                            </div>
                                            <div style="float: left;">
                                                <asp:Label ID="lblTotal" CssClass="spantxt2" runat="server" Text="0.00"></asp:Label>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;">
                                                <span class="spantxt">บาท </span>
                                            </div>
                                            <div style="float: left; padding: 0px 10px;">
                                                <asp:Button ID="btaddBudget" CssClass="btAdd" runat="server" OnClientClick="return ckAddBudget();"
                                                    OnClick="btaddBudget_Click" Text="      เพิ่มรายการ" ToolTip="เพิ่มรายการงบประมาณใหม่" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head">
                                        </div>
                                        <div class="divB_Head">
                                            <asp:Label ID="lblckBudget" runat="server" Text="เลือกรายการซ้ำ" ForeColor="Red"
                                                Visible="false"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="spaceDiv"></div>
                                <div style="padding:0px 10px;">
                                    <asp:Button ID="btDelBudget" CssClass="btDelete" runat="server" Visible="false" OnClick="btDelBudget_Click" />
                                </div>
                                <div class="gridViewDiv">
                                    <Control:DataGridView ID="GridViewBudget" runat="server" AutoGenerateCheckList="true"
                                        Width="100%" AutoGenerateColumns="False" PageSize="200" ShowFooter="true">
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
                                                    <span id="spnListName<%#Container.DataItemIndex %>">
                                                        <%# Eval("EntryCostsName").ToString()%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="25%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="หมวดค่าใช้จ่าย">
                                                <ItemTemplate>
                                                    <span id="spntxtCostsName<%#Container.DataItemIndex %>">
                                                        <%# Eval("txtCostsName").ToString()%></span>
                                                    <span id="spnEntryCostsCode<%#Container.DataItemIndex %>" style="font-size: 0pt; visibility: hidden;">
                                                        <%# Eval("EntryCostsCode").ToString()%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="ประเภทของเงิน">
                                                <ItemTemplate>
                                                    <span id="spnBudgetTypeName<%#Container.DataItemIndex %>">
                                                        <%# Eval("BudgetTypeName").ToString()%></span>
                                                    <span id="spnBudgetTypeCode<%#Container.DataItemIndex %>" style="font-size: 0pt; visibility: hidden;">
                                                        <%# Eval("BudgetTypeCode").ToString()%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="หน่วยนับ">
                                                <ItemTemplate>
                                                    <span id="spnTotalP<%#Container.DataItemIndex %>">
                                                        <%# Eval("TotalP").ToString()%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="จำนวนหน่วย">
                                                <ItemTemplate>
                                                    <span id="spnTotalD<%#Container.DataItemIndex %>">
                                                        <%# Eval("TotalD").ToString()%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="ราคาต่อหน่วย">
                                                <ItemTemplate>
                                                    <span id="spnTotalG<%#Container.DataItemIndex %>">
                                                        <%# decimal.Parse(Eval("TotalG").ToString()).ToString("N2")%></span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="10%" />
                                                <FooterTemplate>
                                                    รวม :
                                                </FooterTemplate>
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="รวมเงิน">
                                                <ItemTemplate>
                                                    <%# GetTotalMoney(decimal.Parse(Eval("TotalMoney").ToString())).ToString("N2")%>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="10%" />
                                                <FooterTemplate>
                                                    <%# GetSumTotalMoney().ToString("N2")%>
                                                </FooterTemplate>
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="แก้ไข">
                                                <ItemTemplate>
                                                    <img src="../Image/edit.gif" style="cursor:pointer;" onclick="editmodeBg('<%#Container.DataItemIndex %>');" title="เลือกเพื่อแก้ไข" alt="เลือกเพื่อแก้ไข" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                    BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                            </Control:TemplateField>
                                        </Columns>
                                    </Control:DataGridView>
                                </div>
                                    <div class="clear"></div>
                                    <div class="spaceDiv"></div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <asp:Button ID="btSaveEditBudget" CssClass="btYes" runat="server" Text="       บันทึกการแก้ไขงบประมาณ"
                                    OnClick="btSaveEditBudget_Click" ToolTip="บันทึกการแก้ไขงบประมาณ" Visible="false" />
                                <asp:Button ID="btCancelEdit" CssClass="btNo" runat="server" Text="       ไม่บันทึกการแก้ไข"
                                    OnClick="btCancelEdit_Click" ToolTip="ไม่บันทึกการแก้ไข" Visible="false" />
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div id="Div3" class="TableSearch">
                                <div class="SearchTable" style="text-align: center;">
                                    <div class="SearchHead HeadCenter">
                                        <span class="spantxt2">สรุปงบประมาณ</span>
                                    </div>
                                    <div class="spaceDiv"></div>
                                    <div style="float:left; width:55%;">
                                        <asp:Repeater ID="rptBudget" runat="server">
                                            <ItemTemplate>
                                                <div class="inputrowH">
                                                    <div class="divF_Head" style="width:55%;">
                                                        <span class="spantxt"><%#Eval("BudgetTypeName")%> : </span>
                                                    </div>
                                                    <div class="divB_Head" style="width:30%; text-align:right;">
                                                        <span class="spantxt2"><%# Convert.ToDecimal(Eval("TotalMoney")).ToString("#,##0.00")%></span>
                                                        <span class="spantxt">บาท</span>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <div class="clear"></div>
                                        <div class="inputrowH">
                                            <div class="divF_Head" style="width:55%;">
                                                <span class="spantxt">รวมทั้งหมด : </span>
                                            </div>
                                            <div class="divB_Head" style="width:30%; text-align:right;">
                                                <asp:Label ID="lblTotalAmount" runat="server" CssClass="spantxt2" Text="0.00"></asp:Label>
                                                <span class="spantxt">บาท</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="float:left; width:40%;">
                                        <asp:Literal ID="graphPnl" runat="server"></asp:Literal>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="spaceDiv"></div>
                                </div>
                                <div class="clear"></div>
                                <div class="spaceDiv"></div>
                                <div class="centerDiv">
                                    <asp:Label ID="lblCreate" runat="server" CssClass="spantxt4"></asp:Label>&nbsp;<asp:LinkButton ID="lbtEditCreate" runat="server" Visible="false" OnClick="lbtEditCreate_Click">แก้ไข</asp:LinkButton>
                                </div>
                                <div class="centerDiv">
                                    <asp:Label ID="lblUpdate" runat="server" CssClass="spantxt4"></asp:Label>
                                    <asp:DropDownList ID="ddlCreateUser" CssClass="ddl" Visible="false" runat="server"></asp:DropDownList><asp:Button ID="btnEditCreate" runat="server" Text="บันทึก" Visible="false" OnClick="btnEditCreate_Click" /><asp:Button ID="btnCancelCreate" runat="server" Text="ยกเลิก" Visible="false" OnClick="btnCancelCreate_Click" />
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="centerDiv">
                                    <div class="classButton">
                                        <div class="classBtSave">
                                            <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                                OnClientClick="return Cktxt(1);" ToolTip="บันทึกกิจกรรมนี้" />
                                            <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างกิจกรรมใหม่"
                                                OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกกิจกรรมนี้และสร้างกิจกรรมใหม่" />
                                            <asp:Button ID="btSaveAndGo" CssClass="btYesAndGo" runat="server" Text="       บันทึกและสร้างตัวชี้วัดต่อ"
                                                OnClick="btSaveAndGo_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกกิจกรรมนี้และสร้างตัวชี้วัดต่อ" />                                           
                                        </div>
                                        <div class="classBtCancel">
                                            <input type="button" class="btNo" value="      ออก" title="ออก" onclick="Cancel();" />
                                        </div>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="spaceDiv"></div>
                                <div class="gridViewDiv">
                                    <Control:DataGridView ID="GridView3" runat="server" OnRowDataBound="GridView1_RowDataBound"
                                        Visible="false">
                                        <Columns>
                                            <Control:TemplateField HeaderText="ลำดับที่">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <img title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                                        src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png' />
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" />
                                            </Control:TemplateField>
                                            <Control:BoundField HeaderText="ชื่อกิจกรรม" DataField="ActivityName">
                                                <ItemStyle Width="45%" HorizontalAlign="Left" />
                                            </Control:BoundField>
                                            <Control:TemplateField HeaderText="ช่วงวันที่">
                                                <ItemTemplate>
                                                    <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                            </Control:TemplateField>
                                            <Control:TemplateField HeaderText="งบประมาณ">
                                                <ItemTemplate>
                                                    <%# GetBudget(decimal.Parse(Eval("TotalAmount").ToString())).ToString("N2")%>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="10%" />
                                            </Control:TemplateField>
                                            <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                            </Control:BoundField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" />
                                    </Control:DataGridView>
                                </div>
                            </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
