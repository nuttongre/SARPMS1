function ajax(){
	this.xmlhttp;
	this.formElement;
	this.method;
	this.requestFile;
	this.URLString;
	this.innerDivID;
	this.onCompletion = function() { };
	this.onProcess = function() { };
	this.loading = function(v){
		var v;
		if(v==1){
			//document.getElementById("loading").style.visibility = "visible";
		}else{
			//document.getElementById("loading").style.visibility = "hidden";
		}
	}
	
	this.GetXmlHttp = function(){
		try{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try{
				isIE = true;
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e){
				xmlhttp = false;
			}
		}	
		if(!xmlhttp && document.createElement){
			xmlhttp = new XMLHttpRequest();
		}		
		return xmlhttp;
	}
	
	this.getRequestBody = function(myForm) {
		var aParams = new Array();  
			for (var i=0 ; i < myForm.elements.length; i++) {
            	var sParam = encodeURIComponent(myForm.elements[i].name);
               	sParam += "=";
               	sParam += encodeURIComponent(myForm.elements[i].value);
               	aParams.push(sParam);
           	}     
           	return aParams.join("&");        
	}
	
	this.SendAJAXRequest = function() {	
		var self = this;
		this.xmlhttp = this.GetXmlHttp();	
		if(this.innerDivID!=""){
		    var newDiv = document.createElement("DIV");
                  newDiv.innerHTML='<div id="wait" align="center"><img src="../image/loading.gif" alt="" /><br />กำลังโหลด...</div>';
		    document.getElementById(this.innerDivID).appendChild(newDiv);
		}
		if (this.method == "GET") {
			var totalurlstring = this.requestFile + "?" + this.URLString;
			this.xmlhttp.open(this.method, totalurlstring, true);
		}else{
			this.URLString = this.getRequestBody(this.formElement);
			this.xmlhttp.open(this.method,this.requestFile, true);
		}
		if (this.method == "POST"){
  			try {
				this.xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded')  
			} catch (e) {}
		}		
		this.xmlhttp.onreadystatechange = function(){
			if(self.xmlhttp.readyState==4&&self.xmlhttp.responseText){
				self.loading(0);
				self.onProcess();
				if (self.xmlhttp.status == 200) {
				    try
		            {
					    self.response = self.xmlhttp.responseText; 
					    document.getElementById(self.innerDivID).innerHTML="";
				        self.onCompletion();	
				    }			
				    catch(e)
		            { 
			            window.status=e.name +" : " + e.description + " " + e.number;
		            }	
				}else{
				    window.status="HTTP request failed with status: " + self.xmlhttp.status + " " + self.xmlhttp.statusText;
		    	}
			}else{
				self.loading(1);
				self.onProcess();
			}
		}
		this.xmlhttp.send(this.URLString);
	}
}

function getData(DivID,requestFile,URLString,callFunction){        	
    ajaxObjects[DivID] = new ajax();
    ajaxObjects[DivID].method="GET";
    ajaxObjects[DivID].requestFile=requestFile;
    ajaxObjects[DivID].URLString=URLString;
    ajaxObjects[DivID].innerDivID=DivID;

    ajaxObjects[DivID].onCompletion = function(){ callFunction(ajaxObjects[DivID].response,DivID);};
    ajaxObjects[DivID].SendAJAXRequest();
}
function postData(DivID,requestFile,myfrom,callFunction){
    ajaxObjects[DivID] = new ajax();
    ajaxObjects[DivID].formElement = document.getElementById(myfrom);
    ajaxObjects[DivID].method="POST";
    ajaxObjects[DivID].requestFile=requestFile;
    ajaxObjects[DivID].innerDivID=DivID;
    ajaxObjects[DivID].onCompletion = function(){ callFunction(ajaxObjects[DivID].response,DivID);};
    ajaxObjects[DivID].SendAJAXRequest();
}
function setData(form,DivID,requestFile,URLString,callFunction){    	
    ajaxObjects[DivID] = new ajax();
    ajaxObjects[DivID].method="GET";
    ajaxObjects[DivID].requestFile=requestFile;
    ajaxObjects[DivID].URLString=URLString;
    ajaxObjects[DivID].innerDivID=DivID;
    ajaxObjects[DivID].onCompletion = function(){ callFunction(ajaxObjects[DivID].response,form);};
    ajaxObjects[DivID].SendAJAXRequest();
}
function showData(response,DivID){	 
	   document.getElementById(DivID).innerHTML = response;	   
}
function Redirect(response,Page){	
    if(response=="0") alert("เกิดข้อผิดพลาดระหว่างการบันทึก");  
    else alert("บันทึกรายการเสร็จสมบูรณ์");  
	   document.location.href=Page;
}
//function createDiv(response,DivID){	 
//    document.getElementById(DivID).innerHTML="";
//    var Element=document.createElement("div");  
//    eval("Element.innerHTML='" + response + "'");
//    document.getElementById(DivID).appendChild(Element);
//}
