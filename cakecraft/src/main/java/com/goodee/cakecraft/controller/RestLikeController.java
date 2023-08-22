package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.BoardAnonyService;
import com.goodee.cakecraft.vo.BoardLike;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestLikeController {
	@Autowired BoardAnonyService anonyService;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
		
	// 좋아요 +1
	@PostMapping("/board/likeUp")
	public void likeup(BoardLike like) {
		log.debug(GEH + like.toString() + " <-- like" + RESET);
		int resultRow = anonyService.likeUp(like);
		log.debug(GEH + "좋아요 성공" + RESET);
		
		// 좋아요 성공시
		// board_anony 테이블 -> like_cnt값 +1 변경
		if(resultRow > 0) {
			anonyService.modifyLikeCnt(like);
		}
	}
	
	// 좋아요 -1
	@PostMapping("/board/likeDown")
	public void likeDown(BoardLike like) {
		int resultRow = anonyService.likeDown(like);
		log.debug(GEH + "좋아요 취소 성공" + RESET);
		
		// 좋아요 취소 성공시 
		// board_anony 테이블 -> like_cnt값 -1 변경
		if(resultRow > 0) {
			anonyService.modifyLikeCnt(like);
		}
	}

}
