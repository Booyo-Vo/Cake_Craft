package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.FacilityBase;
import com.goodee.cakecraft.vo.StStdCd;

@Mapper
public interface FacilityMapper {
	//시설비품 리스트 출력
	List<FacilityBase> selectFacilityList(Map<String, Object> paramMap);
	
	//시설비품 1개 출력(번호)
	FacilityBase selectFacilityByNo(FacilityBase facility);
	
	//시설비품 추가
	int insertFacility(Map<String, Object> paramMap);
	
	//시설비품정보 수정
	int updateFacility(Map<String, Object> paramMap);
	
	//이름 중복검사
	int selectFacilityName(FacilityBase facility);
	
	//시설/비품코드 출력
	List<StStdCd> selectFacilityCdList(Map<String, Object> paramMap);
	
	//시설/비품별 코드 수
	int selectCategoryCnt(Map<String, Object> paramMap);
	
	//특정 시설비품 수
	int selectFacilityCnt(StStdCd stStdCd);

	//시설/비품 코드 추가
	int insertCategoryCd(StStdCd stStdCd);
	
	//시설/비품 코드 사용여부 변경
	int updateCategoryUse(StStdCd stStdCd);
}
