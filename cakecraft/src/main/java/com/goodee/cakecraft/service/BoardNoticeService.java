 package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardNoticeMapper;
import com.goodee.cakecraft.vo.BoardNotice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardNoticeService {
	@Autowired BoardNoticeMapper noticeMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 공지 목록 조회
	public Map<String, Object> getNoticeList(String searchRegId, String searchWord){
		
		// Dao의 매개값형태에 맞게 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("searchRegId", searchRegId);
		paramMap.put("searchWord", searchWord);
		
		// 공지 목록 가져오기
		List<BoardNotice> noticeList = noticeMapper.selectNoticeList(paramMap);
		log.debug(GEH + "noticeList --> "+ noticeList.size() + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("noticeList",noticeList);
		
		return resultMap;
				
	}
	
	// 공지 상세 정보 조회
	public BoardNotice getNoticeByNo(BoardNotice notice) {
		BoardNotice resultNotice = noticeMapper.selectNoticeByNo(notice);
		
		return resultNotice;
	}
	
	// 공지 추가
	public int addNotice(BoardNotice notice) {
		int row = noticeMapper.insertNotice(notice);
		
		return row;
	}
	
	// 공지 수정
	public int modifyNotice(BoardNotice notice) {
		int row = noticeMapper.updateNotice(notice);
		
		return row;
	}
	
	// 공지 삭제
	public int removeNotice(BoardNotice notice) {
		int row = noticeMapper.deleteNotice(notice);
		
		return row;
	}
	
}
