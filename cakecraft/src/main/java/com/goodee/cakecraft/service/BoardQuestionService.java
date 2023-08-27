package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardQuestionMapper;
import com.goodee.cakecraft.vo.BoardQuestion;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardQuestionService {
	@Autowired BoardQuestionMapper questionMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 문의 목록 조회
	public Map<String, Object> getQuestionList(String searchRegId, String searchWord){
		
		// Dao의 매개값형태에 맞게 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("searchRegId", searchRegId);
		paramMap.put("searchWord", searchWord);
		
		// 문의 목록 가져오기
		List<BoardQuestion> questionList = questionMapper.selectQuestionList(paramMap);
		log.debug(GEH + questionList.size() + " <-- 문의 목록.size" + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("questionList", questionList);
		
		return resultMap;
				
	}
	
	// 문의 상세 조회
	public BoardQuestion getQuestionByNo(BoardQuestion question) {
		BoardQuestion resultQuestion = questionMapper.selectQuestionByNo(question);
		
		return resultQuestion;
	}
	
	// 문의 추가
	public int addQuestion(BoardQuestion question) {
		int row = questionMapper.insertQuestion(question);
		
		return row;
	}
	
	// 문의 수정
	public int modifyQuestion(BoardQuestion question) {
		int row = questionMapper.updateQuestion(question);
		
		return row;
	}
	
	// 문의 삭제
	public int removeQuestion(BoardQuestion question) {
		int row = questionMapper.deleteQuestion(question);
		
		return row;
	}
}
