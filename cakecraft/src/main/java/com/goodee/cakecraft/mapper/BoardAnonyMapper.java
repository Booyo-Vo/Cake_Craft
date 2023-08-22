package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardLike;

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
	
	// 좋아요를 눌렀는지 안눌렀는지 확인
	int selectLike(BoardAnony anony);
	
	// 좋아요 +1
	int insertLikeUp(BoardLike like);
	
	// 좋아요 -1
	int deleteLikeDown(BoardLike like);
	
	// 게시글별 좋아요 개수 조회
	int selectLikeNum(BoardLike like);
	
	// 전체 좋아요 개수 변경
	int updateLikeCnt(BoardAnony anony);
	
}
