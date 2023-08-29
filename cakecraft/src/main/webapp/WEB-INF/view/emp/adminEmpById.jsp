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
<!-- 제목 -->
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>사원정보</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">부서 팀 관리</li>
							</ol>
							<!-- 사원정보 수정버튼 -->
							<div class="d-flex justify-content-end mb-3">
								<a href="/cakecraft/emp/adminmodifyEmp?id=${empbase.id}" class="btn btn-primary">사원정보수정</a>
							</div>
						</nav>
					</div>
				</div>
			</div>
<!-- 제목끝 -->
<!-- 사원정보 -->
			<div class="pd-20 card-box mb-30">
				<div class="clearfix">
					<div class="pull-left">
						<h4 class="text-blue h4">${empbase.empName} 사원정보</h4>
					</div>
				</div>
			<div class="row">
				<div class="col-md-6 col-sm-12">
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>사번</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.id}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>주민등록번호</b></label>
						<div class="col-sm-12 col-md-4">
							${empbase.socialNo}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>부서</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.deptNm}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>팀</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.teamNm}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>직급</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.positionNm}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>이메일</b></label>
						<div class="col-sm-12 col-md-4">
							${empbase.email}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>입사일</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.hireDate}
						</div>
					</div>
					<c:if test="${empbase.retireDate != null}">
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>퇴사일</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.retireDate}
						</div>
					</div>
					</c:if>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>재직상태</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.empStatus}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>연차잔여개수</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.dayoffCnt}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>주소</b></label>
						<div class="col-sm-12 col-md-3">
							${empbase.address}
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-12 col-md-3 col-form-label"><b>핸드폰번호</b></label>
						<div class="col-sm-12 col-md-4">
							${empbase.empPhone}
						</div>
					</div>
				</div>
			<div class="col-md-6 col-sm-12">
			<div class="form-group row">
				<label class="col-sm-12 col-md-3 col-form-label"><b>프로필 사진</b></label>
					<div class="col-sm-12 col-md-3">
						<c:if test="${not empty empBase.profileFilename}">
								<img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
							</c:if>
							<c:if test="${empty empBase.profileFilename}">
								<img src="${pageContext.request.contextPath}/profileImg/profile.png" alt="default profile image" style="width: 100px; height: 100px;">
							</c:if>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 사원정보끝 -->
</body>
</html>