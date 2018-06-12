<%@ Page Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true"
    CodeFile="PopupCountQACategory.aspx.cs" Inherits="PopupCountQACategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="pageDiv">
                <div style="text-align: left;">
                    <span class="spantxt2">สถานะ : </span>
                    <img style="border: none;" src="../Image/00.png" width="25px" height="25px" /><span style="color: Black;">รอดำเนินการ</span>
                    <img style="border: none;" src="../Image/01.png" width="25px" height="25px" /><span style="color: #086A87;">กำลังดำเนินการ</span>
                    <img style="border: none;" src="../Image/02.png" width="25px" height="25px" /><span style="color: Red;">เลยกำหนดการ</span>
                    <img style="border: none;" src="../Image/03.png" width="25px" height="25px" /><span style="color: Green">ดำเนินการเสร็จสิ้น</span>
                    <img style="border: none;" src="../Image/04.png" width="25px" height="25px" /><span style="color: #886A08;">ใกล้เลยกำหนดการ</span>
                </div>
                <div class="spaceDiv"></div>
                <div class="gridViewDiv">
                    <Control:DataGridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <Control:TemplateField HeaderText="ที่">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <ItemStyle Width="2%" HorizontalAlign="Left" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="สถานะ" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                        <img style="border: none;" title="<%# (Eval("status").ToString()=="0"?"รอดำเนินการ":(Eval("status").ToString()=="1"?"กำลังดำเนินการ":(Eval("status").ToString()=="2"?"เลยกำหนดการ":(Eval("status").ToString()=="3"?"ดำเนินการเสร็จแล้ว":"ใกล้ถึงกำหนด")))) %>"
                                            src='../Image/<%# (Eval("status").ToString()=="0"?"00":(Eval("status").ToString()=="1"?"01":(Eval("status").ToString()=="2"?"02":(Eval("status").ToString()=="3"?"03":"04")))) %>.png' />
                                </ItemTemplate>
                                <ItemStyle Width="5%" />
                            </Control:TemplateField>
                            <Control:TemplateField HeaderText="ชื่อกิจกรรม">
                                <ItemTemplate>
                                    <a href="../PopUp/PopUpActivityDetail.aspx?id=<%#Eval("ActivityCode")%>" id="LinkOld" target="_blank">
                                        <%#Eval("ActivityName")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Width="32%" />
                            </Control:TemplateField>
                            <Control:BoundField HeaderText="หน่วยงาน" DataField="DeptName">
                                <ItemStyle Width="25%" HorizontalAlign="Left" />
                            </Control:BoundField>
                            <Control:BoundField HeaderText="งบประมาณ" DataField="TotalAmount" DataFormatString="{0:n2}">
                                <ItemStyle HorizontalAlign="Right" Width="13%" />
                            </Control:BoundField>
                            <%--<Control:BoundField HeaderText="ประเภทงบประมาณ" DataField="CostsType">
                            <ItemStyle Width="10%" HorizontalAlign="Left" />
                        </Control:BoundField>--%>
                            <Control:TemplateField HeaderText="วันที่ดำเนินการ">
                                <ItemTemplate>
                                    <%#DateFormat (Eval("SDate"),Eval("EDate"))%>
                                </ItemTemplate>
                                <ItemStyle Width="23%" HorizontalAlign="Left" />
                            </Control:TemplateField>
                        </Columns>
                    </Control:DataGridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
