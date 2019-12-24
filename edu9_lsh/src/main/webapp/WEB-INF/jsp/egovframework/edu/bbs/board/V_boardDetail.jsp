<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function(){
		$('#boardButton').show();
	});
	
	/* 수정 폼으로 */
	function fn_modifyform(boardId,bbsId) {
		var param1 = {
			'queryId' : 'board.detail'
			,'ctrlName':'modi'
		}
		var param2 = {
			'queryId' : 'bbs.bbsCondition'
			,'ctrlName':'bbs'
		}
		var jsonData = fn_jsonData(param1,param2);
		
		var params = {
				'returnJSP' : 'board/V_boardModify'
				, bbsId : bbsId
				, boardId : boardId
				, 'jsonData' : jsonData
		}
		fn_go(params,'#detailBox');
	}
	
	/* 글 삭제 함수 */
	function fn_delete(boardId) {
		var listName = fn_Options('listName');
		var menuId = fn_Options('menuId');	
		
		var allData = {
				boardId : boardId
				,'queryname' : "board.updateDeleteBoard"
				,'querytype' : 'update'
		}
		
		$.ajax({
			type : 'POST',
			url : '/save.do',
			data : allData,
			async : false,
			dataType : 'text',
			success : function(data) {
				fn_goboxinbox(menuId,listName);
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
</script>

<table class="board_detail">
	<tbody>
		<tr>
			<td>
				<h2>${detail[0].bbsName }게시판</h2>
			</td>
		</tr>
		<tr>
			<th scope="row">글 번호</th>
			<td>${detail[0].boardId }</td>
		</tr>
		<tr>
			<th scope="row">조회수</th>
			<td>${detail[0].hitcount }</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${detail[0].nickname }</td>
		</tr>
		<tr>
			<th scope="row">작성시간</th>
			<td>${detail[0].writedate }</td>
		</tr>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3">${detail[0].title }</td>
		</tr>
		<tr>
			<td colspan="4">
			<c:choose>
				<c:when test="${detail[0].secretCheck == 1 }">
					<!-- 글쓴 사람과 읽는 사람이 같은 경우 (memberId 1번이 이용자라고 생각할 때) -->
					<c:choose>
						<c:when test="${(detail[0].memberId == login.memberId) || login.groupId == 2}">
							${detail[0].content }
						</c:when>
						<c:otherwise>
							비밀글입니다.
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					${detail[0].content }
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td>
				<!-- 이전글 / 다음글 --> 
				<c:choose>
					<c:when test="${empty leadlag[0].afterId }">
						다음글이 없습니다.
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fn_boardDetail('${leadlag[0].afterId }','${param.bbsId }')">[다음글] ${leadlag[0].afterId } ${leadlag[0].afterName }</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>
				<c:choose>
					<c:when test="${empty leadlag[0].beforeId }">
						이전글이 없습니다.
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fn_boardDetail('${leadlag[0].beforeId }','${param.bbsId }')">[이전글] ${leadlag[0].beforeId } ${leadlag[0].beforeName }</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</tbody>
</table>

<!-- 글쓴 사람과 읽는 사람이 같은 경우-->
<c:if test="${(detail[0].memberId == login.memberId) || login.groupId == 2}">
	<button onclick="fn_modifyform('${param.boardId }','${param.bbsId }')">수정하기</button>
	<c:choose>
		<c:when test="${param.bbsDel=='BO001'}">
			<button onclick="fn_delete('${param.boardId }','${param.bbsId }')">삭제하기</button>
		</c:when>
		<c:when test="${param.bbsDel=='BO002'}">
			<button>삭제불가</button>
		</c:when>
	</c:choose>
</c:if>
<input type="button" value="목록으로" onclick="fn_goboxinbox('${param.menuId}','boardList');">

