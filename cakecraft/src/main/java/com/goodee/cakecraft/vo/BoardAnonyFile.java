package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardAnonyFile {
	private int anonyFileNo;
	private int anonyNo;
	private String anonyFilename;
	private long anonyFilesize;
	private String anonyType;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
