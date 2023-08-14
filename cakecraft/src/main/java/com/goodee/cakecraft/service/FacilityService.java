package com.goodee.cakecraft.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.FacilityMapper;
import com.goodee.cakecraft.vo.FacilityBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FacilityService {
	@Autowired FacilityMapper facilityMapper;
	//ANSI코드
	final String BG_YELLOW = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	public List<FacilityBase> getFacilityList(Map<String, Object> paramMap){
		List<FacilityBase> resultList = facilityMapper.selectFacilityList(paramMap);
		log.debug(BG_YELLOW + resultList.toString() + RESET);
		log.debug(BG_YELLOW + paramMap.toString() + RESET);
		return resultList;
	}
	
	public int addFacility(Map<String, Object> paramMap){
		int addFacilityRow = facilityMapper.insertFacility(paramMap);
		return addFacilityRow;
	}
	
	public int modifyFacility(Map<String, Object> paramMap){
		int modFacilityRow = facilityMapper.updateFacility(paramMap);
		return modFacilityRow;
	}
	
	public FacilityBase getFacilityByNo(FacilityBase facility){
		FacilityBase resultFacility = facilityMapper.selectFacilityByNo(facility);
		log.debug(BG_YELLOW + resultFacility.toString() + RESET);
		return resultFacility;
	}
	
	public int getNameCheck(FacilityBase facility){
		int cnt = -1;
		cnt = facilityMapper.selectFacilityName(facility);
		log.debug(BG_YELLOW + cnt + RESET);
		
		return cnt;
	}
}
