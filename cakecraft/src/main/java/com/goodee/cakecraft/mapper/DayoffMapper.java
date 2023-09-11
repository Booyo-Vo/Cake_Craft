package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.EmpDayoff;

@Mapper
public interface DayoffMapper {
	// 연차리스트
	List<EmpDayoff> selectDayoffById(String id); 
	
	// 연차추가
	int insertDayoff(EmpDayoff empdayoff);
}
