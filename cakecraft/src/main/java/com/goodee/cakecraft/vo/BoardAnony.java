package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardAnony {
	private int anonyNo;
	private String id;
	private int likeCnt;
	private String anonyTitle;
	private String anonyContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
