package com.goodee.cakecraft.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.service.EmpService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.EmpSignImg;
import com.goodee.cakecraft.vo.StStdCd;

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
	    log.debug(KMS + "loginId / EmpController"+ loginId + RESET);
	    log.debug(KMS + "empBase / EmpController"+ empBase + RESET);
	    model.addAllAttributes(allAttributes);
	    return "/emp/myPage";
	}
	
	//마이페이지 프로필사진 업로드
	@PostMapping("emp/myPage")
	public String uploadProfileImage(@RequestParam("file") MultipartFile file, HttpSession session) {
	    Object o = session.getAttribute("loginMember");
	    String loginId = "";

	    if (o instanceof EmpIdList) {
	        loginId = ((EmpIdList) o).getId();
	    }

	    try {
	        String fileName = empService.uploadProfileImage(file, loginId);
	        String filePath = "/profileImg/profile.jpg" + File.separator + fileName;
	        empService.updateProfileImagePath(loginId, filePath);
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 처리 중 에러 발생 시 예외 처리
	    }

	    return "redirect:/cakecraft/emp/myPage";
	}
	//마이페이지 서명 출력
	
	
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
	
		model.addAttribute("empbase", empbase);
		return "/emp/empById";
		}
	
	//사원정보 수정폼
	@GetMapping("/emp/modifyMyEmp")
	public String modifyEmp(HttpSession session, Model model) {
		Object o = session.getAttribute("loginMember");
	    String loginId = "";

	    if (o instanceof EmpIdList) {
	        loginId = ((EmpIdList) o).getId();
	        log.debug(KMS + "loginId EmpController" + loginId + RESET);
	    }

	    EmpBase empBase = empService.getMyEmpById(loginId);

		//부서 팀 직급 수정을 위한 선택 리스트를 나열하기 위해서
		String deptCode = "D001";
		String teamCode = "T001";
		String positionCode = "P001";
		// 부서, 팀, 직급 리스트에서 설정할 수 있게 각각 가져옴
		List<StStdCd> deptList = stStdCdService.getCdList(deptCode);
		List<StStdCd> teamList = stStdCdService.getCdList(teamCode);
		List<StStdCd> positionList = stStdCdService.getCdList(positionCode);
		//뷰로 값넘기기
		model.addAttribute("empbase", empBase);
		model.addAttribute("deptList", deptList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("positionList",positionList);
	return "/emp/modifyMyEmp";
	}
	
	//사원정보 수정 액션
	@PostMapping("/emp/modifyMyEmp")
	public String modifyEmp(HttpSession session, EmpBase empbase) {
	//세선에 저장된 로그인 아이디를 받아옴
	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
	String loginId = loginMember.getId();
	log.debug(KMS + "addEmp loginId :"+loginId + RESET);
	//empbase에 수정자 아이디 담기
	empbase.setModId(loginId);
	
	
	int modifyEmpRow = empService.modifyMyEmp(empbase);
	log.debug(KMS + "modifyEmpRow :"+modifyEmpRow + RESET);
	return "redirect:/emp/adminEmpById?id=" + empbase.getId();
}
}
	

