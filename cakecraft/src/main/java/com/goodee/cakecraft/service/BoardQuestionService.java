package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardAnswerMapper;
import com.goodee.cakecraft.mapper.BoardQuestionMapper;
import com.goodee.cakecraft.vo.BoardAnswer;
import com.goodee.cakecraft.vo.BoardQuestion;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardQuestionService {
	@Autowired BoardQuestionMapper questionMapper;
	@Autowired BoardAnswerMapper answerMapper;
	
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
	public Map<String, Object> getQuestionByNo(BoardQuestion question) {
		BoardQuestion questionByNo = questionMapper.selectQuestionByNo(question);
		BoardAnswer answerByNo = answerMapper.selectAnswerByNo(question);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("questionByNo", questionByNo);
		resultMap.put("answerByNo", answerByNo);
				
		return resultMap;
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
		int row = answerMapper.deleteAnswer(question);
		// 답변이 삭제됐다면 문의도 함께 삭제
		if(row == 1) {
			questionMapper.deleteQuestion(question);
		}
		return row;
	}
}
