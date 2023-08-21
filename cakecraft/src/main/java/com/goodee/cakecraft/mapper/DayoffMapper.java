package com.goodee.cakecraft.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.EmpDayoff;

@Mapper
public interface DayoffMapper {
	// 연차리스트
	EmpDayoff selectDayoffById(String id);
	
	// 연차추가
	int insertDayoff(EmpDayoff empdayoff);
}
