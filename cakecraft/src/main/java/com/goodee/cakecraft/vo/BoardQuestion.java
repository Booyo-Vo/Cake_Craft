package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardQuestion {
	private int questionNo;
	private String id;
	private String secretYn;
	private String questionTitle;
	private String questionContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	
	private String answerContent;
}
