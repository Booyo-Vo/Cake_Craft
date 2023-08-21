package com.goodee.cakecraft.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpSignImg;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class EmpService {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	@Autowired
	private CommonMapper commonMapper;
	
	//마이페이지에 사원정보 출력
	public EmpBase getMyEmpById(String id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("id", id);

	    // 사원 상세내역
	    EmpBase resultEmpBase = empMapper.selectMyEmpById(id);
	    log.debug(KMS + "resultEmpBase / EmpService" + resultEmpBase.toString() + RESET);
	    
	    if (resultEmpBase != null) { 
			//부서 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", resultEmpBase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			log.debug(KMS + "EmpById deptNm :"+ deptNm + RESET);
			//팀 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", resultEmpBase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			log.debug(KMS + "EmpById teamNm :"+ teamNm + RESET);
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", resultEmpBase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			log.debug(KMS + "EmpById positionNm :"+ positionNm + RESET);
			//받아온 이름값 저장하기
			resultEmpBase.setDeptNm(deptNm);
			resultEmpBase.setTeamNm(teamNm);
			resultEmpBase.setPositionNm(positionNm);
		 }
	    return resultEmpBase;
	}
	//프로필 사진 업로드
	 public String uploadProfileImage(MultipartFile file, String id) throws IOException {
	        // 이미지 저장 경로 설정
		    String uploadDir = "/webapp/profileImg";
		    String fileName = id + "_" + file.getOriginalFilename();
		    String filePath = Paths.get(uploadDir, fileName).toString();
		    
		    File dest = new File(filePath);
		    file.transferTo(dest);
		    
		    return fileName; // 저장된 파일명 반환
	}
	// 프로필 사진 경로 업데이트 
    public void updateProfileImagePath(String id, String profilePath) {
        //컨트롤러에서 프로필 이미지 업로드 -> 업로드된 경로를 데이터베이스에 업데이트
    	empMapper.updateProfileImagePath(id, profilePath);
    }


	// 사원이 보는 사원리스트
		public List<EmpBase> getEmpList(){
			//사원리스트 받아오기
			List<EmpBase> empList = empMapper.selectEmpList();
			
			for (EmpBase empbase : empList) {
				//부서 이름 받아오기
				Map<String, Object> deptparamMap = new HashMap<String, Object>();
				deptparamMap.put("grpCd", "D001");
				deptparamMap.put("cd", empbase.getDeptCd());
				String deptNm = commonMapper.getName(deptparamMap);
				log.debug(KMS + "adminEmpList deptNm :"+ deptNm + RESET);
				
				//팀 이름 받아오기
				Map<String, Object> teamparamMap = new HashMap<String, Object>();
				teamparamMap.put("grpCd", "T001");
				teamparamMap.put("cd", empbase.getTeamCd());
				String teamNm = commonMapper.getName(teamparamMap);
				log.debug(KMS + "adminEmpList teamNm :"+ teamNm + RESET);
				
				//직급 이름 받아오기
				Map<String, Object> positionparamMap = new HashMap<String, Object>();
				positionparamMap.put("grpCd", "P001");
				positionparamMap.put("cd", empbase.getPositionCd());
				String positionNm = commonMapper.getName(positionparamMap);
				log.debug(KMS + "adminEmpList positionNm :"+ positionNm + RESET);
				//받아온 이름값 저장하기
				empbase.setDeptNm(deptNm);
		        empbase.setTeamNm(teamNm);
		        empbase.setPositionNm(positionNm);
			} 
			return empList;
		}
		// 사원 상세내역
		public EmpBase getEmpById(String id) {
			log.debug(KMS + "EmpById id :"+ id + RESET);
			
			//사원상세내역 받아오기
			EmpBase empbase = empMapper.selectEmpById(id);
			EmpSignImg empSignImg = new EmpSignImg();
			 if (empbase != null) { 
				//부서 이름 받아오기
				Map<String, Object> deptparamMap = new HashMap<String, Object>();
				deptparamMap.put("grpCd", "D001");
				deptparamMap.put("cd", empbase.getDeptCd());
				String deptNm = commonMapper.getName(deptparamMap);
				log.debug(KMS + "EmpById deptNm :"+ deptNm + RESET);
				//팀 이름 받아오기
				Map<String, Object> teamparamMap = new HashMap<String, Object>();
				teamparamMap.put("grpCd", "T001");
				teamparamMap.put("cd", empbase.getTeamCd());
				String teamNm = commonMapper.getName(teamparamMap);
				log.debug(KMS + "EmpById teamNm :"+ teamNm + RESET);
				//직급 이름 받아오기
				Map<String, Object> positionparamMap = new HashMap<String, Object>();
				positionparamMap.put("grpCd", "P001");
				positionparamMap.put("cd", empbase.getPositionCd());
				String positionNm = commonMapper.getName(positionparamMap);
				log.debug(KMS + "EmpById positionNm :"+ positionNm + RESET);
				//받아온 이름값 저장하기
				empbase.setDeptNm(deptNm);
		        empbase.setTeamNm(teamNm);
		        empbase.setPositionNm(positionNm);
		        empSignImg.setSignFilename(id);

			 }
			return empbase;
		}
		//사원정보수정
		public int modifyMyEmp(EmpBase empBase) {
			
			// 부서이름과 팀이름 직급이름이 넘어오면, DB에 입력할 코드 받아오기
			Map<String, Object> deptCdMap = commonMapper.getCode(empBase.getDeptNm());
			//cd가 int이으로 toString() 해준다
			String deptCd = deptCdMap.get("cd").toString();
			log.debug(KMS + "modifyEmp deptCd :"+ deptCd + RESET);
			// 팀 코드 받아오기
			Map<String, Object> teamCdMap = commonMapper.getCode(empBase.getTeamNm());
			String teamCd = teamCdMap.get("cd").toString();
			log.debug(KMS + "modifyEmp teamCd :"+ teamCd + RESET);
			// 직급 코드 받아오기
			Map<String, Object> positionCdMap = commonMapper.getCode(empBase.getPositionNm());
			String positionCd = positionCdMap.get("cd").toString();
			log.debug(KMS + "modifyEmp positionCd :"+ positionCd + RESET);
			
			
			// empbase에 생성된 부서코드와 팀코드 추가
			empBase.setDeptCd(deptCd);
			empBase.setTeamCd(teamCd);
			empBase.setPositionCd(positionCd);
			
			int updaterow = empMapper.updateEmp(empBase);
			log.debug(KMS + "modifyEmp updaterow :"+ updaterow + RESET);
			return updaterow;
		}
}
