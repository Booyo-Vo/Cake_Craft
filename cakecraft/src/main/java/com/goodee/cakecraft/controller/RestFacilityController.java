package com.goodee.cakecraft.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.FacilityBase;
import com.goodee.cakecraft.vo.StStdCd;

@RestController
public class RestFacilityController {
	@Autowired FacilityService facilityService;

	//수정 모달창에 출력할 정보
	@PostMapping("/rest/modifyFacility")
	public Map<String, Object> modifyFacility(FacilityBase facility) {
		Map<String, Object> resultFacility = facilityService.getFacilityByNo(facility);
		
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
	
	//시설비품 카테고리 코드 생성
	@PostMapping("/rest/getCode")
	public String getCode(@RequestParam(name="cd") String cd) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cd", cd+"%");
		int cnt = facilityService.getCategoryCnt(paramMap);
		String code = cd + (cnt+1);
		return code;
	}
	
	//시설비품 사용여부 변경
	@PostMapping("/rest/modifyFacilityCategory")
	public int modifyFacilityUse(HttpSession session,
								 StStdCd stStdCd) {
		String loginId = "";
		Object o = session.getAttribute("loginMember");
		if(o instanceof EmpIdList) {
			loginId = ((EmpIdList)o).getId();
		}
		
		stStdCd.setRegId(loginId);
		
		int modRow = facilityService.modifyFacilityCategory(stStdCd);
		return modRow;
	}
	
	//시설비품 검색조건(시설/비품) 별 리스트 출력
	@PostMapping("/rest/listBySearch")
	public List<StStdCd> listBySearch(@RequestParam(name="cd") String cd){
		List<StStdCd> searchList = facilityService.getFacilityCdList(cd);
		return searchList;
	}
	
	//카테고리 이름 중복검사
	@PostMapping("/rest/categoryNameCheck")
	public int categoryNameCheck(StStdCd stStdCd) {
		int row = facilityService.getCategoryNameCheck(stStdCd);
		return row;
	}
	
	//시설비품 추후 예약 수
	@PostMapping("/rest/getReservationCnt")
	public int getReservationCnt(FacilityBase facility) {
		int cnt = facilityService.getReservationCnt(facility);
		return cnt;
	}
}
