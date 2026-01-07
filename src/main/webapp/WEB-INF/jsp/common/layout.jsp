<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<jsp:include page="/WEB-INF/jsp/common/head.jsp">
	<jsp:param value="${isLogin}" name="title"/>
</jsp:include>

<body>
<%-- 	<input type="hidden" id="contextPath" value="${contextPath}">
	
	<jsp:include page="/WEB-INF/jsp/common/modal.jsp"/>
	<jsp:include page="/WEB-INF/jsp/common/loading.jsp"/> --%>

	<div class="wrap">
		<jsp:include page="/WEB-INF/jsp/common/header.jsp"/>	
		<c:out value="${pageContent}" escapeXml="false"/>
	</div>
	<%-- <jsp:include page="/WEB-INF/jsp/home/common/footer.jsp"/> --%>
</body>
</html>