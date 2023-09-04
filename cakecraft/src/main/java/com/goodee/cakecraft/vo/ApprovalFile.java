package com.goodee.cakecraft.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ApprovalFile {
	private int approvalFileNo;			
	private String documentNo;		
	private String approvalFilename;
	private long approvalFilesize;
	private String approvalType;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	
	private List<MultipartFile> multipartFile;
}
