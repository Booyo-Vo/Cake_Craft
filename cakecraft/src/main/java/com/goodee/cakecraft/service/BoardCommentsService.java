package com.goodee.cakecraft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardCommentsMapper;
import com.goodee.cakecraft.vo.BoardAnonyComments;

@Service
@Transactional
public class BoardCommentsService {
	@Autowired BoardCommentsMapper commentsMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 댓글 상세 정보 조회
	public BoardAnonyComments getCommentsByNo(BoardAnonyComments comments) {
		BoardAnonyComments anonyByNo = commentsMapper.selectCommentsByNo(comments);
		
		return anonyByNo;
	}
	
	// 댓글 추가
	public int addComments(BoardAnonyComments comments) {
		int row = commentsMapper.insertComments(comments);
		
		return row;
	}
	
	// 댓글 수정
	public int modifyComments(BoardAnonyComments comments) {
		int row = commentsMapper.updateComments(comments);
		
		return row;
	}
	
	// 댓글 삭제
	public int removeComments(BoardAnonyComments comments) {
		int row = commentsMapper.deleteComments(comments);
		
		return row;
	}
}
