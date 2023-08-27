package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardQuestion;

@Mapper
public interface BoardQuestionMapper {
	// 문의 목록 조회
	List<BoardQuestion> selectQuestionList(Map<String, Object> paramMap);

	// 문의 상세 조회
	BoardQuestion selectQuestionByNo(BoardQuestion question);
	
	// 문의 추가
	int insertQuestion(BoardQuestion question);
	
	// 문의 수정
	int updateQuestion(BoardQuestion question);
	
	// 문의 삭제
	int deleteQuestion(BoardQuestion question);
}
