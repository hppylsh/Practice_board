//groupList
function fn_groupList() {
	$('#layoutObj').show();
	$('#layoutObj2E').hide();
	var selectGS = $('#selectGS').val();
	var groupListKeyword = $('#groupListKeyword').val();

	myLayout1C.cells("a").setText("그룹 관리");

	myGrid = myLayout1C.cells("a").attachGrid();
	myGrid.setImagePath("dhtmlx/codebase/imgs/");
	myGrid.setHeader("crud,그룹ID,그룹이름"); //sets the headers of columns
	myGrid.setColumnIds("crud,groupId,groupName"); //sets the columns' ids
	myGrid.setInitWidths("100,*,*"); //sets the initial widths of columns
	myGrid.setColAlign("left,left,left"); //sets the alignment of columns
	myGrid.setColTypes("ro,ro,ed"); //sets the types of columns
	myGrid.setColSorting("str,int,str"); //sets the sorting types of columns
	myGrid.init();

	params = {
		'queryId' : 'group.selectGroupList',
		selectGS : selectGS,
		keyword : groupListKeyword
	}

	fn_comcon2(params);
	fn_listUpdate();
}

// fn_byGroup
function fn_byGroup() {
	$('#layoutObj').show();
	$('#layoutObj1C').hide();
	var selectGS = $('#selectGS').val();
	var groupListKeyword = $('#groupListKeyword').val();

	myLayout2E.cells("a").setText("그룹 리스트");
	myGrid = myLayout2E.cells("a").attachGrid();
	myGrid.setImagePath("dhtmlx/codebase/imgs/");
	myGrid.setHeader("그룹ID,그룹이름"); //sets the headers of columns
	myGrid.setColumnIds("groupId,groupName"); //sets the columns' ids
	myGrid.setInitWidths("*,*"); //sets the initial widths of columns
	myGrid.setColAlign("left,left"); //sets the alignment of columns
	myGrid.setColTypes("ro,ro"); //sets the types of columns
	myGrid.setColSorting("int,str"); //sets the sorting types of columns
	myGrid.init();
	var params = {
		'queryId' : 'group.selectGroupList',
		selectGS : selectGS,
		keyword : groupListKeyword
	}
	fn_comcon2(params);

	if (listName == 'memberByGroup') {
		myLayout2E.cells("b").setText("그룹별 사용자관리");
		myGrid.attachEvent("onRowSelect", function(id, ind) {
			var groupId = myGrid.cellById(id, 0).getValue();
			
			if(myGrid2 != undefined){
				var checkedRow=myGrid2.getChangedRows(0);
				if(checkedRow!=''){
					if(confirm('수정중인 데이터가 있습니다.')){
						return false;
					}
				}
			}
			fn_memberByGroupOnRowSelect(groupId);
		});
	}
	if (listName == 'menuByGroup') {
		myLayout2E.cells("b").setText("그룹별 메뉴관리");
		myGrid.attachEvent("onRowSelect", function(id, ind) {
			var groupId = myGrid.cellById(id, 0).getValue();
			
			if(myGrid2 != undefined){
				var checkedRow=myGrid2.getChangedRows(0);
				if(checkedRow!=''){
					if(confirm('수정중인 데이터가 있습니다.')){
						return false;
					}
				}
			}
			fn_menuByGroupOnRowSelect(groupId);
		});
	}
}

//memberByGroup 두번째 grid 생성
function fn_memberByGroupOnRowSelect(groupId) {
	myGrid2 = myLayout2E.cells("b").attachGrid();
	myGrid2.setImagePath("dhtmlx/codebase/imgs/");
	myGrid2.setHeader("crud,멤버ID,이름,닉네임,ID,PW,이메일,그룹이름"); //sets the headers of columns
	myGrid2.setColumnIds("crud,memberId,name,nickname,loginId,pw,email,groupId"); //sets the columns' ids
	myGrid2.setInitWidths("100,100,*,*,*,*,*,100"); //sets the initial widths of columns
	myGrid2.setColAlign("left,left,left,left,left,left,left,left"); //sets the alignment of columns
	myGrid2.setColTypes("ro,ro,ed,ed,ed,ed,ed,coro"); //sets the types of columns
	myGrid2.setColSorting("str,int,str,str,str,str,str,str"); //sets the sorting types of columns
	myGrid2.init();
	
	var param1 = {
		queryId : 'group.selectMemberList',
		'ctrlName' : 'memberList'
	}
	var param2 = {
		queryId : 'group.selectGroupList',
		'ctrlName' : 'group'
	}
	var jsonData = fn_jsonData(param1, param2);
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : { 
					jsonData : jsonData,
					groupId : groupId
		},
		success : function(data) {
			var jdata = JSON.parse(data);

			// 콤보박스 처리
			var items = jdata.group;
			for ( var i in items) {
				var combobox = myGrid2.getCombo(7);
				combobox.put(items[i].groupId, items[i].groupName);
			}
			//나머지 데이터 파싱
			myGrid2.parse(jdata.memberList, 'js');
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
	fn_listUpdate();
}

// menuByGroup 두번째 grid 생성
function fn_menuByGroupOnRowSelect(groupId) {
	myGrid2 = myLayout2E.cells("b").attachGrid();
	myGrid2.setImagePath("dhtmlx/codebase/imgs/");
	myGrid2.setHeader("crud,ID,메뉴INDEX,메뉴ID,메뉴이름,그룹id"); //sets the headers of columns
	myGrid2.setColumnIds("crud,gmId,menuIndex,menuId,menuIndex,groupId"); //sets the columns' ids
	myGrid2.setInitWidths("100,100,200,200,*,200"); //sets the initial widths of columns
	myGrid2.setColAlign("left,left,left,left,left,left"); //sets the alignment of columns
	myGrid2.setColTypes("ro,ro,ro,ro,coro,ro"); //sets the types of columns
	myGrid2.setColSorting("str,int,int,str,str,str"); //sets the sorting types of columns
	myGrid2.setColumnHidden(5, true);
	myGrid2.init();
	
	var param1 = {
		queryId : 'menu.comboMenu',
		'ctrlName' : 'menu'
	}
	var param2 = {
		queryId : 'gm.selectGM',
		'ctrlName' : 'gm'
	}
	var jsonData = fn_jsonData(param1, param2);
	var params = { 'jsonData' : jsonData,
					groupId : groupId,	}
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : {
			'jsonData' : jsonData,
			groupId : groupId
		},
		success : function(data) {
			var jdata = JSON.parse(data);

			// 콤보박스 처리
			var menu = jdata.menu;
			for ( var i in menu ) {
				var combobox = myGrid2.getCombo(4);
				combobox.put(menu[i].menuIndex, menu[i].menuName);
			}
			//나머지 데이터 파싱
			myGrid2.parse(jdata.gm, 'js');
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
	fn_listUpdate();
}