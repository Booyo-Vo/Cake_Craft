package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.StStdCd;
@Mapper
public interface StStdCdMapper {
	//각 grp_cd에 따른 리스트 받아오기
	List<StStdCd> selectStStdCdList(String code);
	
	//각 부서에 따른 팀리스트 받아오기
	List<StStdCd> selectTeamListByDept(String deptCd);
}
