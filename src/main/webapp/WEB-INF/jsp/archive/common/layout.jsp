<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<jsp:include page="/WEB-INF/jsp/common/head.jsp">
	<jsp:param value="${isLogin}" name="title"/>
</jsp:include>

<body>
	<input type="hidden" id="contextPath" value="${contextPath}">
	
	<jsp:include page="/WEB-INF/jsp/common/modal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/common/loading.jsp"></jsp:include>
	<%-- 
	<jsp:include page="/WEB-INF/jsp/common/toast.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/common/balloon.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/common/imagePreview.jsp"></jsp:include>
	 --%>
	<div class="d-flex jcc"> 
		<div class="layout-container container-fluid">
		
			<jsp:include page="/WEB-INF/jsp/archive/common/header.jsp"/>
			
			<div class="content-container container">
				<c:out value="${pageContent}" escapeXml="false"/>
			</div>

			<jsp:include page="/WEB-INF/jsp/archive/common/footer.jsp"/>
		</div>
	</div>
</body>
</html>