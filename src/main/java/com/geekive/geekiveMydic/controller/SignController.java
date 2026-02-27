package com.geekive.geekiveMydic.controller;

import java.time.Instant;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.geekive.geekiveMydic.common.AutoLoginTokenUtil;
import com.geekive.geekiveMydic.common.MessageUtil;
import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;
import com.geekive.geekiveMydic.mapper.service.SignService;

@Controller
@RequestMapping("/sign")
public class SignController {

	@Resource
	SignService signService;

	@ResponseBody
	@PostMapping(value = "/signup")
	public GeekiveMap signupPost(HttpSession session, @RequestBody GeekiveMap gMap) throws Exception{
		try {
			gMap.put("userUid", Util.generateUID("USR"));
			signService.insertUser(gMap);
			gMap.setResultMessage(MessageUtil.getMessage("home.signup.complete"));

			GeekiveMap userMap = new GeekiveMap();
			userMap.put("userUid"	, gMap.getString("userUid"));
			userMap.put("name"		, gMap.getString("name"));
			session.setAttribute("isSignedIn"	, true);
			session.setAttribute("userMap"		, userMap);
		} catch(Exception e) {
			gMap.setResultCode(0);
			gMap.setResultMessage(e.getMessage());
		}
		return gMap;
	}

	@ResponseBody
	@PostMapping(value = "/signin")
	public GeekiveMap signinPost(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestBody GeekiveMap gMap) throws Exception{
		try {
			GeekiveMap userMap = signService.selectUser(gMap);
			if(Util.isEmpty(userMap)) {
				throw new Exception("The email or password is incorrect. Please try again.");
			}

			session.setAttribute("isSignedIn"	, true);
			session.setAttribute("userMap"		, userMap);

			String rememberMe = gMap.getString("rememberMe");

			if("Y".equalsIgnoreCase(rememberMe)) {

				String tokenPlain = AutoLoginTokenUtil.generateTokenPlain();
				String tokenHash  = AutoLoginTokenUtil.sha256Base64Url(tokenPlain);

				long nowEpoch = Instant.now().getEpochSecond();

				GeekiveMap t = new GeekiveMap();
				t.put("userUid"			, userMap.getString("userUid"));
				t.put("tokenHash"		, tokenHash);
				t.put("expiresAtEpoch"	, nowEpoch + AutoLoginTokenUtil.getAutoLoginMaxAgeSec());
				t.put("ua"				, AutoLoginTokenUtil.safeUserAgent(request));
				t.put("ip"				, AutoLoginTokenUtil.safeIp(request));

				signService.upsertAutologinToken(t);

				AutoLoginTokenUtil.writeAutoLoginCookie(response, tokenPlain);

			} else {

				AutoLoginTokenUtil.clearAutoLoginCookie(response);
				signService.deleteAutologinTokenByUserUid(userMap);
			}

		} catch(Exception e) {
			gMap.setResultCode(0);
			gMap.setResultMessage(e.getMessage());
		}

		return gMap;
	}

	@GetMapping(value = "/signout")
	public String signout(HttpSession session, HttpServletResponse response) throws Exception{
		try {
			Object um = session.getAttribute("userMap");
			if(um instanceof GeekiveMap) {
				GeekiveMap userMap = (GeekiveMap) um;
				signService.deleteAutologinTokenByUserUid(userMap);
			}
		} catch(Exception ignore) {}

		session.invalidate();
		AutoLoginTokenUtil.clearAutoLoginCookie(response);
		return "redirect:/";
	}

	@ResponseBody
	@PostMapping(value = "/checkEmailExistence")
	public GeekiveMap checkEmailExistence(HttpServletRequest request, @RequestBody GeekiveMap gMap) throws Exception{
		try {
			if(signService.checkEmailExistence(gMap)) {
				throw new Exception("This email is already registered. Please use a different email address.");
			}
		} catch(Exception e) {
			gMap.setResultCode(0);
			gMap.setResultMessage(e.getMessage());
		}
		return gMap;
	}
}