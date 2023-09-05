package com.goodee.cakecraft.controller;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDate;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.goodee.cakecraft.service.ApprovalService;
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalHistory;
import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardNotice;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ApprovalController {
	@Autowired ApprovalService approvalService;
	@Autowired StStdCdService stStdCdService;
	
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
	
	
	// 결재문서 상세보기
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
		if (resultApprMap.get("resultApprHist") != null) {
		model.addAttribute("apprHist", resultApprMap.get("resultApprHist"));
		model.addAttribute("apprHistPreLv", resultApprMap.get("resultApprHistPreLv"));
		}
		model.addAttribute("apprRef", resultApprMap.get("resultApprRef"));
		model.addAttribute("apprInfoLv1", resultApprMap.get("resultApprInfoLv1"));
		model.addAttribute("apprInfoLv2", resultApprMap.get("resultApprInfoLv2"));
		model.addAttribute("apprInfoLv3", resultApprMap.get("resultApprInfoLv3"));
		model.addAttribute("apprFileList", resultApprMap.get("resultApprFileList"));
		model.addAttribute("documentNo", documentNo);
		
		return "/approval/apprDocByNo";
	}

	
	// 결재 이력 수정
	@PostMapping("/approval/modifyApprHist")
	public String modifyApprHistAccept(ApprovalHistory apprHistory) {
		
		approvalService.modifyApprHistory(apprHistory);
		
		return "redirect:/approval/apprDocListByApprId";
	}
	
	
	// 결재문서 추가 폼
	@GetMapping("/approval/addApprDoc")
	public String addApprDoc(HttpSession session, Model model) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 문서구분, 항목구분 리스트 각각 가져오기
		String doctCode = "A002";
		String docSubCode = "A003";
		List<StStdCd> docCodeList = stStdCdService.getCdList(doctCode);
		List<StStdCd> docSubCodeList = stStdCdService.getCdList(docSubCode);		
		
		// 현재 날짜 가져오기
		LocalDate currentDate = LocalDate.now();
		
		// 뷰로 값넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("docCodeList", docCodeList);
		model.addAttribute("docSubCodeList", docSubCodeList);
		model.addAttribute("currentDate", currentDate);
		
		return "/approval/addApprDoc";
	}
	
	// 결재문서 추가 액션
	@PostMapping("/approval/addApprDoc")
	public String addApprDoc(HttpServletRequest request,
				            HttpSession session,
				            ApprovalFile approvalfile) {
			
		HashMap<String, Object> param = new HashMap<>();
		param = CommonController.getParameterMap(request);
		log.debug(SHJ + param.get("documentNm").toString() + " <-- addApprDoc documentNm"+ RESET);
		log.debug(SHJ + param.get("documentSubNm").toString() + " <-- addApprDoc documentSubNm"+ RESET);
		log.debug(SHJ + param.get("documentContent").toString() + " <-- addApprDoc documentContent"+ RESET);
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		String path = request.getServletContext().getRealPath("/apprupload/");
	
		log.debug(SHJ + approvalfile + " <-- addApprDoc approvalfile"+ RESET);
		
		param.put("path", path);
		approvalService.addApprDoc(param, loginId, approvalfile);
		
		return "redirect:/approval/apprDocListById";
	}
	
	
	// 임시저장 문서 수정 폼
	@GetMapping("/approval/modifyApprDoc")
	public String modifyNotice(
					HttpSession session,
					Model model,
					@RequestParam("documentNo") String documentNo) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 임시저장 문서 상세정보 가져오기
		ApprovalDocument resultApprDocTempY = approvalService.getApprDocByNoTempY(documentNo);
		
		// 문서구분, 항목구분 리스트 각각 가져오기
		String doctCode = "A002";
		String docSubCode = "A003";
		List<StStdCd> docCodeList = stStdCdService.getCdList(doctCode);
		List<StStdCd> docSubCodeList = stStdCdService.getCdList(docSubCode);		
		
		// 현재 날짜 가져오기
		LocalDate currentDate = LocalDate.now();
		
		// 뷰로 값 넘기기
		model.addAttribute("loginId",loginId);
		model.addAttribute("apprDocByNo", resultApprDocTempY);
		model.addAttribute("docCodeList", docCodeList);
		model.addAttribute("docSubCodeList", docSubCodeList);
		model.addAttribute("currentDate", currentDate);
		
		return "/approval/modifyApprDoc";
	}
	
	// 임시저장 문서 수정 액션
	@PostMapping("/approval/modifyApprDoc")
	public String modifyApprDocTempY(ApprovalDocument apprDoc) {
		log.debug(SHJ + apprDoc + " <-- addApprDoc apprDoc"+ RESET);
		approvalService.modifyApprDocTempY(apprDoc);
		
		return "redirect:/approval/apprDocListByIdTempY";
	}
	
	// 임시저장 문서 삭제
	@GetMapping("/approval/removeApprDoc")
	public String removeApprDocTempY(ApprovalDocument apprDoc) {
		
		approvalService.removeApprDocTempY(apprDoc);
		
		return "/approval/apprDocListByIdTempY";
	}
}
