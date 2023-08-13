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
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private IdListMapper idlistMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	// 사원번호 생성 + 사원추가 + 아이디 비밀번호 추가
	public int addEmp(EmpBase empbase) {
		//공통메서드로 부서이름과 팀이름이 넘어오면, 코드 받아오기
		// 부서 코드 받아오기
		Map<String, Object> deptCdMap = commonMapper.getCode(empbase.getDeptNm());
		//cd가 int이으로 toString() 해준다
		String deptCd = deptCdMap.get("cd").toString();
		
		// 팀 코드 받아오기
		Map<String, Object> teamCdMap = commonMapper.getCode(empbase.getTeamNm());
		String teamCd = teamCdMap.get("cd").toString();
		
		// 직급 코드 받아오기
		Map<String, Object> positionCdMap = commonMapper.getCode(empbase.getPositionNm());
		String positionCd = positionCdMap.get("cd").toString();
		
		// empbase에 생성된 부서코드와 팀코드 추가
		empbase.setDeptCd(deptCd);
		empbase.setTeamCd(teamCd);
		empbase.setPositionCd(positionCd);
		
		//1) 사원번호 생성
		String id = empMapper.selectEmpId(empbase);
		// empbase에 생성된 사원번호 추가
		empbase.setId(id); 
		
		if (id!=null) {
			//2) 사원추가
			int insertEmpRow = empMapper.insertEmp(empbase);
		
			int insertIdListRow = 0;
			if (insertEmpRow > 0) {// 사원추가가 됐다면
				//3) id 비밀번호 추가
				insertIdListRow = idlistMapper.insertIdList(empbase);
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
			//직급 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", empbase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			//부서 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", empbase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", empbase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			//받아온 이름값 저장하기
			empbase.setDeptNm(deptNm);
	        empbase.setTeamNm(teamNm);
	        empbase.setPositionNm(positionNm);
		} 
		return adminEmpList;
	}
	
	// 관리자가 보는 사원상세내역
	public EmpBase getAdminEmpById(String id) {
		//사원상세내역 받아오기
		EmpBase empbase = empMapper.selectEmpById(id);
		 if (empbase != null) { 
			//직급 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", empbase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			//부서 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", empbase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", empbase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			//받아온 이름값 저장하기
			empbase.setDeptNm(deptNm);
	        empbase.setTeamNm(teamNm);
	        empbase.setPositionNm(positionNm);
		 }
		return empbase;
	}
}

