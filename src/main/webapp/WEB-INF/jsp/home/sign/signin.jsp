<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>
<c:set var="pageContent">
	<script>
		$(function(){
			const signin = new Signin();
			signin.message.email.fill 		= '<spring:message code="home.signin.message.email.fill"/>';
			signin.message.email.format 	= '<spring:message code="home.signin.message.email.format"/>';
			signin.message.password.fill 	= '<spring:message code="home.signin.message.password.fill"/>';
		})
	</script>
	<div class="sign-body-wrapper d-flex jcc aic">
		<div class="field-group-wrapper">
			<div class="d-flex jcc aic"><spring:message code="home.signin"/></div>
			
			<div class="field-wrapper">
				<input type="email" id="email" class="form-control" placeholder="<spring:message code="home.signin.email"/>" autocomplete="off">
			</div>
			
			<div class="field-wrapper">
				<input type="password" id="password" class="form-control" placeholder="<spring:message code="home.signin.password"/>" oninput="this.value = this.value.replace(/[^A-Za-z0-9!@#$%^&*(),.?:{}|<>_-]/g, '')">
			</div>
			
			<div class="field-wrapper">
				<div class="forgot-password">
					<spring:message code="home.signin.forgot"/>
				</div>
				<div class="not-registered" onclick="goToPage('<c:url value="/sign/signup"/>')">
					<spring:message code="home.signin.registered"/>
				</div>
			</div>
			
			<div class="field-wrapper d-flex jcc">
				<button type="button" id="btn-signin" class="btn btn-outline-dark"><spring:message code="home.signin"/></button>
			</div>
		</div>
	</div>
</c:set>
<%@ include file="/WEB-INF/jsp/home/common/layout.jsp" %>