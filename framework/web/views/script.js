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

function edit_scan(obj){
	document.getElementById('fade').style.display = document.getElementById('edit_scan_div').style.display = document.getElementById('edit_scan_div').style.display == 'block' ? 'none' : 'block';
	document.getElementById('edit_scan_div_title').innerHTML(obj);
}

function edit_rule(){
	document.getElementById('fade').style.display = document.getElementById('edit_rule_div').style.display = document.getElementById('edit_rule_div').style.display == 'block' ? 'none' : 'block';
}

function http_get(url){
	//if( confirm("delete?") ){
	var xmlhttp;
	if (window.XMLHttpRequest){
	  xmlhttp=new XMLHttpRequest();
	}else{
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	//var delCred = "?delCred="+id;
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
	return xmlhttp.responseText;
	//refresh()
	//}
}

function http_post(dst,data){
	var xmlhttp;
	if (window.ActiveXObject){
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}else if (window.XMLHttpRequest){
		xmlhttp = new XMLHttpRequest();
	}
	//var dst = "http://localhost/api";
	//var data = d;
	xmlhttp.open( "POST", dst, true );
	xmlhttp.setRequestHeader("Content-Length",data.length);
	xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
	xmlhttp.send(data);
}


//setTimeout("refresh()",5000);
