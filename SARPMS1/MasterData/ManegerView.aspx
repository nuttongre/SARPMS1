<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MasterOriginal2.master" AutoEventWireup="true" CodeFile="ManegerView.aspx.cs" Inherits="MasterData_ManegerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        $(function () {

            function runEffect() {
                var options = {};
                options = { to: "#Menu", className: "ui-effects-transfer" };

                // run the effect
                $("#Menu").effect("transfer", options, 1, callback);
            };

            function callback() {
                setTimeout(function () {
                    $("#Menu").removeAttr("style").fadeIn();
                }, 100);
            };

            $("#Menu").click(function () {
                runEffect();
                $("#Menu").toggleClass("ManageMiniMainMenu", 100);
                $(".divMenu").toggleClass("MinidivMenu");
                $(".ManageDivMenu").toggleClass("ManageMiniDivMenu");
                
                if ($("#Menu").hasClass("ManageMiniMainMenu") == true) {
                    $get("Menu1").style.display = "none";
                    $get("Menu2").style.display = "none";
                    $get("Menu3").style.display = "none";
                    $get("Menu4").style.display = "none";
                    $get("Menu5").style.display = "none";
                    $get("Menu6").style.display = "none";
                    $get("Menu7").style.display = "none";
                    $get("Menu8").style.display = "none";
                }

                return false;
            });
        });
        function OpenFrame(ck)
        {
            if (ck == 1)
            {
                $get("Menu1").style.display = "block";
            }
            if (ck == 2) {
                $get("Menu2").style.display = "block";
            }
            if (ck == 3) {
                $get("Menu3").style.display = "block";
            }
            if (ck == 4) {
                $get("Menu4").style.display = "block";
            }
            if (ck == 5) {
                $get("Menu5").style.display = "block";
            }
            if (ck == 6) {
                $get("Menu6").style.display = "block";
            }
            if (ck == 7) {
                $get("Menu7").style.display = "block";
            }
            if (ck == 8) {
                $get("Menu8").style.display = "block";
            }
        }
    </script>

    <div id="divMain" style="width: 100%; min-height: 650px;">
        <div id="Menu" class="ManageMainMenu">
            <div class="divMenu">
            <img id="menu1" src="../Image/Menu1.png" class="ManageDivMenu" title="ผลการประเมิน ณ ปัจจุบัน" onclick="OpenFrame(1);" />ผลการประเมิน</div>
            <div class="divMenu">
            <img id="menu2" src="../Image/Menu2.png" class="ManageDivMenu" title="สถานะกิจกรรม"  onclick="OpenFrame(2);" />สถานะกิจกรรม</div>
            <div class="divMenu">
            <img id="menu3" src="../Image/Menu3.png" class="ManageDivMenu" title="จำนวนกิจกรรมตามตัวชี้วัด"  onclick="OpenFrame(3);" />จำนวนกิจกรรมตามตัวบ่งชี้</div>
            <div class="divMenu">
            <img id="menu4" src="../Image/Menu4.png" class="ManageDivMenu" title="งบประมาณโครงการ" onclick="OpenFrame(4);" />งบประมาณโครงการ</div>
            <div class="divMenu">
            <img id="menu5" src="../Image/Menu5.png" class="ManageDivMenu" title="กราฟจำนวนกิจกรรมตามมาตรฐาน" onclick="OpenFrame(5);" />กราฟกิจกรรมตามมาตรฐาน</div>
            <div class="divMenu">
            <img id="menu6" src="../Image/Menu6.png" class="ManageDivMenu" title="กราฟงบประมาณรายปี" onclick="OpenFrame(6);" />กราฟงบประมาณตามปี</div>
            <div class="divMenu">
            <img id="menu7" src="../Image/Menu7.png" class="ManageDivMenu" title="การตัดงบประมาณ" onclick="OpenFrame(7);" />ตัดงบประมาณ</div>
            <div class="divMenu">
            <img id="menu8" src="../Image/Menu8.png" class="ManageDivMenu" title="ปฏิทินปฏิบัติงาน" onclick="OpenFrame(8);" />ปฏิทินปฏิบัติงาน</div>
        </div>
        <div id="Menu1" class="ClearFrame">
            <iframe src="../MasterData/ReportTreeView.aspx" width="100%" height="600px"></iframe>
        </div>
        <div id="Menu2" class="ClearFrame">
            <iframe src="../MasterData/ReportActivity.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu3" class="ClearFrame">
            <iframe src="../MasterData/ReportCountActivity.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu4" class="ClearFrame">
            <iframe src="../MasterData/ReportBudgetProjects.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu5" class="ClearFrame">
            <iframe src="../MasterData/GraphCountActivityByStd.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu6" class="ClearFrame">
            <iframe src="../MasterData/GraphBudget.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu7" class="ClearFrame">
            <iframe src="../MasterData/CutBudget.aspx" width="100%" height="600"></iframe>
        </div>
        <div id="Menu8" class="ClearFrame">
            <iframe src="../MasterData/ReportCalendar.aspx" width="100%" height="600"></iframe>
        </div>
    </div>
</asp:Content>

