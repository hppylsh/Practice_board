<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/* id check  */
.msg-green {
	color: green;
}

.msg-red {
	color: red;
}

/* password check */
.pw-default {
	color: gray;
}

.pw-correct {
	color: green;
	font-weight: bold;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	/* id중복체크  */
	// uid 입력창 keyup
	$('#loginId').on('keyup', function () {
		loginIdResult = false;
		idMsg.text("");
		finalCheck();
	});
	
	//pw 입력창 keyup
	$('#pw').on('keyup', function() {
		pwCheck();
	});

	// pw 확인 입력창 keyup
	$('#pwck').on('keyup', function() {
		pwCheck();
	});
	// 이름 입력창 keyup
	$('#name').on('keyup', function() {
		nameCheck();
	});

	// 닉네임 입력창 keyup
	$('#nickname').on('keyup', function() {
		nicknameCheck();
	});

	// email 입력창 keyup
	$('#email').on('keyup', function() {
		joinEmailCheck();
	});

})

/* id 중복 체크 */
var loginIdObj = $('#loginId');
var idMsg = $('#id-msg');

function joinIdCheck() {
	loginIdResult = false;
	var loginId = loginIdObj.val();
	
	if (!regIdType(loginId)) {
		idMsg.removeClass('msg-green').addClass('msg-red');
		idMsg.text("아이디는 영 소문자, 숫자 6~12자리로 입력해주세요.");
		return;
	} 
	$.ajax({
		type : 'POST',
		url : '/joincheckid.do',
		data : {loginId : loginId},
		dataType : 'text',
		success : function(result) {
			if (result == 'OVERLAP') {
				idMsg.removeClass('msg-green').addClass('msg-red');
				idMsg.text('이미 사용중인 아이디입니다.');
			} else if (result == 'SUCCESS') {
				loginIdResult = true;
				idMsg.removeClass('msg-red').addClass('msg-green');
				idMsg.text('ID 사용가능');
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}

/* 비밀번호 체크 */
var passwordCk = $('#password-ck');
var pwMsg = $('#pw-msg');
var pwObj = $('#pw');
var pwckObj = $('#pwck');
var pwResult = false;

function pwCheck() {
	pwResult = false;
	if ((pwObj.val() == pwckObj.val()) && regPasswordType(pwObj.val()) && regPasswordType(pwckObj.val())) {
		pwMsg.text('');
		passwordCk.removeClass('pw-default').addClass('pw-correct');
		pwResult = true;
	} else {
		if (!regPasswordType(pwObj.val())) {
			pwMsg.text('비밀번호는 특수문자 / 영어대소문자 / 숫자 포함 형태의 8~15자리 이내여야 합니다.');
		} else {
			pwMsg.text('');
		}
		passwordCk.removeClass('pw-correct').addClass('pw-default');
	}
}

/* 이름 체크 */
var nameObj = $('#name');
var nameMsg = $('#name-msg');
var nameResult = false;

function nameCheck() {
	if (nameObj.val() == '' || nameObj.val() == null) {
		nameMsg.text('이름은 필수항목입니다.');
	} else {
		nameMsg.text('');
		nameResult = true;
	}
}

/* 닉네임체크 */
var nicknameObj = $('#nickname');
var nicknameMsg = $('#nickname-msg');
var nicknameResult = true;

function nicknameCheck() {
	if (nicknameObj.val() == '' || nicknameObj.val() == null) {
		nicknameMsg.text('닉네임은 필수항목입니다.');
	} else {
		nicknameMsg.text('');
		nicknameResult = true;
	}
}

/* 이메일 체크 */
var emailObj = $('#email');
var emailMsg = $('#email-msg');
var emailResult = false;

function joinEmailCheck() {

	var email = emailObj.val();

	if (!regEmailType(email)) {
		emailMsg.removeClass('msg-green').addClass('msg-red');
		emailMsg.text('형식에 맞지 않는 이메일입니다.');
	} else {
		emailMsg.text('');
		emailResult = true;
		finalCheck();
	}
}

/* submit 버튼 활성화 */
var submitBtn = $('#submit-btn');

function finalCheck() {
	if (loginIdResult && pwResult && nameResult && nicknameResult && emailResult) {
		submitBtn.removeAttr('disabled');
	} else {
		submitBtn.attr('disabled', 'disabled');
	}
}
/* submit */
$('#submit-btn').on('click', function() {
	$.ajax({
		type : 'POST',
		url : '/join.do',
		data : $('[name=joinform]').serialize(),
		dataType : 'text',
		success : function(data) {
			alert('회원가입되셨습니다.')
			fn_go({returnJSP:'common/V_login'},'#tabbarObj');
		},
		error : function(err) {
			console.log(err);
		}
	});
});

/* 유효성 체크 true/false값이 return 된다 */
function regIdType(data) {
	// 아이디 유효성 체크(소문자,숫자로 시작하는 특수문자(-,_)조합으로 6~12자리)
	var regex = /^[0-9a-z]{6,12}$/;
	return regex.test(data);
}

//비밀번호 유효성
function regPasswordType(data) {
	// 비밀번호(패스워드) 유효성 체크 (문자, 숫자, 특수문자의 조합으로 8~15자리)
	var regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$/;
	return regex.test(data);
}

//이메일 유효성
function regEmailType(data) {
	var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	return regex.test(data);
}
</script>
<div class="container">
	<form id="joinform" name="joinform" method="post">
		<h3>회원가입</h3>
		<table>
			<tr>
				<td><input type="text" id="loginId" name="loginId" placeholder="아이디는 영 소문자, 숫자 6~12자리로 입력해주세요.">
					<input type="button" onclick="joinIdCheck()" value="중복 검사"><span id="id-msg"></span>
				</td>
			</tr>
			<tr>
				<td><input type="password" id="pw" name="pw" placeholder="비밀번호 (특수문자 / 문자 / 숫자 포함 형태의 8~15자리"> <span id="pw-msg" style="color: red"></span></td>
			</tr>
			<tr>
				<td><input type="password" id="pwck" name="pwck" placeholder="비밀번호 확인"></td>
			</tr>
			<tr>
				<td><em id="password-ck" class="pw-default">password check</em></td>
			</tr>
			<tr>
				<td><input type="text" id="name" name="name" placeholder="이름"> <span id="name-msg" style="color: red"></span></td>
			</tr>
			<tr>
				<td><input type="text" id="nickname" name="nickname" placeholder="닉네임"> <span id="nickname-msg" style="color: red"></span></td>
			</tr>
			<tr>
				<td><input type="email" id="email" name="email" placeholder="이메일"> <span id="email-msg"></span></td>
			</tr>
			<tr>
				<td><input type="button" id="submit-btn" disabled="disabled" value="회원가입"></td>
			</tr>
		</table>
	</form>
</div>
