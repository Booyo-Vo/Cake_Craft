package com.goodee.cakecraft.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.BoardQuestionService;
import com.goodee.cakecraft.vo.BoardQuestion;
import com.goodee.cakecraft.vo.EmpIdList;

@Controller
public class BoardQuestionController {
	@Autowired BoardQuestionService questionService;
	
	// 문의 목록 조회 
	@GetMapping("/board/questionList")
	public String questionList(Model model, HttpSession session,
							@RequestParam(name = "searchRegId", defaultValue = "") String searchRegId,
							@RequestParam(name = "searchWord", defaultValue = "") String searchWord) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 문의목록 가져오기
		Map<String, Object> resultMap = questionService.getQuestionList(searchRegId, searchWord);
		
		model.addAttribute("loginId",loginId);
		model.addAttribute("questionList",resultMap.get("questionList"));
		
		return "/board/questionList";
	}
	
	// 문의 상세 조회
	@GetMapping("/board/questionByNo")
	public String questionByNo(Model model, HttpSession session, BoardQuestion question) {
		
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 문의 상세정보, 답변 가져오기
		Map<String, Object> resultMap = questionService.getQuestionByNo(question);

		model.addAttribute("loginId",loginId);
		model.addAttribute("questionByNo",resultMap.get("questionByNo"));
		model.addAttribute("answerByNo",resultMap.get("answerByNo"));
		
		return "/board/questionByNo";
	}
	
	// 문의 추가
	@GetMapping("/board/addQuestion")
	public String addQuestion(Model model, HttpSession session) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		model.addAttribute("loginId",loginId);
		
		return "/board/addQuestion";
	}
	
	@PostMapping("/board/addQuestion")
	public String addQuestion(BoardQuestion question) {
		
		questionService.addQuestion(question);
		
		return "redirect:/board/questionList";
	}
	
	// 문의 수정
	@GetMapping("/board/modifyQuestion")
	public String modifyQuestion(Model model, HttpSession session, BoardQuestion question) {
		// 세션에서 로그인 된 loginId 추출
		EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		
		// 문의 상세정보 가져오기
		Map<String, Object> resultMap = questionService.getQuestionByNo(question);

		model.addAttribute("loginId",loginId);
		model.addAttribute("questionByNo", resultMap.get("questionByNo"));
		
		return "/board/modifyQuestion";
	}
	
	@PostMapping("/board/modifyQuestion")
	public String modifyQuestion(BoardQuestion question) {
		
		questionService.modifyQuestion(question);
		
		return "redirect:/board/questionByNo?questionNo="+question.getQuestionNo();
	}
	
	// 문의 삭제
	@GetMapping("/board/removeQuestion")
	public String removeQuestion(BoardQuestion question) {
		
		questionService.removeQuestion(question);
		
		return "redirect:/board/questionList";
	}
}
