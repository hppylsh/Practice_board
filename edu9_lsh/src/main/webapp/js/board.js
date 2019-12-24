/* search를 사용하는 경우 */
function fn_onSearchView(){
	var bbsSearch = fn_Options('bbsSearch');
	var param1 = {
		'queryId' : 'board.selectSN',
		'ctrlName' : 'selectSN'
	}
	var param2 = {
		'queryId' : 'board.selectSO',
		'ctrlName' : 'selectSO'
	}

	var jsonData = fn_jsonData(param1, param2);

	var params = {
		returnJSP : 'board/V_search',
		bbsSearch : bbsSearch,
		'jsonData' : jsonData
	}
	fn_go(params, '#search');
}

/* search기능 사용하지 않는 경우 */
function fn_noSearchView(){
	var bbsSearch = fn_Options('bbsSearch');
	var params = {
		returnJSP : 'board/V_search',
		bbsSearch : bbsSearch
	}
	fn_go(params, '#search');
}

/* 페이징 사용하는 경우 */
function fn_listbox(curPage){
	var listName = fn_Options('listName');
	var bbsId = fn_Options('bbsId');

	var params = {
		'returnJSP' : 'board/V_listbox',
		'ctrlName' : 'page',
		'bbsId' : bbsId,
		curPage : curPage,
		listName : listName
	}
	fn_go(params, '#listPage');
}

/* 페이징 사용하지 않는 경우 */
function fn_listbox2(){
	var listName = fn_Options('listName');
	var params = {
		'returnJSP' : 'board/V_listbox',
		listName : listName
	}
	fn_go(params, '#listPage');
}