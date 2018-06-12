<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true" CodeFile="PopUpUploadFile.aspx.cs" Inherits="PopUp_PopUpUploadFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../CSS/fileupload.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function AttDel(id, obj) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) {
                $.getJSON("PopUpUploadFile.aspx?opt=delAtt&attID=" + id, function (response) {
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
    </script>
    <div>
        <asp:HiddenField ID="hdfID" runat="server" />
        <div class="inputrowH">
            <div class="divF_Head">
                <span class="spantxt">แนบไฟล์ : </span>
            </div>
            <div class="divB_Head">
                <img src="../Image/imgIcon.png" title="เลือกไฟล์" style="float: left; padding-right: 5px; vertical-align: bottom;" />
                <asp:FileUpload ID="fpAttach" runat="server" Width="200px" /><asp:Button ID="btnAttach" Text="    แนบไฟล์" CssClass="btAttachFile"
                    runat="server" OnClientClick="return ValidateAttachFile();"
                    OnClick="btnAttach_Click" />
                <asp:CheckBox ID="cbDuo" runat="server" Text=" เป็นไฟล์ Duo" Visible="false" />
            </div>
        </div>
        <div class="inputrowH">
            <div class="divF_Head">
                <span class="spantxt">ไฟล์แนบ : </span>
            </div>
            <div class="divB_Head">
                <div class="framImg" style="height:300px;">
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
    </div>
</asp:Content>

