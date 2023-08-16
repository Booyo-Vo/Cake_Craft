package com.goodee.cakecraft.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.goodee.cakecraft.interceptor.LoginInterceptor;

import lombok.extern.slf4j.Slf4j;

@org.springframework.context.annotation.Configuration
@Slf4j
public class Configuration implements WebMvcConfigurer {
	//ANSI코드
		final String BLUE = "\u001B[44m";
		final String RESET = "\u001B[0m";
	//인터셉터를 설정하는 역할
		/*
		 * @Bean -> LoginInterceptor를 빈으로 등록하는 메서드 
		 * LoginInterceptor 클래스의 로그인 처리와 관련된 기능이 웹 애플리케이션 전체에 적용
		 */
	    @Bean
	    public LoginInterceptor myLoginInterceptor() {
	        return new LoginInterceptor();
	    }
	    @Autowired
	    LoginInterceptor loginInterceptor;
	    
	    @Override
	    public void addInterceptors(InterceptorRegistry registry) {
	    	// myLoginInterceptor() 메서드를 호출하여 빈을 가져옴
	        registry.addInterceptor(myLoginInterceptor())
	                .addPathPatterns("/emp/**","/facility/**","/schedule/**","/approval/**")
	                // /board로 시작하는 경로에 대해서 인터셉터 적용
	                .excludePathPatterns("/login");
	        		// /login 경로는 인터셉터에서 제외
	        log.debug(BLUE + "Configuration 활성화" + RESET);
	    }
}
