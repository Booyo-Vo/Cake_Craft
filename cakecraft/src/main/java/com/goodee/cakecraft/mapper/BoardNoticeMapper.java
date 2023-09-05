package com.goodee.cakecraft.mapper;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.BoardNotice;

@Mapper
public interface BoardNoticeMapper {
	// 공지 목록 조회
	List<BoardNotice> selectNoticeList(Map<String, Object> paramMap);

	// 개별 공지 상세 조회
	BoardNotice selectNoticeByNo(BoardNotice notice);
	
	// 공지 추가
	int insertNotice(BoardNotice notice);
	
	// 공지 수정
	int updateNotice(BoardNotice notice);
	
	// 공지 삭제
	int deleteNotice(BoardNotice notice);
	
	// 번호를 기준으로 공지 다섯개만 조회
	List<BoardNotice> selectNoticeListByCount(BoardNotice notice);
}
