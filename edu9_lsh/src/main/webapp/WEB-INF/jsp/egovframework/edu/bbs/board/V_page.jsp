<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#pagingTable {
	margin-left: 20%;
}
</style>
<table id="pagingTable">
	<tr>
		<!-- 페이징 처리 -->
		<td colspan="5" align="center">
			<c:if test="${pager.curBlock > 1}">
				<a href="javascript:void(0)" onclick="fn_listbox('1')">[처음]</a>
			</c:if> 
			<c:if test="${pager.curBlock > 1}">
				<a href="javascript:void(0)" onclick="fn_listbox('${pager.prevPage}')">[이전]</a>
			</c:if> 
			<c:forEach var="num" begin="${pager.blockBegin}" end="${pager.blockEnd}">
				<c:choose>
					<c:when test="${num==pager.curPage}">
						<span style="color: red;">${num}</span>&nbsp;
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0)" onclick="fn_listbox('${num}')">${num}</a>&nbsp;
					</c:otherwise>
				</c:choose>
			</c:forEach> 
			<c:if test="${pager.curBlock <= pager.totBlock}">
				<a href="javascript:void(0)" onclick="fn_listbox('${pager.nextPage}')">[다음]</a>
			</c:if> 
			<c:if test="${pager.curPage <= pager.totPage}">
				<a href="javascript:void(0)" onclick="fn_listbox('${pager.totPage}')">[끝]</a>
			</c:if>
		</td>
	</tr>
</table>