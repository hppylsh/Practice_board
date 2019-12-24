<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
#noti{
	font-weight: bold;
}
</style>

<script type="text/javascript">
/* 입력 폼 */
function fn_writeForm(bbsNotice) {
	$.ajax({
		type : 'POST',
		url : '/comcon.do',
		data : {
			 'returnJSP' : 'board/V_Write'
			,'bbsNotice' : bbsNotice
			, menuId : menuId
		},
		dataType : 'html',
		success : function(data) {
			$("#detailBox").html(data);
			$("#detailBox").show();
			$("#listBox").hide();
		},
		error : function(err) {
			console.log(err);
		}
	});
}

/* 상세내용 */
function fn_boardDetail(boardId,bbsId,bbsDel) {
	// 옵션 불러오기
	var search_notice = fn_SearchOptions('search_notice');
	var search_option = fn_SearchOptions('search_option');
	var keyword = fn_SearchOptions('keyword');
	var menuId = fn_Options('menuId');
	
	// 쿼리 2개를 실행시키기 위한 array
	var param1 = {
		'queryId' : 'board.detail'
		,'ctrlName':'detail'
	}
	var param2 = {
		'queryId' : 'board.selectLeadLag'
		,'ctrlName':'leadlag'
	}
	var jsonData = fn_jsonData(param1,param2);
	
	var params = {
			'returnJSP' : 'board/V_boardDetail'
			, bbsId : bbsId
			, boardId : boardId
			, search_notice : search_notice
			, search_option : search_option
			, keyword : keyword
			, menuId : menuId
			, bbsDel : bbsDel
			, 'jsonData' : jsonData
	}
	
	/* 조회수 업데이트 */
	$.ajax({
		type : 'POST',
		url : '/save.do',
		data : {
			'boardId' : boardId
			,'querytype' : 'update'
			,'queryname' : 'board.updateHitCnt'
		},
		dataType : 'text',
		success : function(data) {
			// 조회수 올린 후에 detail 접속 
			fn_go(params,'#detailBox');
			$("#listBox").hide();
			$("#detailBox").show();
		},
		error : function(err) {
			console.log(err);
		}
	}); 
}
</script>
<h2>${bbs[0].bbsName} 게시판</h2>
<c:choose>
	<c:when test="${bbs[0].bbsWrite == 'BO001'}">
		<input type="button" value="글쓰기" onclick="fn_writeForm('${bbs[0].bbsNotice}')"/>
	</c:when>
	<c:otherwise>
		<input type="button" value="글쓰기x"/>
	</c:otherwise>
</c:choose>

<table style="border: 1px solid #ccc">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="15%" />
		<col width="20%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">글번호</th>
			<th scope="col">제목</th>
			<th scope="col">글쓴이</th>
			<th scope="col">조회수</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<!-- 공지사용(bbsList) 여부 -->
		<c:forEach items="${list }" var="row">
			<c:if test="${(bbs[0].bbsNotice == 'BO002' && row.notice== 0)||(bbs[0].bbsNotice == 'BO001')}">   
				<tr>
					<td>
						<c:choose>
							<c:when test="${row.notice == 1 }">
								<span id="noti">공지</span>
							</c:when>
							<c:otherwise> 
								${row.boardId }
							</c:otherwise>
						</c:choose> 
					</td>
					<td>
						<c:choose>
							<c:when test="${bbs[0].bbsRead == 'BO002' }">${row.title }</c:when>
							<c:otherwise>
								<a href="javascript:void(0)" onClick="fn_boardDetail('${row.boardId }','${row.bbsId }','${bbs[0].bbsDel }')">${row.title }</a>
							</c:otherwise>
						</c:choose>
						<!-- 비밀글 선택시 --> 
						<c:if test="${row.secretCheck == 1 }">비밀글</c:if>
						<c:if test="${row.popnew < 1 }">new</c:if>
					</td>
					<td>${row.nickname }</td>
					<td>${row.hitcount }</td>
					<td><fmt:formatDate value="${row.writedate }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>
