package com.goodee.cakecraft.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.EmpService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.EmpSignImg;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EmpController {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m";
	
	@Autowired
	private EmpService empService;
	
	@Autowired
	private StStdCdService stStdCdService;
	
	//마이페이지 출력
	@GetMapping("/emp/myPage")
	public String EmpOne(HttpSession session, Model model) {
	    Object o = session.getAttribute("loginMember");
	    String loginId = "";

	    if (o instanceof EmpIdList) {
	        loginId = ((EmpIdList) o).getId();
	        log.debug(KMS + "loginId EmpController" + loginId + RESET);
	    }

	    EmpBase empBase = empService.getMyEmpById(loginId);

	    Map<String, Object> allAttributes = new HashMap<>();
	    allAttributes.put("empBase", empBase);
	    allAttributes.put("loginId", loginId);

	    model.addAllAttributes(allAttributes);
	    return "/emp/myPage";
	}
	
	//사원리스트 출력
	@GetMapping("/emp/empList")
 	public String empList(Model model) {
		List<EmpBase> empList = empService.getEmpList();
		
		
		model.addAttribute("empList", empList);
		return "/emp/empList";
		
	}
	
	//사원상세내역 출력
	
	@GetMapping("/emp/empById")
 	public String adminEmpList(Model model,
 								@RequestParam String id) {
	EmpBase empbase = empService.getEmpById(id); 
	
	//뷰로 값넘기기
	model.addAttribute("empbase", empbase);
	return "/emp/empById";
}
}
	

