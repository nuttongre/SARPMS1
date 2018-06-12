<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true" CodeFile="Education21EvaluateView.aspx.cs" Inherits="MasterData_Education21EvaluateView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../CSS/dialog.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/Loading.js" type="text/javascript"></script>

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
                    การประเมินการจัดการศึกษาตามแนวทางศตวรรษที่ 21
                </div>
                <div class="spaceDiv"></div>
                <asp:Button ID="btn1" OnClick="btn1_Click" CssClass="btNone" runat="server" OnClientClick="Loading.show();" />
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
                                        OnSelectedIndexChanged="ddlYearB_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <%--<div class="inputrow">
                                <div class="SearchtxtF">
                                    <span id="Span1" runat="server" class="spantxt">ประเภทการประเมิน : </span>
                                </div>
                                <div class="SearchF">
                                    <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchEvaluateType" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlSearchEvaluateType_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>--%>
                            <div class="spaceDiv"></div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div style="float: right;">
                        <span style="color: #424242; font-weight: bold; font-size: 14pt; padding: 0 55px 0 0;">ระดับคุณภาพ</span> <span style="color: #424242; font-weight: bold; font-size: 14pt; padding: 0 35px 0 0;">คะแนนเต็ม</span> <span style="color: #424242; font-weight: bold; font-size: 14pt;">คะแนนที่ได้</span>                   
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div style="width: 100%;">
                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                    </div>
                    <div class="clear"></div>
                    <div class="spaceDiv"></div>
                    <div class="spaceDiv"></div>
                    <div style="width: 100%;">
                        <asp:Label ID="lblSumSide1" runat="server"></asp:Label>
                    </div>
                    <div>
                        <asp:TreeView ID="TreeView1" runat="server" Width="100%" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" CollapseImageUrl="../Image/icon/T2.png" ExpandImageUrl="../Image/icon/T1.png">
                        </asp:TreeView>
                    </div>
                    <div class="spaceDiv"></div>
                    <div class="spaceDiv"></div>
                    <div style="width: 100%;">
                        <asp:Label ID="lblSumSide2" runat="server"></asp:Label>
                    </div>
                    <div>
                        <asp:TreeView ID="TreeView2" runat="server" Width="100%" OnSelectedNodeChanged="TreeView2_SelectedNodeChanged" CollapseImageUrl="../Image/icon/T2.png" ExpandImageUrl="../Image/icon/T1.png">
                        </asp:TreeView>
                    </div>
                    <%--<div style="float: right;">
                        <span>***</span> <span style="color: #0B610B; font-weight: bold;">สีเขียว - ผ่าน</span>,
                        <span style="color: #DF0101; font-weight: bold;">สีแดง - ไม่ผ่าน</span>
                    </div>--%>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

