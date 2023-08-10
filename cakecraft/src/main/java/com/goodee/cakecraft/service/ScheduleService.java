package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.ScheduleMapper;
import com.goodee.cakecraft.vo.ScheduleBase;

@Service
@Transactional
public class ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	
	// 월간 일정 목록 출력 (달력에 일정 출력)
	public List<ScheduleBase> getScheduleListByMonth(String id, int targetYear, int targetMonth){
		// controller가 넘겨준 매개값을 Dao의 매개값형태에 맞게 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth);
		// 반환값
		List<ScheduleBase> scheduleList = scheduleMapper.selectScheduleListByMonth(paramMap);
		
		return scheduleList;
	}
	
	// 개별 일정 출력
	public ScheduleBase getScheduleByNo(ScheduleBase schedule) {
		// 반환값
		ScheduleBase resultSchedule = scheduleMapper.selectScheduleByNo(schedule);
		
		return resultSchedule;
	}
	
	
	// 일정 추가
	public int addSchedule(ScheduleBase schedule) {
		// 반환값
		int row = scheduleMapper.insertSchedule(schedule);
		
		return row;
	}
	
	// 일정 수정 
	public int modifySchedule(ScheduleBase schedule) {
		// 반환값
		int row = scheduleMapper.updateSchedule(schedule);
		
		return row;
	}
	
	// 일정 삭제
	public int removeSchedule(ScheduleBase schedule) {
		// 반환값
		int row = scheduleMapper.deleteSchedule(schedule);
		
		return row;
	}
}
