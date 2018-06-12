<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopUpProjOld.aspx.cs" Inherits="PopUp_PopUpProjOld" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    ข้อมูลปีที่ผ่านมา
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">ค้นหาตัวชี้วัด</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddl" ID="ddlSearchYear" Width="70px" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearchYear_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">มาตรฐาน : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearch" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearch_SelectedIndexChanged" Width="400px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ตัวบ่งชี้ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList ID="ddlSearch1" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlSearch1_SelectedIndexChanged" Width="400px">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">กลยุทธ์ : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearch2" Width="400px" runat="server"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlSearch2_SelectedIndexChanged">
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
                                    ID="btSearch" runat="server" OnClick="btSearch_Click" />
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
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server">
                        <Columns>
                            <Control:BoundField HeaderText="โครงการ" DataField="ProjectsName">
                                <ItemStyle HorizontalAlign="Left" Width="25%" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="กิจกรรม">
                                <ItemTemplate>
                                    <span title="ปัญหา/ข้อเสนอแนะ : <%#Eval("Note")%>"><%#Eval("ActivityName")%></span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="25%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="ตัวชี้วัด" DataField="IndicatorsName2">
                                <ItemStyle Width="28%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="เกณฑ์ที่ผ่าน" DataField="Weight">
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ตัววัด" DataField="WeightType">
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ทั้งหมด" DataField="OffAll">
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="ทำได้" DataField="OffThat">
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </Control:BoundField>
                            <Control:TemplateField HeaderText="ผลประเมิน">
                                <ItemTemplate>
                                    <img title="<%# Convert.ToBoolean(Eval("CkCriterion")) ? "ผ่าน" : "ไม่ผ่าน" %>"
                                        src="../image/<%# Convert.ToBoolean(Eval("CkCriterion")) ? "ok" : "no" %>.png"
                                        border="0" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="7%" />
                            </Control:TemplateField>
                        </Columns>
                    </Control:DataGridView>
                </div>
                <div class="clear"></div>
                <div class="spaceDiv"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
