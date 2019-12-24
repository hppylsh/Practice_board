function fn_submitGrid(arrSplit,memberId) {
	var paramArray = [];
	var param = [];

	// 배열의 개수만큼 for문 돌리기
	for (var i = 0; i < arrSplit.length ; i++) {

		// 0번째 셀의 값 가져오기
		if(listName == 'menuByGroup'|| listName == 'memberByGroup'){
			var crudName = myGrid2.cellById(arrSplit[i], 0).getValue();
			param[i] = myGrid2.getRowData(arrSplit[i]);
		} else {
			var crudName = myGrid.cellById(arrSplit[i], 0).getValue();
			param[i] = myGrid.getRowData(arrSplit[i]);
		}
		var querytype = '';
		var queryname = '';

		if(listName == 'bbsList'){
		 	// 게시판 이름을 입력하지 않은 경우
			if (param[i].bbsName == '') {
				alert('게시판 이름을 입력해주십시오');
				return false;
			}
			if (crudName == 'ADD') {
				querytype = 'insert';
				queryname = 'bbs.insertBbs'
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
				queryname = 'bbs.updateBbsDetail'
			} else if (crudName == 'DELETE') {
				querytype = 'update';
				queryname = 'bbs.updateDeleteBbs'
			}
		}else if(listName == 'menuList'){
			// 게시판 이름을 입력하지 않은 경우
			if (param[i].menuName == '') {
				alert('메뉴 이름을 입력해주십시오');
				return false;
			}
			if (param[i].proId == '') {
				alert('프로그램을 선택해주십시오');
				return false;
			}
			// 셀의 value에 따라 분기
			if (crudName == 'ADD') {
				querytype = 'insert';
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
			} else if (crudName == 'DELETE') {
				querytype = 'delete';
			}
			
		}else if(listName=='menuByGroup'){
			// 셀의 value에 따라 분기
			if (crudName == 'ADD') {
				querytype = 'insert';
				queryname = 'gm.insertGM'
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
				queryname = 'gm.updateGM'
			} else if (crudName == 'DELETE') {
				querytype = 'update';
				queryname = 'gm.deleteGM'
			}

		}else if(listName == 'memberByGroup'){
			// 게시판 이름을 입력하지 않은 경우
			if (param[i].loginId == '') {
				alert('아이디를 입력해주십시오');
				return false;
			}
			if (param[i].nickname == '') {
				alert('닉네임을 입력해주십시오');
				return false;
			}
			// 셀의 value에 따라 분기
			if (crudName == 'ADD') {
				querytype = 'insert';
				queryname = 'group.insertMember'
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
				queryname = 'group.updateMember'
			} else if (crudName == 'DELETE') {
				querytype = 'update';
				queryname = 'group.updateDelMember'
			}
			
		} else if(listName == 'groupList'){
			// 게시판 이름을 입력하지 않은 경우
			if (param[i].groupName == '') {
				alert('그룹 이름을 입력해주십시오');
				return false;
			}
			// 셀의 value에 따라 분기
			if (crudName == 'ADD') {
				querytype = 'insert';
				queryname = 'group.insertGroup';
				param[i].memberId = memberId;	
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
				queryname = 'group.updateGroup'
			} else if (crudName == 'DELETE') {
				querytype = 'update';
				queryname = 'group.updateDeleteGroup';
			}

		} else if(listName == 'programList'){
			// 게시판 이름을 입력하지 않은 경우
			if (param[i].proName == '') {
				alert('프로그램 이름을 입력해주십시오');
				return false;
			}
			// 셀의 value에 따라 분기
			if (crudName == 'ADD') {
				querytype = 'insert';
				queryname = 'program.insertProgram'
			} else if (crudName == 'UPDATE') {
				querytype = 'update';
				queryname = 'program.updatePro'
			} else if (crudName == 'DELETE') {
				querytype = 'update';
				queryname = 'program.deletePro'
			}
		}
		param[i].queryname = queryname;
		param[i].querytype = querytype;				
		paramArray.push(param[i]);
	}
	
	return paramArray;
}

function fn_addRow() {
	var rowId = myGrid.uid(); //generates an unique id
	if (listName == 'memberByGroup' || listName == 'menuByGroup'){
		// generates an unique id
		var rowId = myGrid2.uid();
		var groupId = myGrid.cellById(myGrid.getSelectedRowId(), 0).getValue();
		myGrid2.addRow(rowId,['']);
		if (listName == 'memberByGroup') {
			myGrid2.cellById(rowId,7).setValue(groupId);
		}else if(listName == 'menuByGroup') {
			myGrid2.cellById(rowId,5).setValue(groupId);
		}
	} else if(listName == 'bbsList'){
		myGrid.addRow(rowId, [ "", "", "", "BO001", "BO001", "BO001", "BO001", "BO001", "BO001", "BO001" ]);
	} else {
		myGrid.addRow(rowId,['']);
		if (listName == 'menuList'){
			myGrid.cellById(rowId,6).setValue("MENU_000000");
		}
	}
	
	if (listName == 'memberByGroup' || listName == 'menuByGroup') {
		myGrid2.cellById(rowId, 0).setValue("ADD");
	} else {
		myGrid.cellById(rowId, 0).setValue("ADD");
	}
}

function fn_listSubmit() {
	var memberId = '${login.memberId}';
	// 0번째 셀에 값이 입력된(ADD,UPDATE,DELETE) row id 가져오기
	if(listName == 'menuByGroup' || listName == 'memberByGroup'){
		var checkedRow = myGrid2.getCheckedRows(0);
	}else {
		var checkedRow = myGrid.getCheckedRows(0);
	}
	// 배열로 만들기 위해서 ,로 나누기
	var arrSplit = checkedRow.split(',');

	//배열에 자료가 없는경우 return
	if (arrSplit == '') {
		return false;
	}
	
	var paramArray = fn_submitGrid(arrSplit,memberId);
	if(paramArray==false){
		return false;
	}
	
	var jsonData = JSON.stringify(paramArray);
	var param = {'jsonData' : jsonData };
	var groupId = myGrid.cellById(myGrid.getSelectedRowId(), 0).getValue();
	
	if(listName == 'menuList'){
		$.ajax({
			type : 'POST',
			url : '/menusave.do',
			data : param,
			success : function(data) {
					fn_goboxinbox(fn_Options('menuId'), listName)
			},
			error : function(err) {
				alert('실패');
				console.log(err);
			}
		});
	} else {
		$.ajax({
			type : 'POST',
			url : '/save.do',
			data : param,
			success : function(data) {
				if(listName=='menuByGroup'){
					fn_menuByGroupOnRowSelect(groupId);
				}else if(listName == 'memberByGroup'){
					fn_memberByGroupOnRowSelect(groupId);
				}else {
					fn_goboxinbox(fn_Options('menuId'), listName)
				}
			},
			error : function(err) {
				alert('실패');
				console.log(err);
			}
		});
	}
}

function fn_listUpdate() {
	if (myGrid != null) {
		// cell이 수정되었을 때
		myGrid.attachEvent("onEditCell", function(stage, rId, cInd, nValue, oValue) {
			// add셀 제외, 입력한 데이터와 수정한 데이터가 같은 경우 제외
			if (myGrid.cells(rId, 0).getValue() != 'ADD' && nValue != oValue) {
				//0번째 셀에 update 글자가 들어감
				myGrid.cellById(rId, 0).setValue("UPDATE");
				// 수정된 데이터가 들어감
				myGrid.cellById(rId, cInd).setValue(nValue);
				
				//메뉴관리 부모 메뉴 바뀌었을때 'y'데이터 들어갈 수 있도록
				if (listName == 'menuList') {
					if(cInd == 6){
						myGrid.cellById(rId, 8).setValue("y");
					}
				}
			}
			// 메뉴관리 입력할때 return false
			if (listName == 'menuList') {
				if (stage == 0) {
					if (myGrid.cellById(rId, 0).getValue() == 'ADD') {
						if (cInd == 1 || cInd == 5) {
							return false;
						}
					}
					if (myGrid.cellById(rId, 1).getValue() == 'MENU_000000'){
						alert('최상위 메뉴는 수정할 수 없습니다');
						return false;
					}
				}
			}
			// 프로그램관리에서 게시판과 연동된 데이터는 이름 수정 못하도록 함
			if (listName == 'programList') {
				if (myGrid.cellById(rId, 2).getValue() != '') {
					if (cInd == 3) {
						return false;
					}
				}
			}
			return true;
		});
	}
	if (myGrid2 != null) {
		// cell이 수정되었을 때
		myGrid2.attachEvent("onEditCell", function(stage, rId, cInd, nValue, oValue) {
			// add셀 제외, 입력한 데이터와 수정한 데이터가 같은 경우 제외
			if (myGrid2.cells(rId, 0).getValue() != 'ADD' && nValue != oValue) {
				//0번째 셀에 update 글자가 들어감
				myGrid2.cellById(rId, 0).setValue("UPDATE");
				// 수정된 데이터가 들어감
				myGrid2.cellById(rId, cInd).setValue(nValue);
			}

			// memberByGroup에서 ID 수정 못하게
			if (listName == 'memberByGroup') {
				if (stage == 0) {
					if (myGrid2.cellById(rId, 0).getValue() == 'ADD') {
						return true;
					} else if (cInd == 4) {
						return false;
					}
				}
			}
			return true;
		});
	}
}

function fn_listDelete() {
	if(myGrid2!=undefined){
		var rowId = myGrid2.getSelectedRowId(); // row Id
		var rowIndex = myGrid2.getRowIndex(rowId); // 행 index
		var getRowsNum = myGrid2.getRowsNum(); //전체 행 개수

		myGrid2.cellById(rowId, 0).setValue("DELETE");
		
		if (rowId != null) {
			if (rowIndex != (getRowsNum - 1)) {
				myGrid2.selectRow(rowIndex + 1, true); // index 다음값 선택select
			} else {
				myGrid2.selectRow(rowIndex - 1, true); // index 이전값 선택select
			}
		}
		
	}else if(myGrid!=undefined){
		var rowId = myGrid.getSelectedRowId(); // row Id
		var rowIndex = myGrid.getRowIndex(rowId); // 행 index
		var getRowsNum = myGrid.getRowsNum(); //전체 행 개수
		
		if (listName == 'programList') {
			if (myGrid.cellById(rowId, 2).getValue() != '') {
				alert('게시판과 연동된 프로그램은 삭제할 수 없습니다');
				return false;
			}
		}
		
		// 기본그룹과 운영자 그룹 삭제 막기
		if (listName == 'groupList') {
			if (myGrid.cellById(rowId, 1).getValue() == 1) {
				alert('기본그룹은 삭제할 수 없습니다.');
				return false;
			}
			if (myGrid.cellById(rowId, 1).getValue() == 2) {
				alert('운영자그룹은 삭제할 수 없습니다.');
				return false;
			}
		}
		myGrid.cellById(rowId, 0).setValue("DELETE");
		
		if (rowId != null) {
			if (rowIndex != (getRowsNum - 1)) {
				myGrid.selectRow(rowIndex + 1, true); // index 다음값 선택select
			} else {
				myGrid.selectRow(rowIndex - 1, true); // index 이전값 선택select
			}
		}
	}
}