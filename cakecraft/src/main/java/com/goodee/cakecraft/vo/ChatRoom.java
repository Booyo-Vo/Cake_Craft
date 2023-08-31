package com.goodee.cakecraft.vo;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
public class ChatRoom {
	private String roomId;
	private String roomName;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	private Set<WebSocketSession> sessions = new HashSet<>();
	//WebSocketSession : Spring 에서 WebSocket Connection이 맺어진 세션
	
	public static ChatRoom createId(ChatRoom chatRoom) {
		ChatRoom room = new ChatRoom();
		String id = UUID.randomUUID().toString().replaceAll("-", "");
		room.setRoomId(id);
		room.setRoomName(chatRoom.getRoomName());
		room.setRegId(chatRoom.getRegId());
		return room;
	}
}
