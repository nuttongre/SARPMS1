///©2007 NetCom Thai Corporations. ///
/// NetCom.Web.Controls.DataGridView version 1.0 ///


function DataGridView(id, list){
this.id=id;
this.listitems=list;
this.MsgSingleSelectionOnly="";
this.MsgSelectItemFirst="";
this.MsgConfirmDelete="";
this.SelectedRowCssClass="";
this.RowItemCssClass="";
this.RowHoverCssClass="";
this.HeaderSelectedCssClass="";
this.HeaderCssClass="";
}
DataGridView.prototype.SelectAllList=function(obj){
    alert("");
}

DataGridView.prototype.Selected=function(row, selected, hChk){
var selectedrow=$get(row);
if(selected)
selectedrow.className=this.SelectedRowCssClass;
else
selectedrow.className=selectedrow.state;

if(hChk!=undefined || hChk!=null) return;
var headBg=$get(this.id+'_header_checklist');
if(headBg)headBg.className=this.HeaderCssClass;

var chk=document.getElementsByName(this.listitems);
var head=$get(this.id+"_checkAll");
if(!head) return;
for(var i=0; i<chk.length; i++){
    if(!chk[i].checked){
        head.checked=false;
        return;
    } 
}
head.checked=true;
head.value="checked";
if(headBg)headBg.className=this.HeaderSelectedCssClass;
}

DataGridView.prototype.OnSave=function(){
}
DataGridView.prototype.OnEdit=function(){
var chk=document.getElementsByName(this.listitems);
var num=0;
for(i=0; i<chk.length; i++){
if(chk[i].checked) num+=1;
}
if(num==1){
return true;
}
if(num>1) alert(this.MsgSingleSelectionOnly);
if(num<1) alert(this.MsgSelectItemFirst);
return false;
}
DataGridView.prototype.OnPreview=function(){
var chk=document.getElementsByName(this.listitems);
var num=0;
for(i=0; i<chk.length; i++){
if(chk[i].checked) num+=1;
}
if(num==1){
return true;
}
if(num>1) alert(this.MsgSingleSelectionOnly);
if(num<1) alert(this.MsgSelectItemFirst);
return false;
}

DataGridView.prototype.OnDelete=function(){
var chk=document.getElementsByName(this.listitems);
var num=0;
for(i=0; i<chk.length; i++){
if(chk[i].checked) num+=1;
}

if(num==0){
alert(this.MsgSelectItemFirst);
return false;
} 
if(num>0){
return confirm(this.MsgConfirmDelete); 
}
}
