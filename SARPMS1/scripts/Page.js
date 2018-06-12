var page = {

    init: function() {
    },

    showDialog: function(name, queryString, title, width, height, bgColor, dragAble, scrolling) {
        dialogBox.show(String.format("../Popup/Default.aspx?c_path={0}{1}", name, queryString), title, width, height, bgColor, dragAble, scrolling);
    },

    openDialog: function(control, title, queryString, func, scrolling) {
        this.showDialog(control, String.format("&{0}&func={1}", queryString, (func != undefined ? "?" + func : "")), title, "655px", "605px", "transparent", true, scrolling);
    },

    popupControl: function (control, title, JSONParams) {
        page.SeachData("", "", title, 'timeline', ["&" + $.param(JSONParams)], '', 'yes', control);
    },

    Clear: function(key, value) {
        var key = $get(key);
        var value = $get(value);
        if (key) key.value = "";
        if (value) {
            if (value.type == 'text') value.value = "";
            else value.innerHTML = "";
        }
    },

    beforeSearchData: function(parentControl, message, key, value, title, mode, param, func) {
        if (parentControl != undefined) {
            if (parentControl.length > 0) {
                for (var i = 0; i < parentControl.length; i++) {
                    if ($get(parentControl[i])) { if ($get(parentControl[i]).value == "") { alert(message); return false; } }
                }
            }
        }
        this.SeachData(key, value, title, mode, param, func, 'yes');
        return false;
    },

    SeachData: function (key, value, title, mode, param, func, scrolling, control, type) {
        if (control == undefined || control == "") control = "SeachData";
        var params = new Array();
        if (param != undefined) {
            if (param.length > 0) {
                for (var i = 0; i < param.length; i++) {
                    try {
                        if ($get(param[i]))
                            params[i] = $get(param[i]).value;
                        else
                            params[i] = param[i];
                    }
                    catch (err) {
                        params[i] = param[i];
                    }
                }
            }
        }
        if (func == undefined) func = "";
        var defaultValue = $get(key);
        if (defaultValue) defaultValue = defaultValue.value;
        else defaultValue = "";
        var defaultText = $get(value);
        if (defaultText && (defaultText.type == 'text' || defaultText.type == 'hidden')) defaultText = defaultText.value;
        else defaultText = "";
        this.showDialog(control, String.format("&key={0}&value={1}&mode={2}&param={3}&func={4}&defaultvalue={5}&defaulttext={6}&type={7}", key, value, mode, params.join(','), func, defaultValue, defaultText, type == undefined ? "" : type), title, "655px", "605px", "transparent", true, scrolling);
    },

    saveCurrentPage: function(id) {
        setCookie("mId", id);
    },

    appendQuery: function(query) {
        var url = document.URL;
        if (url.lastIndexOf("#") == url.length - 1) url = url.substring(0, url.length - 1);
        if (url.indexOf("?") > -1) {
            var val = getValue(query);
            var key = getKey(query);

            if (Request(key)) url = url.replace(key + "=" + Request(key), key + "=" + val);
            else
                url += "&" + query;
        } else {
            url += "?" + query;
        }
        return url;

    },
    getVirtualDirectory: function () {
        var url = window.location.href;
        var url_parts = url.split('/');
        url_parts[url_parts.length - 1] = '';
        url_parts[url_parts.length - 2] = '';
        url_parts.splice(url_parts.length - 1, 1);
        var current_page_virtual_path = url_parts.join('/');
        return current_page_virtual_path;
    },
    login: function (auth) {
        if (auth) {
            this.saveReferer();
            window.location.replace("../oauth/authorize.ashx");
        }
        else {
            location.href = "../oauth/signin.ashx";
        }
    },

    logout: function () {
        setCookie("mId", "");
        location.href = "../oauth/signout.ashx";
    },

    register: function() {
        location.href = "../oauth/register.ashx";
    },

    resetpwd: function() {
        location.href = "../oauth/resetpwd.ashx";
    },

    forgetpwd: function() {
        location.href = "../Tools/ForgetPassword.aspx";
    },

    showTools: function (name, authen) {
        this.saveReferer();
        this.saveCurrentPage("");
        if (authen)
            location.replace('../oauth/tools.ashx?name='+ name);
        else
            location.replace('../Tools/' + name + '.aspx');
    },

    showPage: function(id, url, target) {
        if (target) {
            openWindow(url, id, "scrollbars=1, status=0, toolbar=0, location=0,left=0,top=0, menubar=0, resizable=1");
        } else {
            this.saveCurrentPage(id);
            location.href = url == "" ? "../Pages/Default.aspx" : url;
        }
    },

    getUrl: function(url, referrable, cookie) {
        if (referrable || referrable == undefined)
            this.saveReferer();
        if (url == "?") url = location.href.replace(location.search, '');
        if (cookie != undefined) setCookie(cookie.name, cookie.value);
        location.href = url;
    },

    add: function(pages, queryString) {
        this.saveReferer();
        var url = page.appendQuery("pm=0" + (queryString != undefined ? queryString : ""));
        url = url.substring(url.indexOf("?"))
        if (pages != undefined)
            location.href = String.format("{0}.aspx{1}", pages, url);
        else
            location.href = String.format("{0}", url);
    },

    edit: function (id, pages, isSaveReferer) {       
        this.saveReferer(isSaveReferer);
        var queryString = page.appendQuery("id=" + id);
        queryString = queryString.substring(queryString.indexOf("?"));
        if (pages != undefined)
            location.href = String.format("{0}.aspx{1}", pages, queryString);
        else
            location.href = page.appendQuery(String.format("id={0}", id));
    },

    query: function(queryString) {
        var url = document.URL;
        if (url.indexOf("?") > 0)
            url = url.substring(0, url.indexOf("?"));
        this.saveReferer();
        location.href = String.format("{0}?{1}", url, queryString);
    },

    saveReferer: function (isSaveReferer) {
        setCookie("refURL", (isSaveReferer == undefined || isSaveReferer) ? document.URL : "");
    },

    gotoReferer: function (isBack) {
        var url = getCookie("refURL");
        if (isBack && !url) history.back();
        else {
            if (!url) url = "../Pages/";
            location.replace(url != location.href ? url : isBack ? url.replace(url.substring(url.lastIndexOf('/') + 1), isBack) : url.split('?')[0]);
        }
    },
    displayInCompatVersion: function() {
        var msg = "เว็บไซต์นี้ไม่สนับสนุนการใช้งานบน Web Browser ที่คุณใช้";
        document.write("<center><div style=\"color:red\">" + msg + "</div></center>");
        document.title = msg;
    },
    getValidURL: function(url) {
        return url.replace(/[^\w@-]/g, "");
    },

    viewQuestion: function(pages, id) {
        this.saveReferer();
        location.href = String.format("../Pages/{0}.aspx?eid={1}", pages, id);
    },

    viewExam: function(pages, sid, cid) {
        this.saveReferer();
        location.href = String.format("../Pages/{0}.aspx?em=0&sid={1}&cid={2}", pages, sid, cid);
    },

    showQuestion: function(questionId, questionMode, type) {
        var queryString = String.format("mode={0}&qid={1}{2}", questionMode, questionId, (type != undefined ? "&rpt=1" : ""));
        this.previewQuestion(queryString);
    },

    previewQuestion: function(queryString) {
        var url = String.format("../Popup/ViewQuestion.aspx?{0}", queryString);
        openWindow(url, "showQuestion", 'resizable=1, scrollbars=1, status=1, toolbar=0, location=0, directories=0, menubar=1,  width=600,height=450');
    },

    monitor: function (id) {
        var queryString = page.appendQuery("id=" + id);
        queryString = queryString.substring(queryString.indexOf("?"));
        this.getUrl(String.format("TestingMonitor.aspx{0}", queryString), true);
    },

    print: function(pages, queryString) {
        openWindow(String.format("../Popup/{0}.aspx{1}", pages, (queryString != undefined ? "?" + queryString : "")), 'Print', 'resizable=1, scrollbars=1, status=1, toolbar=0, left=0,top=0, menubar=0');
    },

    report: function(pages, queryString, isUrl) {
        if (isUrl) {
            //var reg = /([\w\d_-]*)\.?[^\\\/]*$/i;
            var file = Request("id", queryString);//pages.match(reg)[1];    
            openWindow(pages + (queryString != undefined ? queryString : ""), file, 'resizable=1, scrollbars=1, status=1, toolbar=0, location=0, directories=0, menubar=1,  width=750,height=600');
        }
        else
            openWindow(String.format("../Report/{0}.aspx{1}", pages, (queryString != undefined ? "?" + queryString : "")), this.newID(), 'resizable=1, scrollbars=1, status=1, toolbar=0, location=0, directories=0, menubar=1,  width=750,height=600');
    },

    newID: function() {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        for (var i = 0; i < 5; i++)
            text += possible.charAt(Math.floor(Math.random() * possible.length));

        return text;
    },

    reportQuestion: function (mode) {
        var eid = Request("eid");
        if (eid) {
            var queryString;
            if (mode == 1)
                queryString = "report=examBYcate&type=Q&id=&schid=&uid=&roleid=&depid=&level=&roomid=&eid=" + eid;
            else
                queryString = "report=examBYindicator&p=1&type=Q&id=&schid=&uid=&roleid=&depid=&level=&roomid=&eid=" + eid;
            this.report("Default", queryString);
        } else {
            var queryString;
            var arguments = this.reportQuestion.arguments;
            switch (mode) {
                case "qa": queryString = String.format("?mode={0}&sid={1}", mode, arguments[1]);
                    break;
                case "iq": queryString = String.format("?mode={0}&did={1}&cid={2}&sid={3}&nid={4}&uid={5}&sdate={6}&edate={7}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
                    break;
                case "iqs": queryString = String.format("?type=T&id=62&schid={3}&sdate={6}&edate={7}&uid=&roleid=&depid={8}&level=&roomid=", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]);
                    break;
                case "ic": queryString = String.format("report=chapter&type=T&id=42&depid={0}&catid={1}&schid={2}&nid={3}&uid={4}&sdate={5}&edate={6}", arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
                    this.report("Default", queryString, false); return;
                    break;
                case "ict": queryString = String.format("report=chapter&type=T&id=42&indid={0}&depid={1}&catid={2}&uid={3}&sdate={4}&edate={5}", arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
                    this.report("Default", queryString, false); return;
                    break;
                case "iqt": queryString = String.format("?mode={0}&iid={1}&did={2}&sid={3}&uid={4}&schid={5}&sdate={6}&edate={7}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
                    break;
                case "qp": queryString = String.format("?mode={0}&uid={1}&sdate={2}&edate={3}&type={4}&did={5}&sid={6}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
                    break;
                case "qu": queryString = String.format("?mode={0}&did={1}&uid={2}&type={3}&depid={4}&sid={5}&cid={6}&catid={7}&sdate={8}&edate={9}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8], arguments[9]);
                    break;
                case "qc": queryString = String.format("?mode={0}&type={1}&id={2}&did={3}&sid={4}&shid={5}&cid={6}&sdate={7}&edate={8}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]);
                    break;
                case "qe": queryString = String.format("?mode={0}&eid={1}&uid={2}", mode, arguments[1], arguments[2]);
                    break;
                case "qesa": queryString = String.format("?mode={0}&eid={1}&uid={2}&ayear={3}&depid={4}&sid={5}", mode, arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]);
                    break;
                case "dq": queryString = String.format("?mode={0}&qid={1}&sdate={2}&edate={3}", mode, arguments[1], arguments[3], arguments[4]);
                    break;
                case "siq": queryString = String.format("report=indicatorquestion&type=T&id=57&depid={0}&catid={1}&uid={2}&schid={3}&nid={4}&sdate={5}&edate={6}", arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]);
                    this.report("Default", queryString, false);
                    return;
                case "sic": queryString = String.format("report=indicatorchapter&type=T&id=69&depid={0}&catid={1}&uid={2}&schid={3}&sdate={4}&edate={5}", arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
                    this.report("Default", queryString, false);
                    return;
                    break;
                default: return; break;
            }
            if (mode == "iqs")
            { this.report("../Report/QuestionIndicator.aspx", queryString, true); }
            else if (mode == "qesa")
            { this.report("../PopUp/RPTQuestionSA.aspx", queryString, true); }
            else
            { this.report("../PopUp/RPTQuestion.aspx", queryString, true); }
        }
    },

    importQuestion: function(eid) {
        this.saveReferer();
        if (eid != undefined)
            location.href = String.format("../Pages/QuestionImport.aspx?eid={0}", eid);
        else {
            var queryString = "";
            if (request("ps") == "1") queryString = "?ps=1";
            location.href = "../Pages/QuestionImport.aspx" + queryString;
        }
    },

    testing: function (eid, tid, auth, referrable, log) {
        if (referrable || referrable == undefined)
            this.saveReferer();
        var winWidth = screen.availWidth - 5;
        var H = screen.availHeight - 5;
        var feature = 'fullscreen=yes, scrollbars=0, stauts=0, toolbar=0, location=0,left=0,top=0, menubar=0, width=' + winWidth + ', height=' + H;
        var url = String.format("../Testing/{0}TestDetail.aspx{1}{2}{3}", this.isMobile() ? "m" : "", eid == undefined ? "" : "?id=" + eid, tid == undefined ? "" : (log ? "&lid=" + tid : "&tid=" + tid), auth == undefined ? "" : "?auth=" + auth);
        if (this.isMobile()) location.replace(url);
        else openWindow(url, "Testing", feature);
    },
    
    vote: function (cid, uid) {
        if (uid)
            dialogBox.show(String.format("../Popup/Opinion.aspx?cid={0}", cid), "โหวต", "200px", "150px", "transparent", true);
        else alert('กรุณาตรวจสอบการลงชื่อเข้าใช้ระบบ');
    },

    license: function(isUpdate) {
        dialogBox.show("../Tools/License.aspx" + (isUpdate ? "?mode=update" : ""), "License", "560px", "470px", "transparent", true);
    },

    showContent: function(id, cId, target) {
        this.saveReferer();
        if (!id) id = "";
        if (!cId) cId = "";
        var url = String.format("../Pages/ViewContent.aspx?id={0}&cId={1}", id, cId);
        if (target)
            window.open(url);
        else
            location.href = url;
    },

    help: function () {
        this.container = $get("help");
        if (this.container) {
            var self = this;
            var pageName = window.location.pathname;
            pageName = pageName.substring(pageName.lastIndexOf('/') + 1);
            var queryString = window.location.search.replace(/\b[a-f\d\-]{36}\b/g, '*');
            var url = window.location.pathname.match(/([^/]*)\.[^.]*$/);
            if (url == null) return;
            $.ajax({
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                url: url[0] + '/GetHelp',
                dataType: 'json', data: "{'PageName':'" + pageName + queryString + "'}",
                success: function (data) {
                    data = $.parseJSON(data.d);
                    if (data) {
                        if (data.TypeID == "1")
                            self.container.innerHTML = String.format("<a href=\"{0}\" target=\"_blank\" title=\"{1}\"><img src=\"../Images/help.gif\" alt=\"{1}\" />{1}</a>", data.FileUrl, "ช่วยเหลือ");
                        else
                            self.container.innerHTML = String.format("<a href=\"../file/download.ashx?id={0}&mode=getfile&help=1\" target=\"_blank\" title=\"{1}\"><img src=\"../Images/help.gif\" alt=\"{1}\" />{1}</a>", data.HelpID, "ช่วยเหลือ");
                    }
                }
            });
        }
    },
    
    load: function (path) { var script = document.getElementsByTagName("script"); for (var i = 0; i < script.length; i++) { if (script[i].src) { if (script[i].src.indexOf(path) > -1) return; } } document.write('<script type="text/javascript" src="' + path + '" charset="utf-8"></script>'); },
    getById: function (a, b) {
        if (b) {
            if (b.getElementById) return b.getElementById(a);
            else if (b.all) return b.all[a]; else return null
        } else {
            if (document.getElementById) return document.getElementById(a);
            else if (document.all) return document.all[a];
            else return null
        }
    },
    getByTag: function (a, b) {
        if (b && b.getElementsByTagName) return b.getElementsByTagName(a);
        return document.getElementsByTagName(a)
    },
    getWebMethodUrl: function (webMethod) {
        return window.location.pathname.match(/([^/]*)\.[^.]*$/)[0] + "/" + webMethod;
    },
    isMobile: function () {
        var isMobile = false;
        if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent)
            || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0, 4))) isMobile = true;
        return isMobile;
    }
};
page.init();

function AppleWebKit(menu) {
    if (navigator.userAgent.match(/AppleWebKit/i)) {
        var nav = document.getElementById(menu);
        if (nav) {
            var els = nav.getElementsByTagName('li');
            for (var i = 0; i < els.length; i++) {
                els[i].addEventListener("touchstart", function()
                { this.className = "hover"; }, false); els[i].addEventListener("touchend", function()
                { this.className = ""; }, false);
            }
        }
    }
}
