package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardAnonyMapper;
import com.goodee.cakecraft.vo.BoardAnony;

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
		log.debug(GEH + "anonyList --> "+ anonyList.size() + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("anonyList",anonyList);
		
		return resultMap;
				
	}
	
	// 개별 게시글 상세 조회
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
	
}