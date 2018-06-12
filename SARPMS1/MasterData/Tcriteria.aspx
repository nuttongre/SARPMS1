<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="Tcriteria.aspx.cs" Inherits="Tcriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "Tcriteria.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "Tcriteria.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('ต้องการลบรายการนี้ ใช่หรือไม่')) location.href = "Tcriteria.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "Tcriteria.aspx";
        }
        function printRpt(mode, type, id) {
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type);
        }
        function Cktxt(m) {
            var ck = 0;
            var ddlScoreGroup = $get("<%=ddlScoreGroup.ClientID%>");
            var ErrorScoreGroup = $get("ErrorScoreGroup");
            var txtDetail = $get("<%=txtDetail.ClientID%>");
            var ErrorDetail = $get("ErrorDetail");
            var txtCriterion = $get("<%=txtCriterion.ClientID%>");
            var ErrorCriterion = $get("ErrorCriterion");
            var txtTranslation = $get("<%=txtTranslation.ClientID%>");
            var ErrorTranslation = $get("ErrorTranslation");
            var txtMin = $get("<%=txtMin.ClientID%>");
            var ErrorMin = $get("ErrorMin");
            var txtMax = $get("<%=txtMax.ClientID%>");
            var ErrorMax = $get("ErrorMax");

            ck += ckTxtNull(m, txtMax, ErrorMax);
            ck += ckTxtNull(m, txtMin, ErrorMin);
            ck += ckTxtNull(m, txtTranslation, ErrorTranslation);
            ck += ckTxtNull(m, txtCriterion, ErrorCriterion);
            ck += ckTxtNull(m, txtDetail, ErrorDetail);
            ck += ckDdlNull(m, ddlScoreGroup, ErrorScoreGroup);

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
                    ตารางเทียบเกณฑ์การประเมินระดับคุณภาพ
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">ค้นหาเกณฑ์การประเมินระดับคุณภาพ</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">หมวดน้ำหนักคะแนน : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">คำค้นหา : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:TextBox CssClass="txtSearch" ID="txtSearch" runat="server" Width="322px"></asp:TextBox><asp:Button
                                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="คลิ๊กเพื่อค้นหา" />
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
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" Text="       สร้างเกณฑ์การประเมินใหม่"
                                    OnClientClick="AddItem();" ToolTip="สร้างเกณฑ์การประเมินใหม่" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server">
                                <Columns>
                                    <Control:TemplateField HeaderText="ช่วงคะแนนที่คำนวณได้">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("TcriteriaID").ToString(), Eval("Detail").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="35%" />
                                    </Control:TemplateField>
                                    <Control:BoundField HeaderText="คะแนนน้อยสุด" DataField="TMin" DataFormatString="{0:N2}">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="คะแนนมากสุด" DataField="TMax" DataFormatString="{0:N2}">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="น้ำหนักคะแนน" DataField="Tcriteria">
                                        <ItemStyle Width="10%" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="ระดับคุณภาพ" DataField="Criterion">
                                        <ItemStyle Width="10%" />
                                    </Control:BoundField>
                                    <Control:BoundField HeaderText="แปลคุณภาพ" DataField="Translation">
                                        <ItemStyle Width="15%" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="แก้ไข">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("TcriteriaID") %>');">
                                                <img style="border: 0; cursor: pointer;" title="แก้ไข" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ลบ">
                                        <ItemTemplate>
                                            <%# checkdel(Eval("CreateUser").ToString(), Eval("TcriteriaID").ToString()) %>
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
                                    <span class="spantxt">หมวดน้ำหนักคะแนน : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlScoreGroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlScoreGroup_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <span class="ColorRed">*</span> <span id="ErrorScoreGroup"
                                        class="ErrorMsg">กรุณาเลือกหมวดน้ำหนักคะแนน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">น้ำหนักคะแนนเต็ม : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:Label ID="lblTcriteria" runat="server" Text="0" ForeColor="Black"></asp:Label>
                                    <span class="spantxt">คะแนน</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ช่วงคะแนนที่คำนวณได้ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt250" ID="txtDetail" MaxLength="20" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorDetail" class="ErrorMsg">กรุณาป้อนช่วงคะแนนที่คำนวณได้</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">ระดับคุณภาพ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum txt50" ID="txtCriterion" onkeypress="return KeyNumber(event);"
                                        MaxLength="1" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorCriterion" class="ErrorMsg">กรุณาป้อนระดับคุณภาพ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">แปลคุณภาพ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxL txt250" ID="txtTranslation" MaxLength="20" runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorTranslation" class="ErrorMsg">กรุณาป้อนแปลคุณภาพ</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">คะแนนต่ำสุด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum txt50" ID="txtMin" MaxLength="6" onkeypress="return KeyNumber(event);"
                                        runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorMin" class="ErrorMsg">กรุณาป้อนคะแนนต่ำสุด</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">คะแนนสูงสุด : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox CssClass="txtBoxNum txt50" ID="txtMax" MaxLength="6" onkeypress="return KeyNumber(event);"
                                        runat="server"></asp:TextBox>
                                    <span class="ColorRed">*</span> <span id="ErrorMax" class="ErrorMsg">กรุณาป้อนคะแนนสูงสุด</span>
                                </div>
                            </div>
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
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       บันทึก"
                                            OnClick="btSave_Click " OnClientClick="return Cktxt(1);" ToolTip="บันทึกเกณฑ์การประเมินนี้" />
                                        <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       บันทึกและสร้างเกณฑ์การประเมินใหม่"
                                            OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="บันทึกและสร้างเกณฑ์การประเมินใหม่" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ไม่บันทึก" title="ไม่บันทึกพันธกิจนี้" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server">
                                    <Columns>
                                        <Control:BoundField HeaderText="ช่วงคะแนนที่คำนวณได้" DataField="Detail">
                                            <ItemStyle Width="35%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="คะแนนน้อยสุด" DataField="TMin" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="คะแนนมากสุด" DataField="TMax" DataFormatString="{0:N2}">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="น้ำหนักคะแนน" DataField="Tcriteria">
                                            <ItemStyle Width="10%" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="ระดับคุณภาพ" DataField="Criterion">
                                            <ItemStyle Width="10%" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="แปลคุณภาพ" DataField="Translation">
                                            <ItemStyle Width="15%" />
                                        </Control:BoundField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
