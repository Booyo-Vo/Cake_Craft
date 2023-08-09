package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class BoardFile {
	private int boardFileNo;
	private int boardNo;
	private String boardFilename;
	private String boardPath;
	private String boardType;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
