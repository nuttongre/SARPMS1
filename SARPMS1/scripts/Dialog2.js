var dialogBox = {
    init: function(url, title, winWidth, winHeight, bgColor, dragAble) {
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

        this.body = document.createElement("IFRAME");

        this.body.id = "dialog";
        this.body.className = "dialog-body";
        this.body.frameBorder = 0;
        this.body.scrolling = "yes";
        this.body.src = url;
        if (Browser.name == Browser.type.IE) this.body.onreadystatechange = dialogBox.getState;
        else addEvent(this.body, "onload", dialogBox.getState);
        this.returnValue = null;
        this.onclosing = function() { return true; };
        this.onclosed = function() { };

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
        removeEvent(document, "onmousemove", dialogBox.dragStart, true);
        removeEvent(document, "onmouseup", dialogBox.dragStop, true);
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
        addEvent(document, "onmousemove", dialogBox.dragStart, true);
        addEvent(document, "onmouseup", dialogBox.dragStop, true);

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
        if (absURL.indexOf("?") > -1) absURL;
        return absURL;
    },

    handlerClose: function(e) {
        var keynum = getKeyCode(e);
        if (keynum == 27) dialogBox.close();
    },


    show: function(url, title, winWidth, winHeight, bgColor, dragAble) {
        if (dialogBox.isShowed) dialogBox.close();
        this.init(url, title, winWidth, winHeight, bgColor, dragAble);
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
        //top += windowScroll.top


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
        this.body.src = this.getURL(this.body.src);
        addEvent(window.document, "onkeydown", dialogBox.handlerClose, false);
        if (this.dragAble) addEvent(dialogBox.head, "onmousedown", dialogBox.initDrag);
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
        removeEvent(window.document, "onkeydown", dialogBox.handlerClose, false);
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
                //win.addEvent(win.document, "onkeydown", function(e) { var keynum = win.getKeyCode(e); if (keynum == 27) dialogBox.close(); }, false);
                break;
            case undefined:
                var doc = GetIFrameDocument(dialogBox.body);
                addEvent(doc, "onkeydown", function(e) { var keynum = getKeyCode(e); if (keynum == 27) dialogBox.close(); }, false);
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
