package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardAnonyComments;

@Mapper
public interface BoardCommentsMapper {
	// 댓글 목록 조회
	List<BoardAnonyComments> selectCommentsList(BoardAnony anony);
	
	// 댓글 상세 정보 조회
	BoardAnonyComments selectCommentsByNo(BoardAnonyComments comments);
	
	// 댓글 추가
	int insertComments(BoardAnonyComments comments);
	
	// 댓글 수정
	int updateComments(BoardAnonyComments comments);
	
	// 댓글 삭제
	int deleteComments(BoardAnonyComments comments);
}
