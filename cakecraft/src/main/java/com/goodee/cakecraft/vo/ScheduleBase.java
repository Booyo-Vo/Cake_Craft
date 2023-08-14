package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ScheduleBase {
	private int scheduleNo;
	private String id;
	private String categoryCd;
	private String teamCd;
	private String scheduleContent;
	private String startDtime;
	private String endDtime;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
