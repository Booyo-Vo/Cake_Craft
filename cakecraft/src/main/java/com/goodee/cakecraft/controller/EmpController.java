package com.goodee.cakecraft.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.service.EmpService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.EmpProfileImg;
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
	
	//사원리스트 출력
	@GetMapping("/emp/empList")
 	public String empList(Model model,
 							HttpSession session,
 							@RequestParam(name="searchWord", defaultValue ="")String searchWord) {
		//세션 로그인 아이디 가져오기
		Object o = session.getAttribute("loginMember");
	    String loginId = "";

	    if (o instanceof EmpIdList) {
	        loginId = ((EmpIdList) o).getId();
	        log.debug(KMS + "loginId EmpController" + loginId + RESET);
	    }

	    //EmpBase empBase = empService.getMyEmpById(loginId);
		
		//익명게시판 목록 가져오기
		List<EmpBase> empList = empService.getEmpList(searchWord);
		model.addAttribute("empList", empList);
		
		model.addAttribute("loginId", loginId);
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
	public String modifyMyEmp(HttpSession session, Model model) {
		Object o = session.getAttribute("loginMember");
	    String loginId = "";

	    if (o instanceof EmpIdList) {
	        loginId = ((EmpIdList) o).getId();
	        log.debug(KMS + "loginId EmpController" + loginId + RESET);
	    }

	    //사원상세내역
	    EmpBase empBase = empService.getMyEmpById(loginId);

	    Map<String, Object> allAttributes = new HashMap<>();
	    allAttributes.put("empBase", empBase);
	    allAttributes.put("loginId", loginId);
	    log.debug(KMS + "loginId / EmpController"+ loginId + RESET);
	    log.debug(KMS + "empBase / EmpController"+ empBase + RESET);
	    model.addAllAttributes(allAttributes);
			
		return "/emp/modifyMyEmp";
	}

	
	// 사원정보 수정 액션
	@PostMapping("/emp/modifyMyEmp")
	public String modifyMyEmp(HttpSession session, HttpServletRequest request, EmpBase empBase, @RequestParam("profileImage") MultipartFile profileImage) {
	    // 세션에 저장된 로그인 아이디를 받아옴
	    EmpIdList loginMember = (EmpIdList) session.getAttribute("loginMember");
	    String loginId = loginMember.getId();
	    log.debug(KMS + loginId + "<- addEmp loginId" + RESET);

	    // empbase에 수정자 아이디 담기
	    empBase.setId(loginId);

	    String path = request.getServletContext().getRealPath("/profileImg/");
	    log.debug(KMS + path + "<--path / EmpController" + RESET);

	    // 파일 저장(저장위치 필요 -> path변수)
	    // path위치에 저장할 파일 이름 생성
	    String profileFilename = loginId + ".jpg"; // 로그인 아이디를 기반으로 파일 이름 생성
	    File f = new File(path + profileFilename);
	    // 빈파일에 첨부된 파일의 스트림을 주입한다.
	    try {
	        profileImage.transferTo(f); // 스트림 주입 메서드
	    } catch (IllegalStateException | IOException e) {
	        e.printStackTrace();
	        throw new RuntimeException();
	    }
	    // 사원 정보 수정
	    empService.modifyMyEmp(empBase, path);

	    return "redirect:/emp/myPage?id=" + empBase.getId();
	}
	
	@Autowired EmpMapper empMapper;
	// 비밀번호 변경 액션
    @PostMapping("/emp/changePw")
    public String changePassword(HttpSession session,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 Model model) {
        Object o = session.getAttribute("loginMember");
        String loginId = "";

        if (o instanceof EmpIdList) {
            loginId = ((EmpIdList) o).getId();
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "/emp/modifyMyEmp";
        }

        // 비밀번호 변경 메서드 호출
        empMapper.changePassword(loginId, newPassword);

        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "/emp/myPage";
    }

	
}
