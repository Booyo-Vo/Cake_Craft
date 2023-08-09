package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ApprovalFile {
	private int fileNo;			
	private int documentNo;		
	private String approvalFilename;
	private String approvalPath;
	private String approvalType;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
