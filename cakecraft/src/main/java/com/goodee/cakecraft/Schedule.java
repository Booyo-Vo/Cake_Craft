package com.goodee.cakecraft;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.goodee.cakecraft.service.DayoffService;

@Component
public class Schedule {
	@Autowired
	DayoffService dayoffService;
	
	@Scheduled(cron = "0 0 1 1 1 ?") // 매년 1월 1일 자정에 실행
	public void updatedefaultDayoffCnt() {
		dayoffService.defaultDayoffCnt();
	}
}
