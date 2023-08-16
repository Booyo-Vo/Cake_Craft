package com.goodee.cakecraft.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class StStdController {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired 
	private StStdCdService stStdCdService;
	
    @GetMapping("getTeamListByDept")
    public List<StStdCd> teamListByDept(@RequestParam String deptNm) {
        List<StStdCd> teamList = stStdCdService.getTeamListByDept(deptNm);
        return teamList;
    }
}
	
