package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ScheduleBase;
@Mapper
public interface ScheduleMapper {
	// 월간 전사일정 목록 조회
	List<ScheduleBase> selectScheduleListByCateAll(Map<String, Object> paramMap);
	
	// 월간 팀일정 목록 조회 
	List<ScheduleBase> selectScheduleListByCateTeam(Map<String, Object> paramMap);
	
	// 월간 개인일정 목록 조회
	List<ScheduleBase> selectScheduleListByCateId(Map<String, Object> paramMap);
	
	// 일간 일정 목록 조회 (오늘의 일정 출력)
	List<ScheduleBase> selectScheduleListByDate(Map<String, Object> paramMap);
	
	// 개별 일정 출력
	ScheduleBase selectScheduleByNo(ScheduleBase schedule);
	
	// 일정 추가 
	int insertSchedule(ScheduleBase schedule);
	
	// 일정 수정
	int updateSchedule(ScheduleBase schedule);
	
	// 일정 삭제
	int deleteSchedule(ScheduleBase schedule);
}
