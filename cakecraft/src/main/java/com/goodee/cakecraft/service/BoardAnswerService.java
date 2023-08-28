package com.goodee.cakecraft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.BoardAnswerMapper;
import com.goodee.cakecraft.vo.BoardAnswer;

@Service
@Transactional
public class BoardAnswerService {
	@Autowired BoardAnswerMapper answerMapper;
	
	// 답변 추가
	public int addAnswer(BoardAnswer answer) {
		int row = answerMapper.insertAnswer(answer);
		
		return row;
	}
	
	// 답변 수정
	public int modifyAnswer(BoardAnswer answer) {
		int row = answerMapper.updateAnswer(answer);
		
		return row;
	}
}
