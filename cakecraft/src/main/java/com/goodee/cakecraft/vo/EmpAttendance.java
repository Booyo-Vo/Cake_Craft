package com.goodee.cakecraft.vo;


import lombok.Data;

@Data
public class EmpAttendance {
	private int attendanceNo;
	private String id;
	private String startDtime;
	private String endDtime;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
