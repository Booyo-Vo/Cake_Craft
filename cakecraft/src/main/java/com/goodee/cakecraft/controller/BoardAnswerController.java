package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.cakecraft.service.BoardAnswerService;
import com.goodee.cakecraft.vo.BoardAnswer;

@Controller
public class BoardAnswerController {
	@Autowired BoardAnswerService answerService;
	
	// 답변 추가
	@PostMapping("/board/addAnswer")
	public String addAnswer(BoardAnswer answer) {
		
		answerService.addAnswer(answer);
		
		return "redirect:/board/questionByNo?questionNo="+answer.getQuestionNo();
	}
	
	// 답변 수정
	@PostMapping("/board/modifyAnswer")
	public String modifyAnswer(BoardAnswer answer) {
		
		answerService.modifyAnswer(answer);
		
		return "redirect:/board/questionByNo?questionNo="+answer.getQuestionNo();
	}
}
