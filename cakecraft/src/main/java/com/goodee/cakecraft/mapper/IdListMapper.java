package com.goodee.cakecraft.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;
@Mapper
public interface IdListMapper {
	// 아이디 비밀번호추가
	int insertIdList(EmpBase empbase);
	
	// 아이디 비밀번호삭제
	int deleteIdList(String id);
	
	//로그인
	//EmpIdList 객체를 파라미터로 받아 회원정보를 db에서 조회
	EmpIdList selectMemberById(EmpIdList empIdList);
	
}
