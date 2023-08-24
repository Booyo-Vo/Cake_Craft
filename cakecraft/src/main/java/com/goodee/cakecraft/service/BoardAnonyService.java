package com.goodee.cakecraft.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.mapper.BoardAnonyFileMapper;
import com.goodee.cakecraft.mapper.BoardAnonyMapper;
import com.goodee.cakecraft.mapper.BoardCommentsMapper;
import com.goodee.cakecraft.vo.BoardAnony;
import com.goodee.cakecraft.vo.BoardAnonyComments;
import com.goodee.cakecraft.vo.BoardAnonyFile;
import com.goodee.cakecraft.vo.BoardLike;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardAnonyService {
	@Autowired BoardAnonyMapper anonyMapper;
	@Autowired BoardAnonyFileMapper anonyFileMapper;
	@Autowired BoardCommentsMapper commentsMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 익명게시판 목록 조회
	public Map<String, Object> getAnonyList(String searchWord){
		
		// 게시글 목록 가져오기
		List<BoardAnony> anonyList = anonyMapper.selectAnonyList(searchWord);
		log.debug(GEH + anonyList.size() + " <-- 익명 게시판 목록.size" + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("anonyList",anonyList);
		
		return resultMap;
		
	}
	
	// 게시글 상세정보
	public Map<String, Object>  getAnonyByNo(BoardAnony anony) {
		// 게시글 상세정보 조회
		BoardAnony resultAnony = anonyMapper.selectAnonyByNo(anony);
		log.debug(GEH + resultAnony.toString() + " <-- 게시글상세정보" + RESET);
		
		// 첨부파일 목록 조회
		List<BoardAnonyFile> anonyFileList = anonyFileMapper.selectAnonyFile(anony);
		log.debug(GEH + anonyFileList.size() + " <-- 첨부파일 목록.size" + RESET);
		
		// 댓글 목록 조회
		List<BoardAnonyComments> commentsList = commentsMapper.selectCommentsList(anony);
		log.debug(GEH + commentsList.size() + " <-- 댓글 목록.size" + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultAnony", resultAnony);
		resultMap.put("anonyFileList", anonyFileList);
		resultMap.put("commentsList", commentsList);
		
		return resultMap;
	}
	
	// 게시글 추가 & 첨부파일 추가
	public int addAnony(BoardAnony anony, String path) {
		// 게시글 추가
		int row = anonyMapper.insertAnony(anony);
		
		// 첨부파일 추가
		List<MultipartFile> fileList = anony.getMultipartFile();
		// 게시글 입력이 성공하고 첨부된 파일이 1개이상 있다면
		if(row == 1 && fileList != null && fileList.size() > 0) {
			int anonyNo = anony.getAnonyNo();
			String id = anony.getId();
			int maxFileSize = 1024 * 1024 * 100; //100Mbyte
			
			// 첨부된 파일의 개수만큼 반복
			for(MultipartFile mf : fileList) {
				// 파일 크기가 0보다 크고 제한 크기 이하인 경우에만 처리
				if(mf.getSize() > 0 && mf.getSize() <= maxFileSize) {
					BoardAnonyFile af = new BoardAnonyFile();
					af.setAnonyNo(anonyNo);
					af.setModId(id);
					af.setRegId(id);
					af.setAnonyFilesize(mf.getSize()); 
					af.setAnonyType(mf.getContentType());
					// 원래 파일 이름
					String originFileName = mf.getOriginalFilename().substring(0,mf.getOriginalFilename().lastIndexOf("."));
					// 확장자
					String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
					// 저장될 파일 이름 = 원래이름 + UUID + 확장자
					af.setAnonyFilename(originFileName + "_" + UUID.randomUUID().toString().replace("-", "").substring(0,3) + ext);
					
					// DB에 저장
					anonyFileMapper.insertAnonyFile(af);
					
					// 파일 저장(저장위치 필요 -> path변수)
					// path위치에 저장파일 이름으로 빈 파일을 생성
					File f = new File(path+af.getAnonyFilename());
					// 빈파일에 첨부된 파일의 스트림을 주입한다.
					try {
						mf.transferTo(f); // 스트림 주입 메서드
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
						throw new RuntimeException();
					}
				}
			}
		}
		
		return row;
	}
	
	// 게시글 수정 & 첨부 파일 수정
	public int modifyAnony(BoardAnony anony, String path) {
		// 게시글 수정
		int row = anonyMapper.updateAnony(anony);
		
		// 게시글 수정이 성공하고 첨부된 파일이 1개 이상이 있다면 
		List<MultipartFile> fileList = anony.getMultipartFile();
		if(row == 1 && fileList != null && fileList.size() > 0) {
			// 이전 첨부파일 삭제
			List<BoardAnonyFile> anonyFileList = anonyFileMapper.selectAnonyFile(anony);
			if(anonyFileList != null && anonyFileList.size() > 0) {
				for(BoardAnonyFile af : anonyFileList) {
					File f = new File(path + af.getAnonyFilename());
					if(f.exists()) {
						// 폴더에서 파일 삭제
						f.delete();
					}
				}
				// board_anony_file 테이블에서 삭제
				anonyFileMapper.deleteAnonyFile(anony);
			}
			
			int anonyNo = anony.getAnonyNo();
			String id = anony.getId();
			int maxFileSize = 1024 * 1024 * 100; //100Mbyte
			
			// 첨부된 파일의 개수만큼 반복
			for(MultipartFile mf : fileList) {
				// 파일 크기가 0보다 크고 제한 크기 이하인 경우에만 처리
				if(mf.getSize() > 0 && mf.getSize() <= maxFileSize) {
					BoardAnonyFile af = new BoardAnonyFile();
					af.setAnonyNo(anonyNo);
					af.setModId(id);
					af.setRegId(id);
					af.setAnonyFilesize(mf.getSize()); 
					af.setAnonyType(mf.getContentType());
					// 원래 파일 이름
					String originFileName = mf.getOriginalFilename().substring(0,mf.getOriginalFilename().lastIndexOf("."));
					// 확장자
					String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
					// 저장될 파일 이름 = 원래이름 + UUID + 확장자
					af.setAnonyFilename(originFileName + "_" + UUID.randomUUID().toString().replace("-", "").substring(0,3) + ext);
					
					// DB에 저장
					anonyFileMapper.insertAnonyFile(af);
				
					// 파일 저장(저장위치 필요 -> path변수)
					// path위치에 저장파일 이름으로 빈 파일을 생성
					File f = new File(path+af.getAnonyFilename());
					// 빈파일에 첨부된 파일의 스트림을 주입한다.
					try {
						mf.transferTo(f); // 스트림 주입 메서드
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
						throw new RuntimeException();
					}
				}
			}
		}
		return row;
	}
	
	// 게시글 삭제 & 첨부파일 삭제
	public int removeAnony(BoardAnony anony, String path) {
		// 첨부파일 삭제
		List<BoardAnonyFile> anonyFileList = anonyFileMapper.selectAnonyFile(anony);
		if(anonyFileList != null && anonyFileList.size() > 0) {
			for(BoardAnonyFile af : anonyFileList) {
				File f = new File(path + af.getAnonyFilename());
				if(f.exists()) {
					// 폴더에서 파일 삭제
					f.delete();
				}
			}
			// board_anony_file 테이블에서 삭제
			anonyFileMapper.deleteAnonyFile(anony);
		}
		
		// 게시글 삭제
		int row = anonyMapper.deleteAnony(anony);
				
		return row;
	}
	
	// 좋아요 눌렀는지 여부 확인
	public int getLike(BoardAnony anony) {
		int row = anonyMapper.selectLike(anony);
		log.debug(GEH + row + " <-- 좋아요 여부확인" + RESET);
		
		return row;
	}
	
	// 좋아요 +1
	public int likeUp(BoardLike like) {
		int row = anonyMapper.insertLikeUp(like);
		
		return row;
	}
	
	// 좋아요 -1
	public int likeDown(BoardLike like) {
		int row = anonyMapper.deleteLikeDown(like);
		
		return row;
	}
	
	// 전체 좋아요 개수 변경
	public int modifyLikeCnt(BoardLike like) {
		// 게시글별 좋아요 개수 조회
		int sumLikeNum = anonyMapper.selectLikeNum(like);
		
		BoardAnony anony = new BoardAnony();
		anony.setAnonyNo(like.getAnonyNo());
		anony.setLikeCnt(sumLikeNum);
		
		int row = anonyMapper.updateLikeCnt(anony);
		
		return row;
	}
}
