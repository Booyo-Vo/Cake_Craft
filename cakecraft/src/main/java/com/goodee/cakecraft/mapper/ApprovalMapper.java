package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalRef;
import com.goodee.cakecraft.vo.ApprovalHistory;

@Mapper
public interface ApprovalMapper {
	
	/* 결재 문서 : ApprovalDocument */
	// 결재 문서 목록 출력
	List<ApprovalDocument> selectApprDocListByPage(Map<String, Object> apprDocListByPageMap);
	
	// 결재 문서 개수 출력
	int selectApprDocCnt();
	
	// 개별 결재 문서 상세정보 출력
	ApprovalDocument selectApprDocByNo(ApprovalDocument apprDoc);
	
	// 결재 문서 추가
	int insertApprDoc(ApprovalDocument apprDoc);
	
	// 결재 문서 수정
	int updateApprDoc(ApprovalDocument apprDoc);
	
	// 결재 문서 삭제
	int deleteApprDoc(ApprovalDocument apprDoc);
	
	
	/* 결재 파일 : ApprovalFile */
	// 결재 파일 추가
	int insertApprFile(ApprovalFile apprFile);
	
	// 결재 파일 삭제
	int deleteApprFile(ApprovalFile apprFile);
	
	
	/* 결재 참조자 : ApprovalRef */
	// 결재 참조자 추가
	int insertApprRef(ApprovalRef apprRef);
	
	// 결재 참조자 삭제
	int deleteApprRef(ApprovalRef apprRef);
	
	
	/* 결재 이력 : ApprovalHistory */
	// 결재 이력 목록 출력
	List<ApprovalHistory> selectApprHistListByPage(Map<String, Object> apprHistListByPageMap);
	
	// 결재 이력 추가
	int insertApprHistory(ApprovalHistory apprHistory);
	
	// 결재 이력 수정
	int updateApprHistory(ApprovalHistory apprHistory);
	
}
