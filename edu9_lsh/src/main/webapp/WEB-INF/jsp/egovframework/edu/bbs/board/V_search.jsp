<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#searchTable {
	margin-left: 20%;
}
</style>

<script type="text/javascript">
//자주 사용하는 검색 옵션 부분 함수로 만듦 
function fn_SearchOptions(flag) {
	switch (flag) {
	case "search_notice":
		return $('#search_notice').val();
		break;
	case "search_option":
		return $('#search_option').val();
		break;
	case "keyword":
		return $('#keyword').val();
		break;
	}
}
</script>

<!-- Search기능을 사용할때만 출력 -->
<c:if test="${param.bbsSearch == 'BO001'}">
	<table id="searchTable">
		<tr>
			<td>
				<!-- 검색 -->
				<form name="searchForm" method="post">
					<select id="search_notice" name="search_notice">
						<c:forEach var="sn" items="${selectSN }">
							<option value="${sn.optionId }">${sn.optionName }</option>
	 					</c:forEach>
					</select> 
					<select id="search_option" name="search_option">
						<c:forEach var="so" items="${selectSO }">
							<option value="${so.optionId }">${so.optionName }</option>
						</c:forEach>
					</select>
					<input id="keyword" name="keyword" value="${keyword }"> 
					<input type="button" onclick="fn_listbox(1)" value="조회">
				</form>
			</td>
		</tr>
	</table>
</c:if>
