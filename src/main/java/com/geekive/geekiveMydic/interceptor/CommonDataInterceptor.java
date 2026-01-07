package com.geekive.geekiveMydic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.service.ArchiveService;

@Component
public class CommonDataInterceptor implements HandlerInterceptor {

	private final ArchiveService archiveService;

    public CommonDataInterceptor(ArchiveService archiveService) {
        this.archiveService = archiveService;
    }
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String archiveName 			= Util.extractArchiveNameFromUrl(request);
		String categoryUrlPath 		= Util.extractCategoryNameFromUrl(request);
		String articleNumber		= Util.extractArticleNumberFromUrl(request);
		String userUid				= "";
		String currentArchiveLogo 	= "";
		String categoryUid			= "";
		String articleUid			= "";
		Boolean isMyArchvie			= false;
		
		// get user uid or it's gonna send redirect
		GeekiveMap gMap = new GeekiveMap();
		gMap.put("archiveName", archiveName);
		userUid = archiveService.selectUserUid(gMap);
		if(Util.isEmpty(userUid)) {
			response.sendRedirect("/");
			return false;
		}
		gMap.put("userUid", userUid);
		currentArchiveLogo = archiveService.selectArchiveLogo(gMap);
		
		// check if the archive entering is mine
		if(Util.isLogin(request)) {
			HttpSession session = request.getSession();
			GeekiveMap userMap 	= (GeekiveMap) session.getAttribute("userMap");
			if(userMap.getString("userUid").equals(userUid)) {
				isMyArchvie = true;
			}
		}
		
		// get category uid or it's gonna send redirect
		if(Util.isNotEmpty(categoryUrlPath)) {
			gMap.put("categoryUrlPath"	, categoryUrlPath);
			categoryUid = archiveService.selectCategoryUid(gMap);
			if(Util.isEmpty(categoryUid)) {
				response.sendRedirect("/" + archiveName);
				return false;
			}
		}
		
		// check article number exists and if not, it's gonna send redirect
		if(Util.isNotEmpty(articleNumber)) {
			gMap.put("articleNumber", articleNumber);
			gMap.put("categoryUid"	, categoryUid);
			if(!archiveService.checkArticleExistence(gMap)) {
				response.sendRedirect("/" + archiveName + "/" + categoryUrlPath);
			}else {
				articleUid = archiveService.selectArticleUid(gMap);
			}
		}

		request.setAttribute("currentArchiveUserUid"	, userUid);
		request.setAttribute("currentCategoryUid"		, categoryUid);
		request.setAttribute("currentArchiveName"		, archiveName);
		request.setAttribute("currentArchiveLogo"		, currentArchiveLogo);
		request.setAttribute("currentArticleNumber"		, articleNumber);
		request.setAttribute("currentArticleUid"		, articleUid);
		request.setAttribute("isMyArchvie"				, isMyArchvie);
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		/*
		request.removeAttribute("currentArchiveUserUid");
		request.removeAttribute("currentCategoryUid");
		*/
	}
}
