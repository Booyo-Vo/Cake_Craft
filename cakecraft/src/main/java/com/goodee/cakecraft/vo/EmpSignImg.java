package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class EmpSignImg {
	private String id;
	private String signFilename;
	private int signFilesize;
	private String signType;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
