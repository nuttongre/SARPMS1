<%@ Page Language="C#" MasterPageFile="~/Master/MasterOriginal.master" AutoEventWireup="true"
    CodeFile="RptOther.aspx.cs" Inherits="RptOther" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function printRpt(mode, type) {
            var yearmode = 0;

            if (document.getElementById("<%=rbtBudgetYear.ClientID%>").checked == true) {
                yearmode = 1;
            }

            var yearb = document.getElementById("<%=ddlSearchYear.ClientID%>").value;
            window.open('../GtReport/Viewer.aspx?rpt=36&yearB=' + yearb + '&yearmode=' + yearmode + '&rpttype=' + type);
        }
        function spnYear(ck) {
            if (ck == 0) {
                document.getElementById("lblYear").innerHTML = "ปีการศึกษา : ";
            }
            else {
                document.getElementById("lblYear").innerHTML = "ปีงบประมาณ : ";
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
                    รายงานรายจ่ายอื่น ๆ
                </div>
                <div class="spaceDiv"></div>
                <div id="Div1" class="TableSearch">
                    <div class="SearchTable">
                        <div class="SearchHead">
                            <span class="spantxt2 spansize14">เงื่อนไขการเรียกดู</span>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span class="spantxt">ประเภทปี : </span>
                            </div>
                            <div class="SearchF">
                                <asp:RadioButton ID="rbtStudyYear" CssClass="spantxt2" Text=" ปีการศึกษา" onclick="spnYear(0);" GroupName="rbt" Checked="true" runat="server" />
                                <asp:RadioButton ID="rbtBudgetYear" CssClass="spantxt2" Text=" ปีงบประมาณ" onclick="spnYear(1);" GroupName="rbt" runat="server" />
                            </div>
                        </div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                                <span id="lblYear" class="spantxt">ปีการศึกษา : </span>
                            </div>
                            <div class="SearchF">
                                <asp:DropDownList CssClass="ddlSearch" ID="ddlSearchYear" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="inputrow">
                            <div class="SearchtxtF">
                            </div>
                            <div class="SearchF">
                                <asp:Literal ID="linkReport" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="spaceDiv"></div>
                        <div class="spaceDiv"></div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
