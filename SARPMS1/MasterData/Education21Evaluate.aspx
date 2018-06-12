<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Education21Evaluate.aspx.cs" Inherits="Education21Evaluate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../CSS/fileupload.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function EditItem(id, lv) {
            location.href = "Education21Evaluate.aspx?mode=2&id=" + id + "&lv=" + lv;
        }
        function deleteItem(id, lv) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "Education21Evaluate.aspx?mode=3&id=" + id + "&lv=" + lv;
        }
        function Cancel() {
            location.href = "Education21Evaluate.aspx";
        }
        function printRpt(mode, type) {
            var yearb = document.getElementById("<%=ddlSearchYear.ClientID%>").value;
            window.open("../GtReport/Viewer.aspx?rpt=25&yearB=" + yearb + "&rpttype=" + type);
        }
        function Cktxt(m) {
            var ck = 0;
            var ddlEducation21Criterion = $get("<%=ddlEducation21Criterion.ClientID%>");
            var ErrorEducation21Criterion = $get("ErrorEducation21Criterion");

            ck += ckDdlNull(m, ddlEducation21Criterion, ErrorEducation21Criterion);

            if (ck > 0) {
                return false;
            }
            else {
                return true;
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
        function ValidateAttachFile() {
            var attName = $get("<%=fpAttach.ClientID%>").value;
            if (attName == "") {
                alert("กรุณาเลือกไฟล์");
                return false;
            }
            else {
                return true;
            }
        }
        function ckDivCriterion()
        {
            $("div[id^=divCriterion").hide();                       
            if($("[id$=ddlEducation21Criterion").val() != "")
            {
                $("div[id^=divCriterion" + $("[id$=ddlEducation21Criterion").val()).show();
            }
        }

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="pageDiv">
        <div class="warningDiv">
            <asp:Image ID="Img1" runat="server" Visible="false" />
            <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
        </div>
        <div class="headTable">
            การประเมินการจัดการศึกษาตามแนวทางศตวรรษที่ 21
        </div>
        <div class="spaceDiv"></div>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="view" runat="server">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาตัวชี้วัดคุณภาพการพัฒนา</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span id="Span1" runat="server" class="spantxt">ประเภทการประเมิน : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchEvaluateType" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchEvaluateType_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">ด้านการพัฒนาการจัดการศึกษา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged" Width="330">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">มาตรฐานคุณภาพการพัฒนา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearchStandard" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchStandard_SelectedIndexChanged" Width="330">
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
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
                                    </div>
                                </div>
                                <%--<div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">พิมพ์รายงาน : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                                    </div>
                                </div>--%>
                                <div class="spaceDiv"></div>
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
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server" PageSize="30">
                                <Columns>
                                    <Control:BoundField HeaderText="ตัวชี้วัดคุณภาพการพัฒนาที่" DataField="eSort">
                                        <ItemStyle Width="5%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="มาตรฐานคุณภาพการพัฒนา">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("eID").ToString(), Eval("StandardName").ToString(), Eval("lv").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="40%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ตัวชี้วัดคุณภาพการพัฒนา">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("eID").ToString(), Eval("IndicatorName").ToString(), Eval("lv").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="45%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="คะแนน">
                                        <ItemTemplate>
                                            <%# checkEvaluate(Eval("eID").ToString(), Eval("lv").ToString()) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("eID") %>', '<%# Eval("lv") %>');">
                                                <img alt="" style="border: 0; cursor: pointer;" title="ลบ" src="../Image/delete.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
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
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div id="table1" class="PageManageDiv">
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span id="lblYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divStudyYear" style="width: 500px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ประเภทการประเมิน : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divEvaluateType" style="width: 500px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ด้านการพัฒนาการจัดการศึกษา : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divEducation21Side" style="width: 500px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">มาตรฐานคุณภาพการพัฒนา : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divEducation21Standard" style="width: 500px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ตัวชี้วัดคุณภาพการพัฒนา : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divEducation21Indicator" style="width: 500px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">รายละเอียด : </span>
                                </div>
                                <div class="divB_Head">
                                    <div id="divDetail" style="width: 450px;" runat="server">
                                    </div>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ระดับเกณฑ์คุณภาพ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList ID="ddlEducation21Criterion" CssClass="ddl txt200" runat="server">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorEducation21Criterion" class="ErrorMsg">เลือกระดับเกณฑ์คุณภาพ</span>
                                </div>
                            </div>
                            <div>
                                <asp:Repeater ID="rptCriterion" runat="server">
                                    <ItemTemplate>
                                        <div id="divCriterion<%# Container.ItemIndex + 1 %>" style="float:left; display:none; width:100%;">
                                            <div class="inputrowH">
                                                <div class="divF_Head">
                                                    <span class="spantxt">คำอธิบาย : </span>
                                                </div>
                                                <div class="divB_Head">
                                                    <%# Eval("Detail").ToString() %>
                                                </div>
                                            </div>
                                            <div class="inputrowH">
                                                <div class="divF_Head">
                                                    <span class="spantxt">คะแนน : </span>
                                                </div>
                                                <div class="divB_Head">
                                                    <%# Eval("Score").ToString() %>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
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
                        <asp:CheckBox ID="cbDuo" runat="server" Text=" เป็นไฟล์ Duo" />
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
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="spaceDiv"></div>
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
                                        OnClientClick="return Cktxt(1);" ToolTip="บันทึกตัวชี้วัดคุณภาพการพัฒนานี้" />
                                    <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างตัวชี้วัดคุณภาพการพัฒนาใหม่"
                                        OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกตัวชี้วัดคุณภาพการพัฒนานี้และสร้างตัวชี้วัดคุณภาพการพัฒนาใหม่" />
                                </div>
                                <div class="classBtCancel">
                                    <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึก" onclick="Cancel();" />
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
