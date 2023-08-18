package com.goodee.cakecraft.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.ReservationMapper;
import com.goodee.cakecraft.vo.EmpIdList;
import com.goodee.cakecraft.vo.FacilityReservation;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ReservationService {
	@Autowired ReservationMapper reservationMapper;
	final String KMJ = "\u001B[43m";
	final String RESET = "\u001B[0m";
	
	public Map<String, Object> getReservationByDate(Integer targetYear, Integer targetMonth, Integer targetDate, String categoryCd) {
		//날짜 값 세팅
		Calendar today = Calendar.getInstance();
		int currYear = today.get(Calendar.YEAR);
		int currMonth = today.get(Calendar.MONTH);
		int currDate = today.get(Calendar.DATE);
		String currDay = "";
		String currMonthStr = "" + currMonth;
		String currDateStr = "" + currDate;
		//view 출력을 위하여 반환값 가공
		if(currMonth < 9) {
			currMonthStr = "0" + (currMonth + 1);
		}
		if(currDate < 10) {
			currDateStr = "0" + currDate;
		}
		currDay = currYear + "-" + currMonthStr + "-" + currDateStr;

		//view 출력을 위하여 반환값 가공
		if(targetYear == null) {
			targetYear = currYear;
		}
		if(targetMonth == null) {
			targetMonth = currMonth;
		}
		if(targetDate == null) {
			targetDate = currDate;
		}
		
		String date = "";
		String targetMonthStr = "" + targetMonth;
		String targetDateStr = "" + targetDate;
		if(targetMonth < 9) {
			targetMonthStr = "0" + (targetMonth + 1);
		}
		if(targetDate < 10) {
			targetDateStr = "0" + targetDate;
		}
		date = targetYear + "-" + targetMonthStr + "-" + targetDateStr;
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1);
		paramMap.put("targetDate", targetDate);
		paramMap.put("categoryCd", categoryCd+"%");
		
		List<FacilityReservation> reservationList = reservationMapper.selectReservationListByDate(paramMap);
		log.debug(KMJ + reservationList.size() + " <--ReservationService.getReservationByDate reservationList.size()" + RESET);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		today.add(today.DATE, +7); //일주일 후 날짜 계산
		int weekYear = today.get(Calendar.YEAR);
		int weekMonth = today.get(Calendar.MONTH);
		int weekDate = today.get(Calendar.DATE);
		String weekDay = "";
		String weekMonthStr = "" + weekMonth;
		String weekDateStr = "" + weekDate;
		if(weekMonth < 9) {
			weekMonthStr = "0" + (weekMonth + 1);
		}
		if(targetDate < 10) {
			weekDateStr = "0" + weekDate;
		}
		weekDay = weekYear + "-" + weekMonthStr + "-" + weekDateStr;
		
		resultMap.put("reservationList", reservationList);
		resultMap.put("targetYear", targetYear);
		resultMap.put("targetMonth", targetMonth);
		resultMap.put("targetDate", targetDate);
		resultMap.put("date", date);
		resultMap.put("currDay", currDay);
		resultMap.put("weekDay", weekDay);
		resultMap.put("categoryCd", categoryCd);
		resultMap.put("weekYear", weekYear);
		resultMap.put("weekMonth", weekMonth);
		resultMap.put("weekDate", weekDate);
		
		return resultMap;
	}
	
	public List<String> getReservationTime(Map<String, Object> paramMap){
		List<Map<String, Object>> timeList = reservationMapper.selectReservationTime(paramMap);
		log.debug(timeList.toString());
		
		List<String> unbookedList = new ArrayList<>();
		for(int i=9; i<18; i++) {
			unbookedList.add(i+":00-"+(i+1)+":00");
		}
		
		for(Map<String, Object> m : timeList){
			int startHour = Integer.parseInt(m.get("startHour").toString()); //시작시간
			int endHour = Integer.parseInt(m.get("endHour").toString()); //끝나는시간
			for(double d=9.5; d<18; d++) {
				if(d > startHour && d < endHour) {
					int hour = (int)(d - 0.5);
					unbookedList.remove(hour+":00-"+(hour+1)+":00");
				}
			}
		}
		log.debug(KMJ + unbookedList.toString() + "<--reservationService.getReservationTime() unbookedList" + RESET);
		return unbookedList;
	}
	
	public List<Map<String, Object>> getReservationListById(EmpIdList emp){
		List<Map<String, Object>> resultList = reservationMapper.selectReservationListById(emp);
		return resultList;
	}
	
	public int addReservation(Map<String, Object> paramMap) {
		int addReservRow = reservationMapper.insertReservation(paramMap);
		return addReservRow;
	}
	
	public int removeReservation(FacilityReservation reservation) {
		int rmvReservRow = reservationMapper.deleteReservation(reservation);
		return rmvReservRow;
	}
	
	public String getAnHourLater() {
		String anHourLater = reservationMapper.selectAnHourLater();
		return anHourLater;
	}
}
