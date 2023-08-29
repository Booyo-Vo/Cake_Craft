package com.goodee.cakecraft.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.goodee.cakecraft.mapper.EmpMapper;
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
	
	@Autowired
	private EmpMapper empMapper; 
	
	//로그인 액션
	@PostMapping("/login")
	public String login(HttpServletRequest request,
									@RequestParam(name= "id") String id,
									@RequestParam(name ="pw") String pw) {
		EmpIdList empIdList = new EmpIdList();
		empIdList.setId(id);
		empIdList.setPw(pw);
		EmpIdList loginMember = loginService.login(empIdList);
		
		if(loginMember == null) {
			log.debug(KMS + "로그인 실패" + RESET);
			return "redirect:/login";
		}
	
	
		// 로그인 성공: 세션에 로그인 정보 저장
		log.debug(KMS + "로그인 성공" + RESET);
		log.debug(KMS + "loginMember LoginController" + loginMember + RESET);
		HttpSession session = request.getSession();
		
		// 세션의 만료 시간을 설정
	    session.setMaxInactiveInterval(3 * 60 * 60); // 3시간
		session.setAttribute("loginMember", loginMember);
		
		// 프로필 이미지 경로 조회 및 세션에 저장 (세션을 이용해 header.jsp 가 인클루드 된 모든 페이지에서 프로필 사진을 띄운다)
				// autowired로 EmpMapper 주입
				String profileImagePath = empMapper.getProfileImagePath(id);
					if (profileImagePath != null) {
						session.setAttribute("profileImagePath", profileImagePath);
						log.debug(KMS + profileImagePath +  "profileImagePath /LoginController"+RESET);
					} else {
						session.setAttribute("profileImagePath", "default_profile.png");
					}

			return "redirect:/schedule/schedule";
		}
	  
	
	//로그아웃 액션
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();

        return "redirect:/login";
	}
}
