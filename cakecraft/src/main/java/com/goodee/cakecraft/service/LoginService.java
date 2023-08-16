package com.goodee.cakecraft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.IdListMapper;
import com.goodee.cakecraft.vo.EmpIdList;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class LoginService {
	//ANSI코드
		final String BLUE = "\u001B[44m";
		final String RESET = "\u001B[0m"; 
	
	//로그인 요청이 들어왔을 때 입력받은 회원정보를 db에서 조회하고 일치하면 로그인 성공
		@Autowired
		//loginMapper 인터페이스 주입 (db 연동)
		private IdListMapper idListMapper;
		
		//로그인
		//login 메서드 -> 주어진 Member 객체를 파라미터로 받아 db에서 조회
		public EmpIdList login(EmpIdList empIdList) {
			//해당 회원의 정보를 가져옴
			EmpIdList login = idListMapper.selectMemberById(empIdList);
			log.debug(BLUE + "LoginService" + idListMapper + RESET);
			return login;
		}
}
