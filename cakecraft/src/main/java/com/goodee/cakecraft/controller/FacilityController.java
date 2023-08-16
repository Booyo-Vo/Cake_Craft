package com.goodee.cakecraft.controller;

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

import com.goodee.cakecraft.service.FacilityService;
import com.goodee.cakecraft.vo.FacilityBase;

import lombok.extern.slf4j.Slf4j;

@Controller
public class FacilityController {
	@Autowired FacilityService facilityService;
	//ANSI코드
	final String KMJ = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	//시설비품리스트 view
	@GetMapping("/facility/facilityList")
	public String facilityList(Model model,
							   @RequestParam(name="categoryCd", defaultValue = "A") String cateogryCd,
							   @RequestParam(name="useYn", defaultValue = "A") String useYn){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("categoryCd", cateogryCd);
		paramMap.put("useYn", useYn);
		List<FacilityBase> resultList = facilityService.getFacilityList(paramMap);
		
		String loginId = "admin1";
		/*Object o = session.getAttribute("loginId");
		if(o instanceof String) {
			loginId = (String)o;
		}*/
		
		model.addAttribute("loginId", loginId);
		model.addAttribute("resultList", resultList);
		
		return "/facility/facilityList";
	}
	
	//시설비품 추가 액션
	@PostMapping("/facility/addFacility")
	public String addFacility(HttpSession session,
							  @RequestParam(name="loginId") String loginId,
							  @RequestParam(name="categoryCd") String categoryCd,
							  @RequestParam(name="facilityName") String facilityName,
							  @RequestParam(name="facilityNote") String facilitiyNote,
							  @RequestParam(name="useYn") String useYn) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("categoryCd", categoryCd);
		paramMap.put("facilityName", facilityName);
		paramMap.put("facilityNote", facilitiyNote);
		paramMap.put("useYn", useYn);
		paramMap.put("regId", loginId);
		
		facilityService.addFacility(paramMap);
		
		return "redirect:/facility/facilityList";
	}
	
	//시설비품 수정 액션
	@PostMapping("/facility/modifyFacility")
	public String modifyFacility(HttpSession session,
								@RequestParam(name="facilityNo") int facilityNo,
							  	@RequestParam(name="loginId") String loginId,
							  	@RequestParam(name="categoryCd") String categoryCd,
							  	@RequestParam(name="facilityName") String facilityName,
							  	@RequestParam(name="facilityNote") String facilitiyNote,
							  	@RequestParam(name="useYn") String useYn) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("facilityNo", facilityNo);
		paramMap.put("categoryCd", categoryCd);
		paramMap.put("facilityName", facilityName);
		paramMap.put("facilityNote", facilitiyNote);
		paramMap.put("useYn", useYn);
		paramMap.put("regId", loginId);
		
		facilityService.modifyFacility(paramMap);
		
		return "redirect:/facility/facilityList";
	}
}
