package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.ChatMapper;
import com.goodee.cakecraft.vo.ChatMessage;
import com.goodee.cakecraft.vo.ChatRoom;
import com.goodee.cakecraft.vo.EmpBase;

@Service
@Transactional
public class ChatService {
	@Autowired ChatMapper chatMapper;
	//채팅방 리스트 최근 순 반환
	public List<ChatRoom> getAllRooms(EmpBase empBase){
		List<ChatRoom> result = chatMapper.selectChatRoomList(empBase);

		return result;
	}
	
	//채팅방 id로 조회
	public ChatRoom getChatRoomById(ChatRoom chatRoom){
		return chatMapper.selectChatRoomById(chatRoom);
	}
	
	//채팅방 db에 넣기
	public int addChatRoom(ChatRoom chatRoom){
		int row = chatMapper.insertChatRoom(chatRoom); //DB에 저장

		return row;
	}
	
	//채팅방 나가기
	public int removeChatRoom(ChatRoom chatRoom) {
		chatMapper.updateChatRoomCnt(chatRoom);
		int row = chatMapper.deleteChatRoom(chatRoom);
		return row;
	}
	
	//채팅내용 저장
	public int addChatMessage(ChatMessage chatMessage) {
		int row = chatMapper.insertChatMessage(chatMessage);
		return row;
	}
	
	//채팅방내용(메시지, 참여인원) 불러오기
	public Map<String, Object> getChatMessageById(ChatRoom chatRoom){
		Map<String, Object> resultMap = new HashMap<>();
		List<ChatMessage> messageList = chatMapper.selectChatMessageById(chatRoom);
		List<Map<String, Object>> memberList = chatMapper.selectMemberListByRoom(chatRoom);
		resultMap.put("messageList", messageList);
		resultMap.put("memberList", memberList);
		return resultMap;
	}
}
