package com.goodee.cakecraft.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.EmpService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class RestSignController {
	@Autowired
	EmpService empService;
	
	@PostMapping("/emp/addSign")
	public String addSign(HttpServletRequest request, @RequestParam(name = "sign") String sign) {
		String path = request.getServletContext().getRealPath("/signImg/");
		empService.addSign(sign, path);
		
		return "YES";
	}
}
