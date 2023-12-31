package com.goodee.cakecraft.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.cakecraft.service.CommonService;


@Controller
public class CommonController {
	@Autowired CommonService commonService;
	
	//코드를 받아서 이름을 반환
	public String getCode(@RequestParam(name="grpCd", defaultValue = "") String grpCd,
							@RequestParam(name="cd", defaultValue = "") String cd){
		String cdNm = commonService.getName(grpCd, cd);
		return cdNm;
	} 
	
	//이름을 받아서 코드를 반환
	public Map<String, Object> getName(@RequestParam(name="cdNm", defaultValue = "") String cdNm) {
		Map<String, Object> codeMap = commonService.getCode(cdNm);
		
		return codeMap;
	}
	
	public static HashMap<String, Object> getParameterMap(HttpServletRequest request){



		HashMap<String, Object> parameterMap = new HashMap<String, Object>();

	      Enumeration enums = request.getParameterNames();

	      

	      while(enums.hasMoreElements()){

	         String paramName = (String)enums.nextElement();

	         String[] parameters = request.getParameterValues(paramName);

	   

	         if(parameters.length > 1){

	            parameterMap.put(paramName, parameters);

	         }else{

	            parameterMap.put(paramName, parameters[0]);

	         }

	      }

	   

	      return parameterMap;

	   }
}
