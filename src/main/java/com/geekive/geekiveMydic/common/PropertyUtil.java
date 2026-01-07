package com.geekive.geekiveMydic.common;

import org.springframework.beans.BeansException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class PropertyUtil implements ApplicationContextAware{

	private static ApplicationContext applicationContext;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}
	
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	
	public static String getProperty(String property) {
		
		String value = null;
		
		ApplicationContext applicationContext = getApplicationContext();
		if(applicationContext.getEnvironment().getProperty(property) == null) {
			/* log.warn("\n ■ [" + property + "] property was not loaded."); */
		}else {
			value = applicationContext.getEnvironment().getProperty(property).toString();
		}
		return value;
	}
}
