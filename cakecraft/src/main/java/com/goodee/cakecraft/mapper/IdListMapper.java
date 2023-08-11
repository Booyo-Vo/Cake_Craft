package com.goodee.cakecraft.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.EmpBase;
@Mapper
public interface IdListMapper {
	// 아이디 비밀번호추가
	int insertIdList(EmpBase empbase);
}
