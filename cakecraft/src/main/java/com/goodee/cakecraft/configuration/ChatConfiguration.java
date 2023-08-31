package com.goodee.cakecraft.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.goodee.cakecraft.handler.ChatHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
@EnableWebSocket //WebSocket을 활성화
public class ChatConfiguration implements WebSocketConfigurer {
	
	private final ChatHandler chatHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(chatHandler, "ws/chat/chat").setAllowedOrigins("*");
		//WebSocket에 접속하기 위한 url은 /chat/chat으로 하고, 다른 서버에서도 접속 가능하도록 setAllowedORigins("*")추가
	}

}
