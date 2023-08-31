package com.goodee.cakecraft.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.cakecraft.service.ChatRoomService;
import com.goodee.cakecraft.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatRoomController {
	@Autowired ChatRoomService chatRoomService;
	
	//채팅방 목록조회
	@GetMapping("/chat/rooms")
	public String rooms(Model model){

		log.info("# All Chat Rooms");
		List<ChatRoom> chatList = chatRoomService.getAllRooms();
		model.addAttribute("chatList", chatList);
		return "/chat/rooms";
	}

    //채팅방 개설
    @PostMapping("/chat/room")
    public String addRoom(ChatRoom chatRoom,
    					 Model model){

		log.info("# Create Chat Room , name: " + chatRoom.getRoomName());
		chatRoomService.addChatRoom(chatRoom);
		model.addAttribute("newRoomName", chatRoom.getRoomName());
		return "redirect:/chat/rooms";
    }

	//채팅방 조회
	@GetMapping("/chat/room")
	public String openRoom(ChatRoom chatRoom, 
    					   Model model){

		log.info("# get Chat Room, roomID : " + chatRoom.getRoomId());
		ChatRoom room = chatRoomService.getChatRoomById(chatRoom);
		model.addAttribute("room", room);
		return "/chat/room";
	}
}
