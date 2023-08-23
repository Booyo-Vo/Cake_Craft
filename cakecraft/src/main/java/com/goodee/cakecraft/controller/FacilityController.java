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
import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.FacilityBase;
import com.goodee.cakecraft.vo.StStdCd;

@Controller
public class FacilityController {
	@Autowired FacilityService facilityService;
	
	//ANSI코드
	final String KMJ = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	//시설비품리스트 view
	@GetMapping("/facility/facilityList")
	public String facilityList(HttpSession session,
							   Model model,
							   @RequestParam(name="categoryCd", defaultValue = "A") String cateogryCd,
							   @RequestParam(name="useYn", defaultValue = "A") String useYn){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("categoryCd", cateogryCd);
		paramMap.put("useYn", useYn);
		List<FacilityBase> resultList = facilityService.getFacilityList(paramMap);
		
		String loginId = "";
		Object o = session.getAttribute("loginMember");
		if(o instanceof EmpIdList) {
			loginId = ((EmpIdList)o).getId();
		}
		List<StStdCd> categoryCdList = facilityService.getFacilityCdList("A");
		
		model.addAttribute("loginId", loginId);
		model.addAttribute("resultList", resultList);
		model.addAttribute("categoryCdList", categoryCdList);
		return "/facility/facilityList";
	}
	
	//시설비품 추가 액션
	@PostMapping("/facility/addFacility")
	public String addFacility(HttpSession session,
							  @RequestParam(name="loginId") String loginId,
							  FacilityBase facility) {
		
		facilityService.addFacility(facility, loginId);
		
		return "redirect:/facility/facilityList";
	}
	
	//시설비품 수정 액션
	@PostMapping("/facility/modifyFacility")
	public String modifyFacility(HttpSession session,
								 @RequestParam(name="loginId") String loginId,
								 FacilityBase facility) {
		
		facilityService.modifyFacility(facility, loginId);
		
		return "redirect:/facility/facilityList";
	}
	
	//시설비품 카테고리 관리view
	@GetMapping("/facility/categoryList")
	public String categoryList(HttpSession session,
							   Model model,
							   @RequestParam(name="cd", defaultValue = "1") String cd) {
		/*
		 * if(!cd.equals("1")) { cd = cd + "%"; }
		 */
		
		String loginId = "";
		Object o = session.getAttribute("loginMember");
		if(o instanceof EmpIdList) {
			loginId = ((EmpIdList)o).getId();
		}
		
		List<StStdCd> cdList = facilityService.getFacilityCdList("A"); 
		model.addAttribute("cdList", cdList);
		model.addAttribute("loginId", loginId);
		return "/facility/categoryList";
	}
	
	@PostMapping("/facility/addFacilityCd")
	public String addFacilityCd(StStdCd stStdCd) {
		facilityService.addFacilityCd(stStdCd);
		return "redirect:/facility/categoryList";
	}
	
}
