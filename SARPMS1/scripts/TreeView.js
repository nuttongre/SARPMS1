///copyright 2008 IDBox Inc. ///
/// Star.Web.UI.Controls.TreeView version 1.0 ///
function Node(id, pid, name, url, title, target, icon, iconOpen, open) {	this.id = id;	this.pid = pid;	this.name = name;	this.url = url;	this.title = title;	this.target = target;	this.icon = icon;	this.iconOpen = iconOpen;	this._io = open || false;	this._is = false;	this._ls = false;	this._hc = false;	this._ai = 0;	this._p;}
function TreeView(objName, imgFolder) {	this.config = {		target				: null,		folderLinks			: true,		useSelection		: true,		useCookies			: true,		useLines				: false,		useIcons				: true,		useStatusText		: false,		closeSameLevel	: false,		inOrder				: false,		fullRowSelect      :true	}
    this.imageFolder=imgFolder; 

    
	this.icon = {
		root				:"root.gif",
		folder			: "folder.gif",
		folderOpen	:"folderopen.gif",
		node				:"node.gif",
		empty				:"empty.gif",
		line				:"line.gif",
		join				:"join.gif",
		joinBottom	: "joinbottom.gif",
		plus				: "plus.gif",
		plusBottom	: "plusbottom.gif",
		minus				:"minus.gif",
		minusBottom	: "minusbottom.gif",
		nlPlus			: "nolines_plus.gif",
		nlMinus			: "nolines_minus.gif"
	};    
    
	this.obj = objName;	
	this.aNodes = [];
	this.aIndent = [];
	this.root = new Node("-1");
	this.selectedNode = null;
	this.selectedFound = false;
	this.completed = false;		this.collapseText="Collapse";		this.expandText="Expand";		this.width="100%";		this.height=null;

};
TreeView.prototype.add = function(id, pid, name, url, title, target, icon, iconOpen, open) {
	this.aNodes[this.aNodes.length] = new Node(id, pid, name, url, title, target, icon, iconOpen, open);
};
TreeView.prototype.openAll = function() {
	this.oAll(true);
};
TreeView.prototype.closeAll = function() {
	this.oAll(false);
};
TreeView.prototype.populate = function() {if(this.imageFolder!="" || this.imageFolder !=null){	this.icon = {
		root				:this.imageFolder+ "root.gif",
		folder			: this.imageFolder+"folder.gif",
		folderOpen	:this.imageFolder+ "folderopen.gif",
		node				:this.imageFolder+ "node.gif",
		empty				:this.imageFolder+ "empty.gif",
		line				:this.imageFolder+ "line.gif",
		join				:this.imageFolder+ "join.gif",
		joinBottom	:this.imageFolder+ "joinbottom.gif",
		plus				: this.imageFolder+"plus.gif",
		plusBottom	: this.imageFolder+"plusbottom.gif",
		minus				: this.imageFolder+"minus.gif",
		minusBottom	: this.imageFolder+"minusbottom.gif",
		nlPlus			: this.imageFolder+"nolines_plus.gif",
		nlMinus			:this.imageFolder+ "nolines_minus.gif"
	};
	}
	var str = "<div id=\""+this.obj+"\" class=\"TreeView\" style=\""+((this.height!=null)?"height:"+this.height+";":"")+"width:"+this.width+";\">\n";
	if (document.getElementById) {
		if (this.config.useCookies) this.selectedNode = this.getSelected();
		str += this.addNode(this.root);
	} else str += "Browser not supported.";
	str += "</div>";
	if (!this.selectedFound) this.selectedNode = null;
	this.completed = true;
	document.write(str);    
};TreeView.prototype.addNode = function(pNode) {
	var str = "";
	var n=0;
	if (this.config.inOrder) n = pNode._ai;
	for (n; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == pNode.id) {
			var cn = this.aNodes[n];
			cn._p = pNode;
			cn._ai = n;
			this.setCS(cn);
			if (!cn.target && this.config.target) cn.target = this.config.target;
			if (cn._hc && !cn._io && this.config.useCookies) cn._io = this.isOpen(cn.id);
			if (!this.config.folderLinks && cn._hc) cn.url = null;
			if (this.config.useSelection && cn.id == this.selectedNode && !this.selectedFound) {
					cn._is = true;										this.selRow=cn;
					this.selectedNode = n;
					this.selectedFound = true;
			}
			str += this.node(cn, n);
			if (cn._ls) break;
		}
	}
	return str;
};
TreeView.prototype.node = function(node, nodeId) {
if(! this.config.fullRowSelect){

var str = "<div  class=\"Node\">" + this.indent(node, nodeId);
	if (this.config.useIcons) {
		if (!node.icon) node.icon = (this.root.id == node.pid) ? this.icon.root : ((node._hc) ? this.icon.folder : this.icon.node);
		if (!node.iconOpen) node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
		if (this.root.id == node.pid) {
			node.icon = this.icon.root;
			node.iconOpen = this.icon.root;
		}
		str += "<img id=\"i" + this.obj + nodeId + "\" src=\"" + ((node._io) ? node.iconOpen : node.icon) + "\"  alt=\"\" />";
	}
	if (node.url) {
		str += "<a  href=\"" + node.url + "\"";

		if (node.target) str += " target=\"" + node.target + "\"";
		if (this.config.useStatusText) str += " onmouseover=\"window.status='" + node.name + "';return true;\" onmouseout=\"window.status='';return true;\" ";


		str += ">";
	}
	else if ((!this.config.folderLinks || !node.url) && node._hc && node.pid != this.root.id)	str += "<a  href=\"#\" onclick=\"return false;\" class=\"node\">";
        str += "<span onmouseover=\"if(this.className!='SelectedNode') this.className='Node_Hover';\" onmouseout=\"if(this.className!='SelectedNode') this.className='Node';\" style=\"padding:2px;cursor:hand;vertical-align:middle\" class=\"" + ((this.config.useSelection) ? ((node._is ? "SelectedNode" : "Node")) : "Node") + "\"  id=\"TreeNode_"+this.obj+"_"+nodeId+"\" ";              	if (node.title) str += " title=\"" + node.title + "\"";
        if (this.config.useSelection ) str+=" onclick=\"javascript: " + this.obj + ".s(" + nodeId + ");\"";
        str+=">"+node.name+"</span>";        	if (node.url || ((!this.config.folderLinks || !node.url) && node._hc)) str += "</a>";
	str += "</div>";
	if (node._hc) {
		str += "<div id=\"d" + this.obj + nodeId + "\" class=\"clip\" style=\"display:" + ((this.root.id == node.pid || node._io) ? "block" : "none") + ";\">";
		str += this.addNode(node);
		str += "</div>";
	}
	this.aIndent.pop();
	return str;
	
	}else{
	
	var str="<div onmouseover=\"if(this.className!='SelectedNode') this.className='Node_Hover';\" onmouseout=\"if(this.className!='SelectedNode') this.className='Node';\" id=\"TreeNode_"+this.obj+"_"+nodeId+"\" class=\"" + ((this.config.useSelection) ? (((node._is) ? "SelectedNode" : "Node")) : "Node") + "\" onclick=\"";    if ((!this.config.folderLinks || !node.url) && node._hc && node.pid != this.root.id)	str += this.obj + ".o(" + nodeId + ");";   str+=this.obj + ".s(" + nodeId + ");\"";	if (node.title) str+=" title=\""+node.title+"\"";	str+=">" ;	str+= this.indent(node, nodeId);	if (this.config.useIcons) {
		if (!node.icon) node.icon = (this.root.id == node.pid) ? this.icon.root : ((node._hc) ? this.icon.folder : this.icon.node);
		if (!node.iconOpen) node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
		if (this.root.id == node.pid) {
			node.icon = this.icon.root;
			node.iconOpen = this.icon.root;
		}
		str += "<img id=\"i" + this.obj + nodeId + "\" src=\"" + ((node._io) ? node.iconOpen : node.icon) + "\" alt=\"\" />";
	}
	if (node.url) {
		str += "<a  href=\"" + node.url + "\"";		if (node.target) str += " target=\"" + node.target + "\"";
		if (this.config.useStatusText) str += " onmouseover=\"window.status='" + node.name + "';return true;\" onmouseout=\"window.status='';return true;\" ";
		str += ">";
	}		str += node.name;
    if (node.url) str+="</a>";
    
	str += "</div>";
	if (node._hc) {
		str += "<div id=\"d" + this.obj + nodeId + "\" class=\"clip\" style=\"display:" + ((this.root.id == node.pid || node._io) ? "block" : "none") + ";\">";
		str += this.addNode(node);
		str += "</div>";
	}
	this.aIndent.pop();
	return str;}
};

TreeView.prototype.indent = function(node, nodeId) {
	var str = "";
	if (this.root.id != node.pid) {
		for (var n=0; n<this.aIndent.length; n++)
			str += "<img align=\"absmiddle\"  src=\"" + ( (this.aIndent[n] == 1 && this.config.useLines) ? this.icon.line : this.icon.empty ) + "\" alt=\"\" />";
		(node._ls) ? this.aIndent.push(0) : this.aIndent.push(1);
		if (node._hc) {
			str += "<img align=\"absmiddle\" id=\"j" + this.obj + nodeId + "\" src=\"";
			if (!this.config.useLines) str += (node._io) ? this.icon.nlMinus : this.icon.nlPlus;
			else str += ( (node._io) ? ((node._ls && this.config.useLines) ? this.icon.minusBottom : this.icon.minus) : ((node._ls && this.config.useLines) ? this.icon.plusBottom : this.icon.plus ) );
			str+="\" alt=\""+((node._io)?this.collapseText:this.expandText)+"\"";						if(!this.config.fullRowSelect) str += " onclick=\"javascript: " + this.obj + ".o(" + nodeId + ");\"";						str+=" />";
		} else str += "<img align=\"absmiddle\" src=\"" + ( (this.config.useLines) ? ((node._ls) ? this.icon.joinBottom : this.icon.join ) : this.icon.empty) + "\" alt=\"\" />";
	}
	return str;		
};
TreeView.prototype.setCS = function(node) {
	var lastId;
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id) node._hc = true;
		if (this.aNodes[n].pid == node.pid) lastId = this.aNodes[n].id;
	}
	if (lastId==node.id) node._ls = true;
};
TreeView.prototype.getSelected = function() {
	var sn = this.getCookie("cs" + this.obj);
	return (sn) ? sn : null;
};

TreeView.prototype.s = function(id) {
	if (!this.config.useSelection) return;
	var cn = this.aNodes[id];	if (this.selectedNode != id) {
		if (this.selectedNode || this.selectedNode==0) {
			eOld = $get("TreeNode_" + this.obj +"_"+ this.selectedNode);
			eOld.className = "Node";
		}
		eNew = $get("TreeNode_" + this.obj +"_"+ id);
		eNew.className = "SelectedNode";
		this.selectedNode = id;
		if (this.config.useCookies) this.setCookie("cs" + this.obj, cn.id);
	}
};
TreeView.prototype.o = function(id) {
	var cn = this.aNodes[id];
	this.nodeStatus(!cn._io, id, cn._ls);
	cn._io = !cn._io;
	if (this.config.closeSameLevel) this.closeLevel(cn);
	if (this.config.useCookies) this.updateCookie();
};
TreeView.prototype.oAll = function(status) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n]._hc && this.aNodes[n].pid != this.root.id) {
			this.nodeStatus(status, n, this.aNodes[n]._ls)
			this.aNodes[n]._io = status;
		}
	}
	if (this.config.useCookies) this.updateCookie();
};
TreeView.prototype.openTo = function(nId, bSelect, bFirst) {
	if (!bFirst) {
		for (var n=0; n<this.aNodes.length; n++) {
			if (this.aNodes[n].id == nId) {
				nId=n;
				break;
			}
		}
	}
	var cn=this.aNodes[nId];
	if (cn.pid==this.root.id || !cn._p) return;
	cn._io = true;
	cn._is = bSelect;
	if (this.completed && cn._hc) this.nodeStatus(true, cn._ai, cn._ls);
	if (this.completed && bSelect) this.s(cn._ai);
	else if (bSelect) this._sn=cn._ai;
	this.openTo(cn._p._ai, false, true);
};
TreeView.prototype.closeLevel = function(node) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.pid && this.aNodes[n].id != node.id && this.aNodes[n]._hc) {
			this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

TreeView.prototype.closeAllChildren = function(node) {
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id && this.aNodes[n]._hc) {
			if (this.aNodes[n]._io) this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);		
		}
	}
}

TreeView.prototype.nodeStatus = function(status, id, bottom) {
	eDiv	= $get("d" + this.obj + id);
	eJoin	= $get("j" + this.obj + id);
	if (this.config.useIcons) {
		eIcon	= $get("i" + this.obj + id);
		eIcon.src = (status) ? this.aNodes[id].iconOpen : this.aNodes[id].icon;
	}
	eJoin.src = (this.config.useLines)?
	((status)?((bottom)?this.icon.minusBottom:this.icon.minus):((bottom)?this.icon.plusBottom:this.icon.plus)):
	((status)?this.icon.nlMinus:this.icon.nlPlus);
    eJoin.alt=((status)?this.collapseText:this.expandText);
    
    eJoin.align="absmiddle"; 

	eDiv.style.display = (status) ? "block": "none";
};
TreeView.prototype.clearCookie = function() {
	var now = new Date();
	var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
	this.setCookie("co"+this.obj, "cookieValue", yesterday);
	this.setCookie("cs"+this.obj, "cookieValue", yesterday);
};
TreeView.prototype.setCookie = function(cookieName, cookieValue, expires, path, domain, secure) {
	document.cookie =
		escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toGMTString() : '')
		+ (path ? '; path=' + path : '; path=/')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
};
TreeView.prototype.getCookie = function(cookieName) {
	var cookieValue = '';
	var posName = document.cookie.indexOf(escape(cookieName) + '=');
	if (posName != -1) {
		var posValue = posName + (escape(cookieName) + '=').length;
		var endPos = document.cookie.indexOf(';', posValue);
		if (endPos != -1) cookieValue = unescape(document.cookie.substring(posValue, endPos));
		else cookieValue = unescape(document.cookie.substring(posValue));
	}
	return (cookieValue);
};
TreeView.prototype.updateCookie = function() {
	var str = '';
	for (var n=0; n<this.aNodes.length; n++) {
		if (this.aNodes[n]._io && this.aNodes[n].pid != this.root.id) {
			if (str) str += '.';
			str += this.aNodes[n].id;
		}
	}
	this.setCookie('co' + this.obj, str);
};
TreeView.prototype.isOpen = function(id) {
	var aOpen = this.getCookie('co' + this.obj).split('.');
	for (var n=0; n<aOpen.length; n++)
		if (aOpen[n] == id) return true;
	return false;
};

if (!Array.prototype.push) {
	Array.prototype.push = function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
};
if (!Array.prototype.pop) {
	Array.prototype.pop = function array_pop() {
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
};
function ShowPopUp(url, win, option){
var winRef=window.open(url, win, option);
}