<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
var listName = '${param.listName}';
var menuId ='${param.menuId}';

//자주 사용하는 옵션 함수로 만듦
function fn_Options(flag) {
	switch (flag) {
	case "bbsId":
		return '${data[0].bbsId }'
		break;
	case "bbsSearch":
		return '${data[0].bbsSearch}'
		break;
	case "bbsPage":
		return '${data[0].bbsPage}'
		break;
	case "listName":
		return '${param.listName}'
		break;
	case "menuId":
		return '${param.menuId}'
		break;
	}
}

var params = [];
params = {
	returnJSP : 'common/V_listView'
	, menuId : menuId
	, listName : listName
}

/* 검색에 필요한 데이터 */
if(listName=='boardList'){
	fn_go(params,'#listView');
}else {
	if(listName=='programList'){
		params.queryId = 'common.selectPS';
		params.ctrlName = 'selectPS';
	}else if(listName=='menuList'){
		params.queryId = 'common.selectMS';
		params.ctrlName ='selectMS';		
	}else if(listName=='bbsList'){
		params.queryId = 'common.selectBS';
		params.ctrlName ='selectBS';
	}else if(listName=='groupList'||listName=='memberByGroup'||listName=='menuByGroup'){
		params.queryId = 'common.selectGS';
		params.ctrlName ='selectGS';	
	}
	fn_go(params,'#listView');
}

</script>

<div id="listView"></div>

