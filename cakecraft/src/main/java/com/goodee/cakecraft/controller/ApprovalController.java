package com.goodee.cakecraft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.goodee.cakecraft.service.ApprovalService;
import com.goodee.cakecraft.vo.ApprovalDocument;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ApprovalController {
	@Autowired ApprovalService approvalService;
	// ANSI 코드
	final String SHJ = "\u001B[46m";
	final String RESET = "\u001B[0m";
	
	// 본인이 기안한 결재문서 리스트 view
	@GetMapping("/approval/approvalDocumentList")
	public String approvalDocumentList(Model model) {
		// Map<String, Object>paramMap = new HashMap<>();
		List<ApprovalDocument> apprDocList = approvalService.getApprDocListByPage();
		
		String loginId = "232211558";
		/*
			Object o = session.getAttribute("loginId");
			if(o instanceof String) {
				loginId = (String)o;
			}
		*/
		
		// 뷰로 값넘기기
		model.addAttribute("loginId", loginId);
		model.addAttribute("apprDocList", apprDocList);
		log.debug(SHJ + "apprDocList : " + apprDocList + RESET);
		return "/approval/approvalDocumentList";
	}
}
