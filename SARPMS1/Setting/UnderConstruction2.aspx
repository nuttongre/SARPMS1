<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UnderConstruction2.aspx.cs"
    Inherits="Setting_UnderConstruction2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ขออภัยในความไม่สะดวก</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="background-color:#ffa5a5; min-height: 600px; text-align: center; border:dotted 5px #e43c3c; ">
        <br />
        <span style="color:#045FB4; font-size:large; font-weight: bold;">ขออภัย  ท่านอาจารย์ที่เคารพ</span><br /><br />
        <i><span style="color:#ff0000; font-size:medium; font-weight: bold;"><u>ขณะนี้  ระบบถูกระงับการใช้งาน</u></span></i><br /><br />
        <span style="color:#FFFFFF; font-size:medium;">เนื่องสัญญาเช่าใช้ระบบได้หมดอายุแล้ว</span><br /><br />
        <span style="color:#FFFFFF; font-size:medium;">ขออภัยในความไม่สะดวก กรุณาติดต่อบริษัทเพื่อต่ออายุการใช้งานครับ ขอบคุณครับ</span><br /><br />
        <img src="../Image/Sorry.gif" />
        <br />
        <asp:Label ID="lblConUser" runat="server" ForeColor="Black" Font-Size="Small"></asp:Label>
    </div>
    </form>
</body>
</html>
