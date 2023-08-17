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
import com.goodee.cakecraft.vo.BoardNotice;
import com.goodee.cakecraft.vo.EmpIdList;

@Controller
public class BoardNoticeController {
	@Autowired BoardNoticeService noticeService;
	
	@GetMapping("/board/noticeList")
	public String noticeList(Model model,
							@RequestParam(name = "searchRegId", defaultValue = "") String searchRegId,
							@RequestParam(name = "searchWord", defaultValue = "") String searchWord) {
		
		// 공지 목록 조회 
		Map<String, Object> resultMap = noticeService.getNoticeList(searchRegId, searchWord);
		
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
	public String addNotice(@RequestParam(name="id") String id,
							@RequestParam(name="noticeTitle") String noticeTitle,
							@RequestParam(name="noticeContent") String noticeContent) {
		
		BoardNotice notice = new BoardNotice();
		notice.setId(id);
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);
		
		noticeService.addNotice(notice);
		
		return "redirect:/board/noticeList";
	}
	
}
