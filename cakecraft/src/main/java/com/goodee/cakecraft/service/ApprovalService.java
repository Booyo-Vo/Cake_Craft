package com.goodee.cakecraft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.ApprovalMapper;
import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalHistory;
import com.goodee.cakecraft.vo.ApprovalRef;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ApprovalService {
	@Autowired 
	private ApprovalMapper apprDocMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	// ANSI 코드
	final String SHJ = "\u001B[46m";
	final String RESET = "\u001B[0m";
	
	/* 결재 문서 : ApprovalDocument */
	// 결재한 문서 목록 출력
	public List<ApprovalDocument> getApprDocListById(String loginId){
		// 반환값
		List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListById(loginId);
				
		return apprDocList;
	}
	
	// 결재자로 지정된 문서 목록 출력
	public List<ApprovalDocument> getApprDocListByApprId(String loginId){
		// 반환값
		List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListByApprId(loginId);
				
		return apprDocList;
	}
	
	// 참조자로 지정된 문서 목록 출력
	public List<ApprovalDocument> getApprDocListByRefId(String loginId){
		// 반환값
		List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListByRefId(loginId);
				
		return apprDocList;
	}
	
	
	// 결재 문서 개수 출력
	public int getApprDocCnt(ApprovalDocument apprDoc){
		// 반환값
		int apprDocCnt = apprDocMapper.selectApprDocCnt();
		
		return apprDocCnt;
		
	}
	
	// 개별 결재 문서 상세정보 출력
	public ApprovalDocument getApprDocByNo(String loginMember){
		// 반환값
		ApprovalDocument resultApprDoc = apprDocMapper.selectApprDocByNo(loginMember);
		
		return resultApprDoc;
	}
	
	
	// 1) 문서분류 이름을 받아서 문서코드로 입력 
	// 2) 문서번호 생성 
	// 3) 결재문서 추가 
	// 4) 결재이력 추가 (Lv 1 2 3)
	// (+파일추가, 참조자추가)
	public int addApprDoc(ApprovalDocument apprDoc, String loginId, String approvalIdLv2, String approvalIdLv3, String tempSave){
		
		// 1) 문서코드 받아오기
		Map<String, Object> apprDocCdMap = commonMapper.getCode(apprDoc.getApprovalDocumentCd());
		// 문서분류 이름이 넘어오면 -> DB에 입력할 코드 받아오기
		String approvalDocumentCd = apprDocCdMap.get("cd").toString();
		// 디버깅
		log.debug(SHJ + approvalDocumentCd + " <-- addApprDoc approvalDocumentCd"+ RESET);
		// 생성된 문서코드 입력
		apprDoc.setApprovalDocumentCd(approvalDocumentCd);
		
		// 2) 문서번호 생성
		String documentNo = apprDocMapper.selectDocumentNo(apprDoc);
		// 디버깅
		log.debug(SHJ + documentNo + " <-- addApprDoc documentNo"+ RESET);
		
		if(documentNo != null) { // 문서번호 생성 성공 시
			// 생성된 문서번호 입력
			apprDoc.setDocumentNo(documentNo);
			apprDoc.setId(loginId);
			apprDoc.setRegId(loginId);
			apprDoc.setModId(loginId);
			
			// 3) 결재문서 추가
			// 반환값
			int addApprDocRow = apprDocMapper.insertApprDoc(apprDoc);
			// 디버깅
			log.debug(SHJ + addApprDocRow + " <-- addApprDoc addApprDocRow"+ RESET);
			
			if(addApprDocRow > 0 && "N".equals(tempSave)) { // 결재문서 추가 성공 시
				
				// 4) 결재이력 추가
				// 담당자(=level 1) 추가
				ApprovalHistory apprHistoryLv1 = new ApprovalHistory();
				apprHistoryLv1.setApprovalId(loginId);
				apprHistoryLv1.setDocumentNo(documentNo);
				apprHistoryLv1.setApprovalLevel(1);
				apprHistoryLv1.setApprovalStatusCd("1");
				apprHistoryLv1.setRegId(loginId);
				apprHistoryLv1.setModId(loginId);
				int addApprHistLv1Row = apprDocMapper.insertApprHistory(apprHistoryLv1);
				log.debug(SHJ + addApprHistLv1Row + " <-- addApprDoc addApprHistLv1Row"+ RESET);
				
				if(addApprHistLv1Row > 0) {
					// 결재자 level 2 추가
					ApprovalHistory apprHistoryLv2 = new ApprovalHistory();
					apprHistoryLv2.setApprovalId(approvalIdLv2);
					apprHistoryLv2.setDocumentNo(documentNo);
					apprHistoryLv2.setApprovalLevel(2);
					apprHistoryLv2.setApprovalStatusCd("1"); 
					apprHistoryLv2.setRegId(loginId);
			        apprHistoryLv2.setModId(loginId);
					int addApprHistLv2Row = apprDocMapper.insertApprHistory(apprHistoryLv2);
					log.debug(SHJ + addApprHistLv2Row + " <-- addApprDoc addApprHistLv2Row"+ RESET);
				
					if(addApprHistLv2Row > 0) {
						// 결재자 level 3 추가
						ApprovalHistory apprHistoryLv3 = new ApprovalHistory();
						apprHistoryLv3.setApprovalId(approvalIdLv3);
						apprHistoryLv3.setDocumentNo(documentNo);
						apprHistoryLv3.setApprovalLevel(3);
						apprHistoryLv3.setApprovalStatusCd("1");
						apprHistoryLv3.setRegId(loginId);
			            apprHistoryLv3.setModId(loginId);
						int addApprHistLv3Row = apprDocMapper.insertApprHistory(apprHistoryLv3);
						log.debug(SHJ + addApprHistLv3Row + " <-- addApprDoc addApprHistLv3Row"+ RESET);
					}
				}
			 /* 
				if(파일이 있다면) {
					파일 추가
				 
				if(참조자가 있다면) {
					참조자 추가
			*/
			}
			
			// 문서 추가 성공 시 반환값
            return addApprDocRow;
		
		}
		// 문서 번호 생성 실패 시 반환값
	    return 0;
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
