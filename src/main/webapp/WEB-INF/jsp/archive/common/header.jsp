<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>

<!-- header :: s -->
<div class="archive-header-wrapper d-flex jcb">
	
	<!-- menu button :: s -->
	<div class="menu-btn-wrapper d-flex aic">
		<i class="bi-list" data-bs-toggle="offcanvas" href="#menu-wrapper" role="button"></i>
	</div>
	<!-- menu button :: e -->
	
	<!-- logo :: s -->
	<div class="logo-wrapper d-flex jcc aic" onclick="goToPage('/${currentArchiveName}')">
		<c:out value="${currentArchiveLogo}"/>
	</div>
	<!-- logo :: e -->
	
	<!-- search :: s -->
	<div class="search-wrapper d-flex jce aic">
		<div id="input-text-wrapper" class="input-text-wrapper d-flex jcc aic">
			<form id="form-search" method="get">
				<input type="text" class="form-control" name="searchValue" placeholder="<spring:message code="archvie.search"/>" maxlength="30" autocomplete="off">
			</form>
		</div>
		<i id="btn-search" class="bi-search" role="button"></i>
	</div>
	<script>
		const $inputTextWrapper = $('.search-wrapper #input-text-wrapper');
		$('#btn-search').on('click', () => {
			if($inputTextWrapper.hasClass('on')){
				$('#form-search').submit();
			}else{
				$inputTextWrapper.addClass('on');
			}
		});
		$inputTextWrapper.on('dblclick', () => {
			$inputTextWrapper.removeClass('on');
			$('input[name="searchValue"]').val('');
		});
	</script>
	<!-- search :: e -->
</div>
<!-- header :: e -->

<!-- menu :: s -->
<c:import url="/menu">
	<c:param name="isLegalAccess" value="true"/>
</c:import>
<!-- menu :: e -->