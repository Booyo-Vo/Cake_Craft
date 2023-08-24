package com.goodee.cakecraft.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.EmpService;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestSignController {
	// ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m";

	@Autowired
	EmpService empService;
	
	//최초 사인 추가
	@PostMapping("/emp/addsign")
	public String addSign(HttpSession session, HttpServletRequest request, 
							@RequestParam(name = "sign") String sign) {
		String path = request.getServletContext().getRealPath("/signImg/");

		// 현재 로그인된 사용자의 아이디 가져오기
		Object o = session.getAttribute("loginMember");
		String loginId = "";

		if (o instanceof EmpIdList) {
			loginId = ((EmpIdList) o).getId();
			log.debug(KMS + "loginId EmpController" + loginId + RESET);
		}
		
		 log.debug(KMS + "Before calling empService.addSign" + RESET);
		 empService.addSign(sign, path, loginId); 
		 log.debug(KMS +"After calling empService.addSign" + RESET);

		return "YES";
	}
	
	//사인 수정
	@PostMapping("/emp/updateSign")
	public String updateSign(HttpSession session, HttpServletRequest request,
								@RequestParam(name= "sign") String sign) {
		String path = request.getServletContext().getRealPath("/signImg/");
		
		// 현재 로그인된 사용자의 아이디 가져오기
		Object o = session.getAttribute("loginMember");
		String loginId = "";

		if (o instanceof EmpIdList) {
			loginId = ((EmpIdList) o).getId();
			log.debug(KMS + "loginId EmpController" + loginId + RESET);
		}
			
			log.debug(KMS + "Before calling empService.updateSign" + RESET);
			empService.updateSign(sign, path, loginId);
			log.debug(KMS +"After calling empService.updateSign" + RESET);


		return "YES";
	}
}
