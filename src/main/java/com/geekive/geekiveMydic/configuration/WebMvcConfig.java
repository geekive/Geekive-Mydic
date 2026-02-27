package com.geekive.geekiveMydic.configuration;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.geekive.geekiveMydic.common.PropertyUtil;
import com.geekive.geekiveMydic.interceptor.AutoLoginInterceptor;
import com.geekive.geekiveMydic.interceptor.LoginCheckInterceptor;

/**
 * WebMvcConfig
 *
 * Interceptor strategy:
 * 1) AutoLoginInterceptor (order = 0)
 *    - Runs for every request.
 *    - Restores session if auto-login cookie is valid.
 *    - Never redirects.
 *
 * 2) LoginCheckInterceptor (order = 1)
 *    - Runs only for protected paths.
 *    - Blocks unauthenticated access.
 */
@Component
public class WebMvcConfig implements WebMvcConfigurer {

	private final AutoLoginInterceptor autoLoginInterceptor;
	private final LoginCheckInterceptor loginCheckInterceptor;

	public WebMvcConfig(AutoLoginInterceptor autoLoginInterceptor, LoginCheckInterceptor loginCheckInterceptor) {
		this.autoLoginInterceptor 	= autoLoginInterceptor;
		this.loginCheckInterceptor 	= loginCheckInterceptor;
	}

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

		// 1) Auto-login session restoration (global, passive)
		registry.addInterceptor(autoLoginInterceptor)
				.order(0)
				.addPathPatterns("/**")
				.excludePathPatterns(
						"/css/**",
						"/js/**",
						"/images/**",
						"/favicon.ico",
						"/upload/**"
				);

		// 2) Authentication enforcement (protected resources only)
		registry.addInterceptor(loginCheckInterceptor)
				.order(1)
				.addPathPatterns("/vocabulary/**");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/**")
				.addResourceLocations("file:///" + PropertyUtil.getProperty("upload.path"));
	}
}