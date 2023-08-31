package com.goodee.cakecraft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.ChatRoomMapper;
import com.goodee.cakecraft.vo.ChatRoom;

@Service
@Transactional
public class ChatRoomService {
	@Autowired ChatRoomMapper chatRoomMapper;
	//채팅방 리스트 최근 순 반환
	public List<ChatRoom> getAllRooms(){
		List<ChatRoom> result = chatRoomMapper.selectChatRoomList();

		return result;
	}
	
	//채팅방 id로 조회
	public ChatRoom getChatRoomById(ChatRoom chatRoom){
		return chatRoomMapper.selectChatRoomById(chatRoom);
	}
	
	//채팅방 db에 넣기
	public int addChatRoom(ChatRoom chatRoom){
		ChatRoom room = ChatRoom.createId(chatRoom); //ID생성하여 다시 반환
		int row = chatRoomMapper.insertChatRoom(room); //DB에 저장

		return row;
	}
}
