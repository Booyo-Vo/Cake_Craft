package com.goodee.cakecraft.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.service.ReservationService;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.FacilityBase;
import com.goodee.cakecraft.vo.FacilityReservation;

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
	public String getReservationList(HttpSession session,
									 Model model,
									 @RequestParam(name="targetYear", required = false) Integer targetYear,
									 @RequestParam(name="targetMonth", required = false) Integer targetMonth,
									 @RequestParam(name="targetDate", required = false) Integer targetDate,
									 @RequestParam(name="categoryCd", defaultValue = "1") String categoryCd) {
		/*
		 * String loginId = ""; Object o = session.getAttribute("loginMember"); if(o
		 * instanceof EmpIdList) { loginId = ((EmpIdList)o).getId(); }
		 */
		
		//테스트용 코드
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
		model.addAttribute("currDay", resultMap.get("currDay"));
		model.addAttribute("weekDay", resultMap.get("weekDay"));
		model.addAttribute("reservationList", resultMap.get("reservationList"));
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("loginId", loginId);
		model.addAttribute("teamNm", teamNm);
		
		return "/reservation/reservation";
	}
	
	@PostMapping("/reservation/addReservation")
	public String addReservation(HttpSession session,
								 @RequestParam(name="facilityNo") Integer facilityNo,
								 @RequestParam(name="teamNm") String teamNm,
								 @RequestParam(name="reservationContent") String reservationContent,
								 @RequestParam(name="date") String date,
								 @RequestParam(name="times") List<Integer> times) {
		
		/*
		 * String loginId = ""; Object o = session.getAttribute("loginMember"); if(o
		 * instanceof EmpIdList) { loginId = ((EmpIdList)o).getId(); }
		 */
		//테스트용 코드
		String loginId = "user1";
		
		log.debug(KMJ + times.toString() + " <--times" + RESET);
		
		//연속 시간 묶기
		List<List<Integer>> packet = new ArrayList<>(); //연속된 시간묶음 리스트를 저장할 리스트
		List<Integer> temp = new ArrayList<>(); //연속된 시간 묶음
		int n1 = times.get(0);
		temp.add(n1);
		times.remove(0);
		log.debug(KMJ + n1 + " <--ReservationController.addReservation() n1" + RESET);
		while(!times.isEmpty()) {
			int n2 = times.get(0);
			times.remove(0);
			log.debug(KMJ + n2 + " <--ReservationController.addReservation() n2" + RESET);
			
			if(n1 + 1 == n2) { 
				temp.add(n2);
				n1 = n2;
			} else {
				packet.add(temp);
				temp = new ArrayList<>();
				temp.add(n2);
				n1 = n2;
			}
		}
		packet.add(temp);
		log.debug(KMJ + packet.toString() + "<-- ReservationController.addReservation() packet" + RESET);
		
		String teamCd = empService.getAdminEmpById(loginId).getTeamCd();
		
		for(List<Integer> li : packet) {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("facilityNo", facilityNo);
			paramMap.put("teamCd", teamCd);
			paramMap.put("id", loginId);
			paramMap.put("reservationContent", reservationContent);
			paramMap.put("startDtime", date + " " + li.get(0)+":00:00");
			paramMap.put("endDtime", date + " " + (li.get(li.size()-1)+1)+":00:00");
			log.debug(KMJ + paramMap.get("startDtime").toString()+RESET);
			log.debug(KMJ + paramMap.get("endDtime").toString()+RESET);
			reservationService.addReservation(paramMap);
		}
		log.debug(times.toString());
		
		//리다이렉션을 위한 변수
		int targetYear = Integer.parseInt(date.substring(0,4));
		int targetMonth = Integer.parseInt(date.substring(5,7)) - 1;
		int targetDate = Integer.parseInt(date.substring(8));
		FacilityBase facility = new FacilityBase();
		facility.setFacilityNo(facilityNo);
		String cd = facilityService.getFacilityByNo(facility).getCategoryCd().substring(0,1);
		
		return "redirect:/reservation/reservation?categoryCd="+cd+"&targetYear="+targetYear+"&targetMonth="+targetMonth+"&targetDate="+targetDate;
	}
	
	@GetMapping("/reservation/reservationListById")
	public String reservationListById(HttpSession session,
									  Model model) {
		/*
		 * String loginId = ""; Object o = session.getAttribute("loginMember"); if(o
		 * instanceof EmpIdList) { loginId = ((EmpIdList)o).getId(); }
		 */
		//테스트용 코드
		String loginId = "user1";
		EmpIdList emp = new EmpIdList();
		emp.setId(loginId);
		String teamNm = empService.getAdminEmpById(loginId).getTeamNm();
		String anHour = reservationService.getAnHourLater();
		List<Map<String, Object>> list = reservationService.getReservationListById(emp);	
		model.addAttribute("list", list);
		model.addAttribute("teamNm", teamNm);
		model.addAttribute("anHour", anHour);
		return "/reservation/reservationListById";
	}
	
	
	@GetMapping("/reservation/removeReservation")
	public String reservationListById(FacilityReservation reservation) {
		reservationService.removeReservation(reservation);
		
		return "redirect:/reservation/reservationListById";
	}
}
