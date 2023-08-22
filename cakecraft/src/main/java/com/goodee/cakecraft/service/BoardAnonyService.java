package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardAnonyMapper;
import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardLike;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardAnonyService {
	@Autowired BoardAnonyMapper anonyMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 익명게시판 목록 조회
	public Map<String, Object> getAnonyList(String searchWord){
		
		// 게시글 목록 가져오기
		List<BoardAnony> anonyList = anonyMapper.selectAnonyList(searchWord);
		log.debug(GEH + anonyList.size() + " <-- 익명 게시판 목록.size" + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("anonyList",anonyList);
		
		return resultMap;
				
	}
	
	// 게시글 상세정보 조회
	public BoardAnony getAnonyByNo(BoardAnony anony) {
		BoardAnony resultAnony = anonyMapper.selectAnonyByNo(anony);
		
		return resultAnony;
	}
	
	// 게시글 추가
	public int addAnony(BoardAnony anony) {
		int row = anonyMapper.insertAnony(anony);
		
		return row;
	}
	
	// 게시글 수정
	public int modifyAnony(BoardAnony anony) {
		int row = anonyMapper.updateAnony(anony);
		
		return row;
	}
	
	// 게시글 삭제
	public int removeAnony(BoardAnony anony) {
		int row = anonyMapper.deleteAnony(anony);
		
		return row;
	}
	
	// 좋아요 눌렀는지 여부 확인
	public int getLike(BoardAnony anony) {
		int row = anonyMapper.selectLike(anony);
		log.debug(GEH + row + " <-- 좋아요 여부확인" + RESET);
		
		return row;
	}
	
	// 좋아요 +1
	public int likeUp(BoardLike like) {
		int row = anonyMapper.insertLikeUp(like);
		
		return row;
	}
	
	// 좋아요 -1
	public int likeDown(BoardLike like) {
		int row = anonyMapper.deleteLikeDown(like);
		
		return row;
	}
	
	// 전체 좋아요 개수 변경
	public int modifyLikeCnt(BoardLike like) {
		// 게시글별 좋아요 개수 조회
		int sumLikeNum = anonyMapper.selectLikeNum(like);
		
		BoardAnony anony = new BoardAnony();
		anony.setAnonyNo(like.getAnonyNo());
		anony.setLikeCnt(sumLikeNum);
		
		int row = anonyMapper.updateLikeCnt(anony);
		
		return row;
	}
}
