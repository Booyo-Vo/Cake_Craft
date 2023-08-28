<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
////////      로그인 스크립트 시작       ///////
	document.addEventListener("DOMContentLoaded", function () {
    const rememberCheck = document.getElementById("remember-check"); // 아이디를 스토리지에 저장하는 체크박스 요소 가져오기
    const idInput = document.querySelector("input[name='id']"); // 아이디 입력 필드 가져오기
    const pwInput = document.querySelector("input[name='pw']"); // 비밀번호 입력 필드 가져오기
    const loginBtn = document.getElementById("loginBtn"); // 로그인 버튼 요소 가져오기

    const rememberedId = localStorage.getItem("rememberedId"); // 로컬 스토리지에서 기억된 아이디 가져오기
    if (rememberedId) {
        idInput.value = rememberedId; // 가져온 아이디를 입력 필드에 표시
        rememberCheck.checked = true; // 아이디 기억 체크박스를 체크 상태로 변경
    }

    rememberCheck.addEventListener("change", function () {
        if (rememberCheck.checked) {
            localStorage.setItem("rememberedId", idInput.value); // 체크하면 로컬 스토리지에 아이디 저장
        } else {
            localStorage.removeItem("rememberedId"); // 체크 해제하면 로컬 스토리지에서 아이디 제거
        }
    });

    const lastLoginTime = localStorage.getItem("lastLoginTime"); // 마지막 로그인 시간 가져오기
    const userLoggedIn = !!localStorage.getItem("rememberedId"); // 로그인 정보 확인
    const autoLoginTimeThreshold = 10 * 1000; //로그인 시간 제한

    if (!userLoggedIn && lastLoginTime && Date.now() - lastLoginTime < 3 * 60 * 60 * 1000 ) { //3시간 3 * 60 * 60 * 1000
        const savedId = localStorage.getItem("rememberedId"); // 기억된 아이디 가져오기
        if (savedId) {
            idInput.value = savedId; // 가져온 아이디를 입력 필드에 표시
            rememberCheck.checked = true; // 아이디 기억 체크박스를 체크 상태로 변경

            // 사용자가 이미 로그인되어 있지 않은 경우에만 자동 로그인 시도
            loginBtn.click(); // 로그인 버튼 클릭 이벤트 발생 -> 자동 로그인 시도
        }
    }
	// 일정 시간이 지난 후에 로컬 스토리지의 아이디 정보를 삭제
    if (lastLoginTime && Date.now() - lastLoginTime > autoLoginTimeThreshold) {
        localStorage.removeItem("rememberedId");
    }

    loginBtn.addEventListener("click", function () {
        const id = idInput.value; // 입력된 아이디 가져오기
        const pw = pwInput.value; // 입력된 비밀번호 가져오기

        fetch("/cakecraft/api/login", {
            method: "POST",
            body: JSON.stringify({ id: id, pw: pw }), // 아이디와 비밀번호를 JSON 형태로 담아 보낸다
            headers: {
                "Content-Type": "application/json"
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (rememberCheck.checked) {
                    localStorage.setItem("rememberedId", id); // 체크한 경우 아이디를 로컬 스토리지에 저장
                }
                localStorage.setItem("lastLoginTime", Date.now()); // 마지막 로그인 시간 저장
                alert(id + "님 환영합니다");
                window.location.href = "/cakecraft/schedule/schedule"; // 로그인 성공 시 schedule 페이지로 이동
            } else {
                alert("다시 로그인 하세요!");
            }
        })
        .catch(error => {
            console.error("ajax 로그인 요청 에러:", error);
        });
    });
});
////////       로그인 스크립트 끝       ///////
</script>

</head>

<body class="login-page">
	<div class="login-wrap d-flex align-items-center flex-wrap justify-content-center">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="vendors/images/login-page-img.png" alt="">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="login-box bg-white box-shadow border-radius-10">
						<div class="login-title">
							<h2 class="text-center text-primary">Login</h2>
						</div>
						<form method="post" id="loginForm" action="/cakecraft/login">
							<div class="input-group custom">
								<input type="text" name="id" class="form-control form-control-lg" placeholder="Username" value="${loginId}">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="icon-copy dw dw-user1"></i></span>
								</div>
							</div>
							<div class="input-group custom">
								<input type="password" name="pw" class="form-control form-control-lg" placeholder="**********">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
								</div>
							</div>
							<div class="row pb-30">
								<div class="col-6">
									<div class="custom-control custom-checkbox">
										<label for="remember-check">
											<input type="checkbox" id="remember-check" name="remember-check" value="on" checked="checked"> 자동로그인
										</label>
									</div>
								</div>
								<div class="col-6">
									<div class="forgot-password"><a href="forgot-password.html">Forgot Password</a></div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="input-group mb-0">
											<input class="btn btn-primary btn-lg btn-block" id="loginBtn" type="submit" value="Login">
										
									</div>
									<div class="font-16 weight-600 pt-10 pb-10 text-center" data-color="#707373"></div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>