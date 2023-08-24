package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.cakecraft.service.BoardCommentsService;
import com.goodee.cakecraft.vo.BoardAnonyComments;

@Controller
public class BoardCommentsController {
	@Autowired BoardCommentsService commentsService;
	
	// 댓글 추가
	@PostMapping("/board/addComments")
	public String addComments(BoardAnonyComments comments) {
		commentsService.addComments(comments);
		
		return "redirect:/board/anonyByNo?anonyNo="+comments.getAnonyNo();
	}
	
	// 댓글 수정
	@GetMapping("/board/modifyComments")
	public String modifyComments(Model model, BoardAnonyComments comments) {
		commentsService.getCommentsByNo(comments);
		
		return "/board/anonyByNo?anonyNo="+comments.getAnonyNo();
	}
	
	@PostMapping("/board/modifyComments")
	public String modifyComments(BoardAnonyComments comments) {
		commentsService.modifyComments(comments);
		
		return "redirect:/board/anonyByNo?anonyNo="+comments.getAnonyNo();
	}
	
	// 댓글 삭제
	@GetMapping("/board/removeComments")
	public String removeComments(BoardAnonyComments comments) {
		commentsService.removeComments(comments);
		
		return "redirect:/board/anonyByNo?anonyNo="+comments.getAnonyNo();
	}
}
