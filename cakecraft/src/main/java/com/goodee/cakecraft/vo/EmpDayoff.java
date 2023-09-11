package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class EmpDayoff {
	private String dayoffNo;
	private String id;
	private String dayoffStatus;
	private String startDay;
	private String endDay;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	
	private String dayoffStatusNm;
}
