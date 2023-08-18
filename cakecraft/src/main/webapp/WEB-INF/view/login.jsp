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

        // 로컬스토리지를 이용해 아이디 기억하기
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
                    localStorage.setItem("rememberedId", id);
                    const rememberedId = localStorage.getItem("rememberedId");
                    alert(rememberedId + "님 환영합니다");
                    window.location.href = "/cakecraft/schedule/schedule"; // 로그인 성공 시 schedule로 이동
                } else {
                    alert("다시 로그인 하세요!");
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