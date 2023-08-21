package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ApprovalHistory {
	private int approvalNo;
	private String approvalId;
	private String documentNo;
	private int approvalLevel;
	private String approvalStatusCd;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}
