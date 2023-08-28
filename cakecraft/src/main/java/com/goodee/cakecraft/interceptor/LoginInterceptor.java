package com.goodee.cakecraft.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LoginInterceptor implements HandlerInterceptor {
	//ANSI코드
		final String KMS = "\u001B[44m";
		final String RESET = "\u001B[0m";
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		        throws Exception {
		    // session 객체를 가져옴
		    HttpSession session = request.getSession();
		    log.debug(KMS+ "LoginInterceptor 실행" +RESET);
		    // 세션에 로그인 정보가 없는 경우에만 로그인 페이지로 리다이렉트
		    if (session.getAttribute("loginMember") == null) {
		        response.sendRedirect("/cakecraft/login");
		        return false;
		    }
		    
		    return true;
		}
}
