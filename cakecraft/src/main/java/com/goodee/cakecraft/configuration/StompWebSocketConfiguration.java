package com.goodee.cakecraft.configuration;

import org.springframework.context.annotation.Configuration;

import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker //stomp를 사용하기 위한 애노테이션
public class StompWebSocketConfiguration implements WebSocketMessageBrokerConfigurer{

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/stomp").setAllowedOrigins("http://localhost:80");

	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
    
		config.setApplicationDestinationPrefixes("/pub"); //클라이언트에서 send요청을 처리
		config.enableSimpleBroker("/sub"); 
		//해당 경로로 SimpleBroker를 등록한다.
		//SimpleBroker는 해당하는 경로를 SUBSCRIBE하는 Client에게 메세지를 전달하는 간단한 작업을 수행한다.
	}

}
