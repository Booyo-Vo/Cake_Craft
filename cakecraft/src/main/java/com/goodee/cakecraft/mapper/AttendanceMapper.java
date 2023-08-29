package com.goodee.cakecraft.mapper;




import org.apache.ibatis.annotations.Mapper;


import com.goodee.cakecraft.vo.EmpAttendance;

@Mapper
public interface AttendanceMapper {
	// 출근시간 입력
    void insertStartDtime(EmpAttendance empAttendance);
    
    // 퇴근시간 업데이트
    void updateEndDtime(EmpAttendance empAttendance);
}
