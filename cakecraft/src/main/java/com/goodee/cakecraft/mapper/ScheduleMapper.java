package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ScheduleBase;
@Mapper
public interface ScheduleMapper {
	// 월간 일정 목록 출력 (달력에 일정 출력)
	List<ScheduleBase> selectScheduleListByMonth(Map<String, Object> paramMap);
	
	// 개별 일정 출력
	ScheduleBase selectScheduleByNo(ScheduleBase schedule);
	
	// 일정 추가 
	int insertSchedule(ScheduleBase schedule);
	
	// 일정 수정
	int updateSchedule(ScheduleBase schedule);
	
	// 일정 삭제
	int deleteSchedule(ScheduleBase schedule);
}
