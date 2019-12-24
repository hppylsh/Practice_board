// bbsList
function fn_bbsList() {
	$('#layoutObj').show();
	$('#layoutObj2E').hide();
	var selectBS = $('#selectBS').val();
	var bbsListKeyword = $('#bbsListKeyword').val();

	myLayout1C.cells("a").setText("게시판 관리");

	myGrid = myLayout1C.cells("a").attachGrid();
	myGrid.setImagePath("dhtmlx/codebase/imgs/");
	myGrid.setHeader("crud,게시판ID,게시판이름,읽기사용,쓰기사용,삭제사용,공개사용,공지사용,검색사용,페이징사용"); //sets the headers of columns
	myGrid.setColumnIds("crud,bbsId,bbsName,bbsRead,bbsWrite,bbsDel,bbsUse,bbsNotice,bbsSearch,bbsPage"); //sets the columns' ids
	myGrid.setInitWidths("100,100,*,100,100,100,100,100,100,100"); //sets the initial widths of columns
	myGrid.setColAlign("left,left,left,left,left,left,left,left,left,left"); //sets the alignment of columns
	myGrid.setColTypes("ro,ro,ed,coro,coro,coro,coro,coro,coro,coro"); //sets the types of columns
	myGrid.setColSorting("str,int,str,str,str,str,str,str,str,str"); //sets the sorting types of columns
	myGrid.init();
	
	var param1 = {
		'queryId' : 'bbs.bbsList',
		'ctrlName' : 'bbs'
	}
	var param2 = {
		queryId : 'board.useUnuse',
		'ctrlName' : 'use'
	}
	var jsonData = fn_jsonData(param1, param2);
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : {
			'jsonData' : jsonData,
			selectBS : selectBS,
			keyword : bbsListKeyword
		},
		success : function(data) {
			
			var jdata = JSON.parse(data);
			// 콤보박스 처리
			var items = jdata.use;
			for (var i in items) {
				for(var j=3;j<10;j++){
					var combobox = myGrid.getCombo(j);
					combobox.put(items[i].optionId, items[i].optionName);
				}
			}
			//나머지 데이터 파싱
			myGrid.parse(jdata.bbs, 'js');
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
	fn_listUpdate();
}