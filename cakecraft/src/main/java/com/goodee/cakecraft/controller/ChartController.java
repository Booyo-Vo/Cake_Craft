package com.goodee.cakecraft.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.ChartService;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChartController {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m";
	
	@Autowired
	private ChartService chartService;
	
	// 차트리스트
	@GetMapping("/emp/chartList")
	public String yearCnt(HttpSession session,
						Model model,  
						@RequestParam(required = false) String month,
						@RequestParam(required = false) String year) {
	//세선에 저장된 로그인 아이디를 받아옴
	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
	String loginId = loginMember.getId();
	log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);
		
		// 선택된 년도와 월이 없다면 현재 년도와 월 가져오기
    if (year == null || year.isEmpty()) {
        Calendar calendar = Calendar.getInstance();
        year = String.valueOf(calendar.get(Calendar.YEAR));
        log.debug(LJY +"chartList year:"+year +RESET);
    }

    if (month == null || month.isEmpty()) {
        Calendar calendar = Calendar.getInstance();
        month = String.valueOf(calendar.get(Calendar.MONTH) + 1); // 월은 0부터 시작하므로 1을 더해줌
        log.debug(LJY +"chartList month:"+month +RESET);
    }
		
	//해당년도 입사자 퇴사자
	Map<String, Object> YearCntMap= chartService.getYearCnt(year);

	//해당월 입사자 퇴사자
	Map<String, Object> MonthCntMap= chartService.getMonthCnt(month);
	
	//직급별 인원수
    List<Map<String, Object>> positionCnt = chartService.getPositionCnt();
    
    //부서별 인원수
    List<Map<String, Object>> deptCnt = chartService.getDeptCnt();
    
    //팀별 인원수
    List<Map<String, Object>> teamCnt = chartService.getTeamCnt();
    
    //성별 인원수
    List<Map<String, Object>> genderCnt = chartService.getGenderCnt();
    
    
    //view로 넘길때는 다시 분리해서
	model.addAttribute("hireYearCnt", YearCntMap.get("hireYearCnt"));
	model.addAttribute("retireYearCnt", YearCntMap.get("retireYearCnt"));
	model.addAttribute("hireMonthCnt", MonthCntMap.get("hireMonthCnt"));
	model.addAttribute("retireMonthCnt", MonthCntMap.get("retireMonthCnt"));
	model.addAttribute("positionCnt", positionCnt);
	model.addAttribute("deptCnt", deptCnt);
	model.addAttribute("teamCnt", teamCnt);
	model.addAttribute("year", year);
	model.addAttribute("month", month);
	model.addAttribute("genderCnt", genderCnt);
	model.addAttribute("loginId",loginId);
	return "/emp/chartList";
	}
}
	
