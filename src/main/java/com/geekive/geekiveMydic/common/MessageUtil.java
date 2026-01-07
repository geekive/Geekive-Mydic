package com.geekive.geekiveMydic.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

@Component
public class MessageUtil {
	
	private static MessageSource messageSource;
	
	@Autowired
	public MessageUtil(MessageSource messageSource) {
		MessageUtil.messageSource = messageSource;
	}
	
    public static String getMessage(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }
	
    public static String getMessage(String code, Object... args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }
}
