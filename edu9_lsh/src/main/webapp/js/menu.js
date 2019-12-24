//menuList
function fn_menuList() {
	$('#layoutObj').show();
	$('#layoutObj2E').hide();
	var selectMS = $('#selectMS').val();
	var menuListKeyword = $('#menuListKeyword').val();

	myLayout1C.cells("a").setText("메뉴 관리");

	myGrid = myLayout1C.cells("a").attachGrid();
	myGrid.setImagePath("dhtmlx/codebase/imgs/");
	myGrid.setHeader("crud,메뉴ID,메뉴이름,게시판ID,프로그램,정렬,부모메뉴,메뉴INDEX,부모메뉴바뀜"); //sets the headers of columns
	myGrid.setColumnIds("crud,menuId,menuName,bbsId,proId,menuSort,menuParent,menuIndex,changeMenuParent"); //sets the columns' ids
	myGrid.setInitWidths("100,150,*,100,100,100,150,100,100"); //sets the initial widths of columns
	myGrid.setColAlign("left,left,left,left,left,left,left,left,left"); //sets the alignment of columns
	myGrid.setColTypes("ro,ed,ed,ro,ro,ed,coro,ro,ro"); //sets the types of columns
	myGrid.setColSorting("str,str,str,str,str,int,str,str,str"); //sets the sorting types of columns
	myGrid.setColumnHidden(7, true);
	myGrid.setColumnHidden(8, true);
	myGrid.init();
	var param1 = {
		'queryId' : 'menu.selectMenu',
		'ctrlName' : 'menu'
	}
	var param2 = {
		queryId : 'menu.selectParent',
		'ctrlName' : 'parent'
	}
	var jsonData = fn_jsonData(param1, param2);
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : {
			'jsonData' : jsonData,
			selectMS : selectMS,
			keyword : menuListKeyword
		},
		success : function(data) {
			var jdata = JSON.parse(data);
			//콤보박스
			var items = jdata.parent;
			for ( var i in items) {
				var combobox = myGrid.getCombo(6);
				combobox.put(items[i].menuId, items[i].menuName);
			}
			//나머지 데이터 파싱
			myGrid.parse(jdata.menu, 'js');
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
	fn_listUpdate();
	
	//부모메뉴 클릭했을때 팝업
	myGrid.attachEvent("onRowSelect", function(id,ind){
	var gridData = myGrid.cellById(id, 4).getValue();
	var clicked = myGrid.cells(id,ind).cell;
	    if(ind==4){
	    	// 팝업을 myGrid에 붙인다
			myPop = new dhtmlXPopup({ grid : myGrid, id: id });
			
			var x = window.dhx4.absLeft(myGrid.cells(id,ind).cell); 
			var y = window.dhx4.absTop(myGrid.cells(id,ind).cell);
			myPop.show(x, y-60, 100, 100);
			
			//팝업에 myGrid3을 붙인다
			var myGrid3 = myPop.attachGrid(600, 300);
			myGrid3.setImagePath("dhtmlx/codebase/imgs/");
			myGrid3.setHeader("프로그램ID,프로그램이름,프로그램설명,게시판ID");
			myGrid3.setColumnIds("proId,proName,proComment,bbsId");
			myGrid3.setInitWidths("100,*,*,100");
			myGrid3.setColAlign("left,left,left,left");
			myGrid3.setColTypes("ro,ro,ro,ro");
			myGrid3.setColSorting("str,str,str,str");
			myGrid3.init();
			
			$.ajax({
				type : 'POST',
				url : '/comcon2.do',
				data : { 'queryId' : 'program.selectProgramList' },
				success : function(data) {
					var jdata = JSON.parse(data)
					myGrid3.parse(jdata,'js');
				},
				error : function(err) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
			
			//팝업-그리드 클릭했을 때
			myGrid3.attachEvent("onRowSelect", function(){
				//팝업 그리드 데이터
				var grid3Data = myGrid3.cellById(myGrid3.getSelectedRowId(), 0).getValue();					
				if(grid3Data!=gridData){
					//그리드에 팝업에서 선택한 데이터를 넣어준다
					myGrid.cellById(id, 4).setValue(grid3Data);
					//0번 컬럼에 update처리
					if(myGrid.cellById(id, 0).getValue() != 'ADD' ){
						myGrid.cellById(id, 0).setValue("UPDATE");
					}
				}
				myPop.hide();
			});
		}
	    
	});
}