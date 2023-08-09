package com.goodee.cakecraft.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestController {
	@Autowired CommonController commonController;
	
	@GetMapping("/test")
	public String getCode(Model model, String name) {
		String code = commonController.getCode("인사팀");
		log.debug(code);
		model.addAttribute(code);
		return "/test";
	}
}
