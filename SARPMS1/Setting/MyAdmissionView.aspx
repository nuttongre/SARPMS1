<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="MyAdmissionView.aspx.cs" Inherits="MyAdmission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function deleteItem(id)
    {
       if(confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "MyAdmissionView.aspx?mode=3&id=" + id;
    }
    function AddItem()
    {
        location.href = "MyAdmissionView.aspx?mode=1";
    }
    function Cktxt()
    {
       if(document.getElementById("<%=ddlMyProject.ClientID%>").selectedIndex == 0)
        {
            document.getElementById("ErrorMyProject").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorMyProject").style.display = "none";
            return CkMyMainMenu();
            return true;
        }
    }
     function CkMyMainMenu()
    {
       if(document.getElementById("<%=ddlMyMainMenu.ClientID%>").selectedIndex == 0)
        {
            document.getElementById("ErrorMyMainMenu").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorMyMainMenu").style.display = "none";
            return CkMySubMenu();
            return true;
        }
    }
    function CkMySubMenu()
    {
        if(document.getElementById("<%=ddlMySubMenu.ClientID%>").selectedIndex == "")
        {
            document.getElementById("ErrorMySubMenu").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorMySubMenu").style.display = "none";
            return true;
        }
    }
    </script>

    <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td colspan="2">
                    <asp:Image id="Img1" runat="server" visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="headTable">
                    <strong>สิทธิ์การเข้าถึงเมนู</strong>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 15px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <table id="TableSearch" runat="server" width="100%">
                        <tr>
                            <td colspan="3" align="center">
                                <table class="tableSearch">
                                    <tr>
                                        <td colspan="3" class="headSearch">
                                            <span class="spantxt2 spansize14">ค้นหาสิทธิ์การเข้าถึงเมนู</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="SearchB">
                                        </td>
                                        <td class="SearchtxtF">
                                            <span class="spantxt">ระบบงาน : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true" Width="350"
                                                OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="SearchB">
                                        </td>
                                        <td class="SearchtxtF">
                                            <span class="spantxt">เมนูหลัก : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:DropDownList ID="ddlSearch1" CssClass="ddlSearch" runat="server" AutoPostBack="true" Width="350"
                                                OnSelectedIndexChanged="ddlSearch1_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="SearchB">
                                        </td>
                                        <td class="SearchtxtF">
                                            <span class="spantxt">คำค้นหา : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                                CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');" ID="btSearch" 
                                                runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px;">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 10px;">
                            </td>
                        </tr>
                        <tr>
                            <td class="SearchB">
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" Text="       เพิ่มสิทธิ์การเข้าถึงเมนูใหม่"
                                    OnClientClick="AddItem();" OnClick="btAdd_Click" ToolTip="เพิ่มสิทธิ์การเข้าถึงเมนูใหม่" />
                            </td>
                            <td class="SearchtxtF">
                            </td>
                            <td class="SearchF">
                                 <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                                    style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <table id="table1" runat="server" style="width: 100%;">
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">เลือกระบบงาน : </span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMyProject" CssClass="ddl" runat="server" AutoPostBack="true" Width="300"
                                    OnSelectedIndexChanged="ddlMyProject_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span id="ErrorMyProject" class="ErrorMsg">กรุณาเลือกระบบงาน</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">เลือกเมนูหลัก : </span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMyMainMenu" CssClass="ddl" runat="server" AutoPostBack="true" Width="300"
                                    OnSelectedIndexChanged="ddlMyMainMenu_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span id="ErrorMyMainMenu" class="ErrorMsg">กรุณาเลือกเมนูหลัก</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">เลือกเมนูย่อย : </span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMySubMenu" CssClass="ddl" runat="server" Width="300">
                                </asp:DropDownList>
                                <span id="ErrorMySubMenu" class="ErrorMsg">กรุณาเลือกเมนูย่อย</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%" valign="top">
                                <span class="spantxt">กลุ่มผู้ใช้ : </span>
                            </td>
                            <td style="padding: 0 0 0 4px;">
                                <asp:CheckBox ID="cbCkAll" runat="server" Text="เลือกทั้งหมด" OnCheckedChanged="cbCkAll_CheckedChanged"
                                    AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%" valign="top">
                            </td>
                            <td>
                                <asp:CheckBoxList ID="cblUserRole" runat="server">
                                </asp:CheckBoxList>
                                <asp:Label ID="lblErrorUserRole" runat="server" Text="กรุณาเลือกกลุ่มผู้ใช้" Visible="false"
                                    Font-Bold="true" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                            </td>
                            <td align="left" style="width: 80%">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก"
                                    OnClick="btSave_Click " OnClientClick="return Cktxt();" ToolTip="บันทึกสิทธิ์การเข้าถึงเมนูนี้" />
                                <asp:Button ID="btCancel" CssClass="btNo" runat="server" Text ="       ไม่บันทึก"
                                    OnClick="btCancel_Click" ToolTip="ไม่บันทึกสิทธิ์การเข้าถึงเมนูนี้" />
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
                <td colspan ="2" style="padding:0 0 0 10px;">
                <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click"><img src="../Image/delete2.gif" title="ลบรายการที่เลือก" style="border:0;" /> ลบรายการ</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center; width: 100%;">
                    <Control:DataGridView ID="GridView1" runat="server" AutoGenerateCheckList="true" PageSize="50">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="ชื่อเมนูย่อย" DataField="MySubMenuName">
                                <ItemStyle Width="45%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="กลุ่มผู้มีสิทธิ์" DataField="MyUserRoleName">
                                <ItemStyle Width="40%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="แก้ไข">
                                <ItemTemplate>
                                    <a href="MyAdmissionView.aspx?mode=2&id=<%#Eval("MySubMenuID") %>">
                                        <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ลบ">
                                <ItemTemplate>
                                    <a href="javascript:deleteItem('<%#Eval("MySubMenuID") %>');">
                                        <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                </td>
            </tr>
        </table>
    </ajax:AjaxPanel>
</asp:Content>
