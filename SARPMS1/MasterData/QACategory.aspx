<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="QACategory.aspx.cs" Inherits="QACategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function AddItem() {
            location.href = "QACategory.aspx?mode=1";
        }
        function EditItem(id) {
            location.href = "QACategory.aspx?mode=2&id=" + id;
        }
        function deleteItem(id) {
            if (confirm('��ͧ���ź��¡�ù�� ���������')) location.href = "QACategory.aspx?mode=3&id=" + id;
        }
        function Cancel() {
            location.href = "QACategory.aspx";
        }
        function printRpt(mode, type, id) {
            window.open("../GtReport/Viewer.aspx?rpt=" + mode + "&id=" + id + "&rpttype=" + type);
        }
        function Cktxt(m) {
            var ck = 0;
            var txtQACategory = $get("<%=txtQACategory.ClientID%>");
            var ErrorQACategory = $get("ErrorQACategory");
            var txtSort = $get("<%=txtSort.ClientID%>");
            var ErrorSort = $get("ErrorSort");

            ck += ckTxtNull(m, txtSort, ErrorSort);
            ck += ckTxtNull(m, txtQACategory, ErrorQACategory);

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
                    ��Ǵࡳ���ҧ��Ťس�Ҿ
                </div>
                <div class="spaceDiv"></div>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="view" runat="server">
                        <div id="Div1" class="TableSearch">
                            <div class="SearchTable">
                                <div class="SearchHead">
                                    <span class="spantxt2 spansize14">������Ǵࡳ���ҧ��Ťس�Ҿ</span>
                                </div>
                                <div class="spaceDiv"></div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span id="lblSearchYear" runat="server" class="spantxt">�ա���֡�� : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="inputrow">
                                    <div class="SearchtxtF">
                                        <span class="spantxt">�Ӥ��� : </span>
                                    </div>
                                    <div class="SearchF">
                                        <asp:TextBox CssClass="txtSearch txt300" ID="txtSearch" runat="server"></asp:TextBox><asp:Button
                                            CssClass="btSearch" onmouseover="SearchBt(this,'btSearchOver');" onmouseout="SearchBt(this,'btSearch');"
                                            ID="btSearch" runat="server" OnClick="btSearch_Click" ToolTip="�������ͤ���" />
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="spaceDiv"></div>
                                <div class="SearchTotal">
                                    <span class="spantxt">�ӹǹ��辺 : </span><span id="lblSearchTotal" class="spantxt"
                                        style="color: Black;" runat="server"></span>&nbsp;<span class="spantxt">��¡��</span>
                                </div>
                                <div class="spaceDiv"></div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="btAddDiv">
                                <asp:Button ID="btAdd" CssClass="btAdd" runat="server" OnClientClick="AddItem();"
                                    Text="       ���ҧ��Ǵࡳ���ҧ��Ťس�Ҿ����" ToolTip="���ҧ��Ǵࡳ���ҧ��Ťس�Ҿ����" />
                            </div>
                            <div class="spaceDiv"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="spaceDiv"></div>
                        <div class="gridViewDiv">
                            <Control:DataGridView ID="GridView1" runat="server">
                                <Columns>
                                    <Control:BoundField HeaderText="��Ǵࡳ���ҧ��Ťس�Ҿ���" DataField="Sort">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>
                                    <Control:TemplateField HeaderText="������Ǵࡳ���ҧ��Ťس�Ҿ">
                                        <ItemTemplate>
                                            <%# checkedit(Eval("QACategoryID").ToString(), Eval("QACategoryName").ToString())%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="80%" />
                                    </Control:TemplateField>
                                    <%--<Control:BoundField HeaderText="���˹ѡ��ṹ" DataField="WeightScore">
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </Control:BoundField>--%>
                                    <Control:TemplateField HeaderText="���">
                                        <ItemTemplate>
                                            <a href="javascript:;" onclick="EditItem('<%#Eval("QACategoryID") %>');">
                                                <img style="border: 0; cursor: pointer;" title="���" src="../Image/edit.gif" /></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="5%" />
                                    </Control:TemplateField>
                                    <Control:TemplateField HeaderText="ź">
                                        <ItemTemplate>
                                            <a href="javascript:deleteItem('<%#Eval("QACategoryID") %>');">
                                                <img style="border: 0; cursor: pointer;" title="ź" src="../Image/delete.gif" /></a>
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
                                    <span id="lblYear" runat="server" class="spantxt">�ա���֡�� : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:DropDownList CssClass="ddl" ID="ddlYearB" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">��Ǵࡳ���ҧ��Ťس�Ҿ��� : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtSort" CssClass="txtBoxNum txt50" MaxLength="2" runat="server"
                                        onkeypress="return KeyNumber(event);"></asp:TextBox>&nbsp;<span class="ColorRed">*</span>
                                    <span id="ErrorSort" class="ErrorMsg">��سһ�͹�ӴѺ���</span>
                                </div>
                            </div>
                            <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">��Ǵࡳ���ҧ��Ťس�Ҿ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtQACategory" CssClass="txtBoxL txt400" MaxLength="200" runat="server"></asp:TextBox>&nbsp;<span
                                        class="ColorRed">*</span> <span id="ErrorQACategory" class="ErrorMsg">��سһ�͹��Ǵࡳ���ҧ��Ťس�Ҿ</span>
                                </div>
                            </div>
                             <div class="inputrowH">
                                <div class="divF_Head">
                                    <span class="spantxt">��������´ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtDetail" CssClass="txtBoxL txt400" TextMode="MultiLine" Height="80" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="inputrowH" style="display:none;">
                                <div class="divF_Head">
                                    <span class="spantxt">��ṹ : </span>
                                </div>
                                <div class="divB_Head">
                                    <asp:TextBox ID="txtScore" CssClass="txtBoxNum" Width="50" runat="server"></asp:TextBox>
                                    <%--<asp:DropDownList CssClass="ddl" ID="ddlScoreGroup" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlScoreGroup_SelectedIndexChanged">
                                    </asp:DropDownList>--%>&nbsp;<span class="ColorRed">*</span> <span id="ErrorScore" class="ErrorMsg">��سһ�͹��ṹ</span>
                                </div>
                            </div>
                            <div class="spaceDiv"></div>
                            <%--<div class="gridViewDiv">
                                <Control:DataGridView ID="dgCriteria" runat="server">
                                    <Columns>
                                        <Control:BoundField HeaderText="��ǧ��ṹ���ӹǳ��" DataField="Detail">
                                            <ItemStyle Width="58%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="���˹ѡ��ṹ" DataField="Tcriteria">
                                            <ItemStyle Width="10%" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="�дѺ�س�Ҿ" DataField="Criterion">
                                            <ItemStyle Width="10%" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="�Ťس�Ҿ" DataField="Translation">
                                            <ItemStyle Width="20%" />
                                        </Control:BoundField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>--%>
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
                                        <asp:Button ID="btSave" CssClass="btYes" runat="server" Text="       �ѹ�֡" OnClick="btSave_Click"
                                            OnClientClick="return Cktxt(1);" ToolTip="�ѹ�֡��Ǵࡳ���ҧ��Ťس�Ҿ���" />
                                        <asp:Button ID="btSaveAgain" CssClass="btYesToo" runat="server" Text="       �ѹ�֡������ҧ��Ǵࡳ���ҧ��Ťس�Ҿ����"
                                            OnClick="btSaveAgain_Click" OnClientClick="return Cktxt(1);" ToolTip="�ѹ�֡��Ǵࡳ���ҧ��Ťس�Ҿ���������ҧ��Ǵࡳ���ҧ��Ťس�Ҿ����" />
                                    </div>
                                    <div class="classBtCancel">
                                        <input type="button" class="btNo" value="      ���ѹ�֡" title="���ѹ�֡" onclick="Cancel();" />
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                            <div class="gridViewDiv">
                                <Control:DataGridView ID="GridView2" runat="server" Visible="false">
                                    <Columns>
                                        <Control:BoundField HeaderText="��Ǵࡳ���ҧ��Ťس�Ҿ���" DataField="Sort">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>
                                        <Control:BoundField HeaderText="������Ǵࡳ���ҧ��Ťس�Ҿ" DataField="QACategoryName">
                                            <ItemStyle Width="90%" HorizontalAlign="Left" />
                                        </Control:BoundField>
                                        <%--<Control:BoundField HeaderText="���˹ѡ��ṹ" DataField="WeightScore">
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </Control:BoundField>--%>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Right" />
                                </Control:DataGridView>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
