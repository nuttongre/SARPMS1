<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="MR_School.aspx.cs" Inherits="MR_School" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "MR_School.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "MR_School.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "MR_School.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "MR_School.aspx";
        }
        function printRpt(mode, type, id) {
            var yearb = document.getElementById("<%=ddlYearS.ClientID%>").value;
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&yearB=" + yearb + "&rpttype=" + type);
        }
        function deleteImg() {
            if (confirm('ต้องการลบภาพนี้ ใช่หรือไม่')) {
                return true;
            }
            else {
                return false;
            }
        }
        function ckUpload() {
            var fiUpload = document.getElementById("<%=fiUpload.ClientID%>").value;
            if (fiUpload == "") {
                alert("กรุณาเลือกไฟล์");
                return;
            }
        }
        function Cktxt(m) {
            var ck = 0;
            var txtSchoolID = $get("<%=txtSchoolID.ClientID%>");
            var ErrorSchoolID = $get("ErrorSchoolID");
            var txtSchoolName = $get("<%=txtSchoolName.ClientID%>");
            var ErrorSchoolName = $get("ErrorSchoolName");
            var txtAddress = $get("<%=txtAddress.ClientID%>");
            var ErrorAddress = $get("ErrorAddress");
            var ddlProvince = $get("<%=ddlProvince.ClientID%>");
            var ErrorProvince = $get("ErrorProvince");
            var txtTel = $get("<%=txtTel.ClientID%>");
            var ErrorTel = $get("ErrorTel");
            var txtAreaOfStudy = $get("<%=txtAreaOfStudy.ClientID%>");
            var ErrorAreaOfStudy = $get("ErrorAreaOfStudy");
            var txtIdentity = $get("<%=txtIdentity.ClientID%>");
            var ErrorIdentity = $get("ErrorIdentity");
            var txtIdentity2 = $get("<%=txtIdentity2.ClientID%>");
            var ErrorIdentity2 = $get("ErrorIdentity2");
            var txtVision = $get("<%=txtVision.ClientID%>");
            var ErrorVision = $get("ErrorVision");
            var txtManagerName = $get("<%=txtManagerName.ClientID%>");
            var ErrorManagerName = $get("ErrorManagerName");

            ck += ckTxtNull(m, txtManagerName, ErrorManagerName);
            ck += ckTxtNull(m, txtVision, ErrorVision);
            ck += ckTxtNull(m, txtIdentity2, ErrorIdentity2);
            ck += ckTxtNull(m, txtIdentity, ErrorIdentity);
            ck += ckTxtNull(m, txtAreaOfStudy, ErrorAreaOfStudy);
            ck += ckTxtNull(m, txtTel, ErrorTel);
            ck += ckDdlNull(m, ddlProvince, ErrorProvince);
            ck += ckTxtNull(m, txtAddress, ErrorAddress);
            ck += ckTxtNull(m, txtSchoolName, ErrorSchoolName);
            ck += ckTxtNull(m, txtSchoolID, ErrorSchoolID);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
            }
        }
     <%--   function CkComma() {
            var txtArea = document.getElementById("<%=txtArea.ClientID%>");
            document.getElementById("<%=txtArea.ClientID%>").value = (txtArea.value == "") ? "0" : txtArea.value.comma();
        }--%>

        function ckddlDate() {
            var d2 = $get("<%=ddlSDay.ClientID%>").value;
            var m2 = $get("<%=ddlSMonth.ClientID%>").value;
            var y2 = $get("<%=ddlSYear.ClientID%>").value;
            ckDatetimeDDL(d2, m2, y2, $get("<%=ddlSDay.ClientID%>"));

            var d = $get("<%=ddlSDay.ClientID%>").value;
            var m = $get("<%=ddlSMonth.ClientID%>").value;
            var y = $get("<%=ddlSYear.ClientID%>").value;
            $get("<%=txtDateBegin.ClientID%>").value = d + '/' + m + '/' + y;
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
            ข้อมูลวิทยาลัย
        </div>
        <div class="spaceDiv"></div>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="view" runat="server">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาวิทยาลัย</span>
                                </div>
                                <div class="spaceDiv"></div>
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
                            <%--<div class="btAddDiv">
                        <input type="button" class="btAdd" onclick="AddItem();" value="      เพิ่มข้อมูลวิทยาลัยใหม่" title="เพิ่มข้อมูลวิทยาลัยใหม่" />
                    </div>--%>
                            <div class="spaceDiv"></div>
                        </div>

                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server">
                                <Columns>
                                    <Control:BoundField HeaderText="รหัสวิทยาลัย" DataField="SchoolNo">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ชื่อวิทยาลัย">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("SchoolID") %>');"><%# Eval("SchoolName")%></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="35%" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="Tel" DataField="Tel">
                                        <ItemStyle Width="15%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="วันก่อตั้ง" DataField="BirthDate" DataFormatString="{0:d}">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="ผู้อำนวยการวิทยาลัย" DataField="UnderManagerName">
                                        <ItemStyle Width="20%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("SchoolID") %>');">
                                                <img style="border: 0; cursor: pointer;" alt="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <%--<Control:TemplateField HeaderText="ลบ">
                                <ItemTemplate>
                                    <a href="javascript:deleteItem('<%#Eval("SchoolID") %>');">
                                        <img style="border: 0; cursor: pointer;" alt="ลบ" src="../Image/delete.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>--%>
                                </Columns>
                                <PagerStyle HorizontalAlign="Right" />
                            </Control:DataGridView>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:View>
            <asp:View ID="edit" runat="server">
                <div id="Div2" class="PageManageDiv">
                    <div class="inputrowH">
                        <div class="divF_Head">
                            <span class="spantxt">รูปโลโก้วิทยาลัย</span>
                        </div>
                        <div class="divB_Head">
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>
                                    <div style="float:left;width:100px;height:75px;">
                                        <div style="float:right;">
                                            <asp:ImageButton ID="ImgBt" ImageUrl="../Image/delete.gif" runat="server" ToolTip="ลบภาพนี้" OnClick="DeleteImg" OnClientClick="return deleteImg();" />
                                        </div>
                                        <div style="float:left;border:dotted 2px gray; float:left;width:71px;height:71px;padding:3px 3px;">
                                            <asp:Image ID="imgPicture" Width="71" Height="71" runat="server" />
                                        </div>                                  
                                    </div>
                                    <div style="float:left;padding-left:100px;">
                                        <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                                    </div>
                                    <div class="clear"></div>
                                    <div style="float:left; color:gray; margin-left:90px; font-size:5px;">ขนาดไฟล์รูปที่แนะนำ 70 x 70 pixel</div>
                                </ContentTemplate>
                            </asp:UpdatePanel>                          
                        </div>
                    </div>
                    <div class="inputrowH">
                        <div class="divF_Head"></div>
                        <div class="divB_Head">
                            <asp:FileUpload ID="fiUpload" runat="server" CssClass="txtBox"></asp:FileUpload>
                            <input id="btnUpload" type="button" class="btUpload" onserverclick="btnUpload_OnClick" onclick="ckUpload();" value="      Upload" runat="server" />

                        </div>
                    </div>
                    <div class="spaceDiv"></div>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">รหัสวิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt100" ID="txtSchoolID" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorSchoolID" class="ErrorMsg">กรุณาป้อนรหัสวิทยาลัย</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ชื่อวิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtSchoolName" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorSchoolName" class="ErrorMsg">กรุณาป้อนชื่อวิทยาลัย</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ที่อยู่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtAddress" runat="server" TextMode="MultiLine"
                                        Height="50px"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorAddress" class="ErrorMsg">กรุณาป้อนที่อยู่</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">จังหวัด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlProvince" CssClass="ddl" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorProvince" class="ErrorMsg">กรุณาเลือกจังหวัด</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">เบอร์โทรศัพท์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txtShort" ID="txtTel" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorTel" class="ErrorMsg">กรุณาป้อนเบอร์โทรศัพท์</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">โทรสาร (Fax) : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txtShort" ID="txtFax" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">เนื้อที่ทั้งหมด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtArea"
                                        runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ระดับการศึกษาที่เปิดสอน : </span>
                                </div>
                                <div class="divB_Head">
                                    <div style="float: left; display:none;">
                                        <asp:CheckBox ID="cbPrimary" runat="server" Text=" ประถมศึกษา" />
                                    </div>
                                    <div style="float: left; display:none;">
                                        <asp:CheckBox ID="cbSecondary" runat="server" Text=" ปวช." />
                                    </div>
                                    <div style="float: left;">
                                        <asp:CheckBox ID="cbHighSchool" runat="server" Text=" อาชีวศึกษา" />
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">พื้นที่การศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtAreaOfStudy" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorAreaOfStudy" class="ErrorMsg">กรุณาป้อนพื้นที่การศึกษา</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วันที่ก่อตั้ง : </span>
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
                                    <asp:TextBox ID="txtDateBegin" CssClass="txtBoxnone" onkeypress="return false" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">สีประจำวิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtSchoolColor" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปรัชญา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtPhilosophy" runat="server" TextMode="MultiLine"
                                        Height="50px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">คุณธรรมอัตลักษณ์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtSlogan" runat="server" TextMode="MultiLine"
                                        Height="50px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">นโยบาย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtPolicy" runat="server" TextMode="MultiLine"
                                        Height="50px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประวัติวิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" ID="txtHistory" runat="server" TextMode="MultiLine"
                                        Height="200px"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearS" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearS_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">เอกลักษณ์วิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" TextMode="MultiLine" Height="50px" ID="txtIdentity"
                                        runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span><span id="ErrorIdentity" class="ErrorMsg">กรุณาป้อนเอกลักษณ์วิทยาลัย</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">อัตลักษณ์วิทยาลัย : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" TextMode="MultiLine" Height="50px" ID="txtIdentity2"
                                        runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span><span id="ErrorIdentity2" class="ErrorMsg">กรุณาป้อนอัตลักษณ์วิทยาลัย</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">วิสัยทัศน์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt400" TextMode="MultiLine" Height="50px" ID="txtVision"
                                        runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorVision" class="ErrorMsg">กรุณาป้อนวิสัยทัศน์</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">กลยุทธ์ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Repeater ID="rptStrategies" runat="server">
                                        <ItemTemplate>
                                            <span class="spantxt3">
                                                <%#Eval("StrategiesName")%></span>
                                            <br />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ชื่อผู้รับใบอนุญาต : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtManagerName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionManagerName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span>&nbsp;<span id="ErrorManagerName" class="ErrorMsg">กรุณาป้อนชื่อผู้รับใบอนุญาต</span>                                    
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ชื่อผู้แทนผู้รับใบอนุญาติ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtManagerSuppliesName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionSuppliesName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt" style="font-size:13px;">ชื่อผู้อำนวยการวิทยาลัยฯ / ผู้อำนวยการศูนย์การเรียน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtUnderManagerName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionUnderManagerName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ชื่อผู้อำนวยการสำนักบัญชีและการเงิน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtUnderBudgetName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionManagerBudgetName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt" style="font-size:14px;">ชื่อผู้อำนวยการสำนักนโยบายและระบบคุณภาพ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtManagerPlanName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionPlanName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH" style="display:none;">
                                <div class="divF_Head">
                                    <span class="spantxt">ชื่อหัวหน้างานการเงิน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtManagerMoneyName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                    <span class="spantxt"> ตำแหน่ง : </span>
                                    <asp:TextBox ID="txtPositionMoneyName" CssClass="txtBoxL txtShort" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="centerDiv">
                                <div class="classButton">
                                    <div class="classBtSave">
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click"
                                            OnClientClick="return Cktxt(1);" ToolTip="บันทึกข้อมูลวิทยาลัยนี้" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกข้อมูลวิทยาลัยนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
