<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
    // 비밀번호 변경 모달 띄우기
    $('#changePasswordBtn').click(function() {
        $('#changePasswordModal').modal('show');
    });

    // 비밀번호 변경 폼 제출
    $('#confirmPasswordBtn').click(function() {
        let currentPassword = $('#currentPassword').val();
        let newPassword = $('#newPassword').val();
        let confirmPassword = $('#confirmPassword').val();

        // 입력값 유효성 검사
        if (currentPassword.trim() === '' || newPassword.trim() === '' || confirmPassword.trim() === '') {
            alert('필수 입력 항목을 모두 입력해주세요.');
            return;
        }

        if (newPassword !== confirmPassword) {
            alert('새 비밀번호가 일치하지 않습니다.');
            return;
        }

        // 폼 데이터 생성
        var formData = {
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword
        };

        // 비밀번호 변경 폼 제출
        $.post('/cakecraft/emp/changePw', formData)
            .done(function(response) {
                // 성공적으로 처리된 경우의 동작
                alert('비밀번호 변경 성공');
                console.log("비밀번호 변경 성공");
            	 // 모달 닫기
                $('#changePasswordModal').modal('hide');
            })
            .fail(function(error) {
                // 오류 발생 시의 동작
                alert('비밀번호 변경 실패');
                console.error("비밀번호 변경 오류");
            });
    });
});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-6 col-sm-12">
						<div class="title">
							<h4>사원 정보 수정</h4>
						</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
									<li class="breadcrumb-item"><a href="/cakecraft/emp/My Page">My Page</a></li>
									<li class="breadcrumb-item active" aria-current="page">Modify My Page</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<!-- Default Basic Forms Start -->
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<div class="pull-left">
								<p class="mb-30"><b>${loginId} 님의 정보를 조회합니다</b></p>
							</div>
						</div>
					<div class="row">
						<div class="col-md-6 col-sm-12">
						<form action="/cakecraft/emp/modifyMyEmp" method="post" enctype="multipart/form-data">
							<!-- 사번 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>사번</b></label>
								<div class="col-sm-12 col-md-10">
									${empBase.id}
								</div>
							</div>
							<!-- 이름 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>이름</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="text" name="empName" value="${empBase.empName}" />
								</div>
							</div>
							<!-- 입사일 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>입사일</b></label>
								<div class="col-sm-12 col-md-10">
									${empBase.hireDate}
								</div>
							</div>
							<!-- 부서 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>부서</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="hidden" name=deptCd value="${empBase.deptCd}" readonly="readonly" />${empBase.deptNm}
								</div>
							</div>
							<!-- 팀 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>팀</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="hidden" name=teamCd value="${empBase.teamCd}" readonly="readonly"/>${empBase.teamNm}
								</div>
							</div>
							<!-- 직급 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>직급</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="hidden" name=positionCd value="${empBase.positionCd}" readonly="readonly"/>${empBase.positionNm}
								</div>
							</div>
							<!-- email -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>email</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="text" name="email" value="${empBase.email}" />
								</div>
							</div>
							<!-- 주소 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>주소</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="text" name="address" id="address" value="${empBase.address}"/>
									<a onclick="findAddr()" class="btn btn-primary" style="color:white">주소검색</a>
								</div>
							</div>
							<!-- 핸드폰번호 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>핸드폰번호</b></label>
								<div class="col-sm-12 col-md-10">
									<input type="text" name="empPhone" value="${empBase.empPhone}" />
								</div>
							</div>
						</div>
						<div class="col-md-6 col-sm-12">
							<!-- 서명 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>서명</b></label>
								<div class="col-sm-12 col-md-10">
									<!-- 기존 사인 이미지 출력 -->
									<c:if test="${not empty empBase.signFilename}">
										<img src="${pageContext.request.contextPath}/signImg/${empBase.signFilename}" alt="사인 이미지" style="width: 100px; height: 100px;">
									</c:if>
								</div>
							</div>
							<!-- 프로필 사진 -->
							<div class="form-group row">
								<label class="col-sm-12 col-md-2 col-form-label"><b>프로필 사진</b></label>
								<div class="col-sm-12 col-md-10">
									<c:if test="${not empty empBase.profileFilename}">
										<img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
									</c:if>
									<c:if test="${empty empBase.profileFilename}">
										<img src="${pageContext.request.contextPath}/profileImg/profile.png" alt="default profile image" style="width: 100px; height: 100px;">
									</c:if>
									<!-- 프로필 이미지 변경을 위한 업로드 필드 -->
									<input type="file" name="profileImage" class="btn btn-primary"/>
								</div>
							</div>
							<!-- redirect 할때 id 값이 필요해서 hidden으로 전달함-->
							<input type ="hidden" name="id" value="${empbase.id}">
						</div>
						<div class="row">
							<div class="col-md-6 col-sm-12">
								<div class="text-center mb-3">
									<button type="button" id="changePasswordBtn" class="btn btn-primary">비밀번호 변경</button>
								</div>
							</div>
							<div class="col-md-6 col-sm-12">
								<div class="text-center mb-3">
									<button type="submit" class="btn btn-primary">수정</button>
								</div>
							</div>
						</form>
				</div>
			</div>
		</div>
	</div>

<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changePasswordModalLabel">비밀번호 변경</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="password" name="currentPassword" id="currentPassword" placeholder="현재 비밀번호">
				<input type="password" name="newPassword" id="newPassword" placeholder="새 비밀번호">
				<input type="password" name="confirmPassword" id="confirmPassword" placeholder="새 비밀번호 확인">
				<button type="button" id="confirmPasswordBtn">확인</button>
				<div id="passwordError" style="color: red;"></div>
			</div>
		</div>
	</div>
</div>


</div>
<jsp:include page="/layout/footer.jsp"></jsp:include>
<!-- 주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function findAddr(){
		new daum.Postcode({
			oncomplete: function(data) {
				
				console.log(data);
				 
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var zonecode = data.zonecode; // 우편번호
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('address').value = roadAddr;
			}
		}).open();
}
</script>
</body>
</html>