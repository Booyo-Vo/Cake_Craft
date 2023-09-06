package com.goodee.cakecraft.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.service.ChatService;
import com.goodee.cakecraft.vo.ChatMessage;
import com.goodee.cakecraft.vo.ChatRoom;
import com.goodee.cakecraft.vo.EmpBase;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	@Autowired ChatService chatService;
	@Autowired AdminEmpService adminEmpService;
	
	//채팅방 목록조회
	@GetMapping("/chat/rooms")
	public String rooms(HttpSession session,
						Model model){
		EmpBase empBase = (EmpBase)session.getAttribute("loginEmpBase");
		log.info("# All Chat Rooms");
		List<ChatRoom> chatList = chatService.getAllRooms(empBase);
		List<EmpBase> empList = adminEmpService.getEmpList();
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("empList", empList);
		return "/chat/rooms";
	}

    //채팅방 개설
    @PostMapping("/chat/room")
    public String addRoom(ChatRoom chatRoom,
    					  @RequestParam(name="member") String[] memberArr,
    					  Model model){

		log.info("# Create Chat Room , name: " + chatRoom.getRoomName());
		String id = UUID.randomUUID().toString().replaceAll("-", "");
		int memberCnt = memberArr.length;
		chatRoom.setMemberCnt(memberCnt);
		chatRoom.setRoomId(id);
		for(String s : memberArr) {
			chatRoom.setRoomMember(s);
			chatService.addChatRoom(chatRoom);
		}
		
		model.addAttribute("newRoomName", chatRoom.getRoomName());
		return "redirect:/chat/rooms";
    }

	//채팅방 조회
	@GetMapping("/chat/room")
	public String openRoom(ChatRoom chatRoom, 
    					   Model model){

		log.info("# get Chat Room, roomID : " + chatRoom.getRoomId());
		ChatRoom room = chatService.getChatRoomById(chatRoom);
		Map<String, Object> resultMap = chatService.getChatMessageById(chatRoom);
		model.addAttribute("room", room);
		model.addAttribute("messageList", resultMap.get("messageList"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		return "/chat/room";
	}
	
	//채팅 메시지 저장
	@ResponseBody
	@PostMapping("/chat/addMessage")
	public int addMessage(ChatMessage chatMessage) {
		int row = chatService.addChatMessage(chatMessage);
		return row;
	}
	
	//채팅방 나가기
	@GetMapping("/chat/removeChatRoom")
	public String removeChatRoom(ChatRoom chatRoom) {
		chatService.removeChatRoom(chatRoom);
		return "redirect:/chat/rooms";
	}
}
