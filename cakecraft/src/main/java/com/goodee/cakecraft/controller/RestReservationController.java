package com.goodee.cakecraft.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.service.ReservationService;
import com.goodee.cakecraft.vo.FacilityBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestReservationController {
	@Autowired ReservationService reservationService;
	@Autowired FacilityService facilityService;
	
	@PostMapping("/rest/reservationInfo")
	public List<String> reservationInfo(@RequestParam(name="facilityNo") Integer facilityNo,
										@RequestParam(name="targetYear") Integer targetYear,
										@RequestParam(name="targetMonth") Integer targetMonth,
										@RequestParam(name="targetDate") Integer targetDate){
		
		log.debug(facilityNo+"<-- facilityNo");
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("facilityNo", facilityNo);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1);
		paramMap.put("targetDate", targetDate);
		
		List<String> list = reservationService.getReservationTime(paramMap);
		return list;
	}
	
	@PostMapping("/rest/facilityListByCate")
	public List<FacilityBase> facilityListByCate(@RequestParam(name="categoryCd") String categoryCd){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("useYn", "Y");
		paramMap.put("categoryCd", categoryCd + "%");
		List<FacilityBase> facilityList = facilityService.getFacilityList(paramMap);
		
		return facilityList;
	}
}
