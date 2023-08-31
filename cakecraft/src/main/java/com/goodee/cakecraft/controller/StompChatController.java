package com.goodee.cakecraft.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.goodee.cakecraft.vo.ChatMessage;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StompChatController {
	public final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달

	//Client가 SEND할 수 있는 경로
	//stompConfig에서 설정한 applicationDestinationPrefixes와 @MessageMapping 경로가 병합됨
	//"/pub/chat/enter"
	@MessageMapping("/chat/enter")
	public void enter(ChatMessage message){
		message.setMessage(message.getWriter() + "님이 채팅방에 참여하였습니다.");
		template.convertAndSend("/sub/chat/room" + message.getRoomId(), message);
    }

	@MessageMapping("/chat/message")
	public void message(ChatMessage message){
		template.convertAndSend("/sub/chat/room" + message.getRoomId(), message);
	}
}
