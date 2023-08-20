package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.vo.EmpBase;

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
	    EmpBase resultEmpBase = empMapper.selectMyEmpById(paramMap);
	    log.debug(KMS + "resultEmpBase / EmpService" + resultEmpBase.toString() + RESET);

	    return resultEmpBase;
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
			 }
			return empbase;
		}

}
