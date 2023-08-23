package com.goodee.cakecraft.mapper;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpSignImg;
import com.goodee.cakecraft.vo.StStdCd;
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
	
	// 사원수정
	int updateEmp(EmpBase empbase);
	
	// 해당년도 입사자
	int selectHireYearCnt(String year);
	
	// 해당년도 퇴사자
	int selectRetireYearCnt(String year);
	
	// 해당월 입사자
	int selectHireMonthCnt(String month);
	
	// 해당월 퇴사자
	int selectRetireMonthCnt(String month);
	
	// 직급별 인원수 조회
    List<Map<String, Object>> selectPositionCnt();
    
	// 부서별 인원수
    List<Map<String, Object>> selectDeptCnt();
    
    //팀별 인원수
    List<Map<String, Object>> selectTeamCnt();
   
    
    //성별 인원수
    List<Map<String, Object>> selectGenderCnt();
    
    // 부서/팀 번호에 따른 사원존재여부
 	int selectEmpCntByCd(StStdCd stStdCd);
 	
 	//////////////////////////// 사원 마이페이지 //////////////////////// 	
    // 사원 마이페이지 출력
 	EmpBase selectMyEmpById(Map<String, Object> paramMap);
 	
 	// 사원이 보는 마이페이지 출력(empBase + signImg + profileImg)
 	EmpBase selectMyEmpById(String id);
 	
 	// 프로필 사진 출력
 	void updateProfileImagePath(@Param("id") String id, @Param("profilePath") String profilePath);
 	
 	// 사인 등록
 	public int insertSign(EmpSignImg sign);
 	
 	// 사인 삭제
  	public int removeSign(EmpSignImg sign);
}