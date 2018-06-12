var Loading = {
    init: function () {
        this.background = document.createElement("div");
        this.background.id = "dialog-bg";
        this.background.style.width = "100%";
        this.bgColor = "#fff";
        if (this.bgColor) this.background.style.backgroundColor = this.bgColor;

        if (Browser.name == Browser.type.IE) this.background.onreadystatechange = Loading.getState;
        else addEvent(this.body, "onload", background.getState);
        this.onclosing = function () { return true; };
        this.onclosed = function () { };

    },
    handlerClose: function (e) {
        var keynum = getKeyCode(e);
        if (keynum == 27) Loading.close();
    },
    show: function () {
        if (Loading.isShowed) Loading.close();
        this.init();
        this.isShowed = true;
        var w = (screen.availWidth - 100);
        var h = (screen.availHeight - 100);

        var windowScroll = this.getWindowScroll();
        var pageSize = this.getPageSize();

        var top = (pageSize.windowHeight - h) / 2;
        top += windowScroll.top


        var left = (pageSize.windowWidth - w) / 2;
        left += windowScroll.left

        this.background.style.height = (pageSize.pageHeight + 20) + "px";
        this.background.style.width = pageSize.pageWidth + "px";

        if (document.forms.length > 0) {
            document.forms[0].appendChild(this.background);
        } else {
            document.body.appendChild(this.background);
        }
        addEvent(window.document, "onkeydown", Loading.handlerClose, false);
    },

    close: function () {
        if (typeof (this.onclosing) == "function" && this.onclosing() == false) return;
        if (document.forms.length > 0) {
            try {
                document.forms[0].removeChild(this.background);
            } catch (e) {}
        } else {
            document.body.removeChild(this.background);
        }
        this.isShowed = false;
        removeEvent(window.document, "onkeydown", Loading.handlerClose, false);
        if (typeof (this.onclosed) == "function") this.onclosed();
    },

    getState: function () {
        switch (dialogBox.body.readyState) {
            case "loading":
                break;
            case "complete":
                Loading.close();
            case undefined:
                break;
        }
    },

    getWindowScroll: function () {
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

    getPageSize: function () {
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

