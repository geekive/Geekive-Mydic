package com.geekive.geekiveMydic.configuration;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.geekive.geekiveMydic.common.Constants;
import com.geekive.geekiveMydic.common.PropertyUtil;
import com.geekive.geekiveMydic.interceptor.CommonDataInterceptor;
import com.geekive.geekiveMydic.interceptor.LogInterceptor;
import com.geekive.geekiveMydic.interceptor.LoginInterceptor;
import com.geekive.geekiveMydic.mapper.service.ArchiveService;
import com.geekive.geekiveMydic.mapper.service.LogService;

@Component
public class WebMvcConfig implements WebMvcConfigurer{

	@Autowired
	private ArchiveService archiveService;
	
	@Autowired
	private LogService logService;
	
    @Bean
    public LocaleResolver localeResolver() {
        CookieLocaleResolver resolver = new CookieLocaleResolver();
        resolver.setDefaultLocale(Locale.ENGLISH);
        resolver.setCookieName("lang");
        resolver.setCookieMaxAge(60 * 60 * 24 * 30); // 30 days
        resolver.setCookiePath("/");
        return resolver;
    }
    
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(new LoginInterceptor())
			.order(1)
			.addPathPatterns("/vocabulary/**");
		
		/*
		CommonDataInterceptor commonDataInterceptor = new CommonDataInterceptor(archiveService);
		registry.addInterceptor(commonDataInterceptor)
			.order(2)
			.addPathPatterns("/**")
			.excludePathPatterns(Constants.EXCLUDE_PATH);

		registry.addInterceptor(new LogInterceptor(logService))
			.order(3)
			.addPathPatterns("/**")
			.excludePathPatterns(Constants.EXCLUDE_PATH);
			*/
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
			.addResourceHandler("/upload/**")
			.addResourceLocations("file:///" + PropertyUtil.getProperty("upload.path"));
	}
	
	
}
