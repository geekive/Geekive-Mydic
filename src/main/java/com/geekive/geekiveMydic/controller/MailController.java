package com.geekive.geekiveMydic.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.geekive.geekiveMydic.common.Constants;
import com.geekive.geekiveMydic.common.MessageUtil;
import com.geekive.geekiveMydic.common.Util;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveConnector;
import com.geekive.geekiveMydic.geekiveCustom.GeekiveMap;

@Controller
@RequestMapping(value = "/email")
public class MailController {
	
	@Autowired
	private JavaMailSender javaMailSender;

	@ResponseBody
	@PostMapping(value = {"", "/"})
	public GeekiveMap email(HttpServletRequest request, @RequestBody GeekiveMap gMap) throws Exception{
		String type 	= gMap.getString("purpose");
		String email 	= gMap.getString("email");
		try {
			if(Util.isEmpty(email)) {
				throw new Exception("Error. Server hasn't received the email address.");
			}
			
			String lang 		= LocaleContextHolder.getLocale().getLanguage();
			MimeMessage message = javaMailSender.createMimeMessage();
			
			switch (type) {
			case Constants.EMAIL_PURPOSE_SIGNUP :
				String code = Util.verificationCodeGenerator();
				
				GeekiveConnector gConnector = new GeekiveConnector.Builder(Util.getBaseURL(request) + "/email/code?lang=" + lang).build();
				gConnector.sendPost();
					
				String html = gConnector.getResponseData();
				html = html.replace("{{message}}"	, MessageUtil.getMessage("email.signup.message"));
				html = html.replace("{{code}}"		, code);
				
				MimeMessageHelper helper = new MimeMessageHelper(message, true);
		        helper.setTo(email);
		        helper.setSubject(MessageUtil.getMessage("email.signup.subject"));
		        helper.setText(html, true);
		        javaMailSender.send(message);
		        
		        gMap.put("code", code);
		        gMap.setResultMessage(MessageUtil.getMessage("email.common.code.sent"));
				break;
			default:
				throw new Exception("Error. Please contact the administrator.<br/>Possible cause : Unable to determine the purpose of the email transmission.");
			}
		} catch (Exception e) {
			gMap.put("resultCode"	, 0);
			gMap.put("resultMessage", e.getMessage());
		}
		return gMap;
	}
	
	@PostMapping(value = "/code")
	public String code(HttpServletRequest request, ModelMap modelMap) throws Exception{
		return "common/email/code";
	}
}
