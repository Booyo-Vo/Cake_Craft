package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class EmpBase {
	private String id;
	private String empName;
	private String socialNo;
	private String deptCd;
	private String teamCd;
	private String positionCd;
	private String email;
	private String hireDate;
	private String retireDate;
	private String empStatus;
	private int dayoffCnt;
	private String address;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	
    private String deptNm; // 부서명을 저장할 필드
    private String teamNm; // 팀명을 저장할 필드
    private String positionNm; // 직급명을 저장할 필드
}
