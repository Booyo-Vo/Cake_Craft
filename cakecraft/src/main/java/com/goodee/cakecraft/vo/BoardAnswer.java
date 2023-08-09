package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardAnswer {
	private int questionNo;
	private String id;
	private String answerContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
