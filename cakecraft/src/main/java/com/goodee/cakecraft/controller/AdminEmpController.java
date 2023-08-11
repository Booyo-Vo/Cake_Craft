package com.goodee.cakecraft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.vo.EmpBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminEmpController {
	@Autowired
	private AdminEmpService adminempService;
	// 사원추가 폼
	@GetMapping("/emp/addEmp")
		public String addEmp() {
		return "/emp/addEmp";
	}
	// 사원추가 액션
	@PostMapping("/emp/addEmp")
		public String addEmp(EmpBase empbase) {
		int addEmprow = adminempService.addEmp(empbase);
		log.debug("addEmprow :"+addEmprow);
		return "redirect:/emp/adminEmpList";
	}
	
	// 관리자가 보는 사원리스트 출력
	@GetMapping("/emp/adminEmpList")
	 	public String adminEmpList() {
		List<EmpBase> adminEmpList = adminempService.getEmpList();
		return "redirect:/emp/adminEmpList";
	}
}

