package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.EmpMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ChartService {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	
	// 해당년도 입사자, 퇴사자
	public Map<String, Object> getYearCnt(String year) {
		//해당년도 입사자
		int hireYearCnt = empMapper.selectHireYearCnt(year);
		log.debug(GREEN+"getYearCnt hireYearCnt :"+ hireYearCnt +RESET);
		//해당년도 퇴사자
		int retireYearCnt = empMapper.selectRetireYearCnt(year);
		log.debug(GREEN+"getYearCnt retireYearCnt :"+ retireYearCnt +RESET);
		
		//Map으로 묶어서 넘기기
		Map<String, Object> YearCntMap = new HashMap<String, Object>();
		YearCntMap.put("hireYearCnt", hireYearCnt);
		YearCntMap.put("retireYearCnt", retireYearCnt);
		return YearCntMap;
	}
	
	// 해당월 입사자, 퇴사자
	public Map<String, Object> getMonthCnt(String month) {
		//해당월 입사자
		int hireMonthCnt = empMapper.selectHireMonthCnt(month);
		log.debug(GREEN+"getMonthCnt hireMonthCnt :"+ hireMonthCnt +RESET);
		//해당월 퇴사자
		int retireMonthCnt = empMapper.selectRetireMonthCnt(month);
		log.debug(GREEN+"getMonthCnt retireMonthCnt :"+ retireMonthCnt +RESET);
		
		//Map으로 묶어서 넘기기
		Map<String, Object> MonthCntMap = new HashMap<String, Object>();
		MonthCntMap.put("hireMonthCnt", hireMonthCnt);
		MonthCntMap.put("retireMonthCnt", retireMonthCnt);
		return MonthCntMap;
	}
	
	
	// 직급별 인원수
    public List<Map<String, Object>> getPositionCnt() {
    	List<Map<String, Object>> positionCnt = empMapper.selectPositionCnt();
    	log.debug(GREEN+"getPositionCnt positionCnt :"+ positionCnt +RESET);   	
    	return positionCnt;
    }
    
	// 부서별 인원수
    public List<Map<String, Object>> getDeptCnt() {
    	List<Map<String, Object>> deptCnt = empMapper.selectDeptCnt();
    	log.debug(GREEN+"getDeptCnt deptCnt :"+ deptCnt +RESET);  
    	return deptCnt;
    }
    
	// 팀별 인원수
    public List<Map<String, Object>> getTeamCnt() {
    	List<Map<String, Object>> teamCnt = empMapper.selectTeamCnt();
    	log.debug(GREEN+"getTeamCnt teamCnt :"+ teamCnt +RESET);  
    	return teamCnt;
    }
    //성별 인원수
    public List<Map<String, Object>> getGenderCnt() {
    	List<Map<String, Object>> genderCnt = empMapper.selectGenderCnt();
    	log.debug(GREEN+"getGenderCnt genderCnt :"+ genderCnt +RESET);  
    	return genderCnt;
    }
}
