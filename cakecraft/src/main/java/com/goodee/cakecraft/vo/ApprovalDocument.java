package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ApprovalDocument {
	private int documentNo;
	private String id;
	private String documentContent;
	private String approvalStatusCd;
	private String tempSave;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
