package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.ScheduleService;
import com.goodee.cakecraft.vo.ScheduleBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestScheduleController {
	@Autowired ScheduleService scheduleService;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 일정추가 모달창에 출력할 데이터
	@PostMapping("/rest/addSchedule")
	public String addSchedule(@RequestParam(name="targetDate") Integer targetDate,
								@RequestParam(name="targetYear") Integer targetYear,
								@RequestParam(name="targetMonth") Integer targetMonth) {
		// ex)4월을 04월로 나타내기 위해 
		String strM = (targetMonth+1)+""; 
		if(targetMonth < 9){
			strM = "0"+strM;
		}
		
		// ex)1일을 01일로 나타내기 위해 
		String strD = targetDate+"";
		if(targetDate < 10){
			strD = "0"+strD;
		}
		
		// date type 형태로 변환 ex)2023-01-01
		String startDtime = targetYear +"-"+ strM +"-"+ strD;
		log.debug(GEH + startDtime + " <-- startDtime" + RESET);
		
		return startDtime;
	}
	
	// 일정수정 모달창에 출력할 데이터
	@PostMapping("/rest/modifySchedule")
	public ScheduleBase modifySchedule(ScheduleBase schedule) {
		// 일정 상세 정보 가져오기
		ScheduleBase resultSchedule = scheduleService.getScheduleByNo(schedule);
		log.debug(GEH + resultSchedule.toString() + " <-- resultSchedule" + RESET);
		
		return resultSchedule;
	}
}
