package com.goodee.cakecraft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.AttendanceMapper;
import com.goodee.cakecraft.vo.EmpAttendance;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AttendanceService {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private AttendanceMapper attendanceMapper;
	
	//출근 퇴근 시간 입력, 업데이트
	
    public void insertStartDtime(String id) {
        EmpAttendance empAttendance = new EmpAttendance();
        empAttendance.setId(id);
        attendanceMapper.insertStartDtime(empAttendance);
    }

    public void updateEndDtime(String id) {
        EmpAttendance empAttendance = new EmpAttendance();
        empAttendance.setId(id);
        attendanceMapper.updateEndDtime(empAttendance);
    }
    
    //나의 출퇴근 이력 리스트 출력
    public List<EmpAttendance> getMyAttendanceList(String searchWord){
    	//리스트 받아오기
    	List<EmpAttendance> empAttList = attendanceMapper.selectMyAttendanceList(searchWord);
    	log.debug(KMS+ empAttList.size() +"empAttList 사이즈 / AttendanceService" +RESET);
    
    	return empAttList;
    }
    
}
