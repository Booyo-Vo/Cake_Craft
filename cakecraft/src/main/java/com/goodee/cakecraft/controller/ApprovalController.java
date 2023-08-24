package com.goodee.cakecraft.controller;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
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
		
		// 제출하기 버튼을 눌러서 제출된 문서만 출력
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
	
	
	// 결재문서 상세보기
	@GetMapping("/approval/apprDocByNo")
	public String apprDocByNo(
					HttpSession session,
					Model model,
					@RequestParam("documentNo") String documentNo) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 결재문서 상세내역 받아오기
		ApprovalDocument apprDoc = approvalService.getApprDocByNo(documentNo);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDoc",apprDoc);
		log.debug(SHJ + apprDoc + " <-- apprDoc" + RESET);
		return "/approval/apprDocByNo";
	}
		
	
	// 결재문서 추가 폼
	@GetMapping("/approval/addApprDoc")
	public String addApprDoc(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		
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
