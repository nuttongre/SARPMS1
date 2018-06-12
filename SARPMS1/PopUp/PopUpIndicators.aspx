<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpIndicators.aspx.cs" Inherits="PopUpIndicators" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        var count = 0;
        function getItem() {
            var type = Request("type");
            var tag = document.getElementsByTagName("input");
            var Id = ""; var Name = "";

            if (type == 'c') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "checkbox") {
                        if (tag[i].checked) {
                            count += 1;
                        }
                    }
                }
            }
            if (type == 'r') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "radio") {
                        if (tag[i].checked) {
                            count += 1;
                        }
                    }
                }
            }
            if (count == 0) { alert("กรุณาเลือกตัวชี้วัด"); return false; }
            Name = $get("<%=txtID.ClientID%>").value;
            parent.$get(Request('indname')).value = Name.substring(0, Name.length - 1);
            parent.dialogBox.close();
        }
        function setItem(type) {
            $get("<%=txtID.ClientID%>").value = "";
            var tag = document.getElementsByTagName("input");
            var Id = ""; var Name = "";
            if (type == 'c') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "checkbox") {
                        if (tag[i].checked) {
                            count += 1;
                            $get("<%=txtID.ClientID%>").value += tag[i].value + ",";
                        }
                    }
                }
            }
            if (type == 'r') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "radio") {
                        if (tag[i].checked) {
                            count += 1;
                            $get("<%=txtID.ClientID%>").value += tag[i].value + ",";
                        }
                    }
                }
            }
        }
        function CkIsSelect(type) {
            var tag = document.getElementsByTagName("input");
            var txtID = $get("<%=txtID.ClientID%>").value;
            var ckID = txtID.split
            if (type == 'c') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "checkbox") {
                        if (txtID != "") {
                            if (txtID.indexOf(tag[i].value) > -1) {
                                tag[i].checked = true;
                            }
                        }
                    }
                }
            }
            if (type == 'r') {
                for (var i = 0; i < tag.length; i++) {
                    if (tag[i].type == "radio") {
                        if (txtID != "") {
                            if (txtID.indexOf(tag[i].value) > -1) {
                                tag[i].checked = true;
                            }
                        }
                    }
                }
            }
        }
        function gotoExit() {
            parent.dialogBox.close();
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
            <div class="headTable">
                <asp:Label ID="lblStrategiesName" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="spaceDiv"></div>
            <div class="clear"></div>
            <div class="spaceDiv"></div>
            <div id="TableSearch" runat="server" class="PopUpTableSearch">
                <div class="SearchTable" style="width:90%;">
                    <div class="SearchHead">
                        <span class="spantxt2 spansize14">ค้นหาตัวชี้วัด</span>
                    </div>
                    <div class="spaceDiv"></div>
                    <div class="PopUpSearchtxtF">
                        <span class="spantxt">คำค้นหา : </span>
                    </div>
                    <div class="PopUpSearchF">
                        <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="200px"></asp:TextBox><asp:Button
                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา"
                            Text="  " />
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div class="SearchTotal">
                        <span class="spantxt">จำนวนที่พบ : </span><span id="lblSearchTotal" class="spantxt"
                            style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">รายการ</span>
                    </div>
                    <div class="spaceDiv"></div>
                </div>
            </div>
            <div class="clear"></div>
            <div class="spaceDiv"></div>
            <div class="gridViewDiv" style="text-align:left;"> 
                <asp:TextBox ID="txtID" CssClass="txtBoxnone" runat="server" Width="0"></asp:TextBox>
                <asp:Repeater ID="rpt1" runat="server">
                    <ItemTemplate>
                        <div style="margin:3px 40px; clear:both; float:none;">
                            <%# getCheckBox(Eval("RecNum").ToString(), Eval("IndicatorsName").ToString(), Container.ItemIndex) %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="clear"></div>
            <div class="spaceDiv"></div>
            <div class="centerDiv">
                <input type="button" id="btSave" class="btYes" value="      ตกลง" onclick="getItem();" />
                <input type="button" id="btCancel" class="btNo" value="      ยกเลิก" onclick="gotoExit();" />
            </div>
            <div class="clear"></div>
            <div class="spaceDiv"></div>
        </div>
        </ContentTemplate>
    </asp:UpdatePanel>

   <%-- <div>
        <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
            <div style="padding: 0 0 0 20px; text-align: left;">

                <br />
                <hr />
                <asp:Repeater ID="rptIncicators" runat="server">
                    <ItemTemplate>
                        <span class="spantxt3">ตัวชี้วัดที่
                            <%#Container.ItemIndex + 1 %>.
                            <%#Eval("IndicatorsName")%>
                            <br />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ajax:AjaxPanel>
    </div>--%>
</asp:Content>
