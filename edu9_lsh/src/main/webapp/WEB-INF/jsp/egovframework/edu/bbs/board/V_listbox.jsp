<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function(){
	var bbsPage = fn_Options('bbsPage');
	var listName = '${param.listName }';
	
	// 페이징 사용할 때 함수 실행
	if(bbsPage=='BO001') {
		fn_countList();
	}

	// 페이지 선택
	if(listName=='boardList'){
		fn_boardList();		
	}
			
});

// 페이징
function fn_countList(){
	var bbsId = fn_Options('bbsId');
	var curPage = $('#curPage').val();
	var search_notice = $('#search_notice').val();
	var search_option = $('#search_option').val();
	var keyword = $('#keyword').val();
	
	var params = {
			'returnJSP' : 'board/V_page'
			, 'ctrlName' : 'page'
			, bbsId : bbsId
			, curPage : curPage
			, search_notice : search_notice
			, search_option : search_option
			, keyword : keyword
	} 
	fn_go(params,'#page');
}

//board리스트 
function fn_boardList() {
	var bbsId = fn_Options('bbsId');
	var bbsPage = fn_Options('bbsPage');
	var pageStart = $('#pageStart').val();
	var pageEnd = $('#pageEnd').val();
	var search_notice = $('#search_notice').val();
	var search_option = $('#search_option').val();
	var keyword = $('#keyword').val();
	
	var param1 = {
		'queryId' : 'board.list'
		,'ctrlName':'list'
	}
	var param2 = {
		'queryId' : 'bbs.bbsCondition'
		,'ctrlName':'bbs'
	}
	var jsonData = fn_jsonData(param1,param2);

	var params = {
			'returnJSP' : 'board/V_list'
			, bbsId : bbsId
			, 'start' : pageStart
			, 'end' : pageEnd
			, search_notice : search_notice
			, search_option : search_option
			, keyword : keyword
			, bbsPage : bbsPage
			, 'jsonData' : jsonData
			
	}
	fn_go(params,'#list');
}
</script>
   
<input type="text" id="pageStart" value="${start }"/>
<input type="text" id="pageEnd" value="${end }"/>
<input type="text" id="curPage" value="${curPage }"/>

<div id="list"></div>
<div id="page"></div>


