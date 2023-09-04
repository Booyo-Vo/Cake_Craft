<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
////////      로그인 스크립트 시작       ///////
var jq = jQuery.noConflict();

	jq(document).ready(function () {
            const rememberCheck = $("#remember-check");
            const idInput = $("input[name='id']");
            const pwInput = $("input[name='pw']");
            const loginBtn = $("#loginBtn");

            const rememberedId = localStorage.getItem("rememberedId");
            if (rememberedId) {
                idInput.val(rememberedId);
                rememberCheck.prop("checked", true);
            }

            rememberCheck.on("change", function () {
                if (rememberCheck.is(":checked")) {
                    localStorage.setItem("rememberedId", idInput.val());
                } else {
                    localStorage.removeItem("rememberedId");
                }
            });

            const lastLoginTime = localStorage.getItem("lastLoginTime");
            const userLoggedIn = !!localStorage.getItem("rememberedId");
            const autoLoginTimeThreshold = 10 * 1000;

            if (!userLoggedIn && lastLoginTime && Date.now() - lastLoginTime < 3 * 60 * 60 * 1000) {
                const savedId = localStorage.getItem("rememberedId");
                if (savedId) {
                    idInput.val(savedId);
                    rememberCheck.prop("checked", true);

                    loginBtn.trigger("click");
                }
            }

            if (lastLoginTime && Date.now() - lastLoginTime > autoLoginTimeThreshold) {
                localStorage.removeItem("rememberedId");
            }

            loginBtn.on("click", function () {
                const id = idInput.val();
                const pw = pwInput.val();

                $.ajax({
                    url: "/cakecraft/api/login",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ id: id, pw: pw }),
                    success: function (data) {
                        if (data.success) {
                            if (rememberCheck.is(":checked")) {
                                localStorage.setItem("rememberedId", id);
                            }
                            localStorage.setItem("lastLoginTime", Date.now());

                            swal({
                                type: 'success',
                                title: '로그인성공'
                            }).then(function () {
                                window.location.href = "/cakecraft/schedule/schedule";
                            });
                        } else {
                            alert("다시 로그인 하세요!");
                        }
                    },
                    error: function (error) {
                        console.error("ajax 로그인 요청 에러:", error);
                    }
                });
            });
        })
////////       로그인 스크립트 끝       ///////
</script>

</head>

<body class="login-page">
	<div class="login-wrap d-flex align-items-center flex-wrap justify-content-center">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="${pageContext.request.contextPath}/layout/vendors/images/login-page-img.png" alt="">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="login-box bg-white box-shadow border-radius-10">
						<div class="login-title">
							<h2 class="text-center text-primary">Login</h2>
						</div>
						<div>
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
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>