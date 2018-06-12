///<reference path="IDBoxFrameworks.js"/>
var dialogBox = {
    init: function (url, title, winWidth, winHeight, bgColor, dragAble, scrolling) {
        this.title = title;
        this.width = winWidth;
        this.height = winHeight;
        this.background = document.createElement("div");
        this.background.id = "dialog-bg";
        this.background.style.width = "100%";
        this.bgColor = bgColor;
        this.dragAble = dragAble;
        if (this.bgColor) this.background.style.backgroundColor = this.bgColor;
        this.dialog = document.createElement("div");
        this.dialog.id = "dialog-page";
        this.dialog.className = "dialog-page";

        this.head = document.createElement("div");
        this.head.className = "dialog-head";
        if (this.dragAble) this.head.style.cursor = "move";
        this.dialog.appendChild(this.head);

        this.head.lblTitle = document.createElement("h3");
        this.head.lblTitle.id = "dialog-title";
        this.head.lblTitle.innerHTML = this.title;
        this.head.appendChild(this.head.lblTitle);


        this.head.panelMenu = document.createElement("span");
        this.head.panelMenu.id = "dialog-menu";
        this.head.panelMenu.className = "dialog-menu";

        this.head.panelMenu.btnClose = document.createElement("a");
        this.head.panelMenu.btnClose.id = "btnDialogClose";
        this.head.panelMenu.btnClose.href = "#";
        this.head.panelMenu.btnClose.title = "ปิด";

        this.head.panelMenu.btnClose.onclick = function() { dialogBox.close(); return false; };
        this.head.panelMenu.btnClose.className = "dialog-btnClose";
        this.head.panelMenu.appendChild(this.head.panelMenu.btnClose);

        this.head.appendChild(this.head.panelMenu);
        
        if (url != null && url != "") {
            this.body = document.createElement("IFRAME");
            this.body.frameBorder = 0;
            this.body.scrolling = scrolling == undefined ? "no" : scrolling;

            if (Browser.name == Browser.type.IE) this.body.onreadystatechange = dialogBox.getState;
            else addEvent(this.body, "load", dialogBox.getState);
            this.body.src = url;
        } else {
            this.body = document.createElement("div");
        }

        this.body.id = "dialog";
        this.body.className = "dialog-body";
        this.returnValue = null;
        this.onclosing = function() { return true; };
        this.onclosed = function () { };
    },

    dragStart: function(event) {

        var x, y;

        // Get cursor position with respect to the page.

        if (Browser.name == Browser.type.IE) {
            x = window.event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
            y = window.event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
        } else {
            x = event.clientX + window.scrollX;
            y = event.clientY + window.scrollY;
        }

        // Move drag element by the same amount the cursor has moved.
        dialogBox.dialog.style.left = (dialogBox.dialog.elStartLeft + x - dialogBox.dialog.cursorStartX) + "px";
        dialogBox.dialog.style.top = (dialogBox.dialog.elStartTop + y - dialogBox.dialog.cursorStartY) + "px";

        if (Browser.name == Browser.type.IE) {
            window.event.cancelBubble = true;
            window.event.returnValue = false;
        } else {
            event.preventDefault();
        }
    },

    dragStop: function(event) {
        removeEvent(document, "mousemove", dialogBox.dragStart, true);
        removeEvent(document, "mouseup", dialogBox.dragStop, true);
    },

    initDrag: function(event) {

        var el;
        var x, y;

        if (Browser.name == Browser.type.IE) {
            x = window.event.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
            y = window.event.clientY + document.documentElement.scrollTop + document.body.scrollTop;
        } else {
            x = event.clientX + window.scrollX;
            y = event.clientY + window.scrollY;
        }

        dialogBox.dialog.cursorStartX = x;
        dialogBox.dialog.cursorStartY = y;
        dialogBox.dialog.elStartLeft = parseInt(dialogBox.dialog.style.left, 10);
        dialogBox.dialog.elStartTop = parseInt(dialogBox.dialog.style.top, 10);

        if (isNaN(dialogBox.dialog.elStartLeft)) dialogBox.dialog.elStartLeft = 0;
        if (isNaN(dialogBox.dialog.elStartTop)) dialogBox.dialog.elStartTop = 0;

        // Capture mousemove and mouseup events on the page.
        addEvent(document, "mousemove", dialogBox.dragStart, true);
        addEvent(document, "mouseup", dialogBox.dragStop, true);

        if (Browser.name == Browser.type.IE) {
            window.event.cancelBubble = true;
            window.event.returnValue = false;
        } else {
            event.preventDefault();
        }
    },

    getURL: function(url) {
        var absURL = url;
        var id = Math.floor(Math.random() * 999);
        if (absURL.indexOf("?") > -1) absURL += "&r_id=" + id;
        else
            absURL += "?r_id=" + id;
        return absURL;
    },

    handlerClose: function(e) {
        var keynum = getKeyCode(e);
        if (keynum == 27) dialogBox.close();
    },


    show: function (url, title, winWidth, winHeight, bgColor, dragAble, scrolling) {
        if (dialogBox.isShowed) dialogBox.close();
        this.init(url, title, winWidth, winHeight, bgColor, dragAble, scrolling);
        
        this.isShowed = true;
        var w = (screen.availWidth - 100);
        var h = (screen.availHeight - 100);
        if (this.width) w = eval(this.width.replace("px", ""));
        if (this.height) h = eval(this.height.replace("px", ""));
        this.dialog.style.height = (h + 12) + "px";
        this.dialog.style.width = w + "px";

        var windowScroll = this.getWindowScroll();
        var pageSize = this.getPageSize();

        var top = (pageSize.windowHeight - h) / 2;
        top += windowScroll.top


        var left = (pageSize.windowWidth - w) / 2;
        left += windowScroll.left

        this.background.style.height = pageSize.pageHeight + "px";
        //this.background.style.width=pageSize.pageWidth+"px";

        this.dialog.style.left = left + "px";
        this.dialog.style.top = top + "px";

        this.body.style.height = (h - 25) + 'px';

        this.dialog.appendChild(this.body);
        if (document.forms.length > 0) {
            document.forms[0].appendChild(this.background);
            document.forms[0].appendChild(this.dialog);
        } else {
            document.body.appendChild(this.background);
            document.body.appendChild(this.dialog);
        }
        if (url) this.body.src = this.getURL(this.body.src);
        addEvent(window.document, "keydown", dialogBox.handlerClose, false);
        if (this.dragAble) addEvent(dialogBox.head, "mousedown", dialogBox.initDrag);
        return this.body;
    },

    close: function(returnValue) {
        this.returnValue = returnValue;
        if (typeof (this.onclosing) == "function" && this.onclosing() == false) return;
        if (document.forms.length > 0) {
            document.forms[0].removeChild(this.background);
            document.forms[0].removeChild(this.dialog);
        } else {
            document.body.removeChild(this.background);
            document.body.removeChild(this.dialog);
        }
        this.isShowed = false;
        removeEvent(window.document, "keydown", dialogBox.handlerClose, false);
        if (typeof (this.onclosed) == "function") this.onclosed(returnValue);
    },

    getState: function() {
        switch (dialogBox.body.readyState) {
            case "loading":
                dialogBox.head.lblTitle.innerHTML = "กำลังโหลด...";
                break;
            case "complete":
                dialogBox.head.lblTitle.innerHTML = dialogBox.title;
                var win = dialogBox.body.contentWindow;
                win.addEvent(win.document, "keydown", function(e) { var keynum = win.getKeyCode(e); if (keynum == 27) dialogBox.close(); }, false);
                break;
            case undefined:
                var doc = GetIFrameDocument(dialogBox.body);
                addEvent(doc, "keydown", function(e) { var keynum = getKeyCode(e); if (keynum == 27) dialogBox.close(); }, false);
                break;
        }
    },

    getWindowScroll: function() {
        var w = window;
        var T, L, W, H;
        with (w.document) {
            if (w.document.documentElement && documentElement.scrollTop) {
                T = documentElement.scrollTop;
                L = documentElement.scrollLeft;
            } else if (w.document.body) {
                T = body.scrollTop;
                L = body.scrollLeft;
            }
            if (w.innerWidth) {
                W = w.innerWidth;
                H = w.innerHeight;
            } else if (w.document.documentElement && documentElement.clientWidth) {
                W = documentElement.clientWidth;
                H = documentElement.clientHeight;
            } else {
                W = body.offsetWidth;
                H = body.offsetHeight
            }
        }
        return { top: T, left: L, width: W, height: H };

    },

    getPageSize: function() {
        var xScroll, yScroll;

        if (window.innerHeight && window.scrollMaxY) {
            xScroll = document.body.scrollWidth;
            yScroll = window.innerHeight + window.scrollMaxY;
        } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
            xScroll = document.body.scrollWidth;
            yScroll = document.body.scrollHeight;
        } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
            xScroll = document.body.offsetWidth;
            yScroll = document.body.offsetHeight;
        }

        var windowWidth, windowHeight;

        if (self.innerHeight) {  // all except Explorer
            windowWidth = self.innerWidth;
            windowHeight = self.innerHeight;
        } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
            windowWidth = document.documentElement.clientWidth;
            windowHeight = document.documentElement.clientHeight;
        } else if (document.body) { // other Explorers
            windowWidth = document.body.clientWidth;
            windowHeight = document.body.clientHeight;
        }
        var pageHeight, pageWidth;

        // for small pages with total height less then height of the viewport
        if (yScroll < windowHeight) {
            pageHeight = windowHeight;
        } else {
            pageHeight = yScroll;
        }

        // for small pages with total width less then width of the viewport
        if (xScroll < windowWidth) {
            pageWidth = windowWidth;
        } else {
            pageWidth = xScroll;
        }

        return { pageWidth: pageWidth, pageHeight: pageHeight, windowWidth: windowWidth, windowHeight: windowHeight };
    }
};

var messageBox = {
    init: function(name, msg, title, winWidth, winHeight, showBg) {
        if (showBg == undefined) showBg = true;
        this.text = msg;
        this.Title = title;
        this.showBg = showBg;
        this.width = winWidth;
        this.height = winHeight;
        this.body = document.createElement("div");
        this.body.id = name;
        this.body.className = "bgColor texture";
        this.body.innerHTML = String.format("<div class=\"bgColor texture\"><div><div style=\"padding:15px 10px;text-align:center;\">{0}</div><div class=\"messageButton\"><input type=\"button\" id=\"btnOK\" value=\"OK\" onclick=\"messageBox.close();\" class=\"bgColor border gradient\" /></div></div></div>", this.text);
        this.background = document.createElement("div");
        this.background.id = "messageBg";
        this.background.style.width = "100%";
        if (!this.showBg) this.background.className = "message-bg-none";
        else
            this.background.className = "message-bg";
        this.dialog = document.createElement("div");
        this.dialog.id = "message-page";
        this.dialog.className = "Page";
        this.head = document.createElement("div");
        this.head.className = "bgColor message_head gradient";
        this.dialog.appendChild(this.head);
        this.dialogTitle = document.createElement("h2");
        this.dialogTitle.id = "message-title";
        this.dialogTitle.innerHTML = this.Title;
        this.head.appendChild(this.dialogTitle);

    },

    show: function(msg, title, winWidth, winHeight, showBg) {
        this.init("messageBox", msg, title, winWidth, winHeight, showBg);
        if (window.innerHeight && window.scrollMaxY || window.innerWidth && window.scrollMaxX) {
            yScroll = window.innerHeight + window.scrollMaxY;
            xScroll = window.innerWidth + window.scrollMaxX;
            var deff = document.documentElement;
            var wff = (deff && deff.clientWidth) || document.body.clientWidth || window.innerWidth || self.innerWidth;
            var hff = (deff && deff.clientHeight) || document.body.clientHeight || window.innerHeight || self.innerHeight;
            xScroll -= (window.innerWidth - wff);
            yScroll -= (window.innerHeight - hff);
        } else if (document.body.scrollHeight > document.body.offsetHeight || document.body.scrollWidth > document.body.offsetWidth) { // all but Explorer Mac
            yScroll = document.body.scrollHeight;
            xScroll = document.body.scrollWidth;
        } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
            yScroll = document.body.offsetHeight;
            xScroll = document.body.offsetWidth;
        }
        this.background.style.height = (screen.availHeight > yScroll) ? screen.availHeight : (yScroll) + "px";
        var w = (screen.availWidth - 100) + "px";
        var h = (screen.availHeight - 100) + "px";
        if (this.width != "" && this.width != undefined) w = this.width;
        if (this.height != "" && this.height != undefined) h = this.height;

        this.dialog.style.height = h;
        this.dialog.style.width = w;

        var pagesize = this.getPageSize();
        var arrayPageScroll = this.getPageScrollTop();

        var posTop = (arrayPageScroll[1] + (pagesize[1] - eval(h.replace('px', ''))) / 2);
        var posLeft = (arrayPageScroll[0] + (pagesize[0] - eval(w.replace('px', ''))) / 2);

        this.dialog.style.left = (posLeft < 0 ? 0 : posLeft) + "px";
        this.dialog.style.top = (posTop < 0 ? 0 : posTop) + "px";

        this.body.style.width = "100%";
        this.body.style.height = (eval(h.replace('px', '')) - 25) + 'px';

        this.dialog.appendChild(this.body);
        if (document.forms.length > 0) {
            document.forms[0].appendChild(this.background);
            document.forms[0].appendChild(this.dialog);
        } else {
            document.body.appendChild(this.background);
            document.body.appendChild(this.dialog);
        }
        //this.body.src=getURL(this.body.src);
        $get("btnOK").focus();
    },

    close: function() {
        if (document.forms.length > 0) {
            document.forms[0].removeChild(this.background);
            document.forms[0].removeChild(this.dialog);
        } else {
            document.body.removeChild(this.background);
            document.body.removeChild(this.dialog);
        }
    },

    getPageScrollTop: function() {
        var yScrolltop;
        var xScrollleft;
        if (self.pageYOffset || self.pageXOffset) {
            yScrolltop = self.pageYOffset;
            xScrollleft = self.pageXOffset;
        } else if (document.documentElement && document.documentElement.scrollTop || document.documentElement.scrollLeft) {	 // Explorer 6 Strict
            yScrolltop = document.documentElement.scrollTop;
            xScrollleft = document.documentElement.scrollLeft;
        } else if (document.body) {// all other Explorers
            yScrolltop = document.body.scrollTop;
            xScrollleft = document.body.scrollLeft;
        }
        arrayPageScroll = new Array(xScrollleft, yScrolltop)
        return arrayPageScroll;
    },

    getPageSize: function() {
        var de = document.documentElement;
        var w = window.innerWidth || self.innerWidth || (de && de.clientWidth) || document.body.clientWidth;
        var h = window.innerHeight || self.innerHeight || (de && de.clientHeight) || document.body.clientHeight
        arrayPageSize = new Array(w, h)
        return arrayPageSize;
    }
};
