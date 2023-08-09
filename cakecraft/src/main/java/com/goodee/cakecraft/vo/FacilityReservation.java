package com.goodee.cakecraft.vo;

import lombok.Data;

@Data
public class FacilityReservation {
	private int reservationNo;
	private int facilityNo;
	private String teamCd;
	private String id;
	private String reservationContent;
	private String startDtime;
	private String endDtime;
	private String regDtime;
	private String modDtime;
	private String regId;
	private String modId;
}

