package com.goodee.cakecraft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminEmpController {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private AdminEmpService adminempService;
	@Autowired 
	private StStdCdService stStdCdService;
	
	// 사원추가 폼
	@GetMapping("/emp/addEmp")
		public String addEmp(Model model) {
		//부서 팀 직급 추가를 위한 선택 리스트를 나열하기 위해서
		String deptCode = "D001";
	    String teamCode = "T001";
	    String positionCode = "P001";
		// 부서, 팀, 직급 리스트에서 설정할 수 있게 각각 가져옴
	    List<StStdCd> deptList = stStdCdService.getCdList(deptCode);
	    List<StStdCd> teamList = stStdCdService.getCdList(teamCode);
	    List<StStdCd> positionList = stStdCdService.getCdList(positionCode);
		//뷰로 값넘기기
		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("positionList",positionList);		
		return "/emp/addEmp";
	}
	// 사원추가 액션
	@PostMapping("/emp/addEmp")
		public String addEmp(EmpBase empbase) {
		int addEmprow = adminempService.addEmp(empbase);
		log.debug(GREEN +"addEmprow :" + addEmprow +RESET);
		return "redirect:/emp/adminEmpList";
	}
	
	// 관리자가 보는 사원리스트 출력
	@GetMapping("/emp/adminEmpList")
	 	public String adminEmpList(Model model) {
		List<EmpBase> adminEmpList = adminempService.getEmpList();
		
		//뷰로 값넘기기
		model.addAttribute("adminEmpList", adminEmpList);
		return "/emp/adminEmpList";
	}
	
	// 관리자가 보는 사원상세내역 출력
	@GetMapping("/emp/adminEmpById")
	 	public String adminEmpList(Model model,
	 								@RequestParam String id) {
		EmpBase empbase = adminempService.getAdminEmpById(id); 
		
		//뷰로 값넘기기
		model.addAttribute("empbase", empbase);
		return "/emp/adminEmpById";
	}
	
	// 관리자가 하는 사원수정폼
	@GetMapping("/emp/modifyEmp")
		public String modifyEmp(Model model,
					@RequestParam String id) {
		EmpBase empbase = adminempService.getAdminEmpById(id); 
		//부서 팀 직급 수정을 위한 선택 리스트를 나열하기 위해서
		String deptCode = "D001";
	    String teamCode = "T001";
	    String positionCode = "P001";
	    // 부서, 팀, 직급 리스트에서 설정할 수 있게 각각 가져옴
	    List<StStdCd> deptList = stStdCdService.getCdList(deptCode);
	    List<StStdCd> teamList = stStdCdService.getCdList(teamCode);
	    List<StStdCd> positionList = stStdCdService.getCdList(positionCode);
		//뷰로 값넘기기
		model.addAttribute("empbase", empbase);
		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("positionList",positionList);
		return "/emp/modifyEmp";
	}
	
	// 관리자가 하는 사원수정액션
	@PostMapping("/emp/modifyEmp")
		public String modifyEmp(EmpBase empbase) {
		int modifyEmpRow = adminempService.modifyEmp(empbase);
		log.debug(GREEN + "modifyEmpRow :"+modifyEmpRow + RESET);
		return "redirect:/emp/adminEmpById?id=" + empbase.getId();
	}
	
		
}

