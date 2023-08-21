package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardAnony;

@Mapper
public interface BoardAnonyMapper {
	// 익명게시판 목록 조회
	List<BoardAnony> selectAnonyList(String searchWord);

	// 개별 게시글 상세 조회
	BoardAnony selectAnonyByNo(BoardAnony anony);
	
	// 게시글 추가
	int insertAnony(BoardAnony anony);
	
	// 게시글 수정
	int updateAnony(BoardAnony anony);
	
	// 게시글 삭제
	int deleteAnony(BoardAnony anony);

}
