package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.EmpBase;

@Mapper
public interface EmpMapper {
	// 사원번호생성 
	String selectEmpId(EmpBase empbase);
	// 사원추가
	int insertEmp(EmpBase empbase);
	// 사원리스트
	List<EmpBase> selectEmpList();
	// 사원상세내역
	EmpBase selectEmpById(String id);
}
