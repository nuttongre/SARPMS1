<%@ Page Language="C#" MasterPageFile="../Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="MySubMenuView.aspx.cs" Inherits="MySubMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function deleteItem(id)
    {
       if(confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "MySubMenuView.aspx?mode=3&id=" + id;
    }
    function AddItem()
    {
        location.href = "MySubMenuView.aspx?mode=1";
    }
    function Cktxt()
    {
        if(document.getElementById("<%=txtMySubMenuName.ClientID%>").value == "")
        {
            document.getElementById("ErrorMySubMenuName").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorMySubMenuName").style.display = "none";
            return CkMyProject();
            return true;
        }
    }
    function CkMyProject()
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
            return CkLinkName();
            return true;
        }
    }
    function CkLinkName()
    {
        if(document.getElementById("<%=txtLinkName.ClientID%>").value == "")
        {
            document.getElementById("ErrorLinkName").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorLinkName").style.display = "none";
            return CkSort();
            return true;
        }
    }
    function CkSort()
    {
        if(document.getElementById("<%=txtSort.ClientID%>").value == "")
        {
            document.getElementById("ErrorSort").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorSort").style.display = "none";
            return true;
        }
    }
    </script>

    <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td colspan="2">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="headTable">
                    <strong>เมนูย่อย</strong>
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
                                            <span class="spantxt2 spansize14">ค้นหาเมนูย่อย</span>
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
                                            <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" Width="350"
                                                AutoPostBack="true" OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
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
                                            <asp:DropDownList ID="ddlSearch1" CssClass="ddlSearch" runat="server" Width="350"
                                                AutoPostBack="true" OnSelectedIndexChanged="ddlSearch1_SelectedIndexChanged">
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
                                                CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                                ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
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
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" OnClientClick="AddItem();" Text="       เพิ่มเมนูย่อยใหม่"
                                    OnClick="btAdd_Click" ToolTip="เพิ่มเมนูย่อยใหม่" />
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
                                <span class="spantxt">ชื่อเมนูย่อย : </span>
                            </td>
                            <td>
                                <asp:TextBox CssClass="txtBoxL" ID="txtMySubMenuName" runat="server" Width="300px"></asp:TextBox>
                                <span id="ErrorMySubMenuName" class="ErrorMsg">กรุณาป้อนชื่อเมนูย่อย</span>
                            </td>
                        </tr>
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
                                <span class="spantxt">ชื่อหน้าเมนูย่อย : </span>
                            </td>
                            <td>
                                <asp:TextBox CssClass="txtBoxL" ID="txtLinkName" runat="server" Width="300px"></asp:TextBox>
                                <span id="ErrorLinkName" class="ErrorMsg">กรุณาป้อนชื่อหน้าเมนูย่อย</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">ลำดับ : </span>
                            </td>
                            <td>
                                <asp:TextBox CssClass="txtBoxNum" ID="txtSort" runat="server" onkeypress="return KeyNumber(event);"
                                    Width="50px"></asp:TextBox>
                                <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                            </td>
                            <td align="left" style="width: 80%">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก"
                                    OnClick="btSave_Click " OnClientClick="return Cktxt();" ToolTip="บันทึกเมนูย่อยนี้" />
                                <asp:Button ID="btCancel" CssClass="btNo" runat="server" Text="       ไม่บันทึก"
                                    OnClick="btCancel_Click" ToolTip="ไม่บันทึกเมนูย่อยนี้" />
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
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="ชื่อเมนูย่อย" DataField="MySubMenuName">
                                <ItemStyle Width="60%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ชื่อเมนูหลัก" DataField="MyMainMenuName">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="แสดง" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img style="cursor: pointer" title="<%# Convert.ToBoolean(Eval("Status")) ? "แสดง" : "ไม่แสดง" %>"
                                        src="../image/<%# Convert.ToBoolean(Eval("Status")) ? "ok" : "no" %>.png" border="0"
                                        onclick="javascript:Enabled('<%# Eval("MySubMenuID") %>','<%# Eval("Status") %>','1')" />
                                </ItemTemplate>
                                <ItemStyle Width="12%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="แก้ไข">
                                <ItemTemplate>
                                    <a href="MySubMenuView.aspx?mode=2&id=<%#Eval("MySubMenuID") %>">
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
