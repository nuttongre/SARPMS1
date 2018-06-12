<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UnderConstruction.aspx.cs"
    Inherits="Setting_UnderConstruction" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ขออภัยในความไม่สะดวก</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="background-color:#F5F6CE; min-height: 600px; text-align: center; border:dotted 5px #868A08; ">
        <br />
        <span style="color:#045FB4; font-size:large; font-weight: bold;">ขออภัย  ท่านอาจารย์ที่เคารพ</span><br /><br />
        <span style="color:#424242; font-size:medium;">ขณะนี้  ระบบถูกปิดชั่วคราว</span><br /><br />
        <span style="color:#424242; font-size:medium;">เนื่องจากการสรุปแผนงานของฝ่ายแผนงาน หรือการปรับปรุงโปรแกรมให้ดีขึ้นของทางบริษัท</span><br /><br />
        <span style="color:#424242; font-size:medium;">ขออภัยในความไม่สะดวก ทางผู้ดูแลระบบจะรีบดำเนินการให้แล้วเสร็จโดยเร็วที่สุด</span><br /><br />
        <img src="../Image/Sorry.gif" />
        <br />
        <asp:Label ID="lblConUser" runat="server" ForeColor="Black" Font-Size="Small"></asp:Label>
    </div>
    </form>
</body>
</html>
