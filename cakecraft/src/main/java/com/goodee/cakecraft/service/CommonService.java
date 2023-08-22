package com.goodee.cakecraft.service;

import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodee.cakecraft.mapper.CommonMapper;

@Service
public class CommonService {
	@Autowired CommonMapper commonMapper;
	
	//코드를 받아서 이름을 반환
	public String getName(String grpCd, String cd){
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grpCd", grpCd);
		paramMap.put("cd", cd);
		String cdNm = commonMapper.getName(paramMap);
		
		return cdNm;
	} 
	
	//이름을 받아서 코드를 반환
	public Map<String, Object> getCode(String cdNm) {
		Map<String, Object> codeMap = commonMapper.getCode(cdNm);
		
		return codeMap;
	}
	 
}
