package com.goodee.cakecraft.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalRef;
import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardAnonyFile;
import com.goodee.cakecraft.vo.ApprovalHistory;

@Mapper
public interface ApprovalMapper {
	
	/* 결재 문서 : ApprovalDocument */
	// 결재한 문서 목록 출력(기안문서 및 임시저장)
	// List<ApprovalDocument> selectApprDocListByPage(Map<String, Object> apprDocListByPageMap);
	List<ApprovalDocument> selectApprDocListById(String loginId, String tempSave);
	
	// 결재자로 지정된 문서 목록 출력
	List<ApprovalDocument> selectApprDocListByApprId(String loginId);
	
	// 결재자가 승인해야 할 문서 목록 출력
	List<ApprovalDocument> selectApprDocWaitListByNo(String documentNo);
	
	// 결재자가 승인해야 할 문서번호 조회
	List<ApprovalHistory> selectApprDocWaitNoById(String loginId);
	
	// 결재자가 승인해야 할 문서 개수 조회
	int selectApprDocWaitNoByIdCnt(String loginId);
	
	// 참조자로 지정된 문서 목록 출력
	List<ApprovalDocument> selectApprDocListByRefId(String loginId);
	
	/*
	// 결재문서 개수 출력
	int selectApprDocCnt();
	*/
	
	// 결재문서 상세정보 출력
	ApprovalDocument selectApprDocByNo(String documentNo);
	
	// 결재문서 상세이력 출력
	ApprovalHistory selectApprHistByNo(String documentNo, String loginId);
	
	// 이전 결재자의 결재상태 조회
	ApprovalHistory selectApprHistByNoPreLv(int approvalNo);
	
	// 문서번호 및 결제레벨로 결재정보 조회
	ApprovalHistory selectApprInfoByNo(String documentNo, int approvalLevel);
	
	// 문서번호 생성
	String selectDocumentNo(Map param);
	
	// 결재문서 추가
	int insertApprDoc(Map param);
	
	// 임시저장 문서 수정
	int updateApprDocTempY(ApprovalDocument apprDoc);
	
	// 임시저장 문서 삭제
	int deleteApprDocTempY(ApprovalDocument apprDoc);
	
	
	/* 결재 첨부파일 : ApprovalFile */
	// 결재 첨부파일 목록 조회
	List<ApprovalFile> selectApprFile(ApprovalDocument apprDoc);
	
	// 결재 첨부파일 추가
	int insertApprFile(ApprovalFile apprFile);
	
	// 결재 첨부파일 삭제
	// int deleteApprFile(ApprovalFile apprFile);
	
	
	/* 결재참조자 : ApprovalRef */
	// 결재참조자 조회
	ApprovalRef selectApprRefByNo(String documentNo);
	
	// 결재참조자 추가
	int insertApprRef(Map param);
	
	// 결재참조자 삭제
	// int deleteApprRef(ApprovalRef apprRef);
	
	
	/* 결재이력 : ApprovalHistory */
	// 결재이력 목록 출력
	List<ApprovalHistory> selectApprHistListByPage(Map<String, Object> apprHistListByPageMap);
	
	// 결재이력 추가
	int insertApprHistory(ApprovalHistory apprHistory);
	
	// 결재이력 수정
	int updateApprHistory(ApprovalHistory apprHistory);
	
}
