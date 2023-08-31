package com.goodee.cakecraft.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ChatRoom;

@Mapper
public interface ChatRoomMapper {
	List<ChatRoom> selectChatRoomList();
	
	ChatRoom selectChatRoomById(ChatRoom chatRoom);
	
	int insertChatRoom(ChatRoom chatRoom);
}
