package com.goodee.cakecraft.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.DayoffMapper;
import com.goodee.cakecraft.vo.EmpDayoff;


@Service
@Transactional
public class DayoffService {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private DayoffMapper dayoffMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	// 연차리스트 받아오기
	public List<EmpDayoff> getdayoffById(String id){
		//연차리스트
		List<EmpDayoff> empDayoffList = dayoffMapper.selectDayoffById(id);
		
		for (EmpDayoff empDayoff : empDayoffList) {
			String startDay = empDayoff.getStartDay();
			String endDay = empDayoff.getEndDay();
			//연차 시작일 종료일 초단위 자르기 
			if (startDay != null) {
				empDayoff.setStartDay(startDay.substring(0, startDay.length() - 3));
			}

			if (endDay != null) {
				empDayoff.setEndDay(endDay.substring(0, endDay.length() - 3));
			}
			
			//연차 코드로 이름받아오기
			Map<String, Object> dayoffMap = new HashMap<String, Object>();
			dayoffMap.put("grpCd", "A003");
			dayoffMap.put("cd", empDayoff.getDayoffStatus());
			String DayoffStatusNm = commonMapper.getName(dayoffMap);
			empDayoff.setDayoffStatusNm(DayoffStatusNm);
		}
		
		return empDayoffList;
	}
}
