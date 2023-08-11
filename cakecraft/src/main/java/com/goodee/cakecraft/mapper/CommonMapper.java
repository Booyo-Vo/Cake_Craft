package com.goodee.cakecraft.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonMapper {
	//코드 받아서 이름반환
	String getName(Map<String, Object> paramMap);
	
	//이름 받아서 코드 반환
	Map<String, Object> getCode(String cdNm);
}
