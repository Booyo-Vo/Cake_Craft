package com.goodee.cakecraft.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.mapper.ScheduleMapper;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.ScheduleBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	@Autowired EmpMapper empMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 일정 목록 조회(월간, 일간)
	public Map<String, Object> getSchedule(String id, Integer targetYear, Integer targetMonth){
		
		Calendar firstDate = Calendar.getInstance();
		// 첫번째 날짜
		firstDate.set(Calendar.DATE, 1);
		
		// targetYear, targetMonth 가 매개값으로 넘어 왔다면
		if(targetYear != null && targetMonth != null) {
			firstDate.set(Calendar.YEAR, targetYear);
			firstDate.set(Calendar.MONTH, targetMonth); 
		}
		
		targetYear = firstDate.get(Calendar.YEAR);
		targetMonth = firstDate.get(Calendar.MONTH);
		
		// 마지막 날짜
		int lastDate = firstDate.getActualMaximum(Calendar.DATE);
		

		// 오늘 날짜 
		Calendar today = Calendar.getInstance();
		int todayDate = today.get(Calendar.DATE);
		
		// 1일의 요일을 이용하여 출력할 시작 공백 수 -> 요일 맵핑 수 - 1
		int beginBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1;
		
		// 마지막 날짜 이후 출력할 공백 수 
		int endBlank = 0;
		if((beginBlank+lastDate) % 7 != 0) {
			endBlank = 7 - ((beginBlank+lastDate)%7);
		}

		// 전체 개수 
		int totalTd = beginBlank + lastDate + endBlank;
		
		log.debug(GEH + "targetYear --> "+ targetYear + RESET);
		log.debug(GEH + "targetMonth --> "+ targetMonth + RESET);
		log.debug(GEH + "lastDate --> "+ lastDate + RESET);
		log.debug(GEH + "todayDate --> "+ todayDate + RESET);
		log.debug(GEH + "beginBlank --> "+ beginBlank + RESET);
		log.debug(GEH + "endBlank --> "+ endBlank + RESET);
		log.debug(GEH + "totalTd --> "+ totalTd + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("targetYear",targetYear);
		resultMap.put("targetMonth",targetMonth);
		resultMap.put("lastDate",lastDate);
		resultMap.put("beginBlank",beginBlank);
		resultMap.put("endBlank",endBlank);
		resultMap.put("totalTd",totalTd);
		
		// 로그인한 사원정보 가져오기
		EmpBase empBase = empMapper.selectEmpById(id);
		log.debug(GEH + "empBase --> "+ empBase.toString() + RESET);
		
		// Dao의 매개값형태에 맞게 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth+1);
		paramMap.put("todayDate", todayDate);
		paramMap.put("teamCd", empBase.getTeamCd());
		
		// 월간 전사일정 목록 가져오기
		List<ScheduleBase> scheduleListByCateAll = scheduleMapper.selectScheduleListByCateAll(paramMap);
		log.debug(GEH + "scheduleListByCateAll.size --> "+ scheduleListByCateAll.size() + RESET);
		
		// 월간 팀일정 목록 가져오기 
		List<ScheduleBase> scheduleListByCateTeam = scheduleMapper.selectScheduleListByCateTeam(paramMap);
		log.debug(GEH + "scheduleListByCateTeam.size --> "+ scheduleListByCateTeam.size() + RESET);
		
		// 월간 개인일정 목록 가져오기
		List<ScheduleBase> scheduleListByCateId = scheduleMapper.selectScheduleListByCateId(paramMap);
		log.debug(GEH + "scheduleListByCateId.size --> "+ scheduleListByCateId.size() + RESET);
		
		// 일간 일정 목록 가져오기
		List<ScheduleBase> scheduleListByDate = scheduleMapper.selectScheduleListByDate(paramMap);
		log.debug(GEH + "scheduleListByDate --> "+ scheduleListByDate.toString() + RESET);
		
		// 반환값
		resultMap.put("empBase",empBase);
		resultMap.put("scheduleListByCateAll",scheduleListByCateAll);
		resultMap.put("scheduleListByCateTeam",scheduleListByCateTeam);
		resultMap.put("scheduleListByCateId",scheduleListByCateId);
		resultMap.put("scheduleListByDate",scheduleListByDate);
		
		return resultMap;
	}
	
	// 개별 일정 조회
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
