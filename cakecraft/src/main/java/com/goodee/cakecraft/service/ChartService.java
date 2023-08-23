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
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	
	// 해당년도 입사자, 퇴사자
	public Map<String, Object> getYearCnt(String year) {
		//해당년도 입사자
		int hireYearCnt = empMapper.selectHireYearCnt(year);
		log.debug(LJY + hireYearCnt +"<- getYearCnt hireYearCnt"+ RESET);
		//해당년도 퇴사자
		int retireYearCnt = empMapper.selectRetireYearCnt(year);
		log.debug(LJY + retireYearCnt +"<- getYearCnt retireYearCnt"+ RESET);
		
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
		log.debug(LJY + hireMonthCnt +"<- getMonthCnt hireMonthCnt"+ RESET);
		//해당월 퇴사자
		int retireMonthCnt = empMapper.selectRetireMonthCnt(month);
		log.debug(LJY + retireMonthCnt +"<- getMonthCnt retireMonthCnt"+ RESET);
		
		//Map으로 묶어서 넘기기
		Map<String, Object> MonthCntMap = new HashMap<String, Object>();
		MonthCntMap.put("hireMonthCnt", hireMonthCnt);
		MonthCntMap.put("retireMonthCnt", retireMonthCnt);
		return MonthCntMap;
	}
	
	
	// 직급별 인원수
    public List<Map<String, Object>> getPositionCnt() {
    	List<Map<String, Object>> positionCnt = empMapper.selectPositionCnt();
    	log.debug(LJY+"getPositionCnt positionCnt :"+ positionCnt +RESET); 
    	log.debug(LJY + positionCnt +"<- getPositionCnt positionCnt"+ RESET);
    	return positionCnt;
    }
    
	// 부서별 인원수
    public List<Map<String, Object>> getDeptCnt() {
    	List<Map<String, Object>> deptCnt = empMapper.selectDeptCnt();
    	log.debug(LJY + deptCnt +"<- getDeptCnt deptCnt"+ RESET);
    	return deptCnt;
    }
    
	// 팀별 인원수
    public List<Map<String, Object>> getTeamCnt() {
    	List<Map<String, Object>> teamCnt = empMapper.selectTeamCnt();
    	log.debug(LJY + teamCnt +"<- getTeamCnt teamCnt"+ RESET);
    	return teamCnt;
    }
    //성별 인원수
    public List<Map<String, Object>> getGenderCnt() {
    	List<Map<String, Object>> genderCnt = empMapper.selectGenderCnt();
    	log.debug(LJY + genderCnt +"<- getGenderCnt genderCnt"+ RESET);
    	return genderCnt;
    }
}
