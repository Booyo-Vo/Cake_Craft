package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.ScheduleService;

@RestController
public class RestScheduleController {
	@Autowired ScheduleService scheduleService;
	
	// 일정추가 모달창에 출력할 정보
	@PostMapping("/rest/addSchedule")
	public String addSchedule(@RequestParam(name="targetDate") Integer targetDate,
								@RequestParam(name="targetYear") Integer targetYear,
								@RequestParam(name="targetMonth") Integer targetMonth) {
		// ex)4월을 04월로 나타내기 위해 
		String strM = (targetMonth+1)+""; 
		if(targetMonth < 10){
			strM = "0"+strM;
		}
		
		// ex)1일을 01일로 나타내기 위해 
		String strD = targetDate+"";
		if(targetDate < 10){
			strD = "0"+strD;
		}
		
		// date type 형태로 변환 ex)2023-01-01
		String startDtime = targetYear +"-"+ strM +"-"+ strD;
		
		return startDtime;
	}
}
