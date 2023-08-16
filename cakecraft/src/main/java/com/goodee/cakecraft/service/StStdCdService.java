package com.goodee.cakecraft.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.StStdCdMapper;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class StStdCdService {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private StStdCdMapper stStdCdMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	//각 grp_cd에 따른 리스트 받아오기
	public List<StStdCd> getCdList(String code){
		List<StStdCd> cdList = stStdCdMapper.selectStStdCdList(code);
		log.debug(GREEN+"getCdList cdList :"+ cdList +RESET);	
		return cdList;
	}
	
	//부서이름이 선택되었을대 그 부서에 맞는 팀 가져오기
	public List<StStdCd> getTeamListByDept(String deptNm) {
	   log.debug(GREEN+"getTeamListByDept deptNm :"+ deptNm +RESET);	
	   // 부서이름이 넘어오면 부서 코드를 받아옴
	   Map<String, Object> deptCdMap = commonMapper.getCode(deptNm);
		//cd가 int이으로 toString() 해준다
		String deptCd = deptCdMap.get("cd").toString();
		log.debug(GREEN+"getTeamListByDept deptCd :"+ deptCd +RESET);
		
		//가져온 부서 코드로 부서에 맞는 팀을 가져온다
		List<StStdCd> teamListbyEmpt = stStdCdMapper.selectTeamListByDept(deptCd);
		log.debug(GREEN+"getTeamListByDept teamListbyEmpt :"+ teamListbyEmpt +RESET);	

	   return teamListbyEmpt;
    }
}
	
	