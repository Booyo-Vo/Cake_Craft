package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodee.cakecraft.mapper.ApprovalMapper;
import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalHistory;
import com.goodee.cakecraft.vo.ApprovalRef;

@Service
public class ApprovalService {
	@Autowired ApprovalMapper apprDocMapper;
	
	/* 결재 문서 : ApprovalDocument */
	// 결재 문서 목록 출력
	// public List<ApprovalDocument> getApprDocListByPage(Map<String, Object> paramMap){
	public List<ApprovalDocument> getApprDocListByPage(){
		// 컨트롤러(Controller)로부터 받은 데이터를, 데이터베이스에 접근하는 DAO(Data Access Object) 레이어에서 사용할 수 있는 형태로 변환 
		// Map<String, Object> paramMap = new HashMap<String, Object>();
		// paramMap.put("id", id);
		String loginId = "232211558";
		
		// 반환값
		List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListByPage(loginId);
		// List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListByPage(paramMap);
				
		return apprDocList;
	}
	
	// 결재 문서 개수 출력
	public int getApprDocCnt(ApprovalDocument apprDoc){
		// 반환값
		int apprDocCnt = apprDocMapper.selectApprDocCnt();
		
		return apprDocCnt;
		
	}
	
	// 개별 결재 문서 상세정보 출력
	public ApprovalDocument getApprDocByNo(ApprovalDocument apprDoc){
		// 반환값
		ApprovalDocument resultApprDoc = apprDocMapper.selectApprDocByNo(apprDoc);
		
		return resultApprDoc;
	}
	
	// 결재 문서 추가
	public int addApprDoc(ApprovalDocument apprDoc){
		// 반환값
		int addApprDocRow = apprDocMapper.insertApprDoc(apprDoc);
				
		return addApprDocRow;
	}
	
	// 결재 문서 수정
	public int modifyApprDoc(ApprovalDocument apprDoc){
		// 반환값
		int updateApprDocRow = apprDocMapper.updateApprDoc(apprDoc);
				
		return updateApprDocRow;
	}
	
	// 결재 문서 삭제
	public int removeApprDoc(ApprovalDocument apprDoc){
		// 반환값
		int deleteApprDocRow = apprDocMapper.deleteApprDoc(apprDoc);
				
		return deleteApprDocRow;
	}
	
	
	/* 결재 파일 : ApprovalFile */
	// 결재 파일 추가
	public int addApprFile(ApprovalFile apprFile){
		// 반환값
		int insertApprFileRow = apprDocMapper.insertApprFile(apprFile);
				
		return insertApprFileRow;
	}
	
	// 결재 파일 삭제
	public int removeApprFile(ApprovalFile apprFile){
		// 반환값
		int deleteApprFileRow = apprDocMapper.deleteApprFile(apprFile);
				
		return deleteApprFileRow;
	}
	
	
	/* 결재 참조자 : ApprovalRef */
	// 결재 참조자 추가
	public int addApprRef(ApprovalRef apprRef){
		// 반환값
		int insertApprRefRow = apprDocMapper.insertApprRef(apprRef);
				
		return insertApprRefRow;
	}
	
	// 결재 참조자 삭제
	public int removeApprRef(ApprovalRef apprRef){
		// 반환값
		int deleteApprRefRow = apprDocMapper.deleteApprRef(apprRef);
				
		return deleteApprRefRow;
	}
	
	
	/* 결재 이력 : ApprovalHistory */
	// 결재 이력 목록 출력
	public List<ApprovalHistory> getApprHistListByPage(String id){
		// 컨트롤러(Controller)로부터 받은 데이터를, 데이터베이스에 접근하는 DAO(Data Access Object) 레이어에서 사용할 수 있는 형태로 변환 
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		
		// 반환값
		List<ApprovalHistory> apprHistList = apprDocMapper.selectApprHistListByPage(paramMap);
				
		return apprHistList;
	}
	
	// 결재 이력 추가
	public int addApprHistory(ApprovalHistory apprHistory){
		// 반환값
		int insertApprHistoryRow = apprDocMapper.insertApprHistory(apprHistory);
				
		return insertApprHistoryRow;
	}
	
	// 결재 이력 수정
	public int modifyApprHistory(ApprovalHistory apprHistory){
		// 반환값
		int updateApprHistoryRow = apprDocMapper.updateApprHistory(apprHistory);
				
		return updateApprHistoryRow;
	}
}
