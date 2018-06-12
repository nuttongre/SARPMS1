<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterPopUp.master" AutoEventWireup="true" CodeFile="PopUpAttachFile.aspx.cs" Inherits="PopUp_PopUpAttachFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../CSS/fileupload.css" rel="stylesheet" type="text/css" />

    <div id="pageDiv" style="background-color: white;">
        <div class="framImg" style="height:350px;">
            <asp:Repeater ID="rptAttach" runat="server">
                <ItemTemplate>
                    <div class="showSmallImg">
                        <div style="margin: 5px auto; width: 65px; height: 50px;">
                            <%# getImgAttatch(Eval("ItemID"), Eval("Title"), Eval("FileType"), Eval("TypeId")) %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

