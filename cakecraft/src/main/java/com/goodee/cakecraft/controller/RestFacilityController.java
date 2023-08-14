package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.vo.FacilityBase;

@RestController
public class RestFacilityController {
	@Autowired FacilityService facilityService;

	//수정 모달창에 출력할 정보
	@PostMapping("/rest/modifyFacility")
	public FacilityBase modifyFacility(@RequestParam(name="facilityNo") Integer facilityNo) {
		FacilityBase facility = new FacilityBase();
		facility.setFacilityNo(facilityNo);
		
		FacilityBase resultFacility = new FacilityBase();
		resultFacility = facilityService.getFacilityByNo(facility);
		
		return resultFacility;
	}
	
	//추가,수정 시 이름 중복검사
	@PostMapping("/rest/nameCheck")
	public int nameCheck(@RequestParam(name="facilityName") String facilityName,
						@RequestParam(name="facilityNo", defaultValue = "-1") Integer facilityNo) {
		FacilityBase facility = new FacilityBase();
		facility.setFacilityName(facilityName);
		facility.setFacilityNo(facilityNo);
		
		int cnt = facilityService.getNameCheck(facility);
		
		return cnt;
	}
}
