package com.goodee.cakecraft.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.mapper.ApprovalMapper;
import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.DayoffMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.vo.ApprovalDocument;
import com.goodee.cakecraft.vo.ApprovalFile;
import com.goodee.cakecraft.vo.ApprovalHistory;
import com.goodee.cakecraft.vo.ApprovalRef;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpDayoff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ApprovalService {
	@Autowired 
	private ApprovalMapper apprDocMapper;
	
	@Autowired
	private DayoffMapper dayoffMapper;
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	// ANSI 코드
	final String SHJ = "\u001B[46m";
	final String RESET = "\u001B[0m";
	
	/* 결재 문서 : ApprovalDocument */
	// 기안문서 목록 출력
	public List<ApprovalDocument> getApprDocListById(String loginId, String tempSave){
		// 반환값
		List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocListById(loginId, tempSave);
		
		for(ApprovalDocument apprDoc : apprDocList) {
			// 문서구분 이름 받아오기
			Map<String,Object> documentNmMap = new HashMap<String,Object>();
			documentNmMap.put("grpCd", "A002");
			documentNmMap.put("cd", apprDoc.getDocumentCd());
			String documentNm =  commonMapper.getName(documentNmMap);
			
			// 항목구분 이름 받아오기
			Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
			documentSubNmMap.put("grpCd", "A003");
			documentSubNmMap.put("cd", apprDoc.getDocumentSubCd());
			String documentSubNm =  commonMapper.getName(documentSubNmMap);
			
			// 받아온 이름값 저장하기
			apprDoc.setDocumentNm(documentNm);
			apprDoc.setDocumentSubNm(documentSubNm);
			
			// 결재 상태 조회를 위해 문서번호 가져오기
		    String documentNo = apprDoc.getDocumentNo();
			
			// 결재 상태 조회
			String approvalStatusCd = "2";
			int countAppr2 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			approvalStatusCd = "3";
			int countAppr3 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			String approvalStatus;

			if (countAppr2 == 3) {
				approvalStatus = "완료";
			} else if (countAppr3 > 0) {
				approvalStatus = "반려";
			} else {
				approvalStatus = "대기";
			}
			apprDoc.setApprovalStatus(approvalStatus);
		}
		
		return apprDocList;
	}
	
	
	// 임시저장 문서 목록 출력
	public List<ApprovalDocument> getApprDocListByIdTempY(String loginId, String tempSave){
		// 반환값
		List<ApprovalDocument> apprDocListTempY = apprDocMapper.selectApprDocListById(loginId, tempSave);
			
		for(ApprovalDocument apprDoc : apprDocListTempY) {
			// 문서구분 이름 받아오기
			Map<String,Object> documentNmMap = new HashMap<String,Object>();
			documentNmMap.put("grpCd", "A002");
			documentNmMap.put("cd", apprDoc.getDocumentCd());
			String documentNm =  commonMapper.getName(documentNmMap);
			
			// 항목구분 이름 받아오기
			Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
			documentSubNmMap.put("grpCd", "A003");
			documentSubNmMap.put("cd", apprDoc.getDocumentSubCd());
			String documentSubNm =  commonMapper.getName(documentSubNmMap);
			
			// 받아온 이름값 저장하기
			apprDoc.setDocumentNm(documentNm);
			apprDoc.setDocumentSubNm(documentSubNm);
		}
		
		return apprDocListTempY;
	}
	
	
	// 결재자로 지정된 문서 목록 출력
	public List<ApprovalDocument> getApprDocListByApprId(String loginId){
		// 반환값
		List<ApprovalDocument> apprDocListAppr = apprDocMapper.selectApprDocListByApprId(loginId);
				
		for(ApprovalDocument apprDoc : apprDocListAppr) {
			// 문서구분 이름 받아오기
			Map<String,Object> documentNmMap = new HashMap<String,Object>();
			documentNmMap.put("grpCd", "A002");
			documentNmMap.put("cd", apprDoc.getDocumentCd());
			String documentNm =  commonMapper.getName(documentNmMap);
			
			// 항목구분 이름 받아오기
			Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
			documentSubNmMap.put("grpCd", "A003");
			documentSubNmMap.put("cd", apprDoc.getDocumentSubCd());
			String documentSubNm =  commonMapper.getName(documentSubNmMap);
			
			// 받아온 이름값 저장하기
			apprDoc.setDocumentNm(documentNm);
			apprDoc.setDocumentSubNm(documentSubNm);

			// 결재 상태 조회를 위해 문서번호 가져오기
		    String documentNo = apprDoc.getDocumentNo();
			
			// 결재 상태 조회
			String approvalStatusCd = "2";
			int countAppr2 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			approvalStatusCd = "3";
			int countAppr3 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			String approvalStatus;

			if (countAppr2 == 3) {
				approvalStatus = "완료";
			} else if (countAppr3 > 0) {
				approvalStatus = "반려";
			} else {
				approvalStatus = "대기";
			}
			apprDoc.setApprovalStatus(approvalStatus);
		}
		
		return apprDocListAppr;
	}
	
	
	// 결재자가 승인해야 할 문서번호 조회 및 문서 목록 출력
	public Map<String, Object> getApprDocWaitNoMap(String loginId) {
		// 결재자의 loginId로 승인 대기 중인 문서번호 조회
		List<ApprovalHistory> apprDocWaitNoList = apprDocMapper.selectApprDocWaitNoById(loginId);
		// 디버깅
		log.debug(SHJ + apprDocWaitNoList + " <-- apprDocWaitNoList" + RESET);
		
		// 결과를 저장할 맵 객체 생성
		Map<String, Object> resultMap = new HashMap<>();
		
		// 문서번호에 따른 문서 목록 조회 및 결과를 저장할 리스트 생성
		List<ApprovalDocument> resultApprDocList = new ArrayList<>();
			
		// 승인 대기 중인 문서번호를 하나씩 돌려서, 각 문서번호에 대한 문서 정보 조회
		for(ApprovalHistory apprDocHist : apprDocWaitNoList) {
			// 해당 문서번호 가져오기
			String documentNo = apprDocHist.getDocumentNo();
			// 해당 문서번호의 문서 정보 가져오기
			List<ApprovalDocument> apprDocList = apprDocMapper.selectApprDocWaitListByNo(documentNo);
			// 디버깅
			log.debug(SHJ + apprDocList + " <-- apprDocList" + RESET);
				
			// 조회한 문서 정보를 결과 리스트에 추가
			for(ApprovalDocument apprDoc : apprDocList) {
				resultApprDocList.add(apprDoc);
			}
		}
		
		for(ApprovalDocument apprDoc : resultApprDocList) {
			// 문서구분 이름 받아오기
			Map<String,Object> documentNmMap = new HashMap<String,Object>();
			documentNmMap.put("grpCd", "A002");
			documentNmMap.put("cd", apprDoc.getDocumentCd());
			String documentNm =  commonMapper.getName(documentNmMap);
			
			// 항목구분 이름 받아오기
			Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
			documentSubNmMap.put("grpCd", "A003");
			documentSubNmMap.put("cd", apprDoc.getDocumentSubCd());
			String documentSubNm =  commonMapper.getName(documentSubNmMap);
			
			// 받아온 이름값 저장하기
			apprDoc.setDocumentNm(documentNm);
			apprDoc.setDocumentSubNm(documentSubNm);
		}
		
		// 결과 리스트를 맵에 "apprDocList"라는 키로 저장
		resultMap.put("apprDocList", resultApprDocList);
		// 디버깅
		log.debug(SHJ + resultApprDocList + " <-- resultApprDocList" + RESET);

		return resultMap;
	}
	
	
	// 참조자로 지정된 문서 목록 출력
	public List<ApprovalDocument> getApprDocListByRefId(String loginId){
		// 반환값
		List<ApprovalDocument> apprDocListRef = apprDocMapper.selectApprDocListByRefId(loginId);
				
		for(ApprovalDocument apprDoc : apprDocListRef) {
			// 문서구분 이름 받아오기
			Map<String,Object> documentNmMap = new HashMap<String,Object>();
			documentNmMap.put("grpCd", "A002");
			documentNmMap.put("cd", apprDoc.getDocumentCd());
			String documentNm =  commonMapper.getName(documentNmMap);
			
			// 항목구분 이름 받아오기
			Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
			documentSubNmMap.put("grpCd", "A003");
			documentSubNmMap.put("cd", apprDoc.getDocumentSubCd());
			String documentSubNm =  commonMapper.getName(documentSubNmMap);
			
			// 받아온 이름값 저장하기
			apprDoc.setDocumentNm(documentNm);
			apprDoc.setDocumentSubNm(documentSubNm);
			
			// 결재 상태 조회를 위해 문서번호 가져오기
		    String documentNo = apprDoc.getDocumentNo();
			
			// 결재 상태 조회
			String approvalStatusCd = "2";
			int countAppr2 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			approvalStatusCd = "3";
			int countAppr3 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
			
			String approvalStatus;

			if (countAppr2 == 3) {
				approvalStatus = "완료";
			} else if (countAppr3 > 0) {
				approvalStatus = "반려";
			} else {
				approvalStatus = "대기";
			}
			apprDoc.setApprovalStatus(approvalStatus);
		}
		
		return apprDocListRef;
	}
	
	
	/*
	// 결재문서 개수 출력
	public int getApprDocCnt(ApprovalDocument apprDoc){
		// 반환값
		int apprDocCnt = apprDocMapper.selectApprDocCnt();
		
		return apprDocCnt;
		
	}
	*/

	
	// 결재문서 상세정보 출력 (승인대기문서, 결재수신문서, 기안문서, 참조문서)
	public Map<String, Object> getApprDocByNo(String documentNo, String loginId){
		// 결재문서 상세정보
		ApprovalDocument resultApprDoc = apprDocMapper.selectApprDocByNo(documentNo);
		
		// 결재문서 상세이력
		ApprovalHistory resultApprHist = apprDocMapper.selectApprHistByNo(documentNo, loginId);
		
		// 이전 결재자의 상세이력
		ApprovalHistory resultApprHistPreLv = null;
		
		if(resultApprHist != null) {
			// 바로 직전 결재자의 결재상태를 조회하기 위해, 이전 결재이력의 번호를 변수에 저장
			int approvalNo = (resultApprHist.getApprovalNo())-1;
			resultApprHistPreLv = apprDocMapper.selectApprHistByNoPreLv(approvalNo);
		}
		
		// 참조자 상세정보
		ApprovalRef resultApprRef = apprDocMapper.selectApprRefByNo(documentNo);
		
		// 첨부파일 목록 조회
		List<ApprovalFile> resultApprFileList = apprDocMapper.selectApprFile(resultApprDoc);
		
		
		// 문서번호 및 결제레벨로 결재정보 조회
		int approvalLevel = 1;
		ApprovalHistory resultApprInfoLv1 = apprDocMapper.selectApprInfoByNo(documentNo, approvalLevel);
		resultApprInfoLv1.setApprovalLevel(approvalLevel);
		
		approvalLevel = 2;
		ApprovalHistory resultApprInfoLv2 = apprDocMapper.selectApprInfoByNo(documentNo, approvalLevel);
		resultApprInfoLv2.setApprovalLevel(approvalLevel);
		
		approvalLevel = 3;
		ApprovalHistory resultApprInfoLv3 = apprDocMapper.selectApprInfoByNo(documentNo, approvalLevel);
		resultApprInfoLv3.setApprovalLevel(approvalLevel);
		
		
		// 문서구분 이름 받아오기
		Map<String,Object> documentNmMap = new HashMap<String,Object>();
		documentNmMap.put("grpCd", "A002");
		documentNmMap.put("cd", resultApprDoc.getDocumentCd());
		String documentNm =  commonMapper.getName(documentNmMap);
		
		// 항목구분 이름 받아오기
		Map<String,Object> documentSubNmMap = new HashMap<String,Object>();
		documentSubNmMap.put("grpCd", "A003");
		documentSubNmMap.put("cd", resultApprDoc.getDocumentSubCd());
		String documentSubNm =  commonMapper.getName(documentSubNmMap);
		
		// 받아온 이름값 저장하기
		resultApprDoc.setDocumentNm(documentNm);
		resultApprDoc.setDocumentSubNm(documentSubNm);
		
		// 반환값
		Map<String, Object> resultApprMap = new HashMap<String, Object>();
		resultApprMap.put("resultApprDoc", resultApprDoc);
		if(resultApprHist != null) {
		resultApprMap.put("resultApprHist", resultApprHist);
		resultApprMap.put("resultApprHistPreLv", resultApprHistPreLv);
		}
		resultApprMap.put("resultApprRef", resultApprRef);
		resultApprMap.put("resultApprInfoLv1", resultApprInfoLv1);
		resultApprMap.put("resultApprInfoLv2", resultApprInfoLv2);
		resultApprMap.put("resultApprInfoLv3", resultApprInfoLv3);
		resultApprMap.put("resultApprFileList", resultApprFileList);
		
		return resultApprMap;
	}
	
	
	// 임시저장 문서 상세정보 출력
	public ApprovalDocument getApprDocByNoTempY(String documentNo){
		// 결재문서 상세정보
		ApprovalDocument resultApprDocTempY = apprDocMapper.selectApprDocByNo(documentNo);
		
		return resultApprDocTempY;
	}

	
	// 1) 문서분류 이름을 받아서 문서코드로 입력 
	// 2) 문서번호 생성
	public Map<String, String> insertDocumentNo(Map<String, Object> param){
		Map<String,String> resultMap = new HashMap<>();
		
		Map<String, Object> apprDocCdMap = commonMapper.getCode(param.get("documentNm").toString());
		Map<String, Object> apprDocCdMap2 = commonMapper.getCode(param.get("documentSubNm").toString());
		// 문서분류 이름이 넘어오면 -> DB에 입력할 코드 받아오기
		String documentCd = apprDocCdMap.get("cd").toString();
		String documentSubCd = apprDocCdMap2.get("cd").toString();
		// 디버깅
		log.debug(SHJ + documentCd + " <-- addApprDoc documentCd"+ RESET);
		log.debug(SHJ + documentSubCd + " <-- addApprDoc documentSubCd"+ RESET);
		// 생성된 문서코드 입력
		param.put("documentCd", documentCd);
		param.put("documentSubCd", documentSubCd);
		
		// 2) 문서번호 생성
		String documentNo = apprDocMapper.selectDocumentNo(param);
		
		resultMap.put("documentNo", documentNo);
		resultMap.put("documentCd", documentCd);
		resultMap.put("documentSubCd", documentSubCd);
		
		// 디버깅
		log.debug(SHJ + documentNo + " <-- addApprDoc documentNo"+ RESET);
		
		return resultMap;
	}
	
	
	// 1) 문서번호 받아오기 
	// 2) 파일 추가
	public Map<String, Object> fileAddApprDoc(Map<String, Object> param, List<MultipartFile> fileList, String loginId){
		Map<String, Object> resultMap = new HashMap<>();
		// 1) 문서번호 받아오기 
		String documentNo = (String) param.get("documentNo"); 
		
		if(documentNo != null) { // 문서번호 생성 성공 시
			
			// 2) 첨부파일 추가
			log.debug(SHJ + fileList + " <-- addApprDoc fileList"+ RESET);
			// 첨부된 파일이 1개이상 있다면
			if(fileList != null && fileList.size() > 0) {
				int maxFileSize = 1024 * 1024 * 100; //100Mbyte
				// 첨부된 파일의 개수만큼 반복
				for(MultipartFile mf : fileList) {						
					// 파일 크기가 0보다 크고 제한 크기 이하인 경우에만 처리
					if(mf.getSize() > 0 && mf.getSize() <= maxFileSize) {
						ApprovalFile af = new ApprovalFile();
						af.setDocumentNo(documentNo);
						af.setModId(loginId);
						af.setRegId(loginId);
						af.setApprovalFilesize(mf.getSize()); 
						af.setApprovalFiletype(mf.getContentType());
						// 원래 파일 이름
						String originFileName = mf.getOriginalFilename().substring(0,mf.getOriginalFilename().lastIndexOf("."));
						log.debug(SHJ + originFileName + " <-- addApprDoc originFileName"+ RESET);
						// 확장자
						String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
						// 저장될 파일 이름 = 원래이름 + UUID + 확장자
						af.setApprovalFilename(originFileName + "_" + UUID.randomUUID().toString().replace("-", "").substring(0,3) + ext);
						
						// DB에 저장
						apprDocMapper.insertApprFile(af);
						
						// 파일 저장(저장위치 필요 -> path변수)
						String path = param.get("path").toString();
						// path위치에 저장파일 이름으로 빈 파일을 생성
						File f = new File(path + af.getApprovalFilename());
						// 빈파일에 첨부된 파일의 스트림을 주입한다.
						try {
							mf.transferTo(f); // 스트림 주입 메서드
							resultMap.put("resultCode", "Y");
							resultMap.put("documentNo", documentNo);
							
						} catch (IllegalStateException | IOException e) {
							e.printStackTrace();
							resultMap.put("documentNo", documentNo);
						}
					}
				}
			} else {
				resultMap.put("resultCode", "Y");
				resultMap.put("documentNo", documentNo);
			}
		}
		// 문서 추가 성공 시 반환값
		return resultMap;
	}
	
	
	// 1) 결재문서 추가 
	// 2) 결재이력 추가
	// 3) 참조자 추가
	public int addApprDoc(Map<String, Object> param, String loginId){
		// 파라미터 맵에 loginId 정보 추가
		param.put("id", loginId);
		param.put("regId", loginId);
		param.put("modId", loginId);
		String documentNo = param.get("documentNo").toString();
		// 디버깅
		log.debug(SHJ + documentNo + " <-- addApprDoc documentNo"+ RESET);
		
		if(documentNo != null) { // 문서번호 생성 성공 시
			
			// 1) 결재문서 추가
			// 반환값
			int addApprDocRow = apprDocMapper.insertApprDoc(param);
			// 디버깅
			log.debug(SHJ + addApprDocRow + " <-- addApprDoc addApprDocRow"+ RESET);
			
			if("Y".equals(param.get("tempSave").toString())) {
				addApprDocRow = 11;
			}
			
			if(addApprDocRow > 0 && "N".equals(param.get("tempSave").toString())) { // 결재문서 추가 성공 시
				// 2) 결재이력 추가
				// 담당자(=level 1) 추가
				ApprovalHistory apprHistoryLv1 = new ApprovalHistory();
				apprHistoryLv1.setApprovalId(loginId);
				apprHistoryLv1.setDocumentNo(documentNo);
				apprHistoryLv1.setApprovalLevel(1);
				apprHistoryLv1.setApprovalStatusCd("2");
				apprHistoryLv1.setRegId(loginId);
				apprHistoryLv1.setModId(loginId);
				int addApprHistLv1Row = apprDocMapper.insertApprHistory(apprHistoryLv1);
				log.debug(SHJ + addApprHistLv1Row + " <-- addApprDoc addApprHistLv1Row"+ RESET);
				
				if(addApprHistLv1Row > 0) {
					// 결재자 level 2 추가
					ApprovalHistory apprHistoryLv2 = new ApprovalHistory();
					apprHistoryLv2.setApprovalId(param.get("approvalIdLv2").toString());
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
						apprHistoryLv3.setApprovalId(param.get("approvalIdLv3").toString());
						apprHistoryLv3.setDocumentNo(documentNo);
						apprHistoryLv3.setApprovalLevel(3);
						apprHistoryLv3.setApprovalStatusCd("1");
						apprHistoryLv3.setRegId(loginId);
						apprHistoryLv3.setModId(loginId);
						int addApprHistLv3Row = apprDocMapper.insertApprHistory(apprHistoryLv3);
						log.debug(SHJ + addApprHistLv3Row + " <-- addApprDoc addApprHistLv3Row"+ RESET);
						
						// 3) 참조자가 있다면 추가
						if(addApprHistLv3Row > 0 && StringUtils.hasText((CharSequence) param.get("refId"))) {
							ApprovalRef apprRef = new ApprovalRef();
							apprRef.setRefId(param.get("refId").toString());
							apprRef.setDocumentNo(documentNo);
							apprRef.setRegId(loginId);
							apprRef.setModId(loginId);
							int addApprRefRow = apprDocMapper.insertApprRef(param);
							log.debug(SHJ + addApprRefRow + " <-- addApprDoc addApprRefRow"+ RESET);
						}
					}
				}
			}
			// 문서 추가 성공 시 반환값
			return addApprDocRow;
			
		}
		// 문서 번호 생성 실패 시 반환값
		return 0;
	}
	
	
	// 임시저장 문서 수정
	public int modifyApprDocTempY(ApprovalDocument apprDoc){
		// 1) 문서코드 받아오기
		Map<String, Object> apprDocCdMap = commonMapper.getCode(apprDoc.getDocumentNm());
		Map<String, Object> apprDocCdMap2 = commonMapper.getCode(apprDoc.getDocumentSubNm());
		// 문서분류 이름이 넘어오면 -> DB에 입력할 코드 받아오기
		String documentCd = apprDocCdMap.get("cd").toString();
		String documentSubCd = apprDocCdMap2.get("cd").toString();
		// 디버깅
		log.debug(SHJ + documentCd + " <-- addApprDoc documentCd"+ RESET);
		log.debug(SHJ + documentSubCd + " <-- addApprDoc documentSubCd"+ RESET);
		
		apprDoc.setDocumentCd(documentCd);
		apprDoc.setDocumentSubCd(documentSubCd);
		
		// 반환값
		int updateApprDocRow = apprDocMapper.updateApprDocTempY(apprDoc);
				
		return updateApprDocRow;
	}
	
	
	// 임시저장 문서 삭제
	public int removeApprDocTempY(ApprovalDocument apprDoc){
		// 반환값
		int deleteApprDocRow = apprDocMapper.deleteApprDocTempY(apprDoc);
				
		return deleteApprDocRow;
	}
	
	
	/* 결재 파일 : ApprovalFile */
	/*
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
	*/
	
	
	/* 결재 참조자 : ApprovalRef */
	/*
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
	*/
	
	
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
	
	
	// 결재 이력 수정 (승인/반려)
	public int modifyApprHistory(String loginId, ApprovalHistory apprHistory){
		
		// 반환값
		int updateApprHistoryRow = apprDocMapper.updateApprHistory(apprHistory);
		
		// 문서 상세 정보
		String documentNo = apprHistory.getDocumentNo();
		ApprovalDocument resultApprDoc = apprDocMapper.selectApprDocByNo(documentNo);
		
		// 결재 상태 조회
		String approvalStatusCd = "2";
		int countAppr2 = apprDocMapper.selectApprStatusCnt(documentNo, approvalStatusCd);
		
		// 버튼을 눌러서 결재상태가 수정되고 && 결재라인 3명 모두 승인한 상태일 때 
		if(updateApprHistoryRow > 0 && countAppr2 == 3) {
			// 연차 이력 추가
			EmpDayoff empdayoff = new EmpDayoff();
			empdayoff.setId(resultApprDoc.getId());
			empdayoff.setDayoffStatus(resultApprDoc.getDocumentSubCd());
			empdayoff.setStartDay(resultApprDoc.getStartDay());
			empdayoff.setEndDay(resultApprDoc.getEndDay());
			empdayoff.setModId(loginId);
			empdayoff.setRegId(loginId);
			int insertDayoffInfoRow = dayoffMapper.insertDayoff(empdayoff);
			// 디버깅
			log.debug(SHJ + insertDayoffInfoRow + " <-- modifyApprHistory insertDayoffInfoRow"+ RESET);
			
			// 연차 이력 추가되면 연차잔여개수 차감
			if(insertDayoffInfoRow > 0) {
				// 기안 작성자의 상세정보
				EmpBase empbase = empMapper.selectEmpById(resultApprDoc.getId());
				Double dayoff = empbase.getDayoffCnt();
				
				// 연차 승인 시 - 1
				if(resultApprDoc.getDocumentSubCd().equals("21")) {
					Double dayoffCnt = dayoff - 1.0;
					empbase.setDayoffCnt(dayoffCnt);
					empbase.setId(resultApprDoc.getId());
					empbase.setModId(loginId);
					int updateDayoffCntRow1 = empMapper.updateDayoffCnt(empbase);
					// 디버깅
					log.debug(SHJ + updateDayoffCntRow1 + " <-- modifyApprHistory updateDayoffCntRow1"+ RESET);
					
				// 반차 승인 시 - 0.5
				} else if(resultApprDoc.getDocumentSubCd().equals("22")) {
					Double dayoffCnt = dayoff - 0.5;
					empbase.setDayoffCnt(dayoffCnt);
					empbase.setId(resultApprDoc.getId());
					empbase.setModId(loginId);
					int updateDayoffCntRow2 = empMapper.updateDayoffCnt(empbase);
					// 디버깅
					log.debug(SHJ + updateDayoffCntRow2 + " <-- modifyApprHistory updateDayoffCntRow2"+ RESET);
				}
			}
		}
				
		return updateApprHistoryRow;
	}
	
}
