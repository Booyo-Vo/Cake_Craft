package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.CommonService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	@Autowired CommonService commonService;
	
	//코드를 받아서 이름을 반환
	public String getCode(@RequestParam(name="code", defaultValue = "") String code){
		String name = commonService.getName(code);
		return name;
	} 
	
	//이름을 받아서 코드를 반환
	public String getName(@RequestParam(name="name", defaultValue = "") String name) {
		String code = commonService.getCode(name);
		
		return code;
	}
}
