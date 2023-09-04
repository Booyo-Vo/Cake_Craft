package com.goodee.cakecraft.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.cakecraft.mapper.EmpMapper;
import com.goodee.cakecraft.mapper.ScheduleMapper;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.ScheduleBase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	@Autowired EmpMapper empMapper;
	
	// Ansi코드
	final String RESET = "\u001B[0m";	
	final String GEH = "\u001B[45m";
	
	// 일정 목록 조회(월간, 일간)
	public Map<String, Object> getSchedule(String id, Integer targetYear, Integer targetMonth) throws IOException{
		
		Calendar firstDate = Calendar.getInstance();
		// 첫번째 날짜
		firstDate.set(Calendar.DATE, 1);
		
		// targetYear, targetMonth 가 매개값으로 넘어 왔다면
		if(targetYear != null && targetMonth != null) {
			firstDate.set(Calendar.YEAR, targetYear);
			firstDate.set(Calendar.MONTH, targetMonth); 
		}
		
		targetYear = firstDate.get(Calendar.YEAR);
		targetMonth = firstDate.get(Calendar.MONTH);
		
		// 마지막 날짜
		int lastDate = firstDate.getActualMaximum(Calendar.DATE);
		
		// 오늘 날짜 
		Calendar today = Calendar.getInstance();
		int todayDate = today.get(Calendar.DATE);
		int todayYear = today.get(Calendar.YEAR);
		int todayMonth = today.get(Calendar.MONTH);
		
		// targetMonth 영문으로 변환
		String strTargetMonth = null;
		if(targetMonth == 0) {
			strTargetMonth = "January";
		}else if(targetMonth == 1) {
			strTargetMonth = "February";
		}else if(targetMonth == 2) {
			strTargetMonth = "March";
		}else if(targetMonth == 3) {
			strTargetMonth = "April";
		}else if(targetMonth == 4) {
			strTargetMonth = "May";
		}else if(targetMonth == 5) {
			strTargetMonth = "June";
		}else if(targetMonth == 6) {
			strTargetMonth = "July";
		}else if(targetMonth == 7) {
			strTargetMonth = "August";
		}else if(targetMonth == 8) {
			strTargetMonth = "September";
		}else if(targetMonth == 9) {
			strTargetMonth = "October";
		}else if(targetMonth == 10) {
			strTargetMonth = "November";
		}else {
			strTargetMonth = "December";
		}
		
		// 1일의 요일을 이용하여 출력할 시작 공백 수 -> 요일 맵핑 수 - 1
		int beginBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1;
		
		// 마지막 날짜 이후 출력할 공백 수 
		int endBlank = 0;
		if((beginBlank+lastDate) % 7 != 0) {
			endBlank = 7 - ((beginBlank+lastDate)%7);
		}

		// 전체 개수 
		int totalTd = beginBlank + lastDate + endBlank;
		
		log.debug(GEH + targetYear + " <-- targetYear" + RESET);
		log.debug(GEH + targetMonth + " <-- targetMonth" + RESET);
		log.debug(GEH + lastDate + " <-- lastDate"+ RESET);
		log.debug(GEH + todayDate + " <-- todayDate"+ RESET);
		log.debug(GEH + beginBlank + " <-- beginBlank"+ RESET);
		log.debug(GEH + endBlank + " <-- endBlank" + RESET);
		log.debug(GEH + totalTd + " <-- totalTd" + RESET);
		log.debug(GEH + todayYear + " <-- todayYear" + RESET);
		log.debug(GEH + todayMonth + " <-- todayMonth" + RESET);
		
		// 반환값
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("targetYear",targetYear);
		resultMap.put("targetMonth",targetMonth);
		resultMap.put("lastDate",lastDate);
		resultMap.put("beginBlank",beginBlank);
		resultMap.put("endBlank",endBlank);
		resultMap.put("totalTd",totalTd);
		resultMap.put("todayYear",todayYear);
		resultMap.put("todayMonth",todayMonth);
		resultMap.put("strTargetMonth",strTargetMonth);
		
		// 로그인한 사원정보 가져오기
		EmpBase empBase = empMapper.selectEmpById(id);
		log.debug(GEH + empBase.toString() + " <-- empBase(로그인한 사원정보)" + RESET);
		
		// Dao의 매개값형태에 맞게 가공
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth+1);
		paramMap.put("todayDate", todayDate);
		paramMap.put("teamCd", empBase.getTeamCd());
		
		// 월간 전사일정 목록 가져오기
		List<ScheduleBase> scheduleListByCateAll = scheduleMapper.selectScheduleListByCateAll(paramMap);
		log.debug(GEH + scheduleListByCateAll.size() + " <-- 월간 전사 일정목록.size" + RESET);
		
		// 월간 팀일정 목록 가져오기 
		List<ScheduleBase> scheduleListByCateTeam = scheduleMapper.selectScheduleListByCateTeam(paramMap);
		log.debug(GEH + scheduleListByCateTeam.size() + " <-- 월간 팀 일정목록.size" + RESET);
		
		// 월간 개인일정 목록 가져오기
		List<ScheduleBase> scheduleListByCateId = scheduleMapper.selectScheduleListByCateId(paramMap);
		log.debug(GEH + scheduleListByCateId.size() + " <-- 월간 개인 일정목록.size" + RESET);
		
		// 일간 일정 목록 가져오기
		List<ScheduleBase> scheduleListByDate = scheduleMapper.selectScheduleListByDate(paramMap);
		log.debug(GEH + scheduleListByDate.size() + " <-- 일간 일정목록.size" + RESET);
		
		// 반환값
		resultMap.put("empBase",empBase);
		resultMap.put("scheduleListByCateAll",scheduleListByCateAll);
		resultMap.put("scheduleListByCateTeam",scheduleListByCateTeam);
		resultMap.put("scheduleListByCateId",scheduleListByCateId);
		resultMap.put("scheduleListByDate",scheduleListByDate);
		
		// 공휴일 정보 불러오기
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); // URL
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "="+ "byt3nbMXPBzGrVyimxHzEnHsLXz9mRAqzovfs3mwJqRdpG3gEmWdic8%2BMPAz5ZnygLMCRXMEH521vFMEXDJN8Q%3D%3D"); // Service Key
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); // 타입
		urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(targetYear.toString(), "UTF-8")); // 검색할 연도
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("365", "UTF-8")); // 최대로 출력할 공휴일 수
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		// 공휴일 정보를 저장할 Array
		List<Map<String, Object>> holidayList = new ArrayList<>();

		try {
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(rd);
				JSONObject responseResult = (JSONObject) jsonObject.get("response");
				JSONObject bodyInfo = (JSONObject) responseResult.get("body");
				JSONObject itemsInfo = (JSONObject) bodyInfo.get("items");
				JSONArray itemInfo = (JSONArray) itemsInfo.get("item");

				for (int i = 0; i < itemInfo.size(); i++) {
					JSONObject day = (JSONObject) itemInfo.get(i);
					String locdate = day.get("locdate").toString();
					String dateName = day.get("dateName").toString();
					
					// 공휴일 정보를 Map에 추가
					Map<String, Object> holidayMap = new HashMap<String, Object>();
					holidayMap.put("locdate", locdate);
					holidayMap.put("dateName", dateName);
					// Map을 리스트에 추가
					holidayList.add(holidayMap);
				}
				rd.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.disconnect();
		}
		
		// 반환값
		resultMap.put("holidayList",holidayList);
		
		return resultMap;
	}
	
	// 일정 상세정보 조회
	public ScheduleBase getScheduleByNo(ScheduleBase schedule) {
		ScheduleBase resultSchedule = scheduleMapper.selectScheduleByNo(schedule);
		
		return resultSchedule;
	}
	
	
	// 일정 추가
	public int addSchedule(ScheduleBase schedule) {
		int row = scheduleMapper.insertSchedule(schedule);
		
		return row;
	}
	
	// 일정 수정 
	public int modifySchedule(ScheduleBase schedule) {
		int row = scheduleMapper.updateSchedule(schedule);
		
		return row;
	}
	
	// 일정 삭제
	public int removeSchedule(ScheduleBase schedule) {
		int row = scheduleMapper.deleteSchedule(schedule);
		
		return row;
	}
}
