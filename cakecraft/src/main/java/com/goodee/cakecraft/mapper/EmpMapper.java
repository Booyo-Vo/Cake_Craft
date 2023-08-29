package com.goodee.cakecraft.mapper;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpProfileImg;
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
	int selectHireMonthCnt(String month, String year);
	
	// 해당월 퇴사자
	int selectRetireMonthCnt(String month, String year);
	
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
	// 사원 마이페이지에서 사원리스트 출력
	List<EmpBase> selectMyEmpList(String searchWord);
	
	// 사원 마이페이지 출력
	EmpBase selectMyEmpById(Map<String, Object> paramMap);
	
	// 사원이 보는 마이페이지 출력(empBase + signImg + profileImg)
	EmpBase selectMyEmpById(String id);
	
	// 사인 등록
	public int insertSign(EmpSignImg sign);
	
	// 사인 삭제
	public int removeSign(EmpSignImg sign);

	// 사원이 보는 마이페이지 수정(empBase + profileImg 수정 cf. signImg는 마이페이지 출력 창에서 )
	int updateEmpInfo(EmpBase empBase);
	
	int updateEmpProfilePic(EmpProfileImg empProfileImg);

	int deleteEmpProfilePic(EmpBase empBase);
	
	// 헤더에 프로필 사진 띄우는 용
	String getProfileImagePath(String id);
	
	// 비밀번호 변경
	void updateEmployee(EmpBase empBase);
	void changePassword(@Param("id") String id, @Param("newPassword") String newPassword);
	
	//게시판에 프로필 파일 추가
	int insertEmpProfileImg(EmpProfileImg empProfileImg);
	
	List<EmpProfileImg> selectEmpProfileImg(EmpBase empBase);
	
	void updateProfileImagePath(EmpProfileImg empProfileImg);
}