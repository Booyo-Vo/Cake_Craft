<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
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
								<h4>마이페이지</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="/cakecraft/schedule/schedule">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">My page</li>
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
								<form>
									<!-- 사번 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>사번</b></label>
										<div class="col-sm-12 col-md-10">
											${loginId}
										</div>
									</div>
									<!-- 이름 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>이름</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.empName}
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
											${empBase.deptNm}
										</div>
									</div>
									<!-- 팀 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>팀</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.teamNm}
										</div>
									</div>
									<!-- 직급 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>직급</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.positionNm}
										</div>
									</div>
									<!-- 주민등록번호 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>주민등록번호</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.socialNo}
										</div>
									</div>
									<!-- 핸드폰번호 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>핸드폰번호</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.empPhone}
										</div>
									</div>
									<!-- email -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>email</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.email}
										</div>
									</div>
									<!-- 주소 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>주소</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.address}
										</div>
									</div>
									<!-- 연차잔여개수 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>연차잔여개수</b></label>
										<div class="col-sm-12 col-md-10">
											${empBase.dayoffCnt}
										</div>
									</div>
								</div>
								<div class="col-md-6 col-sm-12">
									<!-- 서명 -->
									<div class="form-group row">
										<label class="col-sm-12 col-md-2 col-form-label"><b>서명</b></label>
										<div class="col-sm-12 col-md-10">
											<c:if test="${not empty empBase.signFilename}">
												<img src="${pageContext.request.contextPath}/signImg/${empBase.signFilename}" alt="signImg" style="width: 200px; height: 200px;">
											</c:if>
											<c:if test="${empty empBase.signFilename}">
												(비어있음)
											</c:if>
											<!-- 서명이 없는 경우 서명 추가 버튼 출력 / 서명이 있는 경우 서명 수정 버튼 출력 -->
												<c:choose>
													<c:when test="${empty empBase.signFilename}">
														<button id="addSignature">서명 추가</button>
													</c:when>
													<c:otherwise>
													<a class="btn btn-primary" id="updateSignature">서명 수정</a>
														<!-- <button id="updateSignature">서명 수정</button> -->
													</c:otherwise>
												</c:choose>
												
											<!-- 서명 추가모달 -->
											<div class="modal fade" id="signatureModal" tabindex="-1" role="dialog" aria-labelledby="signatureModalLabel" aria-hidden="true">
												<div class="modal-dialog modal-dialog-centered" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="signatureModalLabel">서명 추가</h5>
																<button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
														</div>
													<div class="modal-body">
														<canvas id="modalGoal" style="border: 1px solid black"></canvas>
															<div>
																<button id="modalClear" class="btn btn-default">Clear</button>
																<button id="modalSend" class="btn btn-default">Send</button>
															</div>
														</div>
													</div>
												</div>
											</div>
											
											
											
											
											
											<!-- 서명 수정 모달창 시작 -->
											<div class="modal fade" id="updateSignatureModal" tabindex="-1" role="dialog" aria-labelledby="updateSignatureModal" aria-hidden="true">
												<div class="modal-dialog modal-dialog-centered" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="updateSignatureLabel">서명 수정</h5>
															<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															<canvas id="updateModalGoal" style="border: 1px solid black"></canvas>
																<div>
																<button id="updateModalClear" class="btn btn-default">Clear</button>
																<button id="updateModalSend" class="btn btn-default" data-bs-dismiss="modal">Send</button>
																</div>
														</div>
													</div>
												</div>
											</div>
											<!-- 부서 추가 모달창 끝 -->
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
										</div>
									</div>
								</form>
							</div>
						<div class="row">
							<div class="col-md-6 col-sm-12">
								<div class="text-center mb-3">
									<a href="/cakecraft/emp/modifyMyEmp" class="btn btn-primary">정보수정</a>
								</div>
							</div>
							<div class="col-md-6 col-sm-12">
								<div class="text-center mb-3">
									<a href="/cakecraft/emp/empList" class="btn btn-primary">사원조회</a>
								</div>
							</div>
				</div>
			</div>
		</div>
	</div>
	</div>
<jsp:include page="/layout/footer.jsp"></jsp:include>

</body>

<script>
//////////     서명 추가 모달 스크립트 시작    ///////////

	$(document).ready(function() {
		
		// 서명 추가 모달 열기
		$('#addSignature').click(function() {
			$('#signatureModal').modal('show');
		});

		// 서명 추가 모달 내부의 서명 기능과 관련된 스크립트
		let addModalSign = new SignaturePad(document.getElementById('modalGoal'), {
			minWidth: 2,
			maxWidth: 2,
			penColor: 'rgb(0, 0, 0)'
		});

		// 서명 추가 모달 서명 지우기
		$('#modalClear').click(function() {
		addModalSign.clear();
		});

		// 서명 추가 모달 저장
		$('#modalSend').click(function() {
			if (addModalSign.isEmpty()) {
			alert('내용이 없습니다.');
			} else {
		$.ajax({
			url: '/cakecraft/emp/addsign', //restapi 경로
			data: { sign: addModalSign.toDataURL('image/png', 1.0) },
			type: 'post',
			success: function(jsonData) {
					alert('이미지 전송 성공! - ' + jsonData);
					$('#signatureModal').modal('hide'); // 이미지 전송 성공 후 모달 닫기
					location.reload(); //자동 새로고침
					}
				});
			}
		});
		
//////////       서명 추가 모달 스크립트 끝      ///////////

//////////       서명 수정 모달 스크립트 시작    ////////////

		$(document).ready(function() {
	    // 서명 수정 모달 열기
	    $('#updateSignature').click(function() {
	        $('#updateSignatureModal').modal('show');
	    });
	
	    // 서명 수정 모달 내부의 서명 기능과 관련된 스크립트
	    let updateModalSign = new SignaturePad(document.getElementById('updateModalGoal'), {
	        minWidth: 2,
	        maxWidth: 2,
	        penColor: 'rgb(0, 0, 0)'
	    });
	
	    // 서명 수정 모달 서명 지우기
	    $('#updateModalClear').click(function() {
	        updateModalSign.clear();
	    });
	
	    // 서명 수정 모달 저장
	    $('#updateModalSend').click(function() {
	        if (updateModalSign.isEmpty()) {
	            alert('내용이 없습니다.');
	        } else {
	            $.ajax({
	                url: '/cakecraft/emp/updateSign', // restapi 경로
	                data: { sign: updateModalSign.toDataURL('image/png', 1.0) },
	                type: 'post',
	                success: function(jsonData) {
	                    alert('이미지 전송 성공! - ' + jsonData);
	                    $('#updateSignatureModal').modal('hide'); // 이미지 전송 성공 후 모달 닫기
	                    location.reload(); // 자동 새로고침
	                }
	            });
	        }
	    });
	});
});
//////////      서명 수정 모달 스크립트 끝    ///////////
</script>
</html>