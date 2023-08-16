package com.goodee.cakecraft.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StStdController {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired 
	private StStdCdService stStdCdService;
	
	// 선택된 부서에 따른 팀 리스트 받아오기
    @GetMapping("getTeamListByDept")
    @ResponseBody
	    public List<StStdCd> teamListByDept(@RequestParam String deptNm) {
	        List<StStdCd> teamList = stStdCdService.getTeamListByDept(deptNm);
	        return teamList;
    }

    @GetMapping("/stStdCd/stStdCdList")
    	public String stStdCdList(Model model) {
    	Map<String, Object> StStdCdListMap = stStdCdService.getStdStdCdList();
    	//뷰로 값넘기기
    	model.addAttribute("deptList", StStdCdListMap.get("deptList"));
    	model.addAttribute("teamListMap",StStdCdListMap); // 전체맵을 넘겨줌
		return "/stStdCd/stStdCdList";
    }
}