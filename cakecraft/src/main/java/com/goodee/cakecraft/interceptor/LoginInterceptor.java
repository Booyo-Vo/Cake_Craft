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
		final String BLUE = "\u001B[44m";
		final String RESET = "\u001B[0m";
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // session 객체를 가져옴
    	HttpSession session = request.getSession();
        if (session.getAttribute("loginMember") == null) {
        	// 로그인이 되어 있지 않으면 home.jsp로 리다이렉트
        	response.sendRedirect("/cakecraft/login");
        	log.debug(BLUE + "loginMember / LoginInterceptor" + session.getAttribute("loginMember")+ RESET);
            log.debug(BLUE + "preHandle 작동 interceptor login"+ RESET);
            return false;
        } else {
        	// 로그인이 되어 있으면 요청을 계속 진행
        	return true;
        }
    }
}
