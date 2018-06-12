<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="InputUsers64.aspx.cs" Inherits="InputUsers64" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    
    function Cktxt()
    {
        if(document.getElementById("<%=ipFile.ClientID%>").value == "")
        {
            document.getElementById("ErroripFile").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErroripFile").style.display = "none";
            CkMsg();
            return true;
        }      
    }
    function CkMsg()
    {
        var Msg;
        if(document.getElementById("<%=btImport.ClientID%>").style.display == "block")
        {
            Msg = "คุณต้องการ  Uploads Excel Files ";
        }
        else
        {
            if(document.getElementById("ErrorData").style.display == "block")
            {
                Msg = "ข้อมูลนี้มีการบันทึกไปแล้ว  คุณต้องการบันทึกข้อมูลซ้ำ ";  
            }
            else
            {
                Msg = "คุณต้องการ  บันทึกข้อมูล ";
            }      
        }
        return confirmImport(Msg);
    }
    function confirmImport(Msg)
    {     
        if(confirm(Msg + ' ใช่หรือไม่???... '))
        return true;
        return false;
    } 
    </script>

    <table style="width: 100%;">
        <tr>
            <td colspan="2">
                <asp:Image ID="Img1" runat="server" Visible="false" />
                <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="headTable">
                <strong>นำเข้าข้อมูลผู้ใช้ผ่าน Excel</strong>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:20px;">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%">
                <table id="table1" runat="server" style="width: 100%;">
                    <tr>
                        <td colspan="2" align="center" style="width:100%">
                            <span class="spantxt">เลือกไฟล์ข้อมูลที่จะส่ง : </span>
                            <asp:FileUpload ID="ipFile" runat="server" CssClass="txtBox" />
                            <%--<input type="file" id="ipFile" name="ipFile" class="txtBox" style="width: 280px;" />--%>                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="width:100%">
                            <span id="ErroripFile" class="ErrorMsg">กรุณาเลือกไฟล์ข้อมูลที่จะส่ง</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width:50%">
                            <asp:Button ID="btImport" CssClass="btImportExcel" runat="server" ToolTip="นำเข้าไฟล์ Excel"
                                Text="       Upload" OnClick="btUpload_Click" OnClientClick="return Cktxt();" />
                            <asp:Button ID="btSave" CssClass="btYes" runat="server" ToolTip="บันทึกการนำเข้าข้อมูลผู้ใช้นี้"
                                Text="       บันทึก" OnClick="btSave_Click" OnClientClick="return CkDepartment();" />                            
                        </td>
                        <td align="left" style="width:50%">
                            <asp:Button ID="btCancel" CssClass="btNo" runat="server" ToolTip="ไม่บันทึกการนำเข้าข้อมูลผู้ใช้นี้"
                                Text="       ไม่บันทึก" OnClick="btCancel_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%; height: 5px">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center; width: 100%;">
                    <Control:DataGridView ID="GridView1" runat="server">
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
            </td>
        </tr>
    </table>
</asp:Content>
