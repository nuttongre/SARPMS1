<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Department.aspx.cs" Inherits="Department" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "Department.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "Department.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "Department.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "Department.aspx";
        }
        function printRpt(mode, type, id) {
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type);
        }
        function Cktxt(m) {
            var ck = 0;
            var txtDeptShortName = $get("<%=txtDeptShortName.ClientID%>");
            var ErrorDeptShortName = $get("ErrorDeptShortName");
            var txtDepartment = $get("<%=txtDepartment.ClientID%>");
            var ErrorDepartment = $get("ErrorDepartment");
            var ddlMainDept = $get("<%=ddlMainDept.ClientID%>");
            var ErrorMainDept = $get("ErrorMainDept");
            var ddlMainSubDept = $get("<%=ddlMainSubDept.ClientID%>");
            var ErrorMainSubDept = $get("ErrorMainSubDept");
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");

            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckDdlNull(m, ddlMainDept, ErrorMainDept);
            ck += ckDdlNull(m, ddlMainSubDept, ErrorMainSubDept);
            ck += ckTxtNull(m, txtDepartment, ErrorDepartment);
            ck += ckTxtNull(m, txtDeptShortName, ErrorDeptShortName);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
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
                    หน่วยงาน
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาหน่วยงาน</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานหลัก : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainDept" Width="350px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainDept_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หน่วยงานรอง : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchMainSubDept" Width="350px" runat="server"
                                            AutoPostBack="true" OnSelectedIndexChanged="ddlSearchMainSubDept_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">คำค้นหา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:TextBox CssClass="txtSearch txt300" ID="txtSearch" runat="server"></asp:TextBox><asp:Button
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
                            <div class="btAddDiv">
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" OnClientClick="AddItem();"
                                    Text="       สร้างหน่วยงานใหม่" ToolTip="สร้างหน่วยงานใหม่" />
                            </div>
                            <div style="float: right; padding-right: 20px;"><a href="EmpByDepartmentView.aspx">แสดงผู้ใช้ระบบตามหน่วยงาน</a></div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" PageSize="50">
                                <Columns>
                                    <Control:BoundField HeaderText="ลำดับที่" DataField="Sort">
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="ชื่อหน่วยงาน">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("DeptCode") %>');">
                                                <%#Eval("DeptName")%></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="30%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อหน่วยงานหลัก">
                                        <ItemTemplate>
                                            <%#Eval("MainDeptName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="20%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ชื่อหน่วยงานรอง">
                                        <ItemTemplate>
                                            <%#Eval("MainSubDeptName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="25%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ตัวย่อ">
                                        <ItemTemplate>
                                            <%#Eval("DeptShortName")%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("DeptCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("DeptCode") %>');">
                                                <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
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
                                    <span class="spantxt">หน่วยงานหลัก : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlMainDept" Width="400px" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlMainDept_SelectedIndexChanged">
                                    </asp:DropDownList>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorMainDept" class="ErrorMsg">กรุณาเลือกหน่วยงานหลัก</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงานรอง : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlMainSubDept" Width="400px" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlMainSubDept_SelectedIndexChanged">
                                    </asp:DropDownList>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorMainSubDept" class="ErrorMsg">กรุณาเลือกหน่วยงานรอง</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">หน่วยงาน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtDepartment" CssClass="txtBoxL txt400" MaxLength="300" runat="server"></asp:TextBox>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorDepartment" class="ErrorMsg">กรุณาป้อนหน่วยงาน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวย่อ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtDeptShortName" CssClass="txtBoxL txt50" MaxLength="5" runat="server"></asp:TextBox>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorDeptShortName" class="ErrorMsg">กรุณาป้อนตัวย่อหน่วยงาน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ลำดับที่ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtSort" CssClass="txtBoxNum txt50" MaxLength="2" runat="server"
                                        onkeypress="return KeyNumber(event);"></asp:TextBox>&nbsp;<span class="ColorRed">*</span>
                                    <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
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
                                            OnClientClick="return Cktxt();" ToolTip="บันทึกหน่วยงานนี้" />
                                        <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างหน่วยงานใหม่"
                                            OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(0);" ToolTip="บันทึกหน่วยงานนี้และสร้างหน่วยงานใหม่" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกหน่วยงานนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server" Visible="false" PageSize="50">
                                    <Columns>
                                        <Control:BoundField HeaderText="ลำดับที่" DataField="Sort">
                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="ชื่อหน่วยงาน" DataField="DeptName">
                                            <ItemStyle Width="40%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <Control:TemplateField HeaderText="ชื่อหน่วยงานหลัก">
                                            <ItemTemplate>
                                                <%#Eval("MainDeptName")%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                                        </Control:TemplateField>
                                        <Control:TemplateField HeaderText="ชื่อหน่วยงานรอง">
                                            <ItemTemplate>
                                                <%#Eval("MainSubDeptName")%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                                        </Control:TemplateField>
                                        <Control:TemplateField HeaderText="ตัวย่อ">
                                            <ItemTemplate>
                                                <%#Eval("DeptShortName")%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </Control:TemplateField>
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
