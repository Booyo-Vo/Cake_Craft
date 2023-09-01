package com.goodee.cakecraft.vo;

import java.util.HashSet;

import java.util.Set;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
public class ChatRoom {
	private String roomId;
	private String roomMember;
	private String roomName;
	private int memberCnt;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	private Set<WebSocketSession> sessions = new HashSet<>();
	//WebSocketSession : Spring 에서 WebSocket Connection이 맺어진 세션
}
