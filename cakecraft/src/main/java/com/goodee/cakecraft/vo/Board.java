package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class Board {
	private int boardNo;
	private String id;
	private int likeCnt;
	private String boardTitle;
	private String boardContent;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
