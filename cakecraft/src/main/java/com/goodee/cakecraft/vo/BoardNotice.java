package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardNotice {
	private int noticeNo;
	private String id;
	private String noticeTitle;
	private String noticeContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
