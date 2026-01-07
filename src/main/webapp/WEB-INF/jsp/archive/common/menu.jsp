<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstlcore.jsp"%>
<div class="offcanvas offcanvas-start" tabindex="-1" id="menu-wrapper" aria-labelledby="offcanvasExampleLabel">
	<div class="menu-header offcanvas-header">
		<div class="link-icon-group d-flex aic">
			<c:forEach items="${socialMediaList}" var="socialMedia">
				<c:choose>
					<c:when test="${socialMedia.socialMediaType eq 'GH'}">
						<a href="${socialMedia.url}" target="_blank">
							<i class="link-icon-github bi bi-github" role="button"></i>
						</a>
					</c:when>
					<c:when test="${socialMedia.socialMediaType eq 'YT'}">
						<a href="${socialMedia.url}" target="_blank">
							<i class="link-icon-youtube bi bi-youtube" role="button"></i>
						</a>
					</c:when>
					<c:when test="${socialMedia.socialMediaType eq 'IG'}">
						<a href="${socialMedia.url}" target="_blank">
							<i class="link-icon-instagram bi bi-instagram" role="button"></i>
						</a>
					</c:when>
				</c:choose>
			</c:forEach>
		</div>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div class="accordion">
			<c:forEach items="${categoryList}" var="parentCategory" varStatus="status">
			  	<div class="accordion-item">
			    	<div class="accordion-header">
				      	<button class="menu-depth1 accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#menu${status.index}" aria-expanded="false" aria-controls="menu${status.index}">
				        	${parentCategory.categoryName}
				      	</button>
			    	</div>
			    	<div id="menu${status.index}" class="accordion-collapse collapse">
			    		<c:forEach items="${parentCategory.childList}" var="childCategory">
			      			<div class="menu-depth2 d-flex aic" onclick="goToPage('/${currentArchiveName}/${childCategory.urlPath}')">${childCategory.categoryName}</div>
			      		</c:forEach>
			    	</div>
			  	</div>
			</c:forEach>
		</div>
	</div>
	<div class="menu-footer d-flex jcev aic">
		<c:choose>
			<c:when test="${sessionScope.isSignedIn}">
				<a href="#" onclick="goToPage('/');"><spring:message code="archive.menu.home"/></a>
				<c:choose>
					<c:when test="${isMyArchvie}">
						<a href="#" onclick="goToPage('/admin', '_blank')"><spring:message code="archive.menu.admin"/></a>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="goToPage('/${sessionScope.userMap.myArchiveUrlPath}')"><spring:message code="archive.menu.myarchive"/></a>
					</c:otherwise>
				</c:choose>
				<a href="#" onclick="goToPage('/sign/signout');"><spring:message code="archive.menu.signout"/></a>
			</c:when>
			<c:otherwise>
				<a href="#" onclick="goToPage('/');"><spring:message code="archive.menu.home"/></a>
				<a href="#" onclick="goToPage('/sign/signin')"><spring:message code="archive.menu.signin"/></a>
			</c:otherwise>
		</c:choose>
	</div>
</div>