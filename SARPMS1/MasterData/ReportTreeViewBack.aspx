<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" CodeFile="ReportTreeViewBack.aspx.cs"
    Inherits="ReportTreeViewBack" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../CSS/dialog.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/Loading.js" type="text/javascript"></script>

    <script type="text/javascript">
        function getPopUpActivity(id) {
            dialogBox.show('../PopUp/PopUpActivityDetail.aspx?mode=2&id=' + id, 'รายละเอียดกิจกรรม', '1000', '600', '#000', true, 'yes');
        }
        function AlertActivity() {
            dialogBox.show('../PopUp/PopUpAlertActivity.aspx', 'แจ้งสถานะกิจกรรม', '1000', '500', '#000', true, 'yes');
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdateProgress ID="loading" runat="server">
        <ProgressTemplate>
            <div class="progress">
                <asp:Image ID="loading" runat="server" ImageUrl="../Image/loading1.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div id="pageDiv">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="warningDiv">
                    <asp:Image ID="Img1" runat="server" Visible="false" />
                    <asp:Label ID="MsgHead" runat="server" Text="" Visible="false"></asp:Label>
                </div>
                <div class="headTable">
                    ผลการประเมิน ณ ปัจจุบัน
                </div>
                <div class="spaceDiv"></div>
                <asp:Button ID="btn1" OnClick="btn1_OnClick" CssClass="btNone" runat="server" OnClientClick="Loading.show();" />
                <div style="min-height: 30px; width: 100%;">
                    <div id="Div1" class="TableSearch">
                        <div class="SearchTable">
                            <div class="SearchHead">
                                <span class="spantxt2 spansize14">เงื่อนไขการเรียกดู</span>
                            </div>
                            <div class="spaceDiv"></div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span id="lblSearchYear" runat="server" class="spantxt">ปีการศึกษา : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlYearB" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlYearB_OnSelectedChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span class="spantxt">หน่วยงาน : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList ID="ddlSearchDept" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlSearchDept_SelectedIndexChanged" Width="350px">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="inputrow">
                                <div class="SearchtxtF">
                                    <span class="spantxt">ผู้รับผิดชอบ : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList ID="ddlSearchEmp" CssClass="ddlSearch" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlSearchEmp_SelectedIndexChanged" Width="350px">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="spaceDiv"></div>
                        </div>
                    </div>
                    <div style="text-align: center; width: 100%;">
                        <span class="spantxt" style="display: none;">มุมมอง : </span>
                        <asp:RadioButton ID="rbtlView1" GroupName="v" runat="server" Text=" ทั่วไป" Visible="false"
                            AutoPostBack="true" OnCheckedChanged="rbtView_OnSelectedChanged" />&nbsp;&nbsp;
                        <asp:RadioButton ID="rbtlView2" GroupName="v" runat="server" Text=" เกณฑ์การผ่าน"
                            Visible="false" Checked="true" AutoPostBack="true" OnCheckedChanged="rbtView_OnSelectedChanged" />
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div style="float: right;">
                        <span style="color: #424242; font-weight: bold; font-size: 14pt; padding: 0 70px 0 0;">คะแนนเต็ม</span> <span style="color: #424242; font-weight: bold; font-size: 14pt; padding: 0 55px 0 0;">คะแนนที่ได้</span> <span style="color: #424242; font-weight: bold; font-size: 14pt; padding: 0 35px 0 0;">เกรด</span> <span style="color: #424242; font-weight: bold; font-size: 14pt;">ระดับคุณภาพ</span>                   
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div style="width: 100%;">
                        <asp:Label ID="lblSummarize" runat="server"></asp:Label>
                    </div>
                    <div class="clear"></div>
                    <div>
                        <asp:TreeView ID="TreeView1" runat="server" Width="100%" OnSelectedNodeChanged="TreeView1_OnSelectedNodeChanged" CollapseImageUrl="../Image/icon/T2.png" ExpandImageUrl="../Image/icon/T1.png">
                        </asp:TreeView>
                    </div>
                    <div style="float: right;">
                        <span>***</span> <span style="color: #0B610B; font-weight: bold;">สีเขียว - ผ่าน</span>,
                        <span style="color: #DF0101; font-weight: bold;">สีแดง - ไม่ผ่าน</span>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
