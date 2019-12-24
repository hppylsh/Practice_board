<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var loginId , pw;

function fn_login(){
	loginId = $('#loginId').val();
	pw = $('#pw').val();
	if (loginId == null || loginId == '') {
		alert('아이디를 입력해주세요.');
		return false;
	} else if (pw == null || pw == '') {
		alert('비밀번호를 입력해주세요.');
		return false;
	}
	
	$.ajax({
		type : 'POST',
		url : '/loginPost.do',
		data : { loginId : loginId , pw : pw },
		dataType : 'html',
		success : function(data) {
			$('#tabbarObj').remove();
			$('#treeview').remove();
			$("#loginheader").html(data);
		},
		error : function(err) {
			console.log(err);
		}
	});
}
</script>
<h3>로그인</h3>
<form>
	<table>
		<tr>
			<td><input type="text" id="loginId" placeholder="아이디"></td>
		</tr>
		<tr>
			<td><input type="password" id="pw" placeholder="비밀번호"></td>
		</tr>
		<tr>
			<td><input type="button" onclick="fn_login();" value="로그인"></td>
		</tr>
	</table>
</form>
