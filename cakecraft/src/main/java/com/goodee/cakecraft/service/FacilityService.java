package com.goodee.cakecraft.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.FacilityMapper;
import com.goodee.cakecraft.vo.FacilityBase;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FacilityService {
	@Autowired FacilityMapper facilityMapper;
	@Autowired CommonMapper commonMapper;
	
	//ANSI코드
	final String KMJ = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	//시설비품리스트 출력
	public List<FacilityBase> getFacilityList(Map<String, Object> paramMap){
		List<FacilityBase> resultList = facilityMapper.selectFacilityList(paramMap);
		log.debug(KMJ + resultList.toString() + RESET);
		log.debug(KMJ + paramMap.toString() + RESET);
		return resultList;
	}
	
	//시설비품추가
	public int addFacility(FacilityBase facility, String loginId){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("regId", loginId);
		paramMap.put("facility", facility);
		
		int addFacilityRow = facilityMapper.insertFacility(paramMap);
		return addFacilityRow;
	}
	
	//시설비품 수정
	public int modifyFacility(FacilityBase facility, String loginId){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("id", loginId);
		paramMap.put("facility", facility);
		
		int modFacilityRow = facilityMapper.updateFacility(paramMap);
		return modFacilityRow;
	}
	
	//시설비품번호로 상세정보 반환
	public Map<String, Object> getFacilityByNo(FacilityBase facility){
		FacilityBase resultFacility = facilityMapper.selectFacilityByNo(facility);
		
		//코드 이름(분류) 가져오기
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("grpCd", "F001");
		paramMap.put("cd", resultFacility.getCategoryCd());
		
		String cdNm = commonMapper.getName(paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("facilityNo", resultFacility.getFacilityNo());
		resultMap.put("categoryCd", resultFacility.getCategoryCd());
		resultMap.put("cdNm", cdNm);
		resultMap.put("facilityName", resultFacility.getFacilityName());
		resultMap.put("facilityNote", resultFacility.getFacilityNote());
		resultMap.put("useYn", resultFacility.getUseYn());
		resultMap.put("regDtime", resultFacility.getRegDtime());
		resultMap.put("modDtime", resultFacility.getModDtime());
		resultMap.put("regId", resultFacility.getRegDtime());
		resultMap.put("modId", resultFacility.getModDtime());
		log.debug(KMJ + resultMap.toString() + RESET);
		return resultMap;
	}
	
	//시설비품 이름 중복확인
	public int getNameCheck(FacilityBase facility){
		int cnt = -1;
		cnt = facilityMapper.selectFacilityName(facility);
		log.debug(KMJ + cnt + RESET);
		
		return cnt;
	}
	
	//시설비품 공통코드 리스트 출력
	public List<StStdCd> getFacilityCdList(String cd){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cd", cd);
		List<StStdCd> cdList = facilityMapper.selectFacilityCdList(paramMap);
		return cdList;
	}
	
	//시설비품 카테고리이름 중복확인
	public int getCategoryNameCheck(StStdCd stStdCd){
		int cnt = -1;
		cnt = facilityMapper.selectCategoryName(stStdCd);
		log.debug(KMJ + cnt + RESET);
		
		return cnt;
	}
	
	//시설비품 카테고리 추가
	public int addFacilityCd(StStdCd stStdCd) {
		int addFcltRow = facilityMapper.insertCategoryCd(stStdCd);
		return addFcltRow;
	}
	
	//시설비품 사용여부 변경
	public int modifyFacilityCategory(StStdCd stStdCd) {
		int cnt = facilityMapper.selectFacilityCnt(stStdCd);
		
		int modRow = 0;
		if(stStdCd.getUseYn() != null) { //사용여부만 수정하는 경우
			if(cnt == 0 && stStdCd.getUseYn().equals("N")) { //해당 카테고리를 가진 시설비품이 0이고, Y에서 N으로 바꾸는 경우
				modRow = facilityMapper.updateCategory(stStdCd);
			} else if (stStdCd.getUseYn().equals("Y")) { //N에서 Y로 바꾸는 경우
				modRow = facilityMapper.updateCategory(stStdCd);
			}
		} else { //카테고리 이름을 수정하는 경우
			modRow = facilityMapper.updateCategory(stStdCd);
		}
		
		return modRow;
	}
	
	//시설,비품 별 카테고리 수
	public int getCategoryCnt(Map<String, Object> paramMap) {
		int cnt = facilityMapper.selectCategoryCnt(paramMap);
		return cnt;
	}
}
