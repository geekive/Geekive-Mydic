<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>
<c:set var="pageContent">
	<script>
		$(function(){
			const signup = new Signup();
			signup.message.email.fill 		= '<spring:message code="home.signup.message.email.fill"/>';
			signup.message.email.format 	= '<spring:message code="home.signup.message.email.format"/>';
			signup.message.code.fill 		= '<spring:message code="home.signup.message.code.fill"/>';
			signup.message.code.sending 	= '<spring:message code="home.signup.message.code.sending"/>';
			signup.message.code.wrong 		= '<spring:message code="home.signup.message.code.wrong"/>';
			signup.message.password.fill 	= '<spring:message code="home.signup.message.password.fill"/>';
			signup.message.password.min 	= '<spring:message code="home.signup.message.password.min"/>';
			signup.message.password.format 	= '<spring:message code="home.signup.message.password.format"/>';
			signup.message.password.match 	= '<spring:message code="home.signup.message.password.match"/>';
			signup.message.username.fill 	= '<spring:message code="home.signup.message.username.fill"/>';
			signup.message.archive.fill 	= '<spring:message code="home.signup.message.archive.fill"/>';
			signup.message.archive.min 		= '<spring:message code="home.signup.message.archive.min"/>';
			signup.message.common.saving 	= '<spring:message code="home.signup.saving"/>';
		})
	</script>
	<div class="sign-body-wrapper d-flex jcc aic">
		<div class="field-group-wrapper">
			<div class="d-flex jcc aic"><spring:message code="home.signup"/></div>
			
			<div class="field-wrapper">
				<input type="email" id="email" class="form-control" placeholder="<spring:message code="home.signup.email"/>" autocomplete="off" maxlength="254">
			</div>
			
			<div class="field-wrapper d-flex">
				<div class="code-wrapper">
				    <input type="text" id="code" class="form-control" placeholder="<spring:message code="home.signup.code"/>" autocomplete="off" readonly="readonly" maxlength="6" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
				    <span id="codeTimer">3:00</span>
				</div>
				<button type="button" id="btn-send-code" class="btn btn-outline-dark"><spring:message code="home.signup.button.send"/></button>
				<button type="button" id="btn-resend-code" class="hide btn btn-outline-dark" disabled><spring:message code="home.signup.button.resend"/></button>
				<button type="button" id="btn-check" class="btn btn-outline-dark" disabled><spring:message code="home.signup.button.check"/></button>
			</div>
			
			<div class="field-wrapper">
				<input type="password" id="password" class="form-control" readonly="readonly" placeholder="<spring:message code="home.signup.password"/>" oninput="this.value = this.value.replace(/[^A-Za-z0-9!@#$%^&*(),.?:{}|<>_-]/g, '')">
			</div>
			
			<div class="field-wrapper">
				<input type="password" id="passwordCheck" class="form-control" readonly="readonly" placeholder="<spring:message code="home.signup.password.check"/>">
			</div>
			
			<div class="field-wrapper">
				<input type="text" id="userName" class="form-control" readonly="readonly" placeholder="<spring:message code="home.signup.username"/>" maxlength="20" oninput="this.value = this.value.replace(/[^^\p{L}\s]/gu, '').replace(/\s{2,}/g, ' ');">
			</div>
			
			<div class="field-wrapper">
				<input type="text" id="archiveName" class="form-control" readonly="readonly" placeholder="<spring:message code="home.signup.archive"/>" maxlength="12" oninput="this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '').replace(/\s{2,}/g, ' ').toLowerCase();">
			</div>
			
			<div class="field-wrapper d-flex jcc">
				<button type="button" id="btn-save" class="btn btn-outline-dark" disabled><spring:message code="home.signup"/></button>
			</div>
		</div>
	</div>
</c:set>
<%@ include file="/WEB-INF/jsp/home/common/layout.jsp" %>