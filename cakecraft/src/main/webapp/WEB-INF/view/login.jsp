<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const rememberCheck = document.getElementById("remember-check");
        const idInput = document.querySelector("input[name='id']");

        //로컬스토리지를 이용해 아이디 기억하기
        const rememberedId = localStorage.getItem("rememberedId");
        if (rememberedId) {
            idInput.value = rememberedId;
            rememberCheck.checked = true;
        }

		rememberCheck.addEventListener("change", function () {
        	
            if (rememberCheck.checked) {
                localStorage.setItem("rememberedId", idInput.value);
            } else {
                localStorage.removeItem("rememberedId");
            }
        });
        
		// 로그인 버튼 클릭 시 AJAX 요청을 보내는 부분
		// 로컬스토리지 아이디 저장 체크박스
        // 로그인 버튼 클릭시 ajax로 아이디와 패스워드를 보내 db와 비교(매퍼, 서비스) 다시 불러와서(id pw비교) 로그인성공시 로컬 스토리지에 저장(success) 처리  
        const loginBtn = document.getElementById("loginBtn");
        const pwInput = document.querySelector("input[name='pw']");
        loginBtn.addEventListener("click", function () {
            const id = idInput.value;
            const pw = pwInput.value;
            
            // AJAX 요청 보내기
            fetch("/cakecraft/api/login", {
                method: "POST",
                body: JSON.stringify({ id: id, pw: pw }),
                headers: {
                    "Content-Type": "application/json"
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                	alert("ajax 로그인 성공");
                    localStorage.setItem("rememberedId", id);
                    window.location.href = "/cakecraft/schedule/schedule"; // 로그인 성공 시 schedule로 이동
                } else {
                    alert("ajax 로그인 실패");
                }
            })
            .catch(error => {
                console.error("ajax 로그인 요청 에러:", error);
            });
        });
    });
</script>

	<div class=" container login-wrapper">
        <h2>Login</h2>
        <form method="post" action="/cakecraft/login">
            <input type="text" name="id" placeholder="id" value="${loginId}">
            <input type="password" name="pw" placeholder="pw">
            <label for="remember-check">
            	
                <input type="checkbox" id="remember-check" name="remember-check" value="on" checked="checked">
            </label>
            <button type="submit" id="loginBtn" value="Login">로그인</button>
        </form>
    </div>
</body>
</html>