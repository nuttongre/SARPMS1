<%@ Page Language="C#" AutoEventWireup="true" CodeFile="License.aspx.cs" EnableViewState="false" Inherits="Tools_License" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ระบบควบคุมทะเบียนผลิตภัณฑ์</title>
    <link href="../Style/global.css" rel="stylesheet" type="text/css" />
    <link href="../Style/Default/forms.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../Include/Frameworks.js" type="text/javascript"></script>
            <style type="text/css">
        .about {
            margin: 40px auto 40px;
            padding: 8px;
            width: 360px;
            font: 18px/25px 'Lucida Grande', Arial, sans-serif;
            color: #bbb;
            text-align: center;
            text-shadow: 0 -1px rgba(0, 0, 0, 0.3);
            background: #383838;
            background: rgba(34, 34, 34, 0.8);
            border-radius: 4px;
            background-image: -webkit-linear-gradient(top, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3));
            background-image: -moz-linear-gradient(top, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3));
            background-image: -o-linear-gradient(top, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3));
            background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3));
            -webkit-box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.2), 0 0 6px rgba(0, 0, 0, 0.4);
            box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.2), 0 0 6px rgba(0, 0, 0, 0.4);
        }
            .about a,.about #wait {
                color: #eee;
                text-decoration: none;
                border-radius: 2px;
                -webkit-transition: background 0.1s;
                -moz-transition: background 0.1s;
                -o-transition: background 0.1s;
                transition: background 0.1s;
            }
                .about a:hover {
                    text-decoration: none;
                    background: #555;
                    background: rgba(255, 255, 255, 0.15);
                }
        .about-detail {
            color: #bbb;
        }
            .about-detail > a {
                width: 50%;
                line-height: 30px;
                font-size: 20px;
                padding: 5px 15px;
            }
            .about-detail > span {
                color: #bbb;
                font: 13px/16px 'Lucida Grande', Arial, sans-serif;
            }
        .about-author {
            color: #bbb;
            margin-top: 5px;
            font: 13px/16px 'Lucida Grande', Arial, sans-serif;
        }
            .about-author > a {
                padding: 1px 3px;
                margin: 0 -1px;
            }
    </style>
</head>
<body>
    <div style="float: left;">
        <img id="ImgBack" src="../Image/ImgBack.gif" class="imgback" style="cursor:pointer;" onclick="history.back();" />
    </div>
    <div id="pnlLicense" runat="server" style="text-align: center; margin: 100px;">
    </div>
    <form id="form1" runat="server">
        <div id="AutoUpdate" runat="server" style="text-align: center">
        </div>
    </form>
</body>
</html>
