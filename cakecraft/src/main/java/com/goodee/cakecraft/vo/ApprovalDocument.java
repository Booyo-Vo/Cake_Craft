package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class ApprovalDocument {
	private String documentNo;
	private String id;
	private String documentTitle;
	private String documentContent;
	private String documentCd;
	private String documentSubCd;
	private String startDay;
	private String endDay;
	private String tempSave;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
	
	private String documentNm;
	private String documentSubNm;
}
