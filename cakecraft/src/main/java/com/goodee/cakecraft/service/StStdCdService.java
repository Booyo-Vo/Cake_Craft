package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.StStdCdMapper;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class StStdCdService {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private StStdCdMapper stStdCdMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	//각 grp_cd에 따른 리스트 받아오기
	public List<StStdCd> getCdList(String code){
		List<StStdCd> cdList = stStdCdMapper.selectStStdCdList(code);
		log.debug(GREEN+"getCdList cdList :"+ cdList +RESET);	
		return cdList;
	}
	
	//부서이름이 선택되었을대 그 부서에 맞는 팀 가져오기
	public List<StStdCd> getTeamListByDept(String deptNm) {
	   log.debug(GREEN+"getTeamListByDept deptNm :"+ deptNm +RESET);	
	   // 부서이름이 넘어오면 부서 코드를 받아옴
	   Map<String, Object> deptCdMap = commonMapper.getCode(deptNm);
		//cd가 int이으로 toString() 해준다
		String deptCd = deptCdMap.get("cd").toString();
		log.debug(GREEN+"getTeamListByDept deptCd :"+ deptCd +RESET);
		
		//가져온 부서 코드로 부서에 맞는 팀을 가져온다
		List<StStdCd> teamListbyEmpt = stStdCdMapper.selectTeamListByDept(deptCd);
		log.debug(GREEN+"getTeamListByDept teamListbyEmpt :"+ teamListbyEmpt +RESET);	

	   return teamListbyEmpt;
	   
	  
    }
	//관리자가 보는 부서, 팀관리 리스트
	public Map<String, Object> getStdStdCdList(){
		//부서,팀 코드 설정
		String deptCode = "D001";
	    // 부서리스트 받아오기
	    List<StStdCd> deptList = stStdCdMapper.selectStStdCdList(deptCode);
	    
	    //리스트를 담아 보낼 맵선언
	    Map<String, Object> StStdCdListMap = new HashMap<>();
	    
	    //부서 리스트 안에서
	    for (StStdCd dept : deptList) {
	    	// 부서 코드를 가져옴 int 타입이라 String 으로 반환함
	    	String deptCd = dept.getCd();
	    	log.debug(GREEN + "getStdStdCdList deptCd :"+ deptCd + RESET);	
	    	//코드를 받아와 해당 팀리스트 받아오기
	    	List<StStdCd> teamList = stStdCdMapper.selectTeamListByDept(deptCd);
	    	//부서코드마다 고유한 키를 생성하여 담기
	    	StStdCdListMap.put(deptCd, teamList);
	    }
	    //맵에 부서 리스트 담기
	    StStdCdListMap.put("deptList", deptList);
	    return StStdCdListMap; 
	}
	
	//부서추가
	public int addDept(StStdCd stStdCd) {
		//부서 코드설정 
		String deptCd = "D001";
		stStdCd.setGrpCd(deptCd);
		//1) 입력된 부서이름 중복확인
		int deptNmCnt = stStdCdMapper.selectCdNmCnt(stStdCd);
		log.debug(GREEN+"addDept deptNmCnt :"+ deptNmCnt +RESET);
	    if (deptNmCnt > 0) {
	        return -1; // 중복된 값이 있음을 나타내는 음수
	    }
		// cd값 추가를 위해 count+1을 하여 cd값에 넣어준다 
		int deptCnt =  stStdCdMapper.selectDeptCnt(stStdCd);
		log.debug(GREEN+"addDept deptCnt :"+ deptCnt +RESET);
		stStdCd.setCd(String.valueOf(deptCnt + 1));
		log.debug(GREEN+"addDept stStdCd :"+ stStdCd +RESET);
		//2) 부서이름 추가하기
		int insertDeptrow = stStdCdMapper.insertStStdCd(stStdCd);
		
	return insertDeptrow;
	}
	
	//팀 추가
	public int addTeam(StStdCd stStdCd, String teamDeptNm, String teamNm) {
	//팀 코드설정 
	String deptCd = "T001";
	stStdCd.setGrpCd(deptCd);

	//1) 입력된 팀이름 중복확인
	int deptNmCnt = stStdCdMapper.selectCdNmCnt(stStdCd);
	log.debug(GREEN+"addTeam DeptNmCnt :"+ deptNmCnt +RESET);
	if (deptNmCnt>0) {
		 return -1; // 중복된 값이 있음을 나타내는 음수
	}
	//받아온 부서이름을 부서코드로 바꾼다
	Map<String, Object> deptCdMap = commonMapper.getCode(teamDeptNm);
	log.debug(GREEN+"addTeam deptCdMap :"+ deptCdMap +RESET);
	//맵에서 풀면서 toString 해준다 Object
	String code = deptCdMap.get("cd").toString();
	log.debug(GREEN+"addTeam code :"+ code +RESET);
	
	// 추가된 팀의 cd값 추가를 위해 (connt+1)+(code*10)을 계산하여 cd값에 넣어준다
	int teamCnt =  stStdCdMapper.selectTeamCnt(code);
	log.debug(GREEN+"addTeam teamCnt :"+ teamCnt +RESET);
	
	int cd = (teamCnt + 1) + (Integer.parseInt(code) * 10);
	log.debug(GREEN+"addTeam cd :"+ cd +RESET);
	stStdCd.setCd(String.valueOf(cd));
	stStdCd.setCdNm(teamNm);
	//2) 부서이름 추가하기
	int insertStStdCdrow = stStdCdMapper.insertStStdCd(stStdCd);
	
	return insertStStdCdrow;
	}
	
}
	
	