package com.goodee.cakecraft.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.mapper.AttendanceMapper;
import com.goodee.cakecraft.mapper.CommonMapper;
import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.vo.EmpAttendance;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpProfileImg;
import com.goodee.cakecraft.vo.EmpSignImg;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class EmpService {
	//ANSI코드
	final String KMS = "\u001B[44m";
	final String RESET = "\u001B[0m"; 
	
	@Autowired
	private EmpMapper empMapper;
	@Autowired
	private CommonMapper commonMapper;
	
	//마이페이지에 사원정보 출력
	public EmpBase getMyEmpById(String id) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("id", id);

	    // 사원 상세내역
	    EmpBase resultEmpBase = empMapper.selectMyEmpById(id);
	    log.debug(KMS + "resultEmpBase / EmpService" + resultEmpBase.toString() + RESET);
	    
	    if (resultEmpBase != null) { 
			//부서 이름 받아오기
			Map<String, Object> deptparamMap = new HashMap<String, Object>();
			deptparamMap.put("grpCd", "D001");
			deptparamMap.put("cd", resultEmpBase.getDeptCd());
			String deptNm = commonMapper.getName(deptparamMap);
			log.debug(KMS + "EmpById deptNm :"+ deptNm + RESET);
			//팀 이름 받아오기
			Map<String, Object> teamparamMap = new HashMap<String, Object>();
			teamparamMap.put("grpCd", "T001");
			teamparamMap.put("cd", resultEmpBase.getTeamCd());
			String teamNm = commonMapper.getName(teamparamMap);
			log.debug(KMS + "EmpById teamNm :"+ teamNm + RESET);
			//직급 이름 받아오기
			Map<String, Object> positionparamMap = new HashMap<String, Object>();
			positionparamMap.put("grpCd", "P001");
			positionparamMap.put("cd", resultEmpBase.getPositionCd());
			String positionNm = commonMapper.getName(positionparamMap);
			log.debug(KMS + "EmpById positionNm :"+ positionNm + RESET);
			//받아온 이름값 저장하기
			resultEmpBase.setDeptNm(deptNm);
			resultEmpBase.setTeamNm(teamNm);
			resultEmpBase.setPositionNm(positionNm);
		 }
	    return resultEmpBase;
	}

	
	// 사인 존재여부 확인
	public int signCnt(String id) {
		return empMapper.signCnt(id);
	}
	
    // 사인 추가
    public void addSign(String sign, String path, String loginId) {
		//이미지 데이터 추출
		/*
		 * sign변수: Base64로 인코딩된 이미지 데이터를 담고 있는 문자열
		 * split 메서드: 문자열을 특정 구분자 기준으로 나누는 기능
		 * 나눈 결과를 문자열 배열로 반환한다
		 * type 변수: image 타입이 저장
		 * data 변수: 이미지데이터가 Base64 형식으로 저장
		 */
    	//loginId 받기
    	

		String type = sign.split(",")[0].split(";")[0].split(":")[1];
		String data = sign.split(",")[1];
		//Base64를 디코드 해 이미지 바이트 배열로 변환
		byte[] image = Base64.decodeBase64(data);
		int size = image.length;
		
		// 저장할 파일 이름 생성 (id 사용)
	    String signFilename = loginId + ".png"; // 여기서 id를 사용하여 파일 이름 생성
		
		// DB에 정보 저장을 위한 Sign 객체 생성
		EmpSignImg s = new EmpSignImg();
		s.setId(loginId);
		s.setSignFilename(signFilename);
		s.setSignFilesize(size);
		s.setSignType(type);
		s.setModId(loginId);
		s.setRegId(loginId);
		
		//Sign 정보 DB에 저장
		empMapper.insertSign(s);
		
		// 빈 파일 생성
		File f = new File(path+signFilename);

		try {
			// 빈 파일에 이미지 파일 쓰기
			FileOutputStream fileOutputStream = new FileOutputStream(f);
			fileOutputStream.write(image);
			fileOutputStream.close();
			log.debug("empService.addSign() f.length() : " + f.length());
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			// 트랜잭션 작동을 위해 예외(try/catch를 강요하지 않는 예외: RuntimeException) 발생이 필요
			throw new RuntimeException();
		}
	}

    	
    	// 사인 수정
    	public void updateSign(String sign, String path, String loginId) {
			// 이미지 데이터 추출 및 처리
			String type = sign.split(",")[0].split(";")[0].split(":")[1];
			String data = sign.split(",")[1];
			byte[] image = Base64.decodeBase64(data);
			int size = image.length;
			
			// 기존 사인 이미지 삭제
			EmpSignImg removeSignImg = new EmpSignImg();
			removeSignImg.setId(loginId);
			empMapper.removeSign(removeSignImg);
			
			// 새로운 사인 이미지 추가
			String signFilename = loginId + ".png";
			EmpSignImg s = new EmpSignImg();
			s.setId(loginId);
			s.setSignFilename(signFilename);
			s.setSignFilesize(size);
			s.setSignType(type);
			s.setModId(loginId);
			s.setRegId(loginId);
			empMapper.insertSign(s);

			// 새로운 사인 이미지 파일 생성
			File f = new File(path + signFilename);
			try {
				FileOutputStream fileOutputStream = new FileOutputStream(f);
				fileOutputStream.write(image);
				fileOutputStream.close();
				log.debug("empService.updateSign() f.length() : " + f.length());
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
		}	

	// 사원이 보는 사원리스트
		public List<EmpBase> getEmpList(String searchWord){
			//사원리스트 받아오기
			List<EmpBase> empList = empMapper.selectMyEmpList(searchWord);
			log.debug(KMS + "empList 사이즈/EmpService" + empList.size() +RESET);
			
			for (EmpBase empbase : empList) {
				//부서 이름 받아오기
				Map<String, Object> deptparamMap = new HashMap<String, Object>();
				deptparamMap.put("grpCd", "D001");
				deptparamMap.put("cd", empbase.getDeptCd());
				String deptNm = commonMapper.getName(deptparamMap);
				log.debug(KMS + "adminEmpList deptNm :"+ deptNm + RESET);
				
				//팀 이름 받아오기
				Map<String, Object> teamparamMap = new HashMap<String, Object>();
				teamparamMap.put("grpCd", "T001");
				teamparamMap.put("cd", empbase.getTeamCd());
				String teamNm = commonMapper.getName(teamparamMap);
				log.debug(KMS + "adminEmpList teamNm :"+ teamNm + RESET);
				
				//직급 이름 받아오기
				Map<String, Object> positionparamMap = new HashMap<String, Object>();
				positionparamMap.put("grpCd", "P001");
				positionparamMap.put("cd", empbase.getPositionCd());
				String positionNm = commonMapper.getName(positionparamMap);
				log.debug(KMS + "adminEmpList positionNm :"+ positionNm + RESET);
				//받아온 이름값 저장하기
				empbase.setDeptNm(deptNm);
		        empbase.setTeamNm(teamNm);
		        empbase.setPositionNm(positionNm);
			} 
			return empList;
		}
		// 사원 상세내역
		public EmpBase getEmpById(String id) {
			log.debug(KMS + "EmpById id :"+ id + RESET);
			
			//사원상세내역 받아오기
			EmpBase empbase = empMapper.selectEmpById(id);
			EmpSignImg empSignImg = new EmpSignImg();
			 if (empbase != null) { 
				//부서 이름 받아오기
				Map<String, Object> deptparamMap = new HashMap<String, Object>();
				deptparamMap.put("grpCd", "D001");
				deptparamMap.put("cd", empbase.getDeptCd());
				String deptNm = commonMapper.getName(deptparamMap);
				log.debug(KMS + "EmpById deptNm :"+ deptNm + RESET);
				//팀 이름 받아오기
				Map<String, Object> teamparamMap = new HashMap<String, Object>();
				teamparamMap.put("grpCd", "T001");
				teamparamMap.put("cd", empbase.getTeamCd());
				String teamNm = commonMapper.getName(teamparamMap);
				log.debug(KMS + "EmpById teamNm :"+ teamNm + RESET);
				//직급 이름 받아오기
				Map<String, Object> positionparamMap = new HashMap<String, Object>();
				positionparamMap.put("grpCd", "P001");
				positionparamMap.put("cd", empbase.getPositionCd());
				String positionNm = commonMapper.getName(positionparamMap);
				log.debug(KMS + "EmpById positionNm :"+ positionNm + RESET);
				//받아온 이름값 저장하기
				empbase.setDeptNm(deptNm);
				empbase.setTeamNm(teamNm);
				empbase.setPositionNm(positionNm);
				empSignImg.setSignFilename(id);

			 }
			return empbase;
		}
		// 사원정보수정
		// 파일 추가/수정도 함께
		public int modifyMyEmp(EmpBase empBase, String path) {
			log.debug(KMS + empBase.getEmpName() + RESET);
			
			// 부서 정보 가져오기
			empBase.setDeptCd(empBase.getDeptCd());
			empBase.setTeamCd(empBase.getTeamCd());
			empBase.setPositionCd(empBase.getPositionCd());
			
			int row = empMapper.updateEmpInfo(empBase);
			
			MultipartFile profileImageFile = (MultipartFile) empBase.getProfileImage(); // 프로필 이미지 파일
			
			// 프로필 이미지를 수정했을 때만 실행
			if (profileImageFile != null && !profileImageFile.isEmpty()) {
				int maxFileSize = 1024 * 1024 * 100; // 100Mbyte
				
				// 이전 첨부파일 삭제
				List<EmpProfileImg> empFileList = empMapper.selectEmpProfileImg(empBase);
				if (empFileList != null && empFileList.size() > 0) {
					for (EmpProfileImg af : empFileList) {
						File f = new File(path + af.getProfileFilename());
						if (f.exists()) {
							f.delete();
						}
					}
						// emp_profileImg 테이블에서 삭제
						empMapper.deleteEmpProfilePic(empBase);
				}
		
				// 프로필 이미지 추가 및 업데이트
				String profileFilename = empBase.getId() + ".jpg"; // 로그인 아이디를 기반으로 파일 이름 생성
				String profilePath = path + profileFilename;
				String profileType = profileImageFile.getContentType();
				
				EmpProfileImg empProfileImg = new EmpProfileImg();
				empProfileImg.setId(empBase.getId());
				empProfileImg.setProfileFilename(profileFilename);
				empProfileImg.setProfilePath(profilePath);
				empProfileImg.setProfileType(profileType);
		
				log.debug(KMS + profilePath + "<-profilePath / EmpService" + RESET);
				empMapper.insertEmpProfileImg(empProfileImg);
			}
		
			return row;
		}
		
		// 사원명으로 검색하여 사원정보리스트 조회
		public List<HashMap<String, Object>> getEmpListByNm(String empName) {
			 List<HashMap<String, Object>> enmList = empMapper.getEmpListByNm(empName);
		return enmList; 
		}		

}
