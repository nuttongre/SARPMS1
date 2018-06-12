<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Costs2Edit.aspx.cs" Inherits="Costs2Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../CSS/fileupload.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function Cancel()
        {
            location.href = "CostsView2Edit.aspx";
        }
        function SumTotal() 
        {
            var Total = 0;
            var TotalDiff = 0;
            var grid=$get("<%=GridViewBudget.ClientID %>");
            //alert(grid.rows.length - 1);
            for(var i=0;i<grid.rows.length - 2;i++)
            {
                var txtTm = $get("txtTm"+i).value.replace(/,/g, '');
                var txtT = $get("txtT"+i).value.replace(/,/g, '');
                var txtdiff = $get("txtdiff"+i);
                                                    
                $get("txtdiff"+i).innerHTML = (parseFloat(txtTm) - parseFloat(txtT)).comma();
                    
                Total = Total + parseFloat(txtT);
                TotalDiff = TotalDiff + (parseFloat(txtTm) - parseFloat(txtT));
                    
                if(parseFloat(txtdiff.innerHTML.replace(/,/g, '')) == 0)
                {
                    txtdiff.style.color = "Black";
                }
                else
                {
                    if(parseFloat(txtdiff.innerHTML.replace(/,/g, '')) > 0)
                    {
                        txtdiff.style.color = "Green";
                    }
                    else
                    {
                        txtdiff.style.color = "Red";
                    }
                }
            }
            $get("txtTotalT").innerHTML = Total.comma();
            $get("txtTotalT2").value = Total.comma();
            $get("txtTotalDiff").innerHTML = TotalDiff.comma();
                
            var TotalDiff = parseFloat($get("txtTotalDiff").innerHTML.replace(/,/g, ''));
            if(TotalDiff == 0)
            {
                $get("txtTotalDiff").style.color = "Black";
            }
            else
            {
                if(TotalDiff > 0)
                {
                    $get("txtTotalDiff").style.color = "Green";
                }
                else
                {
                    $get("txtTotalDiff").style.color = "Red";
                }
            }
                    
            if(TotalDiff == 0)
            {
                $get("lblOldTotal").innerHTML = "ใช้งบประมาณตามแผนที่ตั้งไว้";
                $get("lblOldTotal").style.color = "Black";
                $get("lblOldTotal").style.fontWeight = "bold";
            }
            else
            {
                if(TotalDiff < 0)
                {
                    $get("lblOldTotal").innerHTML = "ใช้งบประมาณเกินแผนที่ตั้งไว้";
                    $get("lblOldTotal").style.color = "red";
                    $get("lblOldTotal").style.fontWeight = "bold";
                }
                else
                {
                    $get("lblOldTotal").innerHTML = "ใช้งบประมาณน้อยกว่าแผนที่ตั้งไว้";
                    $get("lblOldTotal").style.color = "Green";
                    $get("lblOldTotal").style.fontWeight = "bold";
                }
            }
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
                $get("<%=txtSDay2.ClientID%>").value = d + '/' + m + '/' + y;
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
                $get("<%=txtEDay2.ClientID%>").value = d + '/' + m + '/' + y;
            }
            jsDateDiff($get("<%=txtSDay.ClientID%>").innerHTML, $get("<%=txtEDay.ClientID%>").innerHTML, $get("datediff1"));
            jsDateDiff($get("<%=txtSDay2.ClientID%>").value, $get("<%=txtEDay2.ClientID%>").value, $get("datediff2"));
        }
        function jsDateDiff(st, en, object)
        {
            var start = new Array(3);
            var end = new Array(3);
     
            //Thai DateFormat 15/08/2552 - DD/MM/YYYY
            //Split Start -> Date/Month/Year
            start[0] = st.substr(0,2);
            start[1] = st.substr(3,2);
            start[2] = st.substr(6,4);
     
            //Split End -> Date/Month/Year
            end[0] = en.substr(0,2);
            end[1] = en.substr(3,2);
            end[2] = en.substr(6,4);
     
            end[1] -= 1;
            start[1] -= 1;
     
            end[2] -= 543;
            start[2] -= 543; 
     
            StratDate = new Date( );         
            EndDate = new Date( );    
     
            StratDate.setDate(start[0]);                   
            StratDate.setMonth(start[1]);              
            StratDate.setFullYear(start[2]);   
     
            EndDate.setDate(end[0]);                   
            EndDate.setMonth(end[1]);              
            EndDate.setFullYear(end[2])    
        
            var theDate1 = Date.parse(StratDate)/1000;
            var theDate2 = Date.parse(EndDate)/1000;
            var diff=(theDate2-theDate1)/(60*60*24);
            object.innerHTML = diff + 1;
            
            cklblDateDiff();
        }
        function cklblDateDiff()
        {
            var datediff1 = parseInt($get("datediff1").innerHTML);
            var datediff2 = parseInt($get("datediff2").innerHTML);
            
            if(datediff1 != datediff2)
            {
                if(datediff2 < datediff1)
                {
                    $get("lblCkDateDiff").innerHTML = "ใช้เวลาน้อยกว่าที่คาดการณ์ไว้";
                    $get("lblCkDateDiff").style.color = "green";
                }
                else
                {
                    $get("lblCkDateDiff").innerHTML = "ไม่เป็นไปตามระยะเวลา";
                    $get("lblCkDateDiff").style.color = "red";
                }
            }
            else
            {
                $get("lblCkDateDiff").innerHTML = "เป็นไปตามระยะเวลา";
                $get("lblCkDateDiff").style.color = "green";
            }
        }
        function ckSaveConfirm()
        {
            if(confirm("การบันทึกนี้จะเป็นการปิดกิจกรรมโดยสมบูรณ์ !!!\nหลังจากนี้จะไม่สามารถแก้ไขงบประมาณต่าง ๆ ของกิจกรรมนี้ได้\n\n ต้องการปิดกิจกรรมนี้หรือไม่ ?"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        function ckUndoConfirm()
        {
            if(confirm("ต้องการกู้คืนกิจกรรมเป็นยังไม่ปิดกิจกรรมหรือไม่ ?"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        function AttDel(id, obj) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) {
                $.getJSON("Costs2Edit.aspx?opt=delAtt&attID=" + id, function (response) {
                    if ($(obj).parent().length == 1) {
                        $(obj).parent().parent().closest("div").remove();
                    }
                });
            }
        }
        function ValidateAttachFile()
        {
            var attName = $get("<%=fpAttach.ClientID%>").value;
            if(attName == "")
            {
                alert("กรุณาเลือกไฟล์");
                return false;
            }
            else
            {
                return true;
            }
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="pageDiv">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="headTable">
            บันทึกค่าใช้จ่ายรายกิจกรรม
        </div>
        <div class="spaceDiv"></div>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="edit" runat="server">
                <div id="Div1" class="PageManageDiv">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="lblYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server" Enabled="false">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <%--<div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlStrategies" Width="600px" Enabled="false"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>--%>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โครงการ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlProjects" Width="600px" Enabled="false" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กิจกรรม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlActivity" Width="600px" runat="server" Enabled="false">
                                    </asp:DropDownList>
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
                                    <span class="spantxt">ภาคเรียนที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblTerm" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="lblYear2" runat="server" class="spantxt">ปีงบประมาณ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblBudgetYear" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
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
                            <div class="inputrowH" style="display:none;">
                                <div class="divF_Head">
                                    <span class="spantxt">ปริมาณผลผลิต/ผลลัพธ์ที่คาดหวัง : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblVolumeExpect" runat="server" CssClass="spantxt2 spantxt4"></asp:Label>
                                </div>
                            </div>
                            <div class="inputrowH" style="display:none;">
                                <div class="divF_Head">
                                    <span class="spantxt">ปริมาณผลผลิต/ผลลัพธ์ที่ได้ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtVolumeCan" CssClass="txtBoxNum" onkeypress="return KeyNumber(event);" Text="0"
                                        onchange="txtComma(this);" onclick="SelecttxtAll(this);" onblur="txtZero(this,0);" runat="server" Width="100px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH" style="display:none;">
                                <div class="divF_Head">
                                    <span class="spantxt">เป้าหมาย : </span>
                                </div>
                                <div class="divB_Head">
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <asp:Label ID="lblTarget1" runat="server"></asp:Label>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxNoBorder" ID="txtTarget" ReadOnly="true" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="inputrowH">
                                        <div class="divF_Head" style="width: 10%;">
                                            <asp:Label ID="lblTarget2" runat="server"></asp:Label>
                                        </div>
                                        <div class="divB_Head">
                                            <asp:TextBox CssClass="txtBoxNoBorder" ID="txtTarget2" ReadOnly="true" runat="server" Width="500px" TextMode="MultiLine"
                                                Height="100px"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ผลการดำเนินงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtResults" TextMode="MultiLine" Height="100px" Width="600px" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="clear"></div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">แนบไฟล์ : </span>
                        </div>
                        <div class="divB_Head">
                            <img src="../Image/imgIcon.png" title="เลือกไฟล์" style="float: left; padding-right: 5px; vertical-align: bottom;" />
                            <asp:FileUpload ID="fpAttach" runat="server" Width="200px" /><asp:Button ID="btnAttach" Text="    แนบไฟล์" CssClass="btAttachFile"
                                runat="server" OnClientClick="return ValidateAttachFile();"
                                OnClick="btnAttach_Click" />
                            <asp:CheckBox ID="cbDuo" runat="server" Visible="false" Text=" เป็นไฟล์ Duo" />
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">ไฟล์แนบ : </span>
                        </div>
                        <div class="divB_Head">
                            <div class="framImg">
                                <asp:Repeater ID="rptAttach" runat="server">
                                    <ItemTemplate>
                                        <div class="showSmallImg">
                                            <div style="margin: 5px auto; width: 65px; height: 50px;">
                                                <img src="../Image/btnremove.png" onclick="AttDel('<%# Eval("ItemId") %>',this);" class="btnDelImg" alt="ลบภาพนี้" title="ลบภาพนี้" />
                                                <%# getImgAttatch(Eval("ItemID"), Eval("Title"), Eval("FileType"), Eval("TypeId")) %>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <div class="spaceDiv"></div>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div id="Div2" class="TableSearch" style="width: 100%;">
                                <div class="SearchTable" style="width: 80%;">
                                    <div class="SearchHead" style="text-align: center;">
                                        <span class="spantxt2 spansize14">รายการงบประมาณ</span>
                                    </div>
                                    <div class="spaceDiv"></div>
                                    <div class="centerDiv" style="margin: 0px 10px;">
                                        <Control:DataGridView ID="GridViewBudget" runat="server" Width="98%" AutoGenerateColumns="False" ShowFooter="true" PageSize="300">
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
                                                        <%#Eval("EntryCostsName")%>
                                                        <input id="txtEntry<%#Container.DataItemIndex %>" name="txtEntry<%#Container.DataItemIndex %>"
                                                            type="hidden" value="<%#Eval("EntryCostsCode") %>" />
                                                        <input id="txtItemID<%#Container.DataItemIndex %>" name="txtItemID<%#Container.DataItemIndex %>"
                                                            type="hidden" value="<%#Eval("ItemID") %>" />
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
                                                        <%# GetTotalMoney(decimal.Parse(Eval("TotalMoney").ToString())).ToString("#,##0.00")%>
                                                        <input id="txtTm<%#Container.DataItemIndex %>" name="txtTm<%#Container.DataItemIndex %>"
                                                            type="hidden" value="<%#Eval("TotalMoney") %>" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    <FooterTemplate>
                                                        <%# GetSumTotalMoney().ToString("#,##0")%>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                        BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                </Control:TemplateField>
                                                <Control:TemplateField HeaderText="งบประมาณที่ใช้จริง">
                                                    <ItemTemplate>
                                                        <input id="txtT<%#Container.DataItemIndex %>" name="txtT<%#Container.DataItemIndex %>"
                                                            type="text" class="txtBoxNum txt100" value="<%#Eval("TotalMoney2Ag") %>" onkeyup="SumTotal();"
                                                            onchange="txtComma(txtT<%#Container.DataItemIndex%>);" onkeypress="return KeyNumber(event);"
                                                            onclick="SelecttxtAll(txtT<%#Container.DataItemIndex%>);" onblur="txtZero(txtT<%#Container.DataItemIndex%>,0); SumTotal();" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    <FooterTemplate>
                                                        <span id="txtTotalT"></span>
                                                        <input id="txtTotalT2" name="txtTotalT2" type="hidden" />
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                        BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                </Control:TemplateField>
                                                <Control:TemplateField HeaderText="ผลต่าง">
                                                    <ItemTemplate>
                                                        <span id="txtdiff<%#Container.DataItemIndex %>"></span>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    <FooterTemplate>
                                                        <span id="txtTotalDiff"></span>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                        BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                </Control:TemplateField>
                                                <Control:BoundField DataField="BudgetTypeName" HeaderText="ประเภทของเงิน" SortExpression="">
                                                    <ItemStyle Width="35%" HorizontalAlign="Center" />
                                                    <FooterStyle HorizontalAlign="Right" Font-Bold="true" Font-Size="12pt"
                                                        BackColor="#cecece" BorderStyle="Solid" BorderColor="gray" BorderWidth="2" />
                                                </Control:BoundField>
                                            </Columns>
                                        </Control:DataGridView>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="spaceDiv"></div>
                                    <div class="centerDiv">
                                        <span id="lblOldTotal"></span>
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
                                        <table width="97%" style="border: solid 1px Black;">
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
                                                    <asp:DropDownList ID="ddlSDay" CssClass="ddl" runat="server">
                                                    </asp:DropDownList>
                                                    /
                                            <asp:DropDownList ID="ddlSMonth" CssClass="ddl" runat="server">
                                            </asp:DropDownList>
                                                    /
                                            <asp:DropDownList ID="ddlSYear" CssClass="ddl" runat="server">
                                            </asp:DropDownList>
                                                    <asp:TextBox ID="txtSDay2" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlEDay" CssClass="ddl" runat="server">
                                                    </asp:DropDownList>
                                                    /
                                            <asp:DropDownList ID="ddlEMonth" CssClass="ddl" runat="server">
                                            </asp:DropDownList>
                                                    /
                                            <asp:DropDownList ID="ddlEYear" CssClass="ddl" runat="server">
                                            </asp:DropDownList>
                                                    <asp:TextBox ID="txtEDay2" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
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
                            <div class="centerDiv">
                                <div class="classButton">
                                    <div class="classBtSave">
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click " OnClientClick="return ckSaveConfirm();"
                                            ToolTip="บันทึกค่าใช้จ่ายรายกิจกรรม" />
                                        <asp:Button ID="btUndo" CssClass="btUpload" runat="server" Text="       กู้คืน" OnClick="btUndo_Click" Visible="false" OnClientClick="return ckUndoConfirm();"
                                            ToolTip="แก้ไขเป็นยังไม่ปิดกิจกรรม" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกค่าใช้จ่ายรายกิจกรรม" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
