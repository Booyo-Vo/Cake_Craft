package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardAnonyFile;

@Mapper
public interface BoardAnonyFileMapper {
	// 익명게시글 파일 목록 조회
	List<BoardAnonyFile> selectAnonyFile(BoardAnony anony);
	
	// 익명게시글 파일 첨부
	int insertAnonyFile(BoardAnonyFile anonyfile);
	
	// 익명게시글 파일 삭제
	int deleteAnonyFile(BoardAnony anony);
}
