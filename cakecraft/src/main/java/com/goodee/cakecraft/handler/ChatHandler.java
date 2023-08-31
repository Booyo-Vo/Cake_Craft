package com.goodee.cakecraft.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChatHandler extends TextWebSocketHandler {
	private static List<WebSocketSession> list = new ArrayList<>(); //접속한 클라이언트 리스트
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload(); //전송하고자 하는 메시지
		log.info("payload : " + payload); 

		for(WebSocketSession sess: list) {
			sess.sendMessage(message);
		}
	}
	
	//클라이언트 접속 시 호출되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		list.add(session); //리스트에 접속한 클라이언트 추가
		log.info(session + " 클라이언트 접속");
	}
	
	//클라이언트 접속 해제 시 호출되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		log.info(session + " 클라이언트 접속 해제"); //리스트에서 접속 해제한 클라이언트 제거
		list.remove(session);
	}
}
