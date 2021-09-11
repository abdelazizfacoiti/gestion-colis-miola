package com.anas.colis.infrastructure;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.anas.colis.security.UserSecurityHandlerInterceptor;

@Configuration
public class SpringMVCConfig implements WebMvcConfigurer {

	@Autowired
	UserSecurityHandlerInterceptor userSecurityInterceptor;

	@Override
	public void addInterceptors(final InterceptorRegistry registry) {
		registry.addInterceptor(userSecurityInterceptor).addPathPatterns("/**").excludePathPatterns("/**");
	}
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addCorsMappings(registry);
		registry.addMapping("/**")
		.allowedOrigins("*")
		.allowedMethods("GET", "PUT", "POST", "PATCH", "DELETE", "OPTIONS");
	}

}

