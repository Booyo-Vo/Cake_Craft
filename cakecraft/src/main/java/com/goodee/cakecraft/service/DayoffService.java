package com.goodee.cakecraft.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.DayoffMapper;
import com.goodee.cakecraft.vo.EmpDayoff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class DayoffService {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private DayoffMapper dayoffMapper;
	
	// 관리자가 보는 사원리스트
	public EmpDayoff getdayoffById(String id){
		//사원리스트 받아오기
		EmpDayoff empDayoff = dayoffMapper.selectDayoffById(id);
			
		return empDayoff;
	}
}
