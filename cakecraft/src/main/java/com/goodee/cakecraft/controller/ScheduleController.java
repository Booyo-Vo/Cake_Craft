package com.goodee.cakecraft.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.ScheduleService;
import com.goodee.cakecraft.vo.ScheduleBase;

@Controller
public class ScheduleController {
	@Autowired ScheduleService scheduleService;
	
	@GetMapping("/schedule/schedule")
	public String schedule(Model model,
							@RequestParam(required = false, name = "targetYear") Integer targetYear,
							@RequestParam(required = false, name = "targetMonth") Integer targetMonth) {
		// ** test용 loginId
		String loginId = "user1";
		
		// 일정 목록 출력 (월간, 일간)
		Map<String, Object> resultMap = scheduleService.getSchedule(loginId, targetYear, targetMonth);
		
		model.addAttribute("loginId",loginId);
		
		model.addAttribute("targetYear",resultMap.get("targetYear"));
		model.addAttribute("targetMonth",resultMap.get("targetMonth"));
		model.addAttribute("lastDate",resultMap.get("lastDate"));
		model.addAttribute("beginBlank",resultMap.get("beginBlank"));
		model.addAttribute("endBlank",resultMap.get("endBlank"));
		model.addAttribute("totalTd",resultMap.get("totalTd"));
		
		model.addAttribute("scheduleList",resultMap.get("scheduleList"));
		model.addAttribute("scheduleListByDate",resultMap.get("scheduleListByDate"));
		model.addAttribute("empBase",resultMap.get("empBase"));
		
		return "/schedule/schedule";
	}
	
	//시설비품 추가 액션
	@PostMapping("/schedule/addSchedule")
	public String addFacility(HttpSession session,
							  @RequestParam(name="loginId") String loginId,
							  @RequestParam(name="teamCd") String teamCd,
							  @RequestParam(name="categoryCd") String categoryCd,
							  @RequestParam(name="scheduleContent") String scheduleContent,
							  @RequestParam(name="startDtime") String startDtime,
							  @RequestParam(name="endDtime") String endDtime) {
		
		ScheduleBase schedule = new ScheduleBase();
		schedule.setId(loginId);
		schedule.setTeamCd(teamCd);
		schedule.setCategoryCd(categoryCd);
		schedule.setScheduleContent(scheduleContent);
		schedule.setStartDtime(startDtime);
		schedule.setEndDtime(endDtime);
	
		scheduleService.addSchedule(schedule);
		
		return "redirect:/schedule/schedule";
	}
}
