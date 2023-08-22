package com.goodee.cakecraft.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.DayoffService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpDayoff;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DayoffController {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private DayoffService dayoffService;
	
	@Autowired
	private AdminEmpService adminEmpService;
	
	// 연차상세내역조회
	@GetMapping("/emp/dayoffById")
	 	public String dayoffList(HttpSession session, Model model,
	 							@RequestParam String id) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		log.debug(LJY + "dayoffById id :"+id + RESET);	
		//연차상세내역 받아오기
		EmpDayoff empDayoff = dayoffService.getdayoffById(id);
		log.debug(LJY + "dayoffById empDayoff :"+empDayoff + RESET);	
		
		//사원상세내역 받아와서 사원정보받아오기
		EmpBase empBase = adminEmpService.getAdminEmpById(id); 
		
		//StartDay, EndDay 뒷자리 세개 잘라내서 초단위 없애기
		empDayoff.setStartDay(empDayoff.getStartDay().substring(0, empDayoff.getStartDay().length() - 3));
		empDayoff.setEndDay(empDayoff.getEndDay().substring(0, empDayoff.getEndDay().length() - 3));
		
		//뷰로 값넘기기
	    model.addAttribute("empDayoff", empDayoff);
	    model.addAttribute("empBase", empBase);
	    model.addAttribute("loginId", loginId);
	    return "/emp/dayoffById";
	}	
}