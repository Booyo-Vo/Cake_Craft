package com.goodee.cakecraft.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.service.ReservationService;
import com.goodee.cakecraft.vo.FacilityBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReservationController {
	@Autowired FacilityService facilityService;
	@Autowired ReservationService reservationService;
	@Autowired AdminEmpService empService;
	
	//ANSI코드
	final String KMJ = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	//오늘 예약현황 view
	@GetMapping("/reservation/reservation")
	public String getReservationList(Model model,
									 @RequestParam(name="targetYear", required = false) Integer targetYear,
									 @RequestParam(name="targetMonth", required = false) Integer targetMonth,
									 @RequestParam(name="targetDate", required = false) Integer targetDate,
									 @RequestParam(name="categoryCd", defaultValue = "1") String categoryCd) {
		//테스트용 id고정
		String loginId = "user1";
		
		String teamNm = empService.getAdminEmpById(loginId).getTeamNm();
		
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("useYn", "Y");
		paramMap.put("categoryCd", categoryCd + "%");
		List<FacilityBase> facilityList = facilityService.getFacilityList(paramMap);
		
		Map<String, Object> resultMap = reservationService.getReservationByDate(targetYear, targetMonth, targetDate, categoryCd);
		
		model.addAttribute("targetYear", resultMap.get("targetYear"));
		model.addAttribute("targetMonth", resultMap.get("targetMonth"));
		model.addAttribute("targetDate", resultMap.get("targetDate"));
		model.addAttribute("date", resultMap.get("date"));
		model.addAttribute("categoryCd", resultMap.get("categoryCd"));
		model.addAttribute("reservationList", resultMap.get("reservationList"));
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("loginId", loginId);
		model.addAttribute("teamNm", teamNm);
		
		return "/reservation/reservation";
	}
	
	@PostMapping("/reservation/addReservation")
	public String addReservation(@RequestParam(name="facilityNo") Integer facilityNo,
								 @RequestParam(name="teamNm") String teamNm,
								 @RequestParam(name="reservationContent") String reservationContent,
								 @RequestParam(name="date") String date,
								 @RequestParam(name="times") String[] times) {
		
		//테스트용 id고정
		String loginId = "user1";
				
		List<String> timesArr = new ArrayList<>();
		for(String s : times) {
			timesArr.add(s);
		}
		log.debug(KMJ + timesArr.toString()+" <--timesArr" + RESET);
		
		String teamCd = empService.getAdminEmpById(loginId).getTeamCd();
		List<String> startArr = new ArrayList<>();
		List<String> endArr = new ArrayList<>();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("facilityNo", facilityNo);
		paramMap.put("teamCd", teamCd);
		paramMap.put("id", loginId);
		paramMap.put("reservationContent", reservationContent);
		
		log.debug(times.toString());
		
		return "redirect:/reservation/reservation";
	}
}
