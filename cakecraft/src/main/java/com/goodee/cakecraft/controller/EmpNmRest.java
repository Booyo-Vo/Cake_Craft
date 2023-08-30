package com.goodee.cakecraft.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.EmpService;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@CrossOrigin
@RestController
public class EmpNmRest {
	@Autowired
	private EmpService emp;
	
	@PostMapping("/searchEmpListByNm")
	public List<HashMap<String, Object>> getEmpListByNm(String empName) {
		log.debug(empName + " <-- empName");
		
		List<HashMap<String, Object>> EmpListByNm = emp.getEmpListByNm(empName);
		log.debug(EmpListByNm + " <-- EmpListByNm");
		return EmpListByNm;
	}
}
