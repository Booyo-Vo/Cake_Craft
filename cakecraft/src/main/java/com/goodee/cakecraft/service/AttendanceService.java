package com.goodee.cakecraft.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.AttendanceMapper;
import com.goodee.cakecraft.vo.EmpAttendance;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class AttendanceService {
	@Autowired AttendanceMapper attendanceMapper;
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m";
	
	/*
	 * //출퇴근 이력 추가 public int addAttendanceTime(EmpAttendance empAttendance, String
	 * loginId) { Map<String, Object> paramMap = new HashMap<>(); paramMap.put("id",
	 * empAttendance.getId()); paramMap.put("empAttendance", empAttendance);
	 * 
	 * int addAttendanceRow = attendanceMapper.insertAttendance(empAttendance);
	 * 
	 * return addAttendanceRow; }
	 */
	
	// 출근 기록 저장
    public void saveStartWork(String empId, LocalDateTime startTime) {
        EmpAttendance empAttendance = new EmpAttendance();
        empAttendance.setId(empId);
        empAttendance.setStartDtime(startTime.toString());

        int addAttendance = attendanceMapper.insertAttendance(empAttendance);
        // 추가적인 로그 등 필요한 작업 수행 가능
    }

    // 퇴근 기록 저장
    public void saveEndWork(String empId, LocalDateTime endTime) {
        EmpAttendance empAttendance = new EmpAttendance();
        empAttendance.setId(empId);
        empAttendance.setEndDtime(endTime.toString());

        int updateAttendance = attendanceMapper.updateAttendance(empAttendance);
        // 추가적인 로그 등 필요한 작업 수행 가능
    }
}
