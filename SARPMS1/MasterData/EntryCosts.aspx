<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="EntryCosts.aspx.cs" Inherits="EntryCosts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function deleteItem(id)
    {
        if(confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "EntryCosts.aspx?mode=3&id="+id;
    }
    function AddItem()
    {
        location.href = "EntryCosts.aspx?mode=1";
    }
    function Ckddl()
    {
        if(document.getElementById("<%=ddlOperations.ClientID%>").selectedIndex == 0)
        {
            document.getElementById("ErrorOperations").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorOperations").style.display = "none";
            return Cktxt();
            return true;
        }
    }
    function Cktxt()
    {
        if(document.getElementById("<%=txtEntryCosts.ClientID%>").value == "")
        {
            document.getElementById("ErrorEntryCosts").style.display = "block";
            return false;
        }
        else
        {
            document.getElementById("ErrorEntryCosts").style.display = "none";
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
        <table style="width: 100%">
            <tr>
                <td colspan="2">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="headTable">
                    รายการค่าใช้จ่าย
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
                                            <span class="spantxt2 spansize14">ค้นหารายการค่าใช้จ่าย</span>
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
                                            <span class="spantxt">การดำเนินงาน : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged" Width="500px">
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
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" Text="       สร้างรายการค่าใช้จ่าย"
                                    OnClientClick="AddItem();" OnClick="btAdd_Click" ToolTip="สร้างรายการค่าใช้จ่าย" />
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
                <td colspan="2" style="width: 100%; height: 5px">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 100%">
                    <table id="table1" runat="server" width="100%">
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">การดำเนินงาน : </span>
                            </td>
                            <td>
                                <asp:DropDownList CssClass="ddl" ID="ddlOperations" Width="500px" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlOperations_OnSelectedChanged" runat="server">
                                </asp:DropDownList>
                                <span class="ColorRed">*</span> <span id="ErrorOperations" class="ErrorMsg">เลือกการดำเนินงาน</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">รายการค่าใช้จ่าย : </span>
                            </td>
                            <td>
                                <asp:TextBox CssClass="txtBoxL" ID="txtEntryCosts" Width="500px" runat="server"></asp:TextBox>
                                <span class="ColorRed">*</span> <span id="ErrorEntryCosts" class="ErrorMsg">กรุณาป้อนรายการค่าใช้จ่าย</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">ประเภทงบประมาณ : </span>
                            </td>
                            <td>
                                <asp:RadioButton ID="rbtStatement" Text=" งบดำเนินงาน" Checked="true" GroupName="1"
                                    runat="server" />
                                <asp:RadioButton ID="rbtPersonnel" Text=" งบบุคคลากร" Checked="false" GroupName="1"
                                    runat="server" />
                                <asp:RadioButton ID="rbtFinance" Text=" งบลงทุน" Checked="false" GroupName="1" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                <span class="spantxt">ลำดับที่ : </span>
                            </td>
                            <td align="left" style="width: 80%">
                                <asp:TextBox CssClass="txtBoxNum" ID="txtSort" runat="server" onkeypress="return KeyNumber(event);"
                                    Width="50px"></asp:TextBox>
                                <span class="ColorRed">*</span> <span id="ErrorSort" class="ErrorMsg">กรุณาป้อนลำดับที่</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                            </td>
                            <td align="left" style="width: 80%">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก"
                                    OnClick="btSave_Click " OnClientClick="return Ckddl();" ToolTip="บันทึกรายการค่าใช้จ่ายนี้" />
                                <asp:Button ID="btCancel" CssClass="btNo" runat="server" Text="       ไม่บันทึก"
                                    OnClick="btCancel_Click" ToolTip="ไม่บันทึกรายการค่าใช้จ่ายนี้" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center; width: 100%;">
                    <Control:DataGridView ID="GridView1" runat="server" PageSize="20">
                        <Columns>
                            <Control:TemplateField HeaderText="ลำดับที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="รายการค่าใช้จ่าย" DataField="EntryCostsName">
                                <ItemStyle Width="60%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ประเภทงบประมาณ" DataField="BudgetType">
                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="แก้ไข">
                                <ItemTemplate>
                                    <a href="EntryCosts.aspx?mode=2&id=<%#Eval("EntryCostsCode") %>">
                                        <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ลบ">
                                <ItemTemplate>
                                    <a href="javascript:deleteItem('<%#Eval("EntryCostsCode") %>');">
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
