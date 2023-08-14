package com.goodee.cakecraft.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.ScheduleService;

@Controller
public class ScheduleController {
	@Autowired ScheduleService scheduleService;
	
	@GetMapping("/schedule")
	public String schedule(Model model,
							@RequestParam(required = false, name = "targetYear") Integer targetYear,
							@RequestParam(required = false, name = "targetMonth") Integer targetMonth) {
		// ** test용 loginId
		String loginId = "user1";
		
		// 일정 목록 출력 (월간, 일간)
		Map<String, Object> resultMap = scheduleService.getSchedule(loginId, targetYear, targetMonth);
		
		model.addAttribute("targetYear",resultMap.get("targetYear"));
		model.addAttribute("targetMonth",resultMap.get("targetMonth"));
		model.addAttribute("lastDate",resultMap.get("lastDate"));
		model.addAttribute("beginBlank",resultMap.get("beginBlank"));
		model.addAttribute("endBlank",resultMap.get("endBlank"));
		model.addAttribute("totalTd",resultMap.get("totalTd"));
		
		model.addAttribute("scheduleList",resultMap.get("scheduleList"));
		model.addAttribute("scheduleListByDate",resultMap.get("scheduleListByDate"));
		
		return "schedule";
	}
}
