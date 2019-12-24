<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function() {
	//로그인 확인하는 변수
	var loginok = '${param.login}';
	if('${login.loginId}'!=null){
		
		doOnLoad();
		
		if(loginok=='ok') {
			alert('로그인되셨습니다.');
		}else if(loginok=='nook'){
			alert('로그인에 실패하셨습니다. 아이디나 비밀번호를 확인해주세요');
		}
	}
});

var myTree;
var myTabbar;

//doOnLoad()
function doOnLoad() {
	fn_side();
	myTabbar = new dhtmlXTabBar("tabbarObj");
	myTree.attachEvent("onClick",function(id){
		fn_gogo(id);
		return true;
	});
}

//fn_side()
function fn_side(){
	myTree = new dhtmlXTreeObject("treeview","300px","800px","MENU_000000");
	myTree.setImagePath("dhtmlx/codebase/imgs/dhxtree_material/");
	var loginId = '${login.loginId }';
	var pw = '${login.pw }';

	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : { queryId : 'menu.selectGroupId', loginId:loginId , pw:pw },
		success : function(data) {
			var jdata = JSON.parse(data)
			//console.log(jdata);
			var Adata = fn_toArray(jdata);
			console.log(Adata);
			if(Adata!=''){
				myTree.parse(Adata,'jsarray');
			}
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

//jsArray로 만들기
function fn_toArray(params) {
	var brr = [];
	var list;
	for(var i = 0 ; i< params.length ; i++){
	   list = params[i];
	   var arr=[];
	   arr.push(list.menuId);
	   arr.push(list.menuParent);
	   arr.push(list.menuName);
	   brr.push(arr);
	}
	return brr; 
}

function fn_gogo(menuId) {
	$.ajax({
		type : 'POST',
		url : '/comcon2.do',
		data : { queryId : 'menu.selectGoTab', menuId : menuId },
		success : function(data) {
			console.log(data);
			var jdata = JSON.parse(data)
			
			//url이 있을때 add탭
			if (jdata[0].proUrl!=null) {
				
				var menuId=jdata[0].menuId;
				
				//탭중에 MENU_ID가 중복되지 않을때 
				if(myTabbar.tabs(menuId)==null){
					myTabbar.addTab(menuId, jdata[0].menuName, null , null , true , true);
					myTabbar.tabs(menuId).attachURL(jdata[0].proUrl, null, { returnJSP:'common/V_box', menuId : menuId });
					myTabbar.tabs(menuId).setActive();
				}else {	//tree에서 클릭하면 tabbar활성화되도록
					myTabbar.tabs(menuId).setActive(); 
				}
			}
		},
		error : function(err) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function fn_logOut() {
	$.ajax({
		type : 'POST',
		url : '/logout.do',
		dataType : 'html',
		success : function(data) {
			$('#tabbarObj').remove();
			$('#treeview').empty();
			$("#loginheader").html(data);
		},
		error : function(err) {
			console.log(err);
		}
	});
}
</script>

<div id="treeview" class="dhtmlxTree" style="float:left;"></div>
<div id="loginheader">
<c:choose>
	<c:when test="${login.memberId == null }">
		<input type="button" onClick="fn_go({returnJSP:'common/join/V_signUp'},'#tabbarObj')" value="회원가입" />
		<input type="button" onClick="fn_go({returnJSP:'common/loginOut/V_login'},'#tabbarObj')" value="로그인" />
	</c:when>
	<c:when test="${login.memberId != null }">
		${login.nickname} 환영쓰! <a href="javascript:void(0)" onclick="fn_logOut()">로그아웃</a>
	</c:when>
</c:choose>
</div>
<div id="tabbarObj" style="float:left; width:1400px; height: 900px;"></div>

