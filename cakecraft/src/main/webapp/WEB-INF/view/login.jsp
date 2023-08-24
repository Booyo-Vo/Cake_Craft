<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
////////      로그인 스크립트 시작       ///////
	document.addEventListener("DOMContentLoaded", function () {
		
		const rememberCheck = document.getElementById("remember-check");//아이디를 스토리지에 저장하는 체크박스
		const idInput = document.querySelector("input[name='id']");//아이디 입력 필드
	
		// 로컬스토리지를 이용해 아이디 기억하기
		
		const rememberedId = localStorage.getItem("rememberedId");//로컬스토리지에서 아이디 가져오기
		if (rememberedId) {
			idInput.value = rememberedId;//가져온 아이디를 입력필드에 표시
			rememberCheck.checked = true;// 아이디 기억 체크박스를 체크 상태로 변경
		}
	
		rememberCheck.addEventListener("change", function () {
			if (rememberCheck.checked) {
				localStorage.setItem("rememberedId", idInput.value); //체크하면 로컬스토리지에서 아이디 삭제
			} else {
				localStorage.removeItem("rememberedId"); // 체크 해제하면 로컬스토리지에서 아이디 삭제
			}
		});
	
	    // 자동 로그인 기능 관련 수정
		const lastLoginTime = localStorage.getItem("lastLoginTime"); //마지막 로그인 시간 가져오기
			if (lastLoginTime && Date.now() - lastLoginTime < 3 * 60 * 60 * 1000) {
				// 로그인 후 3시간 이내에 접속한 경우
				const savedId = localStorage.getItem("rememberedId");//로컬스토리지에서 아이디 가져오기
				if (savedId) {
					idInput.value = savedId; //가져온 아이디 필드에 표시
					rememberCheck.checked = true; //아이디를 기억하는 체크박스를 체크상태로 변경
				
					// 자동 로그인 요청 보내기
					const loginBtn = document.getElementById("loginBtn");
					loginBtn.click(); //로긘 버튼 클릭 이벤트 실행 -> 자동로그인 시도
				}
		}
	
		const pwInput = document.querySelector("input[name='pw']"); //비밀번호 입력 필드 가져오기
		const loginBtn = document.getElementById("loginBtn"); //로그인 버튼 가져오기
		loginBtn.addEventListener("click", function () {
			const id = idInput.value; //입력된 아이디 가져오기
			const pw = pwInput.value; //입력된 비밀번호 가져오기
	
		// AJAX 요청 보내기
		fetch("/cakecraft/api/login", {
				 method: "POST",
				 body: JSON.stringify({ id: id, pw: pw }), //아이디 비밀번호를 json 형태로 담아 보낸다
				 headers: {
				     "Content-Type": "application/json"
				 }
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					if (rememberCheck.checked) {
						localStorage.setItem("rememberedId", id); //체크한 경우 아이디를 로컬스토리지에 저장
					}
					localStorage.setItem("lastLoginTime", Date.now()); // 마지막 로그인 시간 저장
					alert(id + "님 환영합니다");
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
						<form method="post" action="/cakecraft/login">
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
											<input type="checkbox" id="remember-check" name="remember-check" value="on" checked="checked">
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