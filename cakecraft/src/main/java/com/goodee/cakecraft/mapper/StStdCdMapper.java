package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.StStdCd;
@Mapper
public interface StStdCdMapper {
	//각 grp_cd에 따른 리스트 받아오기
	List<StStdCd> selectStStdCdList(String code);
	
	//각 부서에 따른 팀리스트 받아오기
	List<StStdCd> selectTeamListByDept(String deptCd);
	
	//코드이름 중복확인
	int selectCdNmCnt(StStdCd stStdCd);
	
	//공통코드 추가 (부서 , 팀)
	int insertStStdCd(StStdCd stStdCd);
	
	//부서 카운트
	int selectDeptCnt(StStdCd stStdCd);
	
	//부서별 팀 카운트
	int selectTeamCnt(String code);
	
	//부서, 팀 이름 수정
	int updateCdNm(Map<String, Object> paramMap);
	
	//부서, 팀 삭제
	int deleteStStdCd(StStdCd stStdCd);
}
