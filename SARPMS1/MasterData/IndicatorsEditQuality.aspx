<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="IndicatorsEditQuality.aspx.cs" Inherits="IndicatorsEditQuality" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function ValidateFile()
    {
        var file=$get('<%=fpAttach.ClientID %>');
        if(file.value==""){alert("กรุณาเลือกไฟล์");return false;}else return true;
    }
    function ConfirmDelete(Delid)
    {
        if(confirm("คำเตือน!!\r\nการลบข้อมูลนี้เป็นการลบแบบถาวรไม่สามารถนำกลับมาได้\r\n\nต้องการลบรายการที่เลือก ใช่ หรือไม่?\r\n[เลือก OK เพื่อยืนยันการลบข้อมูล หรือเลือก Cancel เพื่อยกเลิกการลบข้อมูล]"))
        {
            var _id = RequestQuery("id");
            var _acid = RequestQuery("acid");
            window.location="IndicatorsEditQuality.aspx?mode=2&id=" + _id + "&acid=" + _acid + "&delmode=3&did=" + Delid;
        }
    }
    function deleteItem(id)
    {
        if(confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "IndicatorsEditQuality.aspx?mode=3&id="+id;
    }
    function AddItem()
    {
        location.href = "IndicatorsEditQuality.aspx?mode=1";
    }
     function Ckddl()
    {

    }
    </script>

    <table style="width: 100%">
        <tr>
            <td colspan="2">
                <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </ajax:AjaxPanel>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="headTable">
                ประเมินเชิงคุณภาพตามตัวบ่งชี้
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 15px;">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%">
                <ajax:AjaxPanel ID="AjaxPanel2" runat="server">
                    <table id="TableSearch" runat="server" width="100%">
                        <tr>
                            <td colspan="3" align="center">
                                <table class="tableSearch">
                                    <tr>
                                        <td colspan="3" class="headSearch">
                                            <span class="spantxt2 spansize14">ค้นหาตัวบ่งชี้</span>
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
                                            <span class="spantxt">ปีการศึกษา : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="SearchB">
                                        </td>
                                        <td class="SearchtxtF">
                                            <span class="spantxt">มาตรฐาน : </span>
                                        </td>
                                        <td class="SearchF">
                                            <asp:DropDownList CssClass="ddlSearch" ID="ddlSearch" Width="500px" runat="server"
                                                AutoPostBack="true" OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
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
                            <td colspan="3" align="center">
                                <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                                    style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                            </td>
                        </tr>
                    </table>
                </ajax:AjaxPanel>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%; height: 5px;">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 100%">
                <table id="table1" runat="server" width="100%">
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">ปีการศึกษา : </span>
                        </td>
                        <td>
                            <asp:Label ID="lblStudyYear" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">มาตรฐาน : </span>
                        </td>
                        <td>
                            <asp:Label ID="lblStandard" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">ตัวบ่งชี้ : </span>
                        </td>
                        <td>
                            <asp:Label ID="lblIndicators" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width:100%; height:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%; vertical-align:top;">
                            <span class="spantxt">คำอธิบาย : </span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDetail" runat="server" CssClass="txtBoxNotType" ReadOnly="true" TextMode="MultiLine" Height="200" Width="600"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width:100%; height:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%; vertical-align: top;">
                            <span class="spantxt">ประเด็นการพิจารณา : </span>
                        </td>
                        <td align="left" style="width: 80%">
                            <asp:TextBox ID="txtDevelopIssues" runat="server" CssClass="txtBoxNotType" ReadOnly="true" TextMode="MultiLine" Height="300" Width="600"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                            <span class="spantxt">น้ำหนักคะแนน : </span>
                        </td>
                        <td>
                            <asp:Label ID="lblWeightScore" CssClass="spantxt2 spantxt3" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 25%; vertical-align: top;">
                            <span class="spantxt2 spantxt5">ระดับคุณภาพที่ทำได้ : </span>
                        </td>
                        <td>
                            <ajax:AjaxPanel ID="AjaxPanel3" runat="server">
                                <asp:DropDownList ID="ddlCan" CssClass="spantxt2 spantxt3" Width="50" runat="server" OnSelectedIndexChanged="ddlCan_OnSelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </ajax:AjaxPanel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 25%; vertical-align: top;">
                            <span class="spantxt">คิดเป็น : </span>
                        </td>
                        <td>
                            <ajax:AjaxPanel ID="AjaxPanel15" runat="server">
                                <asp:Label ID="lblScore" runat="server" CssClass="spantxt2 spantxt3"></asp:Label>
                                <span class="spantxt" id="lblPC">คะแนน</span>
                            </ajax:AjaxPanel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%; vertical-align: top;">
                            <span class="spantxt2 spantxt5">ปัญหา/ข้อเสนอแนะ : </span>
                        </td>
                        <td>
                            <ajax:AjaxPanel ID="AjaxPanel17" runat="server">
                                <asp:TextBox CssClass="txtBox" ID="txtNote" Width="600px" TextMode="MultiLine" Height="100px"
                                    MaxLength="200" runat="server"></asp:TextBox>
                            </ajax:AjaxPanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%; text-align: right;">
                            <span class="spantxt">แนบไฟล์ : </span>
                        </td>
                        <td>
                            <asp:FileUpload ID="fpAttach" runat="server" /><asp:Button ID="btnAttach" Text="เพิ่มไฟล์แนบ"
                                CssClass="button_green2" runat="server" OnClientClick="return ValidateFile();"
                                OnClick="btnAttach_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%; text-align: right;">
                            <span class="spantxt" style="vertical-align: top;">ไฟล์แนบทั้งหมด : </span>
                        </td>
                        <td style="border: solid 1px #BDBDBD; min-height: 25px; vertical-align: middle; text-align: left;
                            background-color: #E0F8F7">
                            <asp:Repeater ID="rptFile" runat="server">
                            <ItemTemplate>
                                    <span class="rpt_content"><a href="#">
                                        <img style="border: none;" src="../Image/RemoveContact.png" alt="ลบไฟล์แนบออก" title="ลบไฟล์แนบออก"
                                            onclick="ConfirmDelete('<%# Eval("AttachId") %>')" /></a> <a target="_blank" href="../AttachFile/<%# Eval("AttachID")%>_<%# Eval("FileName")%>">
                                                <%# Eval("FileName").ToString() %></a> </span>
                            </ItemTemplate>
                             </asp:Repeater>                                             
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 20%">
                        </td>
                        <td align="left" style="width: 80%">
                                <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก" OnClick="btSave_Click "
                                    OnClientClick="return Ckddl();" ToolTip="บันทึกการประเมินกิจกรรมตามตัวชี้วัด" />
                                <asp:Button ID="btCancel" CssClass="btNo" runat="server" Text="       ไม่บันทึก"
                                    OnClick="btCancel_Click" ToolTip="ไม่บันทึกการประเมินกิจกรรมตามตัวชี้วัด" />
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
                <ajax:AjaxPanel ID="AjaxPanel19" runat="server">
                    <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <Control:TemplateField HeaderText="เลือก">
                                <ItemTemplate>
                                    <a href="IndicatorsEditQuality.aspx?mode=2&id=<%#Eval("IndicatorsCode")%>&yearid=<%#Eval("StudyYear")%>">
                                        <img style="border: 0; cursor: pointer;" title="เลือกไปประเมินผล" src="../Image/<%# (Eval("Quality").ToString()== "0" ? "goto":"goto2")%>.png" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <%--<Control:BoundField HeaderText="มาตรฐาน" DataField="stdFullName">
                                <ItemStyle Width="65%" HorizontalAlign="Left" />
                            </Control:BoundField>--%>
                            <Control:BoundField HeaderText="ตัวบ่งชี้" DataField="intFullName">
                                <ItemStyle Width="55%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="น้ำหนักคะแนน" DataField="WeightScore" DataFormatString="{0:n2}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ผลประเมินที่ได้" DataField="Quality" DataFormatString="{0:n0}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="คะแนนที่ได้" DataField="Score" DataFormatString="{0:n2}">
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="แก้ไข">
                                <ItemTemplate>
                                    <a href="IndicatorsEditQuality.aspx?mode=2&id=<%#Eval("IndicatorsCode")%>&yearid=<%#Eval("StudyYear")%>">
                                        <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ลบ" Visible="false">
                                <ItemTemplate>
                                    <a href="javascript:deleteItem('<%#Eval("IndicatorsCode") %>');">
                                        <img style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                            </Control:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Right" />
                    </Control:DataGridView>
                </ajax:AjaxPanel>
            </td>
        </tr>
    </table>
</asp:Content>
