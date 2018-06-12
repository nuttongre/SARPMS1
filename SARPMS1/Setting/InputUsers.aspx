<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="InputUsers.aspx.cs" Inherits="InputUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function ckUpload() {
            if ($get("<%=ipFile.ClientID%>").value == "") {
                alert('กรุณาเลือกไฟล์ก่อน');
                return false;
            }
            else {
                return true;
            }
        }
        function ckDataUpload() {
            var lbltotal = $get("<%=lblSearchTotal.ClientID %>").innerHTML;
            if (lbltotal == "0") {
                alert('กรุณา Upload File ก่อน');
                return false;
            }
            else {
                return true;
            }
        }
    </script>

    <div id="pageDiv">
        <div class="warningDiv">
            <asp:Image ID="Img1" runat="server" Visible="false" />
            <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
        </div>
        <div class="headTable">
            นำเข้าข้อมูลผู้ใช้ผ่าน Excel
        </div>
        <div class="spaceDiv"></div>
        <div id="Div1" class="TableSearch">
            <div class="SearchTable">
                <div class="SearchHead">
                    <span class="spantxt2 spansize14">ค้นหาโครงการ / งาน</span>
                </div>
                <div class="spaceDiv"></div>
                <div class="inputrow">
                    <div class="SearchtxtF">
                        <span class="spantxt">เลือกไฟล์ข้อมูลที่จะส่ง : </span>
                    </div>
                    <div class="SearchF">
                        <div style="float: left;">
                            <asp:FileUpload ID="ipFile" runat="server" CssClass="txtBox" Width="200px" />
                        </div>
                        <div style="float: left; padding-left: 10px;">
                            <asp:Button ID="btImport" CssClass="btImportExcel" runat="server" ToolTip="นำเข้าไฟล์ Excel"
                                Text="       Upload" OnClick="btUpload_Click" OnClientClick="return ckUpload();" />
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="SearchTotal">
                    <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                        style="color: Black;" runat="server">0</span>&nbsp;<span class="spantxt">รายการ</span>
                </div>
                <div class="spaceDiv"></div>
            </div>
            <div class="clear"></div>
            <div class="spaceDiv"></div>
        </div>
        <div class="gridViewDiv">
            <Control:DataGridView ID="GridView1" runat="server" PageSize="50">
                <Columns>
                    <Control:BoundField DataField="UserName" HeaderText="ชื่อเข้าระบบ">
                        <ItemStyle HorizontalAlign="Left" Width="20%" />
                    </Control:BoundField>
                    <Control:BoundField DataField="EmpName" HeaderText="ชื่อ-สกุล">
                        <ItemStyle HorizontalAlign="Left" Width="30%" />
                    </Control:BoundField>
                    <Control:BoundField DataField="Email" HeaderText="E-mail">
                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                    </Control:BoundField>
                    <Control:BoundField DataField="Tel" HeaderText="เบอร์โทร">
                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                    </Control:BoundField>
                    <Control:BoundField DataField="DeptName" HeaderText="หน่วยงาน">
                        <ItemStyle HorizontalAlign="Left" Width="20%" />
                    </Control:BoundField>
                </Columns>
                <PagerStyle HorizontalAlign="Right" />
            </Control:DataGridView>
            <asp:Label ID="Label1" runat="server" Text="Error" Visible="false"></asp:Label>
        </div>
        <div class="spaceDiv"></div>
        <div class="centerDiv">
            <div class="classButton">
                <div class="classBtSave">
                    <asp:Button ID="btSave" CssClass="btYes" runat="server" ToolTip="บันทึกการนำเข้าข้อมูลผู้ใช้นี้"
                        Text="       บันทึก" OnClick="btSave_Click" OnClientClick="return ckDataUpload();" />
                </div>
                <div class="classBtCancel">
                    <asp:Button ID="btCancel" CssClass="btNo" runat="server" ToolTip="ไม่บันทึกการนำเข้าข้อมูลผู้ใช้นี้"
                        Text="       ไม่บันทึก" OnClick="btCancel_Click" />
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="spaceDiv"></div>
    </div>
</asp:Content>
