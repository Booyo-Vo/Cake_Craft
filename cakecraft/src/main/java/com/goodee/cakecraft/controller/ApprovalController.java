package com.goodee.cakecraft.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
	// 본인이 기안한 결재문서 목록 view
	@GetMapping("/approval/approvalDocumentListById")
	public String approvalDocumentListById(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		List<ApprovalDocument> apprDocListById = approvalService.getApprDocListById(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListById", apprDocListById);
		log.debug(SHJ + "apprDocListById : " + apprDocListById + RESET);
		return "/approval/approvalDocumentListById";
	}
	
	// 결재자로 지정된 문서 목록 view
	@GetMapping("/approval/approvalDocumentListByApprId")
	public String approvalDocumentListByApprId(HttpSession session, Model model) {		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		List<ApprovalDocument> apprDocListByApprId = approvalService.getApprDocListByApprId(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListByApprId", apprDocListByApprId);
		log.debug(SHJ + "apprDocListByApprId : " + apprDocListByApprId + RESET);
		return "/approval/approvalDocumentListByApprId";
	}
	
	// 참조자로 지정된 문서 목록 view
	@GetMapping("/approval/approvalDocumentListByRefId")
	public String approvalDocumentListByRefId(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();

		List<ApprovalDocument> apprDocListByRefId = approvalService.getApprDocListByRefId(loginId);
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocListByRefId", apprDocListByRefId);
		log.debug(SHJ + "apprDocListByRefId : " + apprDocListByRefId + RESET);
		return "/approval/approvalDocumentListByRefId";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}