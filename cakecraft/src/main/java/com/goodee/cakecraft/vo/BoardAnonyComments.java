package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardAnonyComments {
	private int commentsNo;
	private int anonyNo;
	private String id;
	private String commentsContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
