package com.goodee.cakecraft.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodee.cakecraft.service.StStdCdService;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.StStdCd;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StStdController {
	//ANSI코드
	final String GREEN = "\u001B[42m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired 
	private StStdCdService stStdCdService;
	
	// 선택된 부서에 따른 팀 리스트 받아오기
    @GetMapping("/stStdCd/getTeamListByDept")
    @ResponseBody
	    public List<StStdCd> teamListByDept(@RequestParam String deptNm) {
	        List<StStdCd> teamList = stStdCdService.getTeamListByDept(deptNm);
	        return teamList;
    }
    //부서, 팀 관리 페이지 (Modal로 추가, 수정)
    @GetMapping("/stStdCd/stStdCdList")
    	public String stStdCdList(Model model) {
    	// 부서와 팀 리스트
    	Map<String, Object> StStdCdListMap = stStdCdService.getStdStdCdList();

    	//뷰로 값넘기기
    	model.addAttribute("deptList", StStdCdListMap.get("deptList"));
    	model.addAttribute("teamListMap",StStdCdListMap); // 전체맵을 넘겨줌
		return "/stStdCd/stStdCdList";
    }
    
    
    //부서추가 액션
    @GetMapping("/stStdCd/addDept")
    @ResponseBody
    	public String addDept(HttpSession session, @RequestParam String deptNm) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(GREEN + "addDept loginId :"+loginId + RESET);
		log.debug(GREEN + "addDept deptNm :"+deptNm + RESET);
		StStdCd stStdCd = new StStdCd();
		stStdCd.setModId(loginId);
		stStdCd.setRegId(loginId);
		stStdCd.setCdNm(deptNm);
    	
    	int insertDeptRow = stStdCdService.addDept(stStdCd);
        if (insertDeptRow == 0) {
            return "FAIL";
        } else if (insertDeptRow == -1) {
            return "DUPLICATE";
        } else {
            return "SUCCESS";
        }
    }
    
    //팀 추가 액션
    @GetMapping("/stStdCd/addTeam")
    @ResponseBody
    	public String addTeam(HttpSession session, @RequestParam String teamNm,  @RequestParam String teamDeptNm) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(GREEN + "addTeam loginId :"+loginId + RESET);
		log.debug(GREEN + "addTeam teamNm :"+teamNm + RESET);
		log.debug(GREEN + "addTeam teamDeptNm :"+teamDeptNm + RESET);
		StStdCd stStdCd = new StStdCd();
		stStdCd.setModId(loginId);
		stStdCd.setRegId(loginId);
    	
    	int insertDeptRow = stStdCdService.addTeam(stStdCd, teamDeptNm, teamNm);
        if (insertDeptRow == 0) {
            return "FAIL";
        } else if (insertDeptRow == -1) {
            return "DUPLICATE";
        } else {
            return "SUCCESS";
        }
    }

    //부서수정액션
    @GetMapping("/stStdCd/modifyDeptCdNm")
    @ResponseBody
    	public String modifyDeptCdNm(HttpSession session, @RequestParam String originDeptCdNm,  @RequestParam String updatedDeptCdNm) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(GREEN + "modifyDeptCdNm loginId :"+loginId + RESET);
		log.debug(GREEN + "modifyDeptCdNm originDeptCdNm :"+originDeptCdNm + RESET);
		log.debug(GREEN + "modifyDeptCdNm updatedDeptCdNm :"+updatedDeptCdNm + RESET);
		
    	
    	int modifyDeptRow = stStdCdService.modifyDeptCdNm(loginId, originDeptCdNm,updatedDeptCdNm);
        if (modifyDeptRow == 0) {
            return "FAIL";
        } else if (modifyDeptRow == -1) {
            return "DUPLICATE";
        } else {
            return "SUCCESS";
        }
    }   
    
    //팀수정액션
    @GetMapping("/stStdCd/modifyTeamCdNm")
    @ResponseBody
    	public String modifyTeamCdNm(HttpSession session, @RequestParam String originTeamCdNm,  @RequestParam String updatedTeamCdNm) {
		//세선에 저장된 로그인 아이디를 받아옴
    	EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
		String loginId = loginMember.getId();
		log.debug(GREEN + "modifyTeamCdNm loginId :"+loginId + RESET);
		log.debug(GREEN + "modifyTeamCdNm originTeamCdNm :"+originTeamCdNm + RESET);
		log.debug(GREEN + "modifyTeamCdNm updatedTeamCdNm :"+updatedTeamCdNm + RESET);
		
    	
    	int modifyTeamRow = stStdCdService.modifyTeamCdNm(loginId, originTeamCdNm,updatedTeamCdNm);
        if (modifyTeamRow == 0) {
            return "FAIL";
        } else if (modifyTeamRow == -1) {
            return "DUPLICATE";
        } else {
            return "SUCCESS";
        }
    }
    
}