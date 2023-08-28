package com.goodee.cakecraft.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardAnswer;
import com.goodee.cakecraft.vo.BoardQuestion;

@Mapper
public interface BoardAnswerMapper {
	// 답변 조회
	BoardAnswer selectAnswerByNo(BoardQuestion question);
	
	// 답변 추가
	int insertAnswer(BoardAnswer answer);
	
	// 답변 수정
	int updateAnswer(BoardAnswer answer);
	
	// 답변 삭제
	int deleteAnswer(BoardQuestion question);
}
