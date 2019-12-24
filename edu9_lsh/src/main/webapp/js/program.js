//programList
function fn_programList() {
	$('#layoutObj').show();
	$('#layoutObj2E').hide();
	var selectPS = $('#selectPS').val();
	var programKeyword = $('#programKeyword').val();

	myLayout1C.cells("a").setText("프로그램 관리");

	myGrid = myLayout1C.cells("a").attachGrid();
	myGrid.setImagePath("dhtmlx/codebase/imgs/");
	myGrid.setHeader("crud,ID,BBS_ID,이름,설명,URL,등록인"); //sets the headers of columns
	myGrid.setColumnIds("crud,proId,bbsId,proName,proComment,proUrl,nickname"); //sets the columns' ids
	myGrid.setInitWidths("100,100,100,*,*,*,100,100"); //sets the initial widths of columns
	myGrid.setColAlign("left,left,left,left,left,left,left,left"); //sets the alignment of columns
	myGrid.setColTypes("ro,ro,ro,ed,ed,ed,ro,ro"); //sets the types of columns
	myGrid.setColSorting("str,str,str,str,str,str,str,str"); //sets the sorting types of columns
	myGrid.init();
	params = {
		'queryId' : 'program.selectProgramList',
		selectPS : selectPS,
		keyword : programKeyword
	}
	fn_comcon2(params);
	fn_listUpdate();
}
