var Browser = {
	init: function () {
		this.name = this.searchString(this.dataBrowser) || "An unknown browser";
		this.version = this.searchVersion(navigator.userAgent)
			|| this.searchVersion(navigator.appVersion)
			|| "an unknown version";
		this.OS = this.searchString(this.dataOS) || "an unknown OS";
		this.type={
	    IE:"Explorer",
        FireFox:"Firefox",
        Netscape:"Netscape",
        OmniWeb:"OmniWeb",
        Safari:"Safari",
        Opera:"Opera",
        ICab:"iCab",
        Konqueror:"Konqueror",
        Camino:"Camino",
        Mozilla:"Mozilla"    
	    };
	},
	
	searchString: function (data) {
		for (var i=0;i<data.length;i++)	{
			var dataString = data[i].string;
			var dataProp = data[i].prop;
			this.versionSearchString = data[i].versionSearch || data[i].identity;
			if (dataString) {
				if (dataString.indexOf(data[i].subString) != -1)
					return data[i].identity;
			}
			else if (dataProp)
				return data[i].identity;
		}
	},
	searchVersion: function (dataString) {
		var index = dataString.indexOf(this.versionSearchString);
		if (index == -1) return;
		return parseFloat(dataString.substring(index+this.versionSearchString.length+1));
	},
	dataBrowser: [
		{ 	string: navigator.userAgent,
			subString: "OmniWeb",
			versionSearch: "OmniWeb/",
			identity: "OmniWeb"
		},
		{
			string: navigator.vendor,
			subString: "Apple",
			identity: "Safari"
		},
		{
			prop: window.opera,
			identity: "Opera"
		},
		{
			string: navigator.vendor,
			subString: "iCab",
			identity: "iCab"
		},
		{
			string: navigator.vendor,
			subString: "KDE",
			identity: "Konqueror"
		},
		{
			string: navigator.userAgent,
			subString: "Firefox",
			identity: "Firefox"
		},
		{
			string: navigator.vendor,
			subString: "Camino",
			identity: "Camino"
		},
		{		// for newer Netscapes (6+)
			string: navigator.userAgent,
			subString: "Netscape",
			identity: "Netscape"
		},
		{
			string: navigator.userAgent,
			subString: "MSIE",
			identity: "Explorer",
			versionSearch: "MSIE"
		},
		{
			string: navigator.userAgent,
			subString: "Gecko",
			identity: "Mozilla",
			versionSearch: "rv"
		},
		{ 		// for older Netscapes (4-)
			string: navigator.userAgent,
			subString: "Mozilla",
			identity: "Netscape",
			versionSearch: "Mozilla"
		}
	],
	dataOS : [
		{
			string: navigator.platform,
			subString: "Win",
			identity: "Windows"
		},
		{
			string: navigator.platform,
			subString: "Mac",
			identity: "Mac"
		},
		{
			string: navigator.platform,
			subString: "Linux",
			identity: "Linux"
		}
	]


};
Browser.init();
function moveLastIndex() {
    var ctrl = document.selection.createRange();
    ctrl.moveStart("character", 200);
    ctrl.select();
}
function getOffset(el) {
    var top = 0, left = 0, width = 0, height = 0;
    do {
        top += el.offsetTop || 0;
        left += el.offsetLeft || 0;
        width += el.offsetWidth || 0;
        height += el.offsetHeight || 0;
    }
    while (el = el.offsetParent);

    return { left: left, top: top, width: width, height: height };
}
function $get(p_id) {
    if (document.getElementById) return document.getElementById( p_id );
    else if (document.all) return document.all[p_id];
    else return null;
}

function $find(p_name) {
    if (document.getElementsByName) return document.getElementsByName(p_name);
    else if (document.all) return document.all[p_name];
    else return null;
}
// Extend String Members and Function. //
String.format = function() {
    if (arguments.length == 0) return null;
    var str = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
}
String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, "");
}
String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
    return this.replace(/\s+$/, "");
}

// Utilities. //
function setCookie(name, value, expires, path, domain, secure) {
		expires = expires * 60*60*24*1000;
		var today = new Date();
		var expires_date = new Date(today.getTime() + (expires));
	    var cookieString = name + "=" +escape(value) + 
	       ( (expires) ? ";expires=" + expires_date.toGMTString() : "") + 
	       ( (path) ? ";path=" + path : ";path=/") + 
	       ( (domain) ? ";domain=" + domain : "") + 
	       ( (secure) ? ";secure" : ""); 
	    document.cookie = cookieString; 
}
function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    } else {
        begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
        end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
}

// Image. //
function showImage(imgBox, imgSrc) {
    if ($get(imgBox)) $get(imgBox).src = imgSrc;
}


// PopUp. //
var popUp;

function openWindow(url, target, feature) {
    if (feature == undefined || feature == "" || feature == null) {
        var winWidth = screen.availWidth - 5;
        var H = screen.availHeight - 5;
        feature = 'scrollbars=1, status=0, toolbar=0, location=0,left=0,top=0, menubar=0, width=' + winWidth + ', height=' + H;
    }
    popUp = window.open(url, target, feature);
    popUp.focus();
    window.onunload = HandlerClosePopUp;
}
function HandlerClosePopUp() {
    if (popUp) popUp.close();
}
function openDialog(url, obj, feature) {
    if (!feature) {
        var winWidth = screen.availWidth;
        var H = screen.availHeight;
        feature = 'dialogWidth:' + winWidth + 'px; dialogHeight:' + H + 'px; center:yes;resizable:no; help: no; status: no; scroll:yes; ';
    }
    return showModalDialog(url, obj, feature);
}

/***** Generic Cross Browser Code *****/

function GetIFrameDocument(iframe) {
    var doc;
    if (iframe.contentDocument)
    // For NS6
        doc = iframe.contentDocument;
    else if (iframe.contentWindow)
    // For IE5.5 and IE6
        doc = iframe.contentWindow.document;
    else if (iframe.document)
    // For IE5
        doc = iframe.document;
    else //other browser
        doc = iframe.document;

    return doc;
}


function getKeyCode(e) {
    var keynum = false;
    if (window.event) // IE
        keynum = e.keyCode;
    else if (e.which) // Netscape/Firefox/Opera
        keynum = e.which;
    return keynum;
}

function setFocus(id) {
    window.setTimeout(function() { var obj = $get(id); if (obj) { obj.focus(); obj.select(); } }, 1000);
}

function blur(p_el) {p_el.blur();}
function ExistsForm(p_name) {
	var form = document.forms[p_name];
    return (form != null && typeof(form) == "object");
}

function getElementObject(p_el) {
	if (typeof p_el == "object") return p_el;
	else if (typeof p_el == "string") return $get( p_el );
}
function getStyleBySelector(p_sel) {
    if (!document.getElementById) return null;
    var sheets = document.styleSheets;
    var rules; var i; var j;
    //look through stylesheets in reverse order that they appear in the document
    for (i=sheets.length-1; i >= 0; i--) {
        rules = sheets[i].cssRules;
        for (j=0; j<rules.length; j++) {
            if (rules[j].type == CSSRule.STYLE_RULE && rules[j].selectorText == p_sel) {
                return rules[j].style;
            }   
        }
    }
    return null;
}
function getStylePropertyById(p_id,p_prop) {
    if (document.getElementById) {
        var oS = $get( p_id );
        if (oS != null) {
            oS = oS.style;
            if (oS[p_prop]) return oS[ p_prop ];
        }
        oS = getStyleBySelector( "#" + p_id );
        return (oS != null) ? oS[p_prop] : null;
    } else if (document.all) {
        return document.all[p_id].style[p_prop];
    } else {
		return "";
	}
}
function setStylePropertyById(p_id,p_prop,p_val) {
    if (document.getElementById) {
        var oS = $get(p_id);
        if (oS != null) {
            oS = oS.style;
            oS[p_prop] = p_val;
        }
    } else if (document.all) {
		if (document.all[p_id] != null)	document.all[p_id].style[p_prop] = p_val;
    } else {} //so Nav4 won't return error
}
function addEvent(obj, evt, fnc, useCapture){
    if (!useCapture) useCapture=false;
    if (obj.addEventListener){
		obj.addEventListener(evt.slice(2),fnc,useCapture);
	} else obj.attachEvent(evt,fnc);
}

function removeEvent(obj, evt, fnc, useCapture){
    if (!useCapture) useCapture=false;
	if (obj.removeEventListener){
		obj.removeEventListener(evt.slice(2),fnc,useCapture);
	} else obj.detachEvent(evt,fnc);
}

function setStylePropertyByElement(p_el,p_prop,p_val ) {
    if (document.getElementById) {
        var oS = p_el;
        if (oS != null) {
            oS = oS.style;
            oS[p_prop] = p_val;
        }
    } else if (document.all) {
		if (p_el != null) p_el.style[p_prop] = p_val;
    } else {} //so Nav4 won't return error
}
function toggleElementDisplay(p_el,p_style) {
	// p_style = (none,block,inline)
	var id;
	if (typeof p_el == "object") id = p_el.id;
	else if (typeof p_el == "string") id = p_el;
	if ((id != "") && (id != null)) {
		if (getStylePropertyById(id,'display')=='none') setStylePropertyById(id,'display',p_style);
		else setStylePropertyById(id,'display','none');
	}
}
function toggleImg(p_el,p_img1,p_img2) {
	var e = getElementObject(p_el);
	if (e != null) {
		// p_img1 may be like ../resources/neutral/arrowblueright.gif
		// so need to get only the image name and compare to image current displayed
		var indx = p_img1.lastIndexOf("/");
		var imgName = (indx != -1) ? p_img1.substring(indx + 1,p_img1.length) : p_img1;
		var strSrc = e.src;
		e.src = (strSrc.indexOf(imgName) > -1) ? e.src = p_img2 : e.src = p_img1;
	}
}
function changeImg(p_el,p_img) {
	if (p_el != null) p_el.src = p_img;

}
/***** End Generic Cross-Browser Code *****/



function getSizeInKilo(sizeinbyte){
    if(sizeinbyte>1024){
        sizeinbyte=sizeinbyte/1024;
        return new NumberFormat(sizeinbyte).toFormatted()+' KB';
    }
    return sizeinbyte+' bytes';
}

function IsImage(filename){
    if(GetExtension(filename).toUpperCase()=="GIF" || GetExtension(filename).toUpperCase()=="JPG" || GetExtension(filename).toUpperCase()=="JPEG" || GetExtension(filename).toUpperCase()=="PNG" || GetExtension(filename).toUpperCase()=="BMP") return true;
    return false;
}

function GetExtension(filename){
    if(filename!='' && filename!=null && filename.indexOf('.')>-1) return filename.substring(filename.lastIndexOf('.')+1); 
    return '';
}

function getKey(query){
    if(!query) return "";
    var key=query;
    if(query.indexOf("=")>-1) key= query.substring(0, query.indexOf("="));
    return key;
}
function getValue(query, key){
    if(!query) return "";
    if(!key) key="";
    var value=false;
    if(query.indexOf(key+"=")>-1) value= query.substring(query.indexOf(key+"=")+(key.length+1));
    return value;
}
function request(param){
    var url=document.URL;
    if(url.indexOf("?")==-1) return null;
    if(url.indexOf(param)==-1) return null;

    var val=url.substring(url.indexOf(param+"="));
    if(val.indexOf("&")!=-1) val=val.substring(0, val.indexOf("&"));
    val=val.substring(val.indexOf("=")+1);
    return val;
}
function Request(parameter) {
    var p = escape(unescape(parameter));
    var regex = new RegExp("[?&]" + p + "(?:=([^&]*))?", "i");
    var match = regex.exec(window.location.search);
    var value = null;
    if (match != null) {
        value = match[1];
    }
    return value;
}

function KeyCustom(e, reg) {
    var keyNum;
    var keyChar;
    var numCheck;
    if (window.event)
        keyNum = e.keyCode;
    else if (e.which)
        keyNum = e.which;
    keyChar = String.fromCharCode(keyNum);
    numCheck = new RegExp(reg);
    return keyNum == 8 ? true : numCheck.test(keyChar);
}

function KeyCustomThai(e) {
    var keyNum;
    var keyChar;
    var numCheck;
    if (window.event)
        keyNum = e.keyCode;
    else if (e.which)
        keyNum = e.which;
    keyChar = String.fromCharCode(keyNum);
    numCheck = new RegExp("[0-9]");
    return keyNum == 8 || keyNum == 9 || keyNum == 13 || keyNum == 46 ? true : (keyNum >= 3585 && keyNum <= 3630) || (numCheck.test(keyChar)) ? true : false;
}

var Guid={
    hexString:function() {
        return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    },

    newGuid:function() {
        return (this.hexString()+this.hexString()+"-"+this.hexString()+"-"+this.hexString()+"-"+this.hexString()+"-"+this.hexString()+this.hexString()+this.hexString());
    }
};

