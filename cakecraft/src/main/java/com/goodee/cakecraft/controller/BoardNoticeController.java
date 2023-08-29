package com.goodee.cakecraft.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.BoardNoticeService;
import com.goodee.cakecraft.service.EmpService;
import com.goodee.cakecraft.vo.BoardNotice;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;

@Controller
public class BoardNoticeController {
	@Autowired BoardNoticeService noticeService;
	@Autowired EmpService empService;
	// 공지 목록 조회 
	@GetMapping("/board/noticeList")
	public String noticeList(Model model, HttpSession session,
							@RequestParam(name = "searchRegId", defaultValue = "") String searchRegId,
							@RequestParam(name = "searchWord", defaultValue = "") String searchWord) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 로그인한 사원 정보 가져오기
		EmpBase empBase = empService.getEmpById(loginId);
		
		// 공지목록 가져오기
		Map<String, Object> resultMap = noticeService.getNoticeList(searchRegId, searchWord);
		
		model.addAttribute("loginId",loginId);
		model.addAttribute("empBase",empBase);
		model.addAttribute("noticeList",resultMap.get("noticeList"));
		
		return "/board/noticeList";
	}
	
	// 공지 추가
	@GetMapping("/board/addNotice")
	public String addNotice(Model model, HttpSession session) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		model.addAttribute("loginId",loginId);
		
		return "/board/addNotice";
	}
	
	@PostMapping("/board/addNotice")
	public String addNotice(BoardNotice notice) {
		
		noticeService.addNotice(notice);
		
		return "redirect:/board/noticeList";
	}
	
	// 공지 수정
	@GetMapping("/board/modifyNotice")
	public String modifyNotice(Model model, HttpSession session, BoardNotice notice) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 공지 상세정보 가져오기
		BoardNotice noticeByNo = noticeService.getNoticeByNo(notice);

		model.addAttribute("loginId",loginId);
		model.addAttribute("noticeByNo", noticeByNo);
		
		return "/board/modifyNotice";
	}
	
	@PostMapping("/board/modifyNotice")
	public String modifyNotice(BoardNotice notice) {
		
		noticeService.modifyNotice(notice);
		
		return "redirect:/board/noticeList";
	}
	
	// 공지 삭제
	@GetMapping("/board/removeNotice")
	public String removeNotice(BoardNotice notice) {
		
		noticeService.removeNotice(notice);
		
		return "redirect:/board/noticeList";
	}
	
	// 공지 상세 정보 조회
	@GetMapping("/board/noticeByNo")
	public String noticeByNo(Model model, HttpSession session, BoardNotice notice) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 공지 상세정보 가져오기
		BoardNotice noticeByNo = noticeService.getNoticeByNo(notice);

		model.addAttribute("loginId",loginId);
		model.addAttribute("noticeByNo",noticeByNo);
		
		return "/board/noticeByNo";
	}
}
