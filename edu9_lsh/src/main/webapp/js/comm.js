function fn_go(params,target){
		$.ajax({
			type : 'POST',
			url : '/comcon.do',
			data : params,
			dataType : 'html',
			success : function(data) {
				$(target).html(data);
			},
			error : function(err) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});	
	}

//boxinbox로 가는 함수
function fn_goboxinbox(menuId,listName){
	var params = {
		returnJSP : 'common/V_boxinbox'
		, queryId : 'menu.selectGoMenu'
		, ctrlName : 'data'
		, menuId : menuId
		, listName : listName
	}
	fn_go(params,'#boxinbox');
}

//param을 n개쓸 때 사용하는 함수
function fn_jsonData(param1,param2,param3,param4) {
	var paramArray = [];
	paramArray.push(param1);
	
	if(param2!=null){
		paramArray.push(param2);
	}
	if(param3!=null){
		paramArray.push(param3);
	}
	if(param4!=null){
		paramArray.push(param4);
	}
	var jsonData = JSON.stringify(paramArray);
	return jsonData;
}

function fn_comcon2(params) {
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : params,
		success : function(data) {
			var jdata = JSON.parse(data)
			myGrid.parse(jdata,'js');
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}