package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.FacilityReservation;

@Mapper
public interface ReservationMapper {
	//전체예약현황 가져오기
	List<FacilityReservation> selectReservationListByDate(Map<String, Object> paramMap);
	
	//id별 예약이력 가져오기
	List<FacilityReservation> selectReservationListById(Map<String, Object> paramMap);
	
	//시설비품별 예약가능 시간
	List<Map<String, Object>> selectReservationTime(Map<String, Object> paramMap);
	
	//예약하기
	int insertReservation(Map<String, Object> paramMap);
	
	//예약 수정하기
	int updateReservation(Map<String, Object> paramMap);
	
	//예약 취소하기
	int deleteReservation(Map<String, Object> paramMap);
	
}
