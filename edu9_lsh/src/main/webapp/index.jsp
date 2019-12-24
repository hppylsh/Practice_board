<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/dhtmlx/codebase/dhtmlx.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dhtmlx/codebase/dhtmlx.css">
<script src="${pageContext.request.contextPath}/dhtmlx/sources/dhtmlxTreeView/codebase/dhtmlxtreeview.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board.js"></script>

</head>
<body>
<div id="index"></div>

<script type="text/javascript">
$(document).ready(function() {
	fn_go({returnJSP:'common/V_header'},'#index');	
});
</script>
</body>
</html>