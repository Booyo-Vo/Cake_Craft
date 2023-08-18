package com.goodee.cakecraft.service;

import java.util.HashMap;



import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.mapper.IdListMapper;
import com.goodee.cakecraft.vo.EmpBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AdminEmpService {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private IdListMapper idlistMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	// 사원번호 생성 + 사원추가 + 아이디 비밀번호 추가
	public int addEmp(EmpBase empBase) {
		// 부서이름과 팀이름 직급이름이 넘어오면, DB에 입력할 코드 받아오기
		// 부서 코드 받아오기
		Map<String, Object> deptCdMap = commonMapper.getCode(empBase.getDeptNm());
		//맵에서 풀면서 toString 해준다 Object
		String deptCd = deptCdMap.get("cd").toString();
		log.debug(GREEN+"addEmp deptCd :"+ deptCd +RESET);
		
		// 팀 코드 받아오기
		Map<String, Object> teamCdMap = commonMapper.getCode(empBase.getTeamNm());
		String teamCd = teamCdMap.get("cd").toString();
		log.debug(GREEN+"addEmp teamCd :"+ teamCd +RESET);
		
		// 직급 코드 받아오기
		Map<String, Object> positionCdMap = commonMapper.getCode(empBase.getPositionNm());
		String positionCd = positionCdMap.get("cd").toString();
		log.debug(GREEN+"addEmp positionCd :"+ positionCd +RESET);
		
		// empbase에 생성된 부서코드와 팀코드 추가
		empBase.setDeptCd(deptCd);
		empBase.setTeamCd(teamCd);
		empBase.setPositionCd(positionCd);
		
		//1) 사원번호 생성
		String id = empMapper.selectEmpId(empBase);
		log.debug(GREEN+"addEmp id :"+ id +RESET);
		// empbase에 생성된 사원번호 추가
		empBase.setId(id); 
		
		if (id!=null) {
			//2) 사원추가
			int insertEmpRow = empMapper.insertEmp(empBase);
			log.debug(GREEN + "addEmp insertEmpRow :"+insertEmpRow + RESET);
			int insertIdListRow = 0;
			if (insertEmpRow > 0) {// 사원추가가 됐다면
				//3) id 비밀번호 추가
				insertIdListRow = idlistMapper.insertIdList(empBase);
				log.debug(GREEN + "addEmp insertIdListRow :"+insertIdListRow + RESET);
			}
		        // 사원 정보 추가 및 비밀번호 추가 결과 반환
		        return insertIdListRow;
		    }
		    
		    // 사원번호 생성 실패 시 반환
		    return 0;
		}
	
	// 관리자가 보는 사원리스트
	public List<EmpBase> getEmpList(){
		//사원리스트 받아오기
		List<EmpBase> adminEmpList = empMapper.selectEmpList();
		
		for (EmpBase empbase : adminEmpList) {
			//부서 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", empbase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			log.debug(GREEN + "adminEmpList deptNm :"+ deptNm + RESET);
			
			//팀 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", empbase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			log.debug(GREEN + "adminEmpList teamNm :"+ teamNm + RESET);
			
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", empbase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			log.debug(GREEN + "adminEmpList positionNm :"+ positionNm + RESET);
			//받아온 이름값 저장하기
			empbase.setDeptNm(deptNm);
	        empbase.setTeamNm(teamNm);
	        empbase.setPositionNm(positionNm);
		} 
		return adminEmpList;
	}
	
	// 관리자가 보는 사원상세내역
	public EmpBase getAdminEmpById(String id) {
		log.debug(GREEN + "EmpById id :"+ id + RESET);
		
		//사원상세내역 받아오기
		EmpBase empbase = empMapper.selectEmpById(id);
		 if (empbase != null) { 
			//부서 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", empbase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			log.debug(GREEN + "EmpById deptNm :"+ deptNm + RESET);
			//팀 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", empbase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			log.debug(GREEN + "EmpById teamNm :"+ teamNm + RESET);
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", empbase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			log.debug(GREEN + "EmpById positionNm :"+ positionNm + RESET);
			//받아온 이름값 저장하기
			empbase.setDeptNm(deptNm);
	        empbase.setTeamNm(teamNm);
	        empbase.setPositionNm(positionNm);
		 }
		return empbase;
	}
	
	// 관리자가 하는 사원정보수정
	public int modifyEmp(EmpBase empBase) {
		//퇴사자로 정보변경이 된다면
		if (empBase.getEmpStatus().equals("퇴사자")) {
			//아이디리스트에서 삭제한다
			int deleteIdListrow = idlistMapper.deleteIdList(empBase.getId());
			log.debug(GREEN+"modifyEmp deleteIdListrow :"+ deleteIdListrow);
		}
		// 부서이름과 팀이름 직급이름이 넘어오면, DB에 입력할 코드 받아오기
		Map<String, Object> deptCdMap = commonMapper.getCode(empBase.getDeptNm());
		//cd가 int이으로 toString() 해준다
		String deptCd = deptCdMap.get("cd").toString();
		log.debug(GREEN + "modifyEmp deptCd :"+ deptCd + RESET);
		
		
		// 팀 코드 받아오기
		Map<String, Object> teamCdMap = commonMapper.getCode(empBase.getTeamNm());
		String teamCd = teamCdMap.get("cd").toString();
		log.debug(GREEN + "modifyEmp teamCd :"+ teamCd + RESET);
		
		
		// 직급 코드 받아오기
		Map<String, Object> positionCdMap = commonMapper.getCode(empBase.getPositionNm());
		String positionCd = positionCdMap.get("cd").toString();
		log.debug(GREEN + "modifyEmp positionCd :"+ positionCd + RESET);
		
		
		// empbase에 생성된 부서코드와 팀코드 추가
		empBase.setDeptCd(deptCd);
		empBase.setTeamCd(teamCd);
		empBase.setPositionCd(positionCd);
		
		int updaterow = empMapper.updateEmp(empBase);
		log.debug(GREEN + "modifyEmp updaterow :"+ updaterow + RESET);
		return updaterow;
	}
}

