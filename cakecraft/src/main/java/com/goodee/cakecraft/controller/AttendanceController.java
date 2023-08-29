package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.goodee.cakecraft.service.AttendanceService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AttendanceController {
	
	@Autowired
	private AttendanceService attendanceService;
	
	@GetMapping("/emp/start")
	public ModelAndView startWork(@RequestParam("id") String id) {
		attendanceService.insertStartDtime(id);
		return new ModelAndView("redirect:/schedule/schedule");
	}
	
	@GetMapping("/emp/end")
	public ModelAndView endWork(@RequestParam("id") String id) {
		attendanceService.updateEndDtime(id);
		return new ModelAndView("redirect:/schedule/schedule");
	}
	
}