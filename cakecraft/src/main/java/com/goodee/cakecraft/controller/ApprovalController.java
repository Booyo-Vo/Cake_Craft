package com.goodee.cakecraft.controller;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.util.ParameterMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.ApprovalService;
import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalHistory;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ApprovalController {
	@Autowired ApprovalService approvalService;
	
	// ANSI 코드
	final String SHJ = "\u001B[46m";
	final String RESET = "\u001B[0m";
	
	// 기안문서 목록
	@GetMapping("/approval/apprDocListById")
	public String approvalDocumentListById(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 제출완료된 문서만 출력
		String tempSave = "N";
		
		List<ApprovalDocument> apprDocListById = approvalService.getApprDocListById(loginId, tempSave);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListById", apprDocListById);
		log.debug(SHJ + apprDocListById + " <-- apprDocListById" + RESET);
		return "/approval/apprDocListById";
	}
	
	
	// 임시저장 문서 목록
	@GetMapping("/approval/apprDocListByIdTempY")
	public String approvalDocumentListByIdTempY(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 임시저장된 문서만 출력
		String tempSave = "Y";
		
		List<ApprovalDocument> apprDocListByIdTempY = approvalService.getApprDocListByIdTempY(loginId, tempSave);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListByIdTempY", apprDocListByIdTempY);
		log.debug(SHJ + apprDocListByIdTempY + " <-- apprDocListByIdTempY" + RESET);
		return "/approval/apprDocListByIdTempY";
	}
	
	
	// 결재자로 지정된 문서 목록
	@GetMapping("/approval/apprDocListByApprId")
	public String approvalDocumentListByApprId(HttpSession session, Model model) {		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		List<ApprovalDocument> apprDocListByApprId = approvalService.getApprDocListByApprId(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListByApprId", apprDocListByApprId);
		log.debug(SHJ + apprDocListByApprId + " <-- apprDocListByApprId" + RESET);
		return "/approval/apprDocListByApprId";
	}
	
	
	// 결재자가 승인해야 할 문서 목록 출력
	@GetMapping("/approval/apprDocWaitListByNo")
	public String apprDocWaitListByNo(HttpSession session, Model model) {		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		Map<String, Object> apprDocWaitMap = approvalService.getApprDocWaitNoMap(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocList", apprDocWaitMap.get("apprDocList"));
		log.debug(SHJ + apprDocWaitMap + " <-- apprDocWaitMap" + RESET);
		return "/approval/apprDocWaitListByNo";
	}
	
	
	// 참조자로 지정된 문서 목록
	@GetMapping("/approval/apprDocListByRefId")
	public String approvalDocumentListByRefId(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();

		List<ApprovalDocument> apprDocListByRefId = approvalService.getApprDocListByRefId(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListByRefId", apprDocListByRefId);
		log.debug(SHJ + apprDocListByRefId + " <-- apprDocListByRefId" + RESET);
		return "/approval/apprDocListByRefId";
	}
	
	
	// 결재문서 상세보기 (결재대기문서, 결재수신문서, 기안문서)
	@GetMapping("/approval/apprDocByNo")
	public String apprDocByNo(
					HttpSession session,
					Model model,
					@RequestParam("documentNo") String documentNo) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 결재문서 정보 및 상세 이력 받아오기
		Map<String, Object> resultApprMap = approvalService.getApprDocByNo(documentNo, loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDoc", resultApprMap.get("resultApprDoc"));
		model.addAttribute("apprHist", resultApprMap.get("resultApprHist"));
		model.addAttribute("apprHistPreLv", resultApprMap.get("resultApprHistPreLv"));
		
		return "/approval/apprDocByNo";
	}
	
	// 문서정보 상세보기 (임시저장, 참조문서)
	@GetMapping("/approval/apprDocInfoByNo")
	public String apprDocInfoByNo(HttpSession session, Model model,
					@RequestParam String documentNo) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 문서정보 받아오기
		ApprovalDocument apprDoc = approvalService.getApprDocInfoByNo(documentNo);
		
		// 뷰로 값넘기기
		model.addAttribute("apprDoc", apprDoc);
		model.addAttribute("loginId", loginId);
		return "/approval/apprDocInfoByNo";
	}
	
	// 결재문서 추가 폼
	@GetMapping("/approval/addApprDoc")
	public String addApprDoc(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 현재 날짜 가져오기
		LocalDate currentDate = LocalDate.now();
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("currentDate", currentDate);
		
		return "/approval/addApprDoc";
	}
	
	
	// 결재문서 추가 액션
	@PostMapping("/approval/addApprDoc")
	public String addApprDoc(HttpServletRequest request,
				            HttpSession session) {
			
		HashMap<String, Object> param = new HashMap<>();
		param = CommonController.getParameterMap(request);
		log.debug(SHJ + param.get("approvalDocumentNm").toString() + " <-- addApprDoc approvalDocumentNm"+ RESET);
		log.debug(SHJ + param.get("documentContent").toString() + " <-- addApprDoc documentContent"+ RESET);
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		approvalService.addApprDoc(param, loginId);
		
		return "redirect:/approval/apprDocListByApprId";
	}
	
}
