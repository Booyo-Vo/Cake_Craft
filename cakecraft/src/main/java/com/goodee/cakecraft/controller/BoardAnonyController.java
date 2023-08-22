package com.goodee.cakecraft.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.BoardAnonyService;
import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.EmpIdList;

@Controller
public class BoardAnonyController {
	@Autowired BoardAnonyService anonyService;
	
	// 익명게시판 목록 조회 
	@GetMapping("/board/anonyList")
	public String anonyList(Model model, HttpSession session,
							@RequestParam(name = "searchWord", defaultValue = "") String searchWord) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 익명게시판 목록 가져오기	
		Map<String, Object> resultMap = anonyService.getAnonyList(searchWord);
		
		model.addAttribute("loginId",loginId);
		model.addAttribute("anonyList",resultMap.get("anonyList"));
		
		return "/board/anonyList";
	}
	
	// 게시글 상세 정보 조회
	@GetMapping("/board/anonyByNo")
	public String anonyByNo(Model model, HttpSession session, BoardAnony anony) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 게시글 상세정보 가져오기	
		BoardAnony anonyByNo = anonyService.getAnonyByNo(anony);

		model.addAttribute("loginId",loginId);
		model.addAttribute("anonyByNo", anonyByNo);
		
		return "/board/anonyByNo";
	}
	
	// 게시글 추가
	@GetMapping("/board/addAnony")
	public String addAnony(Model model, HttpSession session) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		model.addAttribute("loginId",loginId);
		
		return "/board/addAnony";
	}
	
	@PostMapping("/board/addAnony")
	public String addAnony(BoardAnony anony) {
		
		anonyService.addAnony(anony);
		
		return "redirect:/board/anonyList";
	}
	
	// 게시글 수정
	@GetMapping("/board/modifyAnony")
	public String modifyAnony(Model model, HttpSession session, BoardAnony anony) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 게시글 상세정보 가져오기
		BoardAnony anonyByNo = anonyService.getAnonyByNo(anony);
		
		model.addAttribute("loginId",loginId);
		model.addAttribute("anonyByNo", anonyByNo);
		
		return "/board/modifyAnony";
	}
	
	@PostMapping("/board/modifyAnony")
	public String modifyAnony(BoardAnony anony) {
		
		anonyService.modifyAnony(anony);
		
		return "redirect:/board/anonyList";
	}
	
	// 게시글 삭제
	@GetMapping("/board/removeAnony")
	public String removeAnony(BoardAnony anony) {
		
		anonyService.removeAnony(anony);
		
		return "redirect:/board/anonyList";
	}
		
}
