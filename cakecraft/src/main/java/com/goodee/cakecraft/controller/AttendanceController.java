package com.goodee.cakecraft.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.goodee.cakecraft.service.AttendanceService;
import com.goodee.cakecraft.vo.EmpAttendance;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AttendanceController {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m";
	
	@Autowired
	private AttendanceService attendanceService;
	//출근 입력
	@GetMapping("/emp/start")
	public ModelAndView startWork(@RequestParam("id") String id) {
		attendanceService.insertStartDtime(id);
		return new ModelAndView("redirect:/schedule/schedule");
	}
	//퇴근 업데이트
	@GetMapping("/emp/end")
	public ModelAndView endWork(@RequestParam("id") String id) {
		attendanceService.updateEndDtime(id);
		return new ModelAndView("redirect:/schedule/schedule");
	}
	
	
	//출퇴근 리스트 출력
	@GetMapping("/emp/attendanceList")
	public String empATTList(Model model,
							HttpSession session,
							@RequestParam(name="searchWord", defaultValue = "") String searchWord) {
		//세션 로그인 아이디 가져오기
				Object o = session.getAttribute("loginMember");
				String loginId = "";
				
				if (o instanceof EmpIdList) {
					loginId = ((EmpIdList) o).getId();
					log.debug(KMS + "loginId EmpController" + loginId + RESET);
				}
		//출퇴근 목록 가져오기
			List<EmpAttendance> empAttList = attendanceService.getMyAttendanceList(searchWord);
			model.addAttribute("empAttList", empAttList);
			model.addAttribute("loginId", loginId);
			
			return "emp/attendanceList";
	}
	
}