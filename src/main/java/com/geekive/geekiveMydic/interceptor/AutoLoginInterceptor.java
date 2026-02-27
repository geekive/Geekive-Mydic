package com.geekive.geekiveMydic.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.geekive.geekiveMydic.common.AutoLoginTokenUtil;
import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.service.SignService;

/**
 * AutoLoginInterceptor
 *
 * Responsibility:
 * - Restore user session using auto-login cookie if session does not exist.
 * - This interceptor MUST NOT perform redirect.
 * - It should be safe to run for every request ("/**").
 *
 * Design principles:
 * - Passive behavior: only restores session if possible.
 * - Never blocks or redirects requests.
 * - Login enforcement is handled by LoginCheckInterceptor.
 */
@Component
public class AutoLoginInterceptor implements HandlerInterceptor {

	@Resource
	private SignService signService;

	/**
	 * Sliding expiration policy.
	 * true  : Extend cookie expiration on each valid request.
	 * false : Fixed expiration (expires exactly after initial period).
	 */
	private static final boolean SLIDING = true;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// 1) If session already exists, do nothing
		if (Util.isLogin(request)) {
			return true;
		}

		// 2) Read auto-login cookie (plain token)
		//    If cookie does not exist, just continue.
		String tokenPlain = AutoLoginTokenUtil.readAutoLoginCookie(request);
		if (Util.isEmpty(tokenPlain)) {
			return true;
		}

		// 3) Try to restore user using the auto-login token
		GeekiveMap userMap = null;
		try {
			userMap = signService.selectUserByAutologinTokenPlain(tokenPlain);
		} catch (Exception ignore) {
			// Intentionally ignored:
			// auto-login failure should not break request flow
		}

		// 4) Invalid token:
		//    - Clear cookie
		//    - Do NOT redirect
		if (Util.isEmpty(userMap) || Util.isEmpty(userMap.getString("userUid"))) {
			AutoLoginTokenUtil.clearAutoLoginCookie(response);
			return true;
		}

		// 5) Valid token:
		//    - Restore login session
		HttpSession session = request.getSession(true);
		session.setAttribute("isSignedIn", true);
		session.setAttribute("userMap", userMap);

		// 6) Optional sliding expiration (cookie only)
		if (SLIDING) {
			AutoLoginTokenUtil.writeAutoLoginCookie(response, tokenPlain);
		}

		return true;
	}
}