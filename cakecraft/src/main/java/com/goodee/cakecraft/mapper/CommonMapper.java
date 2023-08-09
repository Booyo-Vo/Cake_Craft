package com.goodee.cakecraft.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonMapper {
	String getName(Map<String, Object> paramMap);
	
	String getCode(String name);
}
