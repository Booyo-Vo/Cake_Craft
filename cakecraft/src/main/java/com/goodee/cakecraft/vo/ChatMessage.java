package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ChatMessage {
	private int messageNo;
	private String roomId;
	private String writer;
	private String message;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
