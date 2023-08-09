package com.goodee.cakecraft.service;

import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.mapper.CommonMapper;

@Service
public class CommonService {
	@Autowired CommonMapper commonMapper;
	
	//코드를 받아서 이름을 반환
	public String getCode(@RequestParam(name="code", defaultValue = "") String code){
		
		String grpCd = code.substring(0, 4);
		String cd = code.substring(5);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grpCd", grpCd);
		paramMap.put("cd", cd);
		String name = commonMapper.getName(paramMap);
		
		return name;
	} 
	
	//이름을 받아서 코드를 반환
	public String getName(@RequestParam(name="name", defaultValue = "") String name) {
		String code = commonMapper.getCode(name);
		
		return code;
	}
	 
}
