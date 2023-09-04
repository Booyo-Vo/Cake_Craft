package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ChatMessage;
import com.goodee.cakecraft.vo.ChatRoom;
import com.goodee.cakecraft.vo.EmpBase;

@Mapper
public interface ChatMapper {
	//채팅방 리스트
	List<ChatRoom> selectChatRoomList(EmpBase empBase);
	
	//채팅방
	ChatRoom selectChatRoomById(ChatRoom chatRoom);
	
	//채팅방 개설
	int insertChatRoom(ChatRoom chatRoom);
	
	//채팅방 나가기
	int deleteChatRoom(ChatRoom chatRoom);
	
	//채팅방 인원수정
	int updateChatRoomCnt(ChatRoom chatRoom);
	
	//채팅내용 저장
	int insertChatMessage(ChatMessage chatMessage);
	
	//채팅내용 불러오기
	List<ChatMessage> selectChatMessageById(ChatRoom chatRoom);
}
