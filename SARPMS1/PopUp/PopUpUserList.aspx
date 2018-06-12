<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpUserList.aspx.cs" Inherits="Popup_UserList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ผู้รับผิดชอบงาน</title>

    <script src="../scripts/Dialog.js" type="text/javascript"></script>
    <script src="../scripts/TreeView.js" type="text/javascript"></script>
    <script src="../scripts/Frameworks.js" type="text/javascript"></script>
    <script type="text/javascript" src="../scripts/jquery-1.9.1.js"></script>
    
    <link href="../CSS/TreeView.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/dialogbox.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
    function getUserId()
    {
        var tag=document.getElementsByTagName("input");
        var Id="";var name="";
        var deptId="";var deptName="";
        count=0;
        for(var i =0;i<tag.length;i++){
            if(tag[i].type=="checkbox"){
                if(tag[i].checked)
                {  
                    count+=1;
                    Id += $get('hidden_' + tag[i].id).value + ",";
                    name += $get('hidden_' + tag[i].id).value + ",";
                    deptId += $get('hdfdept_' + tag[i].id).value + ",";
                    deptName += $get('hdfdept_' + tag[i].id).value + ",";
                }
            }
        }
        if(count==0){alert("กรุณาเลือกผู้รับผิดชอบ");return false;}

//        for(var j=0;j<count;j++)
//        {
//            jId +=Guid.newGuid() + ",";
//        }
        parent.$get(Request('id')).value = Id.substring(0,Id.length-1);
        //parent.$get(Request('name')).value = name.substring(0, name.length - 1);

        parent.$get(Request('deptid')).value = deptId.substring(0, deptId.length - 1);
        //parent.$get(Request('deptname')).value = deptName.substring(0, deptName.length - 1);

//        if(Request("btncheck")!=null)
//        {
//            parent.$get(Request('jid')).value=jId.substring(0,jId.length-1);
//            /*parent.$get(Request('btncheck')).click();*/
//        }
        var fnc=parent.eval('loadDept'); 
        if(typeof(fnc)=='function' && fnc) fnc();

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
                    <input type="button" class="button_blue" value="ตกลง" onclick="getUserId()" />
                </div>
            </div>
        </div>
    </ajax:AjaxPanel>
    </form>
</body>
</html>
