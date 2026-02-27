package com.geekive.geekiveMydic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.geekive.geekiveMydic.common.Util;

/**
 * LoginCheckInterceptor
 *
 * Responsibility:
 * - Enforce authentication for protected URLs.
 * - Redirect unauthenticated users to root ("/").
 *
 * Design principles:
 * - Assumes AutoLoginInterceptor already attempted session restoration.
 * - Performs strict access control.
 */
@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// If user is not logged in, block access to protected resource
		if (!Util.isLogin(request)) {
			response.sendRedirect("/");
			return false;
		}

		return true;
	}
}