package com.goodee.cakecraft.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.cakecraft.service.LoginService;
import com.goodee.cakecraft.vo.EmpIdList;



@RestController
public class RestLoginController {
	@Autowired
    private LoginService loginService;

    @PostMapping("/api/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> loginInfo) {
        String id = loginInfo.get("id");
        String pw = loginInfo.get("pw");

        EmpIdList empIdList = new EmpIdList();
        empIdList.setId(id);
        empIdList.setPw(pw);

        EmpIdList loginMember = loginService.login(empIdList);

        Map<String, Object> response = new HashMap<>();
        if (loginMember != null) {
            response.put("success", true);
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            return ResponseEntity.badRequest().body(response);
        }
    }
}
