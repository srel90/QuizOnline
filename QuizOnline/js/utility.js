// JavaScript Document
function ajax(url, data) {
    var response=$.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false
    }).responseText;
    return response;
}
function getRDOValue(radioName){   
    var rdo = document.getElementsByName(radioName);
    for(i=0;i < rdo.length;i++)
    {   
        if(rdo[i].checked) {return rdo[i].value;}
    }
    return null;
}
function setRDOValue(radioName,radioValue){  
    var rdo = document.getElementsByName(radioName);
    for(i=0;i < rdo.length;i++)
    {
        if(rdo[i].value==radioValue) { rdo[i].checked = true;break;}
    }
    return null;
}
function getallchkvalue(chkname){
	var chks=document.getElementsByName(chkname);
	var data= new Array();
	for(var i=0;i<chks.length;i++){
		if(chks.item(i).checked){
			data.push(chks.item(i).value);
		}
	}
	return data.join(',');
}
function setchkvalue(chkname,values){
	var chks=document.getElementsByName(chkname);
	var value=values.split(',');
	for(var k=0;k<chks.length;k++)chks.item(k).checked=false;
	for(var i in value){
		for(var j=0;j<chks.length;j++){
			if(chks.item(j).value==value[i]){
				chks.item(j).checked=true;
			}
		}
	}
}
function getFileExtension(filename) {
  var dot = filename.lastIndexOf(".");
  var extension = filename.substr(dot+1, filename.length);
  return extension;
}
function getFileName(filename) {
  var dot = filename.lastIndexOf("/");
  var extension = filename.substr(dot+1, filename.length);
  return extension;
}
function chkIDCard(value) {
    if (value.length != 13) return false;
    for (i = 0, sum = 0; i < 12; i++)
        sum += parseFloat(value.charAt(i)) * (13 - i); if ((11 - sum % 11) % 10 != parseFloat(value.charAt(12)))
            return false; return true;
}
function _Redirect(url) {
    //var ua = navigator.userAgent.toLowerCase(),
    //    verOffset = ua.indexOf('msie') !== -1,
    //    version = parseInt(ua.substr(4, 2), 10);

    //// IE8 and lower
    //if (verOffset && version < 9) {
    //    var link = document.createElement('a');
    //    link.href = url;
    //    document.body.appendChild(link);
    //    link.click();
    //}

    //    // All other browsers
    //else { window.location.href = url; }
    $(location).attr('href', url);
}