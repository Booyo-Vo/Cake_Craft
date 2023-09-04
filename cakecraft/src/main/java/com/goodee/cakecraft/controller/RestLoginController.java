package com.goodee.cakecraft.controller;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.service.LoginService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
public class RestLoginController {
	@Autowired
    private LoginService loginService;
	
	//ANSI코드
			final String KMS = "\u001B[44m";
			final String RESET = "\u001B[0m"; 

			@Autowired
			private EmpMapper empMapper; 
    @PostMapping("/api/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> loginInfo,
    		HttpServletRequest request) {
    	Map<String, Object> response = new HashMap<>();
    	
    	String id = loginInfo.get("id");
        String pw = loginInfo.get("pw");

        EmpIdList empIdList = new EmpIdList();
        empIdList.setId(id);
        empIdList.setPw(pw);

        EmpIdList loginMember = loginService.login(empIdList);
        EmpBase loginEmpBase = empMapper.selectEmpById(id);
		
		if(loginMember == null) {
			log.debug(KMS + "로그인 실패" + RESET);
			response.put("success", false);
            return ResponseEntity.badRequest().body(response);
		}
	
	
		// 로그인 성공: 세션에 로그인 정보 저장
		log.debug(KMS + "로그인 성공" + RESET);
		log.debug(KMS + "loginMember LoginController" + loginMember + RESET);
		HttpSession session = request.getSession();
		
		// 세션의 만료 시간을 설정
	    session.setMaxInactiveInterval(3 * 60 * 60); // 3시간
		session.setAttribute("loginMember", loginMember);
		session.setAttribute("loginEmpBase", loginEmpBase);
		
		// 프로필 이미지 경로 조회 및 세션에 저장 (세션을 이용해 header.jsp 가 인클루드 된 모든 페이지에서 프로필 사진을 띄운다)
				// autowired로 EmpMapper 주입
				String profileImagePath = empMapper.getProfileImagePath(id);
					if (profileImagePath != null) {
						session.setAttribute("profileImagePath", profileImagePath);
						log.debug(KMS + profileImagePath +  "profileImagePath /LoginController"+RESET);
					} else {
						session.setAttribute("profileImagePath", "default_profile.png");
					}
    
        
            response.put("success", true);
            return ResponseEntity.ok(response);
        
    }
}
