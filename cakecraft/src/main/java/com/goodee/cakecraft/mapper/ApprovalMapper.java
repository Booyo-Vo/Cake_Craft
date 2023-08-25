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
	// 결재한 문서 목록 출력(기안문서 및 임시저장)
	// List<ApprovalDocument> selectApprDocListByPage(Map<String, Object> apprDocListByPageMap);
	List<ApprovalDocument> selectApprDocListById(String loginId, String tempSave);
	
	// 결재자로 지정된 문서 목록 출력
	List<ApprovalDocument> selectApprDocListByApprId(String loginId);
	
	// 결재자 중 lv2가 승인해야 할 문서 목록 출력
	List<ApprovalDocument> selectApprDocWaitListByIdLv2(String loginId);
	
	// 결재자 중 lv3이 승인해야 할 문서번호 조회
	List<ApprovalDocument> selectApprDocWaitNoByIdLv3(String loginId);
	
	// 결재자 중 lv3이 승인해야 할 문서 목록 출력
	List<ApprovalDocument> selectApprDocWaitListByNoLv3(Map param);
	
	// 참조자로 지정된 문서 목록 출력
	List<ApprovalDocument> selectApprDocListByRefId(String loginId);
	
	// 결재문서 개수 출력
	int selectApprDocCnt();
	
	// 결재문서 상세정보 출력
	ApprovalDocument selectApprDocByNo(String documentNo);
	
	// 문서번호 생성
	String selectDocumentNo(Map param);
	
	// 결재문서 추가
	int insertApprDoc(Map param);
	
	// 결재문서 수정
	int updateApprDoc(ApprovalDocument apprDoc);
	
	// 결재문서 삭제
	int deleteApprDoc(ApprovalDocument apprDoc);
	
	
	/* 결재파일 : ApprovalFile */
	// 결재파일 추가
	int insertApprFile(ApprovalFile apprFile);
	
	// 결재파일 삭제
	int deleteApprFile(ApprovalFile apprFile);
	
	
	/* 결재참조자 : ApprovalRef */
	// 결재참조자 추가
	int insertApprRef(ApprovalRef apprRef);
	
	// 결재참조자 삭제
	int deleteApprRef(ApprovalRef apprRef);
	
	
	/* 결재이력 : ApprovalHistory */
	// 결재이력 목록 출력
	List<ApprovalHistory> selectApprHistListByPage(Map<String, Object> apprHistListByPageMap);
	
	// 결재이력 추가
	int insertApprHistory(ApprovalHistory apprHistory);
	
	// 결재이력 수정
	int updateApprHistory(ApprovalHistory apprHistory);
	
}
