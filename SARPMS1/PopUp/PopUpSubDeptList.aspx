<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpSubDeptList.aspx.cs" Inherits="Popup_SubDeptList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>หน่วยงานย่อย</title>

    <script src="../scripts/TreeView.js" type="text/javascript"></script>

    <script src="../scripts/Frameworks.js" type="text/javascript"></script>
    
    <link href="../CSS/TreeView.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function getSubDeptCode()
    {
        var tag=document.getElementsByTagName("input");
        var SubDeptId="";var SubDeptname="";
        count=0;
        for(var i =0;i<tag.length;i++){
            if(tag[i].type=="checkbox"){
                if(tag[i].checked)
                {  
                    count+=1;
                    SubDeptId += $get('hidden_' + tag[i].id).value + ",";
                    SubDeptname += $get('hdfsubdeptname_' + tag[i].id).value + ",";
                }
            }
        }
        if (count == 0)
        {
            parent.$get(Request('subdeptid')).value = "";
            parent.$get(Request('subdeptname')).value = "";
            parent.dialogBox.close();
        }

        parent.$get(Request('subdeptid')).value = SubDeptId.substring(0, SubDeptId.length - 1);
        parent.$get(Request('subdeptname')).value = SubDeptname.substring(0, SubDeptname.length - 1);
 
//        alert(Id.substring(0,Id.length-1));
//        alert(name.substring(0,name.length-1));
//        alert(jId.substring(0,jId.length-1));
        parent.dialogBox.close();
        
    }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ajax:AjaxPanel ID="ajaxPnl" runat="server">
        <div style="margin: 10px">
            <%--<asp:TreeView ID="TreeMenu" ShowLines="true" ShowCheckBoxes="Leaf"  runat="server">
        </asp:TreeView>--%>
        </div>
        <div style="padding: 10px">
            <div class="inputrow ">
                <div class="divinput">
                    <a name="last"></a>
                    <input type="button" class="button_blue" value="ตกลง" onclick="getSubDeptCode()" />
                </div>
            </div>
        </div>
    </ajax:AjaxPanel>
    </form>
</body>
</html>
