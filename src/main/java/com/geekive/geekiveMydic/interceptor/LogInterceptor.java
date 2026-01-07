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
import com.geekive.geekiveMydic.mapper.service.LogService;

@Component
public class LogInterceptor implements HandlerInterceptor {

	private final LogService logService;

    public LogInterceptor(LogService logService) {
        this.logService = logService;
    }
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String currentArchiveUserUid 	= (String) request.getAttribute("currentArchiveUserUid");
		String currentArticleUid 		= (String) request.getAttribute("currentArticleUid");
		String ip 						= Util.getIp(request);
		String device 					= Util.getDevice(request);
		String browser 					= Util.getBrowser(request);
		
		if(Util.isEmpty(currentArchiveUserUid)) {
			return true;
		}
		
		GeekiveMap gMap = new GeekiveMap();
		gMap.put("logUid"				, Util.generateUID("LOG"));
		gMap.put("currentArchiveUserUid", currentArchiveUserUid);
		gMap.put("ip"					, ip);
		gMap.put("device"				, device);
		gMap.put("browser"				, browser);
		logService.insertLogArchiveVisit(gMap);
		
		if(Util.isEmpty(currentArticleUid)) {
			return true;
		}
		
		gMap.put("currentArticleUid", currentArticleUid);
		logService.insertLogArticleView(gMap);
		
		return true;
	}
}
