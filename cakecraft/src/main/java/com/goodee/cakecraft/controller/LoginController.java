package com.goodee.cakecraft.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.LoginService;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	//ANSI코드
		final String KMS = "\u001B[44m";
		final String RESET = "\u001B[0m"; 
		
	@Autowired 
	private LoginService loginService;
	
	//로그인 페이지로 이동
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	
	//로그인 액션
		@PostMapping("/login")
		public String login(HttpServletRequest request,
							@RequestParam(name= "id") String id,
							@RequestParam(name ="pw") String pw) {
			EmpIdList empIdList = new EmpIdList();
			empIdList.setId(id);
			empIdList.setPw(pw);
			EmpIdList loginMember = loginService.login(empIdList);
			//로그인 실패
			if(loginMember == null) {
				log.debug(KMS + "로그인 실패" + RESET);
				return "redirect:/login";
			}
			//로그인 성공 : session 에 로그인 정보 저장
			log.debug(KMS + "로그인 성공" + RESET);
			log.debug(KMS + "loginMember LoginController" + loginMember + RESET);
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			log.debug(KMS + "session LoginController" + session + RESET);
			return "redirect:/schedule/schedule";
			
			
			}
	
	//로그아웃 액션
	@GetMapping("/logout")
	public String logout(HttpSession session) {
        session.invalidate();
        //로컬스토리지로부터 저장된 id 제거(login.jsp에서 제거)
        return "redirect:/login";
	}
}
