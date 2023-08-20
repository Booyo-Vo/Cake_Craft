package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.vo.EmpBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class EmpService {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	@Autowired
	private CommonMapper commonMapper;
	
	//마이페이지에 사원정보 출력
	public EmpBase getMyEmpById(String id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("id", id);

	    // 사원 상세내역
	    EmpBase resultEmpBase = empMapper.selectMyEmpById(paramMap);
	    log.debug(KMS + "resultEmpBase / EmpService" + resultEmpBase.toString() + RESET);

	    return resultEmpBase;
	}
	


}
