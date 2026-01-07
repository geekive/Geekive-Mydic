package com.geekive.geekiveMydic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.geekive.geekiveMydic.common.Util;

@Component
public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(!Util.isLogin(request)) {
			response.sendRedirect("/");
			return false;
		}else {
			return true;
		}
	}	
}
