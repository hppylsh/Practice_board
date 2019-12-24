<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function() {
	$('#boardButton').show();

	$("#postEnd").datepicker({
		dateFormat : 'yy-mm-dd' //Input Display Format 변경
		, showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		, showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
		, changeYear : true //콤보박스에서 년 선택 가능
		, changeMonth : true //콤보박스에서 월 선택 가능
		, minDate : "0" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	});
	
});

</script>

<form id="submitform" name="submitform">
	<table class="write_form">
		<caption>게시글 작성</caption>
		<tbody>
			<tr>
				<!-- 제목 -->
				<th scope="row">제목</th>
				<td><input type="text" id="title" name="title"></input> 
				<!-- 공지 여부 -->
				<c:choose>
					<c:when test="${param.bbsNotice == 'BO001'}">
						<input type='checkbox' id="chkNotice" name="chkNotice" />공지사항
					</c:when>
					<c:otherwise>
						공지불가
					</c:otherwise>
				</c:choose>
					<input type="hidden" id="notice" name="notice" />
				</td>	
			</tr>
			<tr>
				<td>
					<!-- 게시기간 설정 --> 게시기간 <input type="text" id="postEnd" name="postEnd" /> <!-- 비밀글 설정 --> <input type='checkbox' id="chkSecret" name="chkSecret" />비밀글 <input type="hidden" id="secretCheck" name="secretCheck" />
				</td>
			</tr>
			<tr>
				<!-- 내용 -->
				<td colspan="2" class="view_text"><textarea rows="20" cols="100" title="내용" id="content" name="content"></textarea></td>
			</tr>
		</tbody>
	</table>
	<button type="button" onclick="Fn_boardSubmit()">작성하기</button>
	<button type="reset">취소</button>
	<input type="button" value="목록으로" onclick="fn_goboxinbox('${param.menuId}','boardList');">
</form>

