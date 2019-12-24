<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var myLayout2E = new dhtmlXLayoutObject({
	parent : "layoutObj2E", // id or object for parent container
	pattern : "2E", // layout's pattern
});
var myLayout1C = new dhtmlXLayoutObject({
	parent : "layoutObj1C", // id or object for parent container
	pattern : "1C", // layout's pattern
});

var myGrid;
var myGrid2;
var myPop;

$(document).ready(function() {
	$('#layoutObj').hide();
	var bbsSearch = fn_Options('bbsSearch');
	var bbsPage = fn_Options('bbsPage');
	var listName = fn_Options('listName');

	if (listName == 'boardList') {
		$('#forGridPage').hide();
		// 검색사용 / 비사용 분기
		if (bbsSearch == 'BO001') {
			fn_onSearchView();
		} else if (bbsSearch == 'BO002') {
			fn_noSearchView();
		}
		// 페이징 사용/ 비사용 분기
		if (bbsPage == 'BO001') {
			fn_listbox();
		} else if (bbsPage == 'BO002') {
			fn_listbox2();
		}
	}
});

</script>

<div id="listBox">
	<div id="forGridPage">
		<div id="GridSearch">
			<!-- 검색 -->
			<form name="searchForm" method="post">
				<!-- 게시판 관리-->
				<c:if test="${param.listName == 'bbsList'}">
					<select id="selectBS" name="selectBS">
						<c:forEach var="bs" items="${selectBS }">
							<option value="${bs.optionId }">${bs.optionName }</option>
						</c:forEach>
					</select>
					<input Id="bbsListKeyword" name="keyword" value="${keyword }">
					<input type="button" onclick="fn_bbsList()" value="조회">
				</c:if>
				<!-- 프로그램 관리 -->
				<c:if test="${param.listName == 'programList' }">
					<select id="selectPS" name="selectPS">
						<c:forEach var="ps" items="${selectPS }">
							<option value="${ps.optionId }">${ps.optionName }</option>
						</c:forEach>
					</select>
					<input id="programKeyword" name="keyword" value="${keyword }">
					<input type="button" onclick="fn_programList()" value="조회">
				</c:if>
				<!-- 그룹 관리 -->
				<c:if test="${param.listName == 'groupList' || param.listName == 'memberByGroup' || param.listName == 'menuByGroup'}">
					<select id="selectGS" name="selectGS">
						<c:forEach var="gs" items="${selectGS }">
							<option value="${gs.optionId }">${gs.optionName }</option>
						</c:forEach>
					</select>
					<input id="groupListKeyword" name="keyword" value="${keyword }">
					<!-- 조회버튼 그룹 관리일때 -->
					<c:if test="${param.listName == 'groupList'}">
						<input type="button" onclick="fn_groupList()" value="조회">
					</c:if>
					<!-- 조회버튼 그룹별 관리일때 -->
					<c:if test="${param.listName == 'memberByGroup' || param.listName == 'menuByGroup'}">
						<input type="button" onclick="fn_byGroup()" value="조회">
					</c:if>
				</c:if>
				<!-- 메뉴 관리 -->
				<c:if test="${param.listName == 'menuList' }">
					<select id="selectMS" name="selectMS">
						<c:forEach var="ms" items="${selectMS }">
							<option value="${ms.optionId }">${ms.optionName }</option>
						</c:forEach>
					</select>
					<input id="menuListKeyword" name="keyword" value="${keyword }">
					<input type="button" onclick="fn_menuList()" value="조회"/>
				</c:if>
			</form>
		</div>
		<div id="layoutObj">
			<div id="layoutObj2E" style="position: relative; width: 1300px; height: 700px;"></div>
			<div id="layoutObj1C" style="position: relative; width: 1300px; height: 600px;"></div>
			<input type="button" value="추가" onclick="fn_addRow()" />
			<input type="button" value="삭제" onclick="fn_listDelete()" />
			<input type="submit" value="저장" onclick="fn_listSubmit()" />
		</div>
	</div>
	<div id="forElsePage">
		<div id="listPage"></div>
		<div id="search"></div>
	</div>
</div>
<div id="detailBox"></div>
