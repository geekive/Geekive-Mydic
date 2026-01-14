<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<jsp:include page="/WEB-INF/jsp/common/head.jsp">
	<jsp:param value="${isLogin}" name="title"/>
</jsp:include>

<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/jsp/common/header.jsp"/>	
		<c:out value="${pageContent}" escapeXml="false"/>
	</div>
</body>
</html>