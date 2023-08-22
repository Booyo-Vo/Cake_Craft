package com.goodee.cakecraft.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.CommonService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminEmpController {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private AdminEmpService adminEmpService;
	@Autowired 
	private StStdCdService stStdCdService;
	@Autowired 
	private CommonService commonService;
	
	// 사원추가 폼
	@GetMapping("/emp/addEmp")
		public String addEmp(HttpSession session, Model model) {
		//부서 팀 직급 추가를 위한 선택 리스트를 나열하기 위해서
		String deptCode = "D001";
	    String teamCode = "T001";
	    String positionCode = "P001";
		// 부서, 팀, 직급 리스트에서 설정할 수 있게 각각 가져옴
	    List<StStdCd> deptList = stStdCdService.getCdList(deptCode);
	    List<StStdCd> teamList = stStdCdService.getCdList(teamCode);
	    List<StStdCd> positionList = stStdCdService.getCdList(positionCode);
	    
	    //세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
	    
		//뷰로 값넘기기
		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("positionList",positionList);
		model.addAttribute("loginId",loginId);
		return "/emp/addEmp";
	}
	// 사원추가 액션
	@PostMapping("/emp/addEmp")
		public String addEmp(HttpSession session, EmpBase empbase) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		//empbase에 로그인된 아이디 담기
		empbase.setModId(loginId);
		empbase.setRegId(loginId);
		
		int addEmprow = adminEmpService.addEmp(empbase);
		log.debug(LJY +"addEmprow :" + addEmprow +RESET);
		return "redirect:/emp/adminEmpList";
	}
	
	// 관리자가 보는 사원리스트 출력
	@GetMapping("/emp/adminEmpList")
	 	public String adminEmpList(HttpSession session, Model model) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		//사원리스트 받아오기
		List<EmpBase> adminEmpList = adminEmpService.getEmpList();
		
		//뷰로 값넘기기
		model.addAttribute("adminEmpList", adminEmpList);
		model.addAttribute("loginId", loginId);
		return "/emp/adminEmpList";
	}
	
	// 관리자가 보는 사원상세내역 출력
	@GetMapping("/emp/adminEmpById")
	 	public String adminEmpById(HttpSession session, Model model,
	 							@RequestParam String id) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		//사원상세내역 받아오기
		EmpBase empbase = adminEmpService.getAdminEmpById(id); 
		
		//뷰로 값넘기기
		model.addAttribute("empbase", empbase);
		model.addAttribute("loginId", loginId);
		return "/emp/adminEmpById";
	}
	
	// 관리자가 하는 사원수정폼
	@GetMapping("/emp/modifyEmp")
		public String modifyEmp(HttpSession session, Model model,
							@RequestParam String id) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		//사원상세내역을 받아옴
		EmpBase empbase = adminEmpService.getAdminEmpById(id); 
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
		model.addAttribute("loginId",loginId);
		return "/emp/modifyEmp";
	}
	
	// 관리자가 하는 사원수정액션
	@PostMapping("/emp/modifyEmp")
		public String modifyEmp(HttpSession session, EmpBase empbase) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		//empbase에 수정자 아이디 담기
		empbase.setModId(loginId);
		
		
		int modifyEmpRow = adminEmpService.modifyEmp(empbase);
		log.debug(LJY + modifyEmpRow + "<- modifyEmpRow"+ RESET);
		return "redirect:/emp/adminEmpById?id=" + empbase.getId();
	}
	
	//증명서 출력
	@GetMapping("/emp/certificate")
	public String certificate(HttpSession session, Model model,
							@RequestParam String id) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		//사원상세내역
		EmpBase empbase = adminEmpService.getAdminEmpById(id); 
		
		//부서 이름 받아오기
		String deptGrpcd = "D001";
		String deptCd = empbase.getDeptCd();
		String deptNm = commonService.getName(deptGrpcd, deptCd);
		log.debug(LJY + deptNm + "<- certificate deptNm"+ RESET);
		
		//팀 이름 받아오기
		String teamGrpcd = "T001";
		String teamCd = empbase.getTeamCd();
		String teamNm = commonService.getName(teamGrpcd, teamCd);
		log.debug(LJY + teamNm + "<- certificate teamNm"+ RESET);
		
		//직급 이름 받아오기
		String positionGrpcd = "P001";
		String positionCd = empbase.getPositionCd();
		String positionNm = commonService.getName(positionGrpcd, positionCd);
		log.debug(LJY + positionNm + "<- certificate positionNm"+ RESET);
		
		empbase.setDeptNm(deptNm);
		empbase.setTeamNm(teamNm);
		empbase.setPositionNm(positionNm);
		
	    // 현재 날짜 가져오기
        LocalDate currentDate = LocalDate.now();
		
		//뷰로 값넘기기
        model.addAttribute("empbase", empbase);
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("loginId", loginId);
	    return "/emp/certificate";
	}
		
}

